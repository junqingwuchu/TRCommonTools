//
//  TRCommonFunction.h
//  TRTestDemo
//
//  Created by Tracky on 2016/6/13.
//  Copyright © 2016年 Tracky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const TRCommonSDKBundleName;

FOUNDATION_EXTERN dispatch_time_t ExecuteQueu(void);

FOUNDATION_EXTERN dispatch_semaphore_t createSemaphore(long value);

FOUNDATION_EXTERN void signalSemaphore(long value);

FOUNDATION_EXTERN long waitSemaphore(long value, dispatch_time_t timeout);

//Readme :这里定义全局通用C风格的函数,方便调用



@interface TRCommonFunction : NSObject
#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark - *公共方法*
#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

/**
 * 协同信号量控制（并发代码需要访问同一块代码控制时使用）
 */

/**
 * 锁定的代码块
 *
 * @param codeLockName 该代码控制片段名称（需严格遵照各模块自己的命名方式）
 * @param codeFragment 控制的代码片段
*/
+ (void)codeLockName:(NSString *)codeLockName codeFragment:(void(^)(void))codeFragment;


/**
 * 查询方法的顶层调用者
 *
 * @return 顶层调用方法
 */
+ (NSString *)sourceCallMethod;





/*!
 *
 *  @brief 获取系统版本
 *
 *  @return 返回系统大版本号+小版本号 eg:10.2
 */
FOUNDATION_EXPORT NSString *osVersion(void);

/*!
 *
 *  @brief 测试一段代码的执行时间
 *
 *  @param block 待测试代码块
 *  @return 代码块运行时长
 */
FOUNDATION_EXPORT double measureBlock(void (^block)(void));


/*!
 *  @brief 上锁
 */
FOUNDATION_EXPORT void globalLock(void);
/*!
 *  @brief 开锁
 */
FOUNDATION_EXPORT void globalUnlock(void);
/*!
 *
 *  @brief 全局共享的一个锁
 *  @return YES-开的状态  NO-关的状态,默认是开的状态
 */
FOUNDATION_EXPORT BOOL globalLockStatus(void);



/**
 *
 *  @brief 生成UUID
 *  @return 随机生成32位小写的字符串
 *  @since v0.1.0
 */
FOUNDATION_EXPORT NSString* getXUUID(void);
/*!
 *
 *  @brief 生成29位以P打头的唯一标识
 *  @return (P+yyMMddHHmmss+16位随机字符串)组成的字符串
 */
FOUNDATION_EXPORT NSString* getXUUIDStartP(void);

/*!
 *
 *  @brief 生成29位以R打头的唯一标识
 *  @return (R+yyMMddHHmmss+16位随机字符串)组成的字符串
 */
FOUNDATION_EXPORT NSString* getXUUIDStartR(void);


/*!
 *
 *  @brief 获取日期格式化对象,default format is yyyy-MM-dd HH:mm:ss
 每次获取后重新设置dateformat字符串
 *  @return 公用的NSDateFormatter实例对象
 */
FOUNDATION_EXTERN NSDateFormatter* getFormatter(void);

/**
 *
 *  @brief 验证手机号码的合法性
 *  @param mobileNumber 手机号
 *  @return 手机号码是否合法
 *  @since v0.1.0
 */
FOUNDATION_EXPORT BOOL validateMobileNumber(NSString *mobileNumber);



#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark - *JSON*
#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

/**
 *
 *  @brief 将集合对象转换成Json字符串
 *  @param collection 集合对象(Array,Dictionary,Set)
 *  @return Json字符串(如果转换失败，则返回nil)
 *  @since v0.1.0
 */
FOUNDATION_EXPORT NSString* collection2JsonString(id collection);

/**
 *
 *  @brief 将标准的Json格式的字符串转换成集合对象
 *  @param jsonString Json字符串
 *  @return 集合(Array,Dictionary,Set中的某一种)(如果转换失败，则返回nil)
 *  @since v0.1.0
 */
FOUNDATION_EXPORT id jsonString2Collection(NSString *jsonString);


/**
 *
 *  @brief 将模型对象转化为字典
 *  @param obj 模型对象
 *  @return 字典
 *  @since v1.0.0
 */
FOUNDATION_EXPORT NSDictionary* convertObj2Dictionary(id obj);


#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark - *NULL*
#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
/**
 *
 *  @brief 判断一个对象是否是NSArray类型并且不为空
 *  @param object OC对象
 *  @return 是否是可用的数组
 *  @since v0.1.0
 */
FOUNDATION_EXPORT BOOL isArrayWithAnyItems(id object);
/**
 *
 *  @brief 判断一个对象是否是NSDictionary类型并且不为空
 *  @param object OC对象
 *  @return 是否是可用的字典
 *  @since v0.1.0
 */
FOUNDATION_EXPORT BOOL isDictionaryWithAnyItems(id object);

/**
 *
 *  @brief 判断一个对象是否是NSString类型并且不为空
 *  @param object OC对象
 *  @return 是否是可用的字符串
 *  @since v0.1.0
 */
FOUNDATION_EXPORT BOOL isStringWithAnyText(id object);



#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark - *视图相关*
#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

/**
 *
 *  @brief 获取当前显示的视图控制器
 *  @return 当前显示的视图控制器
 *  @since v0.1.0
 */
FOUNDATION_EXPORT UIViewController* currentViewController(void);



#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark - *文件相关*
#pragma mark  - ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

/**
 *
 *  @brief 返回一个拼接了沙盒Document路径的文件路径
 *  @param filename 文件名
 *  @return 拼接了沙盒Document路径的文件路径
 *  @since v0.1.0
 */
FOUNDATION_EXPORT NSString* filePathInDocuments(NSString *filename);

/**
 *
 *  @brief 通过其它bundle的名字来获取一个NSBundle对象
 *  @param bundleName 要获取的NSBundle的文件名字符串
 *  @return NSBundle对象
 *  @since v0.1.0
 */
FOUNDATION_EXPORT NSBundle* externBundle(NSString *bundleName);



/*!
 *
 *  @brief 加载其它bundle中的image
 *  @param bundleName Bundle的文件名字符串
 *  @param imageName  图片名称字符串
 *  @return 其它bundle中的UIImage
 */
FOUNDATION_EXPORT UIImage* externBundleImage(NSString *bundleName,NSString *imageName);

/**
 *
 *  @brief 从指定bundle中加载一个指定的storyboard
 *  @param bundleName     bundle名称
 *  @param storyBoardName storyboard名称
 *  @return storyboard
 *  @since v1.0.0
 */
FOUNDATION_EXPORT UIStoryboard* customStoryBoard(NSString *bundleName,NSString *storyBoardName);

/**
 *
 *  @brief 从指定bundle中加载一个指定的xib组件数组
 *  @param bundleName bundle名称
 *  @param xibName    xib文件名称
 *  @return xib里包含的组件的数组
 *  @since v1.0.0
 */
FOUNDATION_EXPORT NSArray* xibArray(NSString *bundleName,NSString *xibName);

@end
