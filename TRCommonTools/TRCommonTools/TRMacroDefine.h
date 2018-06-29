//
//  TRMacroDefine.h
//  TRTestDemo
//
//  Created by Tracky on 2016/6/13.
//  Copyright © 2016年 Tracky. All rights reserved.
//

#ifndef TRMacroDefine_h
#define TRMacroDefine_h

/* ------自动提示宏------*/
/**
 *  @brief 可以将对象的属性转化为字符串,并且可以出现自动提示(用一下你就知道有多神奇了)
 *  @param __obj     NSObject对象
 *  @param __keyPath 对象的属性
 *  @return 对象属性对应的字符串
 *  @since v0.1.0
 */
#define keyPath(__obj,__keyPath)   @(((void)__obj.__keyPath,#__keyPath))



/* ------格式化字符串------*/
#define F(string, args...)      [NSString stringWithFormat:string, args]



/* ------输出log------*/
#ifndef __OPTIMIZE__
// Debug模式
#define TRLog(...) printf("\n %s [Line:%d] %s\n", __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#else
// Release模式
#define TRLog(...)
#endif


/* ------处理各种赋值为空的问题------*/
#define FixNull(param, default) ((parama == nil || param isEqual:[NSNull null]) ? default : param)


/* ------获取BundleId------*/
#define kBundleIdentifier [[NSBundle mainBundle] bundleIdentifier]


/* ------适配 判断系统版本------*/
// 等于
#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
// 大于
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
// 大于等于
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
// 小于
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
// 小于等于
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


/* ------适配 判断硬件类型------*/
// 判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
// 判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)



/* ------适配 获取UI参数------*/
// 设备bounds
#define kScreenBounds [UIScreen mainScreen].bounds
// 设备的物理宽度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
// 设备的物理宽度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

// 设备宽度比例
#define kSreenWidthScale (ScreenWidth / 320.)

/* ------适配 宽高比例尺寸------*/
#define kWidth(x) ((x)*(kScreenWidth)/375.0)

#define kHeight(y) ((y)*(kScreenHeight)/667.0)

/* ------适配 iPhoneX安全区域尺寸------*/
#define kSafeAreaBottomHeight (kScreenHeight == 812 ? 34 : 0)

#define kSafeAreaTopHeight (kScreenHeight == 812 ? 88 : 64)


/* ------字体------*/
#define kFont(size) ([UIFont systemFontOfSize:size])
#define kBoldFont(size) ([UIFont boldSystemFontOfSize:size])
#define kFontCustomName(name,fontSize) ([UIFont fontWithName:name  size:fontSize])


/* ------颜色------*/
/**
 *  @brief UIColor初始化宏
 *  @param __r 红色
 *  @param __g 绿色
 *  @param __b 蓝色
 *  @param __a 透明度
 *  @return RGB颜色
 *  @since v0.1.0
 */
#define RGBACOLOR(__r,__g,__b,__a) \
[UIColor colorWithRed:(__r)/255.0f green:(__g)/255.0f blue:(__b)/255.0f alpha:(__a)]

#define RGBCOLOR(__r,__g,__b) RGBACOLOR(__r,__g,__b,1.0)

#define RGBXCOLOR(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f green:((float)((rgbValue & 0xFF00) >> 8))/255.0f blue:((float)(rgbValue & 0xFF))/255.0f alpha:1.0]

/**
 *  @author _Finder丶Tiwk, 16-01-13 15:01:04
 *  这个宏灵感来源于ReactiveCocoa EXTScope.h
 *  使用方法如下,注意前面的@符号 :
 @xWeakify
 [obj block:^{
    @xStrongify
    [self doAnything];
    self.property = something;
 }];
 *  @since v0.1.0
 */
#ifndef    xWeakify
#if __has_feature(objc_arc)
#define xWeakify autoreleasepool{} __weak __typeof__(self) weakRef = self;
#else
#define xWeakify autoreleasepool{} __block __typeof__(self) blockRef = self;
#endif
#endif

#ifndef     xStrongify
#if __has_feature(objc_arc)
#define xStrongify try{} @finally{} __strong __typeof__(weakRef) self = weakRef;
#else
#define xStrongify try{} @finally{} __typeof__(blockRef) self = blockRef;
#endif
#endif



/* ------单例------*/
/**
 *  @brief 单例声明
 *  @param __className 类名
 *  @return 单例
 *  @since v0.1.0
 */
#define singleton(__className) \
+ (__className *)share##__className;
/**
 *  @brief 单例的实现
 *  @param __className 类名
 *  @return 单例
 *  @since v0.1.0
 */
#define singletonImpl(__className) \
static __className *_instance; \
+ (id)allocWithZone:(NSZone *)zone{\
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
    _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
+ (__className *)share##__className{\
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
    _instance = [[self alloc] init]; \
    }); \
    return _instance; \
}


/* ------版本&API控制------*/
/**
 *  @brief  用于废弃过时的API
 *  @param __version 从某个版本开始废弃
 *  @param __message 提示信息
 *  @since v0.1.0
 */
#define TR_DEPRECATE(__version,__message)    __attribute__((deprecated(__message)))
/**
 *  @brief  用于禁用某API
 *  @param __verison 从某个版本开始禁用
 *  @param __message 提示信息
 *  @since v0.1.0
 */
#define TR_UNAVAILABLE(__verison,__message)  __attribute__((unavailable(__message)))


#endif /* TRMacroDefine_h */
