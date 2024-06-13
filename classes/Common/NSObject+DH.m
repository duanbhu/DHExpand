//
//  NSObject+DH.m
//  DHExpand
//
//  Created by Duanhu on 2023/2/9.
//  Copyright © 2023 duan. All rights reserved.
//

#import "NSObject+DH.h"
//#import "SceneDelegate.h"

@implementation NSObject (DH)

+ (UIWindow *)dh_currentWindow {
    if ([[[UIApplication sharedApplication] delegate] window]) {
        return [[[UIApplication sharedApplication] delegate] window];
    } else {
        if (@available(iOS 13.0,*)) {
            NSArray *arr = [[[UIApplication sharedApplication] connectedScenes] allObjects];
            UIWindowScene *windowScene =  (UIWindowScene *)arr[0];
            //如果是普通APP开发，可以使用
//            SceneDelegate *delegate = (SceneDelegate *)windowScene.delegate;
//            UIWindow *mainWindow = delegate.window;
            //  由于在sdk开发中，引入不了SceneDelegate的头文件，所以需要使用kvc获取宿主的app的window
            UIWindow *mainWindow = [windowScene valueForKeyPath:@"delegate.window"];
            if(mainWindow) {
                return mainWindow;
            } else {
                return [UIApplication sharedApplication].windows.lastObject;
            }
        } else {
            return [UIApplication sharedApplication].keyWindow;
        }
    }
}

+ (UIViewController*)dh_currentVC {
    UIWindow *window = [self dh_currentWindow];
    UIViewController *topViewController = [window rootViewController];
    while (true) {
        if (topViewController.presentedViewController) {
            topViewController = topViewController.presentedViewController;
        } else if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)topViewController topViewController]) {
            topViewController = [(UINavigationController *)topViewController topViewController];
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController;
        } else {
            break;
        }
    }
    return topViewController;
}

+ (UINavigationController*)dhl_currentNav {
    UIWindow *window = [self dh_currentWindow];
    UIViewController *topViewController = [window rootViewController];
    while (true) {
        if ([topViewController isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)topViewController;
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController;
        } else {
            break;
        }
    }
    return nil;
}

@end
