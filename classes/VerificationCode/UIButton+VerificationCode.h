//
//  UIButton+VerificationCode.h
//  DHXuanWuJi
//
//  Created by duan on 2018/3/29.
//  Copyright © 2019年 duan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (VerificationCode)

/**
 开启倒计时 ，60s
 */
-(void)dh_openCountdown ;

/**
 关闭倒计时
 */
- (void)dh_closeCountdown ;

@end

NS_ASSUME_NONNULL_END
