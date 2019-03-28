//
//  NSDate+DH.h
//  DHXuanWuJi
//
//  Created by duan on 2018/3/29.
//  Copyright © 2019年 duan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSCalendar (NGGCalendar)

+ (instancetype)calendar;

@end

@interface NSDate (DH)

/** 是否为今年 */
- (BOOL)isThisYear;

/** 是否为今天 */
- (BOOL)isToday;

/** 是否为昨天 */
- (BOOL)isYesterday;

@end

NS_ASSUME_NONNULL_END
