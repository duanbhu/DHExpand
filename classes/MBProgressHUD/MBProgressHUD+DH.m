//
//  MBProgressHUD+DH.m
//  DHXuanWuJi
//
//  Created by 段波虎 on 2018/5/18.
//  Copyright © 2018年 duan. All rights reserved.
//

#import "MBProgressHUD+DH.h"

static NSTimeInterval kDelay = 1.2 ;
@implementation MBProgressHUD (DH)

+ (MBProgressHUD *)showHUDWithMessage:(NSString *)message ToView:(UIView *)view {
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.tintColor = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    hud.label.text = message;
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor blackColor];
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    // hud.dimBackground = YES;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor clearColor];
    return hud;
}

#pragma mark -- show tips

/**
 显示一段文字
 @param message 要显示的文字
 @param view 显示hud的view
 @param delay delay秒后hud将会自动消失 ,delay==0表示不会自动消失
 @param model hud的显示类型
 */
+ (void)showTipsMessage:(NSString*)message toView:(UIView*)view hideDelay:(NSTimeInterval)delay Model:(MBProgressHUDMode)model {
    MBProgressHUD *hud = [MBProgressHUD dh_showMsg:message icon:nil hideDelay:delay toView:view];
    hud.mode = model;
}

/**
 显示带图片或者不带图片的信息

 @param msg 要显示的文字
 @param icon 显示的图片名
 @param delay delay秒后hud将会自动消失 ,delay==0表示不会自动消失
 @param view 显示hud的view
 @return HUD
 */
+ (MBProgressHUD*)dh_showMsg:(NSString*)msg icon:(NSString*)icon hideDelay:(NSTimeInterval)delay toView:(UIView*)view {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDWithMessage:msg ToView:view];
    if (icon) {
        //需要显示图片
        UIImage *img = [UIImage imageNamed:icon];
        hud.customView = [[UIImageView alloc] initWithImage:img];
        // 再设置模式
        hud.mode = MBProgressHUDModeCustomView;
    }
    else {
        hud.mode = MBProgressHUDModeText;
    }
    // 指定时间之后再消失
    if (delay > 0) {
        [hud hideAnimated:YES afterDelay:delay];
    }
    return hud;
}

/**  带菊花的文字，不会自动消失  */
+ (void)dh_showActivityMessage:(NSString*)message toView:(UIView*)view {
    [self showTipsMessage:message toView:view hideDelay:0 Model:MBProgressHUDModeIndeterminate];
}

/**  提示文字，1s后会自动消失  */
+ (void)dh_showTipsMessage:(NSString*)message toView:(UIView*)view {
    [self showTipsMessage:message toView:view hideDelay:kDelay Model:MBProgressHUDModeText];
}

/** 显示成功信息 */
+ (void)dh_showSuccess:(NSString *)success toView:(UIView *)view {
    [self dh_showMsg:success icon:@"DHHud.bundle/HUD_success" hideDelay:kDelay toView:view];
}

/** 显示错误信息 */
+ (void)dh_showError:(NSString *)error toView:(UIView *)view {
    [self dh_showMsg:error icon:@"DHHud.bundle/HUD_error" hideDelay:kDelay toView:view];
}

/** 显示警示信息 */
+ (void)dh_showWarning:(NSString *)warning toView:(UIView *)view {
    [self dh_showMsg:warning icon:@"DHHud.bundle/HUD_warning" hideDelay:kDelay toView:view];
}

/** 移除 HUD */
+ (void)dh_hideHUDForView:(UIView *)view {
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:view animated:YES];
}

@end
