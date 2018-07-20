//
//  TRCommonFunction.m
//  TRTestDemo
//
//  Created by Tracky on 2016/6/13.
//  Copyright © 2016年 Tracky. All rights reserved.
//

#import "TRCommonFunction.h"
#import <objc/runtime.h>
#import <mach/mach_time.h>

NSString *const TRCommonSDKBundleName = @"TRCommonSDK";


dispatch_queue_t ExecuteQueue(void) {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.ExecuteQueue.TR", DISPATCH_QUEUE_SERIAL);
    });
    return queue;
}


dispatch_semaphore_t createSemaphore(long value) {
    static dispatch_semaphore_t semaphore;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        semaphore = dispatch_semaphore_create(value);
    });
    return semaphore;
}

void signalSemaphore(long value) {
    dispatch_semaphore_signal(createSemaphore(value));
}

long waitSemaphore(long value, dispatch_time_t timeOut) {
    return dispatch_semaphore_wait(createSemaphore(value), timeOut);
}


@implementation TRCommonFunction


+ (NSMutableDictionary<NSString *,dispatch_semaphore_t> *)semaphoreDictionary {
    static NSMutableDictionary<NSString *,dispatch_semaphore_t>  *instanceSemaphore;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instanceSemaphore = [[NSMutableDictionary<NSString *,dispatch_semaphore_t> alloc] init];
    });
    
    return instanceSemaphore;
}

+ (void)codeLockName:(NSString *)codeLockName codeFragment:(void(^)(void))codeFragment {
    if (codeLockName.length <= 0) {
        return;
    }
    
    NSString *lockNameKey = [NSString stringWithFormat:@"%zi",codeLockName.hash];
    
    NSMutableDictionary *semaphoreDict = [self semaphoreDictionary];
    dispatch_semaphore_t semaphore_t = semaphoreDict[lockNameKey];
    if (semaphore_t == nil) {
        semaphore_t = dispatch_semaphore_create(1);
        semaphoreDict[lockNameKey] = semaphore_t;
    }
    
    dispatch_semaphore_wait(semaphore_t, DISPATCH_TIME_FOREVER);
    
    if (codeFragment) {
        codeFragment();
    }
    
    dispatch_semaphore_signal(semaphore_t);
}



// 查询方法的顶层调用者
+ (NSString *)sourceCallMethod {
    NSArray *symbols = [NSThread callStackSymbols];
    NSInteger maxCount = symbols.count;
    NSString *secondSymbol;
    if (maxCount > 2) {
        secondSymbol = symbols[2];
    } else if (maxCount > 1) {
        secondSymbol = symbols[1];
    } else if ([[symbols firstObject] length]) {
        secondSymbol = [symbols firstObject];
    } else {
        return @"";
    }
    NSString *pattern = @"[+-]\\[.{0,}\\]";
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:pattern options:kNilOptions error:&error];
    if (error) {
        NSLog(@"Error: %@", error);
        return @"";
    }
    NSTextCheckingResult *checkResult = [[regular matchesInString:secondSymbol options:NSMatchingReportCompletion range:NSMakeRange(0, secondSymbol.length)] lastObject];
    NSString *sourceString = [secondSymbol substringWithRange:checkResult.range];
    return sourceString ?: @"";
}


#pragma mark - *公共方法*
/////////////////////////////////////////////////////////////////////////////////////////////////


NSString *osVersion(){
    NSOperatingSystemVersion osVersion = [NSProcessInfo processInfo].operatingSystemVersion;
    NSInteger majorVersion = osVersion.majorVersion;
    NSInteger minorVersion = osVersion.minorVersion;
    return [NSString stringWithFormat:@"%ld.%ld",(long)majorVersion,(long)minorVersion];
}


double measureBlock(void (^block)(void)){
    mach_timebase_info_data_t info;
    if (mach_timebase_info(&info) != KERN_SUCCESS) return -1.0;
    
    uint64_t start = mach_absolute_time ();
    block ();
    uint64_t end = mach_absolute_time ();
    uint64_t elapsed = end - start;
    
    uint64_t nanos = elapsed * info.numer / info.denom;
    return (double)nanos / NSEC_PER_SEC;
}

static BOOL __globalLockStatus = YES;

void globalLock(void){
    @synchronized ([NSObject new]) {
        __globalLockStatus = NO;
    }
}

void globalUnlock(void){
    @synchronized ([NSObject new]) {
        __globalLockStatus = YES;
    }
}

BOOL globalLockStatus(void){
    return __globalLockStatus;
}

NSString* getXUUID(void){
    CFUUIDRef cfUUID = CFUUIDCreate(nil);
    CFStringRef cfUUIDString = CFUUIDCreateString(nil, cfUUID);
    NSString * result = (__bridge_transfer NSString *)CFStringCreateCopy(NULL, cfUUIDString);
    CFRelease(cfUUID);
    CFRelease(cfUUIDString);
    return [[result stringByReplacingOccurrencesOfString:@"-" withString:@""] lowercaseString];
}

static NSString * getXUUIDWithPrefix(NSString *prefix){
    NSMutableString *uuid = [NSMutableString stringWithCapacity:29];
    //添加前缀 支付P 退款R
    [uuid appendString:prefix];
    
    //添加中缀  yyMMddHHmmssSSS
    NSDateFormatter *format = getFormatter();
    format.dateFormat = @"yyMMddHHmmssSSS";
    NSString *infix = [format stringFromDate:[NSDate date]];
    [uuid appendString:infix];
    
    //添加后缀 13位随机字符串
    NSMutableString *suffix = [NSMutableString stringWithCapacity:28];
    NSString *uuidString = getXUUID();
    
    NSMutableSet *mSet = [NSMutableSet setWithCapacity:13];
    while (mSet.count != 13) {
        NSUInteger random = arc4random()%32;
        [mSet addObject:@(random)];
    }
    
    [mSet enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSUInteger index = [(NSNumber *)obj unsignedIntegerValue];
        NSString *string = [uuidString substringWithRange:NSMakeRange(index, 1)];
        [suffix appendString:string];
    }];
    
    [uuid appendString:suffix];
    return uuid;
}
NSString* getXUUIDStartP(void){
    return getXUUIDWithPrefix(@"P");
}
NSString* getXUUIDStartR(void){
    return getXUUIDWithPrefix(@"R");
}

static NSDateFormatter *__TRDataFormatter;
NSDateFormatter* getFormatter(void){
    if (!__TRDataFormatter) {
        __TRDataFormatter = [[NSDateFormatter alloc] init];
        __TRDataFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    return __TRDataFormatter;
}


BOOL validateMobileNumber(NSString *mobileNumber){
    
    /* 中国移动: China Mobile
     * 1340~1348    GSM    SIM手机卡
     * 135    GSM    SIM手机卡
     * 136    GSM    SIM手机卡
     * 137    GSM    SIM手机卡
     * 138    GSM    SIM手机卡
     * 139    GSM    SIM手机卡
     * 147    TD-SCDMA/GSM    USIM/SIM数据卡 / 中国移动香港一咭两号储值卡内地号码
     * 150    GSM    SIM手机卡
     * 151    GSM    SIM手机卡
     * 152    GSM    SIM手机卡
     * 157    TD-SCDMA    USIM无线固话卡
     * 158    GSM    SIM手机卡
     * 159    GSM    SIM手机卡
     * 178    TD-LTE    USIM手机卡
     * 182    GSM    SIM手机卡
     * 183    GSM    SIM手机卡
     * 184    GSM    SIM手机卡
     * 187    TD-SCDMA    USIM手机卡
     * 188    TD-SCDMA    USIM手机卡
     */
    NSString *CM = @"^1(34[0-8]|(3[5-9]|47|5[0127-9]|78|8[23478]|88)\\d)\\d{7}$";
    NSPredicate *regextestCM = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    if ([regextestCM evaluateWithObject:mobileNumber]) {
        return YES;
    }
    
    /**
     * 中国联通：China Unicom
     * 130    GSM    SIM手机卡
     * 131    GSM    SIM手机卡
     * 132    GSM    SIM手机卡
     * 145    WCDMA    USIM数据卡
     * 155    GSM    SIM手机卡
     * 156    GSM/WCDMA    SIM手机卡/中港一卡兩號(3G)
     * 175    FDD-LTE/TD-LTE    USIM手机卡
     * 176    FDD-LTE/TD-LTE    USIM手机卡
     * 185    WCDMA    USIM手机卡
     * 186    WCDMA    USIM手机卡
     */
    NSString *CU = @"^1(3[0-2]|45|5[56]|7[56]|8[56])\\d{8}$";
    NSPredicate *regextestCU = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    if ([regextestCU evaluateWithObject:mobileNumber]) {
        return YES;
    }
    
    /*
     * 中国电信: China Telecom
     * 133    CDMA    UIM手机卡
     * 1349         卫星手机卡
     * 149    FDD-LTE/TD-LTE    USIM数据卡
     * 153    CDMA    UIM手机卡
     * 173    FDD-LTE/TD-LTE    USIM手机卡
     * 177    FDD-LTE/TD-LTE    USIM手机卡
     * 180    CDMA2000    UIM手机卡
     * 181    CDMA2000    UIM手机卡
     * 189    CDMA2000    UIM手机卡
     */
    NSString *CT = @"^1(349|(33|49|53|7[37]|8[01-9])\\d)\\d{7}$";
    NSPredicate *regextestCT = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if ([regextestCT evaluateWithObject:mobileNumber]) {
        return YES;
    }
    
    
    /*
     * 虚拟运营商: Mobile virtual network operator
     中国内地40余家移动虚拟运营商推出了170、171号段。
     * 1700    中国电信    UIM手机卡
     * 1701    中国电信    UIM手机卡
     * 1702    中国电信    UIM手机卡
     * 1703    中国移动    USIM手机卡
     * 1704    中国联通    USIM手机卡
     * 1705    中国移动    USIM手机卡
     * 1706    中国移动    USIM手机卡
     * 1707    中国联通    USIM手机卡
     * 1708    中国联通    USIM手机卡
     * 1709    中国联通    USIM手机卡
     * 171    中国联通    USIM手机卡
     */
    NSString *VM = @"^1(7[01])\\d{8}$";
    NSPredicate *regextestVM = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", VM];
    return [regextestVM evaluateWithObject:mobileNumber];
    
}


#pragma mark - *JSON*
///////////////////////////////////////////////////////////////////////////////////////////////////
NSString* collection2JsonString(id collection){
    
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = nil;
    @try {
        jsonData = [NSJSONSerialization dataWithJSONObject:collection
                                                   options:0
                                                     error:&error];
    } @catch (NSException *exception) {
        return nil;
    }
    if (jsonData) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    //Tip: 解决苹果系统的一个BUG 集合转换成Json时会将'/'转换为'\/'
    //为了处理base64后'/'的问题 http://www.cnblogs.com/kongkaikai/p/5627205.html
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    return jsonString;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
id jsonString2Collection(NSString *jsonString){
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id collection = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingMutableContainers
                                                      error:&err];
    if(err) {
        return nil;
    }
    return collection;
}

NSDictionary* convertObj2Dictionary(id obj){
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    
    unsigned int propertyCount, index;
    objc_property_t *properties = class_copyPropertyList([obj class], &propertyCount);
    for (index = 0 ; index < propertyCount; index++) {
        objc_property_t property = properties[index];
        const char *char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id properyValue = [obj valueForKey:propertyName];
        if (properyValue) {
            [resultDic setValue:properyValue forKey:propertyName];
        }else{
            [resultDic setValue:@"" forKey:propertyName];
        }
    }
    free(properties);
    
    return resultDic;
}

#pragma mark - *NULL*
///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL isArrayWithAnyItems(id object) {
    return [object isKindOfClass:[NSArray class]] && [(NSArray*)object count] > 0;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL isDictionaryWithAnyItems(id object) {
    return [object isKindOfClass:[NSDictionary class]] && [(NSDictionary*)object count] > 0;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL isStringWithAnyText(id object) {
    return [object isKindOfClass:[NSString class]] && [(NSString*)object length] > 0;
}




#pragma mark - *视图相关*
/**
 *
 *  @brief 从RootViewController开始递归查询当前显示的控制器
 *  @since v0.1.0
 */
UIViewController* tr_findBestViewController(UIViewController *controller){
    //1.如果控制器是被present出来的
    if (controller.presentedViewController) {
        return tr_findBestViewController(controller.presentedViewController);
    }
    //2.如果控制器是UISplitViewController
    else if ([controller isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *splitViewController = (UISplitViewController *) controller;
        if (splitViewController.viewControllers.count > 0){
            return tr_findBestViewController(splitViewController.viewControllers.lastObject);
        }else{
            return controller;
        }
    }
    //3.如果控制器是一个导航控制器
    else if ([controller isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = (UINavigationController *) controller;
        if (navController.viewControllers.count > 0){
            return tr_findBestViewController(navController.topViewController);
        }else{
            return controller;
        }
    }
    //4.如果控制器是一个标签栏控制器
    else if ([controller isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *) controller;
        if (tabBarController.viewControllers.count > 0){
            return tr_findBestViewController(tabBarController.selectedViewController);
        }else{
            return controller;
        }
    }
    //5.最根源的控制器
    else {
        return controller;
    }
}

UIViewController* currentViewController(void){
    UIViewController *root = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    return tr_findBestViewController(root);
}


#pragma mark - *文件相关*
///////////////////////////////////////////////////////////////////////////////////////////////////
NSString* filePathInDocuments(NSString *filename){
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths firstObject] stringByAppendingPathComponent:filename];
}

NSBundle* externBundle(NSString *bundleName){
    NSCParameterAssert(bundleName);
    NSString *bundeFullName;
    if ([bundleName rangeOfString:@".bundle"].location == NSNotFound) {
        bundeFullName = [NSString stringWithFormat:@"%@.bundle",bundleName];
    }else{
        bundeFullName = bundleName;
    }
    NSString *bundlePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:bundeFullName];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    return bundle;
}

UIImage* externBundleImage(NSString *bundleName,NSString *imageName){
    NSBundle *bundle = externBundle(bundleName);
    if (!bundle) {
        return [UIImage imageNamed:imageName];
    }
    return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
}

UIStoryboard* customStoryBoard(NSString *bundleName,NSString *storyBoardName){
    NSCParameterAssert(bundleName);
    NSCParameterAssert(storyBoardName);
    NSBundle *bundle = externBundle(bundleName);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyBoardName bundle:bundle];
    return storyboard;
}

NSArray* xibArray(NSString *bundleName,NSString *xibName){
    NSCParameterAssert(xibName);
    NSBundle *bundle = externBundle(bundleName);
    NSArray *array   = [bundle loadNibNamed:xibName owner:nil options:nil];;
    if (!array) {
        array = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];
    }
    return array;
}
@end
