//
//  UIViewController+HUD.h
//  DHExpand
//
//  Created by Duanhu on 2023/2/9.
//  Copyright © 2023 duan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD+DH.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HUD)

/// 提示文字，1s后会自动消失
/// - Parameters:
///   - message: 提示文本
///   - tipsStyle: 提示样式
- (void)dh_showTipsMessage:(NSString *)msg tipsStyle:(DBHTipsStyle)tipsStyle;

/// 警告 提示文字，1s后会自动消失
/// - Parameters:
///   - message: 提示文本
- (void)dh_showWarning:(NSString *)msg;

/// 失败 提示文字，1s后会自动消失
/// - Parameters:
///   - message: 提示文本
- (void)dh_showError:(NSString *)msg;

/// 成功 提示文字，1s后会自动消失
/// - Parameters:
///   - message: 提示文本
- (void)dh_showSuccess:(NSString *)msg;

@end

NS_ASSUME_NONNULL_END
