//
//  UIViewController+HUD.m
//  DHExpand
//
//  Created by Duanhu on 2023/2/9.
//  Copyright © 2023 duan. All rights reserved.
//

#import "NSObject+HUD.h"

@implementation NSObject (HUD)

- (UIView *)toView {
//    if ([self isKindOfClass:[UIViewController class]]) {
//        return ((UIViewController *)self).view;
//    }
    return nil;
}

/// 提示文字，1s后会自动消失
/// - Parameters:
///   - message: 提示文本
///   - tipsStyle: 提示样式
- (void)dh_showTipsMessage:(NSString *)msg tipsStyle:(DBHTipsStyle)tipsStyle {
    [MBProgressHUD dh_showTipsMessage:msg toView:[self toView] tipsStyle:tipsStyle];
}

/// 警告 提示文字，1s后会自动消失
/// - Parameters:
///   - message: 提示文本
- (void)dh_showWarning:(NSString *)msg {
    [MBProgressHUD dh_showWarning:msg toView:[self toView]];
}

/// 失败 提示文字，1s后会自动消失
/// - Parameters:
///   - message: 提示文本
- (void)dh_showError:(NSString *)msg {
    [MBProgressHUD dh_showError:msg toView:[self toView]];
}

/// 成功 提示文字，1s后会自动消失
/// - Parameters:
///   - message: 提示文本
- (void)dh_showSuccess:(NSString *)msg {
    [MBProgressHUD dh_showSuccess:msg toView:[self toView]];
}

@end
