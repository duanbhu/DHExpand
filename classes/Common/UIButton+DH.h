//
//  UIButton+DH.h
//  DHExpand
//
//  Created by duan on 2019/3/27.
//  Copyright © 2019年 duan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DHTouchActionBlock)(void);

@interface UIButton (DH)

/** 改变按钮的响应区域 */
@property (nonatomic, assign) UIEdgeInsets responseInsets;

+ (instancetype)dh_buttonWithTitle:(NSString *)title
                        titleColor:(UIColor*)titleColor
                          fontSize:(NSInteger)fontSize;

+ (instancetype)dh_buttonWithTitle:(NSString *)title
                        titleColor:(UIColor*)titleColor
                          fontSize:(NSInteger)fontSize
                         imageName:(NSString*)imageName;

+ (instancetype)dh_buttonWithTitle:(NSString *)title
                        titleColor:(UIColor*)titleColor
                          fontSize:(NSInteger)fontSize
                   backgroundColor:(UIColor*)backgroundColor
                      cornerRadius:(CGFloat)cornerRadius;

+ (instancetype)dh_buttonWithTitle:(NSString *)title
                        titleColor:(UIColor *)titleColor
                              font:(UIFont *)font;

+ (instancetype)dh_buttonWithTitle:(NSString *)title
                        titleColor:(UIColor*)titleColor
                              font:(UIFont *)font
                         imageName:(NSString*)imageName;

+ (instancetype)dh_buttonWithTitle:(NSString *)title
                        titleColor:(UIColor*)titleColor
                              font:(UIFont *)font
                   backgroundColor:(UIColor*)backgroundColor
                      cornerRadius:(CGFloat)cornerRadius;
/**
 UIControlEventTouchUpInside

 @param touchActionBlock 按钮点击的回调
 */
- (void)dh_addTouchActionBlock:(DHTouchActionBlock)touchActionBlock ;

- (void)dh_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

// default is nil; state: normal/Highlighted/Disabled/Selected
- (void)dh_setBorderColor:(UIColor *)borderColor forState:(UIControlState)state;

- (UIColor *)dh_backgroundColorForState:(UIControlState)state;
- (UIColor *)dh_borderColorForState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
