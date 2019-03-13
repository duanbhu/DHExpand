//
//  UIViewController+DHAlert.h
//  DHXuanWuJi
//
//  Created by duan on 2018/3/29.
//  Copyright © 2018年 duan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DHAlert)

/**
 底部弹出

 @param title title
 @param msg msg
 @param actionTitles 按钮title数组
 @param actionCallBack 点击按钮的回调
 */
-(void)dh_actionSheetTitle:(NSString*)title
                      msg:(NSString*)msg
             actionTitles:(NSArray*)actionTitles
           actionCallBack:(void (^)(NSInteger index))actionCallBack ;

/**
 中间弹出框

 @param title title
 @param msg msg
 @param actionTitles 按钮title数组
 @param actionCallBack 点击按钮的回调
 */
-(void)dh_alertTitle:(NSString*)title
                 msg:(NSString*)msg
        actionTitles:(NSArray*)actionTitles
      actionCallBack:(void (^)(NSInteger index))actionCallBack;

/**
 中间弹出框 ，只有一个确定按钮
 
 @param title title
 @param msg msg
 @param sureHandler 点击确定按钮的回调
 */
-(void)dh_alertTitle:(NSString*)title
             message:(NSString*)msg
         sureHandler:(void (^)(void))sureHandler ;

@end


@interface UIView (DH)

/**
 获取当前view controller

 @return 当前显示的view controller
 */
- (UIViewController*)getCurrentVC ;

@end
