//
//  MBProgressHUD+DH.h
//  DHXuanWuJi
//
//  Created by 段波虎 on 2018/5/18.
//  Copyright © 2018年 duan. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (DH)

/**
 显示带图片或者不带图片的信息
 
 @param msg 要显示的文字
 @param icon 显示的图片名
 @param delay delay秒后hud将会自动消失 ,delay==0表示不会自动消失
 @param view 显示hud的view
 @return HUD
 */
+ (MBProgressHUD*)dh_showMsg:(NSString*)msg icon:(NSString*)icon hideDelay:(NSTimeInterval)delay toView:(UIView*)view;

/**  带菊花的文字，不会自动消失  */
+ (void)dh_showActivityMessage:(NSString*)message toView:(UIView*)view;

/**  提示文字，1s后会自动消失  */
+ (void)dh_showTipsMessage:(NSString*)message toView:(UIView*)view;

/** 显示成功信息 1s后会自动消失 */
+ (void)dh_showSuccess:(NSString *)success toView:(UIView *)view;

/** 显示错误信息 1s后会自动消失 */
+ (void)dh_showError:(NSString *)error toView:(UIView *)view;

/** 显示警示信息 */
+ (void)dh_showWarning:(NSString *)warning toView:(UIView *)view;

/** 移除 HUD */
+ (void)dh_hideHUDForView:(UIView *)view;

@end
