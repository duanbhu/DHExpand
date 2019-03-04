//
//  NSString+Time.h
//  DHXuanWuJi
//
//  Created by duan on 2018/3/29.
//  Copyright © 2019年 duan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Time)

/**
 与当前时间比较来决定显示什么
 @return 与当前时间比较来决定显示什么
 */
- (NSString *)dh_displayTime;

#pragma mark - 时间戳转化为时间字符串

/**
 年-月-日 时-分-秒
 
 @return 年-月-日 时-分-秒
 */
- (NSString*)dh_becomeDate;

/**
 将时间戳规范化，转化为标准时间格式
 
 @param dateFormat 如： dateFormat = @"yyyy-MM-dd HH:mm:ss";
 @return 时间
 */
- (NSString*)dh_becomeDateForWithFormat:(NSString*)dateFormat ;

/**
 获取当前系统时间（时间戳 以毫秒为单位）

 @return 13 时间戳
 */
+ (NSString *)dh_getCurrentTimestamp;

@end

NS_ASSUME_NONNULL_END
