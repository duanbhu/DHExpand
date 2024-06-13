//
//  MBProgressHUD+DH.m
//  DHXuanWuJi
//
//  Created by Duanhu on 2018/5/18.
//  Copyright © 2018年 duan. All rights reserved.
//

#import "MBProgressHUD+DH.h"
#import "NSObject+DH.h"

static NSTimeInterval kDelay = 1.2 ;
@implementation MBProgressHUD (DH)

+ (MBProgressHUD *)showHUDWithMessage:(NSString *)message ToView:(UIView *)view {
    if (view == nil) view = (UIView*)[self dh_currentWindow];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.tintColor = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    hud.customView.backgroundColor = [UIColor blackColor];
    hud.detailsLabel.text = message;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    hud.bezelView.color = [UIColor blackColor];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    // hud.dimBackground = YES;
//    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:.2f];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor blackColor];
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
+ (MBProgressHUD *)dh_showTipsMessage:(NSString*)message toView:(UIView*)view hideDelay:(NSTimeInterval)delay Model:(MBProgressHUDMode)model {
    MBProgressHUD *hud = [MBProgressHUD dh_showMsg:message icon:nil hideDelay:delay toView:view];
    hud.mode = model;
    return hud;
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
+ (MBProgressHUD *)dh_showActivityMessage:(NSString*)message toView:(UIView*)view {
    return [self dh_showTipsMessage:message toView:view hideDelay:0 Model:MBProgressHUDModeIndeterminate];
}

/**  提示文字，1s后会自动消失  */
+ (void)dh_showTipsMessage:(NSString*)message toView:(UIView*)view {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dh_showTipsMessage:message toView:view hideDelay:kDelay Model:MBProgressHUDModeText];
    });
}

/// 提示文字，1s后会自动消失
/// - Parameters:
///   - message: 提示文本
///   - view: HUD 所在view
///   - tipsStyle: 提示样式
+ (void)dh_showTipsMessage:(NSString *)message toView:(UIView *)view tipsStyle:(DBHTipsStyle)tipsStyle {
    NSString *icon = nil;
    switch (tipsStyle) {
        case DBHTipsStyleOnlyText: {
            [self dh_showTipsMessage:message toView:view];
            return;
        }
        case DBHTipsStyleIconSuccess:
            icon = @"icon_toast_success";
            break;
        case DBHTipsStyleIconError:
            icon = @"icon_toast_error";
            break;
        case DBHTipsStyleIconWarning:
            icon = @"icon_toast_warning";
            break;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dh_showMsg:message icon:icon hideDelay:kDelay toView:view];
    });
}

/** 显示成功信息 */
+ (void)dh_showSuccess:(NSString *)success toView:(UIView *)view {
    [self dh_showTipsMessage:success toView:view tipsStyle:DBHTipsStyleIconSuccess];
}

/** 显示错误信息 */
+ (void)dh_showError:(NSString *)error toView:(UIView *)view {
    [self dh_showTipsMessage:error toView:view tipsStyle:DBHTipsStyleIconError];
}

/** 显示警示信息 */
+ (void)dh_showWarning:(NSString *)warning toView:(UIView *)view {
    [self dh_showTipsMessage:warning toView:view tipsStyle:DBHTipsStyleIconWarning];
}

/** 移除 HUD */
+ (void)dh_hideHUDForView:(UIView *)view {
    if (view == nil) view = (UIView*)[self dh_currentWindow];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideHUDForView:view animated:YES];
    });
}

@end
