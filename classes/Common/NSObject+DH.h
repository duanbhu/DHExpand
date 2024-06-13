//
//  NSObject+DH.h
//  DHExpand
//
//  Created by Duanhu on 2023/2/9.
//  Copyright © 2023 duan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (DH)

/// 获取当前window
+ (UIWindow *)dh_currentWindow;

/// 获取当前Controller
+ (UIViewController*)dh_currentVC;

+ (UINavigationController*)dhl_currentNav;

@end

NS_ASSUME_NONNULL_END
