//
//  UIViewController+DHAlert.m
//  DHXuanWuJi
//
//  Created by duan on 2018/3/29.
//  Copyright © 2018年 duan. All rights reserved.
//

#import "UIViewController+DHAlert.h"

@implementation DHAlertConfig

static DHAlertConfig *shareManager = nil;
static dispatch_once_t onceToken;

+ (instancetype)defaultConfig {
    dispatch_once(&onceToken, ^{
        shareManager = [[DHAlertConfig alloc] init];
    });
    return shareManager;
}

@end

@implementation UIViewController (DHAlert)

/** 弹出框 参数 */
- (void)dh_alertTitle:(NSString*)title
                 msg:(NSString*)msg
      preferredStyle:(UIAlertControllerStyle)preferredStyle
        actionTitles:(NSArray*)actionTitles
      actionCallBack:(void (^)(NSInteger index))actionCallBack {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:preferredStyle];
    NSInteger index = 0;
    DHAlertConfig *config = [DHAlertConfig defaultConfig];
    for (NSString *title in actionTitles) {
        UIAlertActionStyle style = UIAlertActionStyleDefault;
        if ([title isEqualToString:@"取消"]) {
            style = UIAlertActionStyleCancel;
        }
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
            if (actionCallBack) {
                actionCallBack(index);
            }
        }];
        
        UIColor *actionTextColor = config.actionTextColors[title];
        if (!actionTextColor) {
            actionTextColor = config.normalColor;
        }
        
        if (actionTextColor) {
            [action setValue:actionTextColor forKey:@"_titleTextColor"];
        }
        
        [alertController addAction:action];
        index ++ ;
    }
    
    //iPad需要以下代码，否则崩溃
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    if (popover) {
        popover.sourceView = self.view;
        popover.sourceRect = CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

/** 中间弹出框 */
- (void)dh_alertTitle:(NSString*)title
                 msg:(NSString*)msg
        actionTitles:(NSArray*)actionTitles
      actionCallBack:(void (^)(NSInteger index))actionCallBack {
    [self dh_alertTitle:title
                    msg:msg
         preferredStyle:UIAlertControllerStyleAlert
           actionTitles:actionTitles
         actionCallBack:actionCallBack];
}

/** 底部弹出框 */
- (void)dh_actionSheetTitle:(NSString*)title
                       msg:(NSString*)msg
              actionTitles:(NSArray*)actionTitles
            actionCallBack:(void (^)(NSInteger index))actionCallBack {
    [self dh_alertTitle:title msg:msg preferredStyle:UIAlertControllerStyleActionSheet actionTitles:actionTitles actionCallBack:actionCallBack];
}

- (void)dh_alertTitle:(NSString *)title
              message:(NSString *)msg
          sureHandler:(void(^)(void))sureHandler {
    DHAlertConfig *config = [DHAlertConfig defaultConfig];
    [self dh_alertTitle:title
                    msg:msg
           actionTitles:@[config.singleTitle ? : @"确定"]
         actionCallBack:^(NSInteger index) {
             sureHandler();
         }];
}

@end

@implementation NSObject (DH)

- (UIViewController*)getCurrentVC {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
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

@end
