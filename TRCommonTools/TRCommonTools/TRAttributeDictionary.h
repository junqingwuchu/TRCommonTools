//
//  TRAttributeDictionary.h
//  TRTestDemo
//
//  Created by Tracky on 2018/6/28.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TRAttributeDictionary : NSObject

/*!
 * @brief 生成一个带Paragraph 属性的字典
 *
 * @param spacing 行间距
 */
NSDictionary *xParagraphLineSpacingAttribute(CGFloat spacing);
/*!
 * @brief 生成一个带Font属性的字典
 *
 * @param font 字体大小
 */
NSDictionary *xFontAttribute(CGFloat font);
NSDictionary *xBoldFontAttribute(CGFloat font);
NSDictionary *xColorAttribute(UIColor *color);

/*!
 * @brief 进行2个字典合并
 *
 * @param att1 字典 1
 * @param att2 字典 2
 * @param ...  多个字典
 * @warning 字典的key不能相同，相同的话，后者会覆盖前者
 */
NSDictionary *xAttributeAdd(NSDictionary *att1,NSDictionary *att2,...);

@end
