//
//  UIView+DH.h
//  DHExpand
//
//  Created by duan on 2019/3/28.
//  Copyright © 2019年 duan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DHTapGestureBlock)(UITapGestureRecognizer *tap);

@interface UIView (DH)

+ (instancetype)viewWithColor:(UIColor *)color;

- (void)dh_setCornerRadius:(CGFloat)cornerRadius;
- (void)dh_setBorderColor:(UIColor*)borderColor;
- (void)dh_setCornerRadius:(CGFloat)cornerRadius borderColor:(UIColor*)borderColor;

- (void)dh_underlineWithColor:(UIColor*)color;
- (void)dh_underlineWithColor:(UIColor*)color margin:(CGFloat)margin;
- (void)dh_underlineWithColor:(UIColor*)color leftMargin:(CGFloat)leftMargin;
- (void)dh_underlineWithColor:(UIColor*)color leftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin;

/** 添加单击手势 */
- (void)dh_addTapGestureTarget:(id)target action:(SEL)action;

/** 单击手势的回调 */
- (void)dh_addTapGestureBlock:(DHTapGestureBlock)tapGestureBlock;

@end

/// 阴影
@interface UIView (Layer)

- (void)dh_setRoundingCorners:(UIRectCorner)corner cornerRadii:(CGFloat)cornerRadii;

- (void)dh_setRoundingCorners:(UIRectCorner)corner cornerRadii:(CGFloat)cornerRadii roundedRect:(CGRect)rect;

/// 添加阴影
- (void)dh_setDefaultShadow;

/// 添加阴影
- (void)dh_setCornerRadius:(CGFloat)cornerRadius
               shadowColor:(UIColor *)shadowColor
              shadowOffset:(CGSize)shadowOffset
             shadowOpacity:(CGFloat)shadowOpacity
              shadowRadius:(CGFloat)shadowRadius;

/// 设置渐变背景色  从startPoint到endPoint
/// @param rect 尺寸  self.bounds
/// @param startPoint 初始位置
/// @param endPoint 结束位置
/// @param colors 渐变颜色
/// @param locations 渐变
- (void)dh_setGradientWithframe:(CGRect)rect
                     startPoint:(CGPoint)startPoint
                       endPoint:(CGPoint)endPoint
                         colors:(NSArray <UIColor *>*)colors
                      locations:(NSArray <NSNumber *>*)locations;

- (void)dh_setGradientWithframe:(CGRect)rect
                     startPoint:(CGPoint)startPoint
                       endPoint:(CGPoint)endPoint
                         colors:(NSArray <UIColor *>*)colors;

/// 设置渐变背景色  从上到下
- (void)dh_setGradientVerWithframe:(CGRect)rect colors:(NSArray <UIColor *>*)colors;

/// 设置渐变背景色  从左到右
- (void)dh_setGradientHorWithframe:(CGRect)rect colors:(NSArray <UIColor *>*)colors;

/// 设置渐变背景色  从上到下
- (void)dh_setGradientVerWithColors:(NSArray <UIColor *>*)colors;

/// 设置渐变背景色  从左到右
- (void)dh_setGradientHorWithColors:(NSArray <UIColor *>*)colors;

@end

@interface UIView (Add)

- (void)dh_addSubviews:(NSArray *)subviews;

- (void)dh_removeAllSubviews;

- (void)dh_addSubview:(UIView *)firstView, ... NS_REQUIRES_NIL_TERMINATION;

@end


NS_ASSUME_NONNULL_END
