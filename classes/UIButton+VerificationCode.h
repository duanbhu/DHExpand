//
//  UIButton+VerificationCode.h
//  DHXuanWuJi
//
//  Created by bangju on 2019/2/28.
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
