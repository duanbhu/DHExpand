//
//  UIView+DH.m
//  DHExpand
//
//  Created by duan on 2019/3/28.
//  Copyright © 2019年 duan. All rights reserved.
//

#import "UIView+DH.h"
#import <objc/runtime.h>
@implementation UIView (DH)

- (void)dh_setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = cornerRadius > 0;
}

- (void)dh_setBorderColor:(UIColor*)borderColor {
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = 1;
}

- (void)dh_setCornerRadius:(CGFloat)cornerRadius borderColor:(UIColor*)borderColor {
    [self dh_setCornerRadius:cornerRadius];
    [self dh_setBorderColor:borderColor];
}

- (void)dh_underlineWithColor:(UIColor*)color {
    [self dh_underlineWithColor:color margin:0];
}

- (void)dh_underlineWithColor:(UIColor*)color margin:(CGFloat)margin {
    [self dh_underlineWithColor:color leftMargin:margin rightMargin:margin];
}

- (void)dh_underlineWithColor:(UIColor*)color leftMargin:(CGFloat)leftMargin {
    [self dh_underlineWithColor:color leftMargin:leftMargin rightMargin:0];
}

- (void)dh_underlineWithColor:(UIColor*)color leftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin {
    CALayer *layer = [CALayer layer];
    CGFloat height = 1 / [UIScreen mainScreen].scale;
    layer.frame = CGRectMake(leftMargin, CGRectGetHeight(self.frame) - height, CGRectGetWidth(self.frame) - leftMargin - rightMargin, height);
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
}

/**
 * 添加单击手势
 */
- (void)dh_addTapGestureTarget:(id)target action:(SEL)action {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
}

/**
 * 单击手势的回调
 */
- (void)dh_addTapGestureBlock:(DHTapGestureBlock)tapGestureBlock {
    objc_setAssociatedObject(self, _cmd, tapGestureBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self dh_addTapGestureTarget:self action:@selector(clickedHandldTap:)];
}

// 点击手势
- (void)clickedHandldTap:(UITapGestureRecognizer*)tap {
    DHTapGestureBlock tapGestureBlock = objc_getAssociatedObject(self, @selector(dh_addTapGestureBlock:));
    if (tapGestureBlock) {
        tapGestureBlock(tap);
    }
}

@end

@implementation UIView (Layer)

- (void)dh_setDefaultShadow {
    [self dh_setCornerRadius:6
                 shadowColor:[UIColor colorWithWhite:0 alpha:0.05]
                shadowOffset:CGSizeMake(0,2)
               shadowOpacity:1
                shadowRadius:4];
}

- (void)dh_setCornerRadius:(CGFloat)cornerRadius
               shadowColor:(UIColor *)shadowColor
              shadowOffset:(CGSize)shadowOffset
             shadowOpacity:(CGFloat)shadowOpacity
              shadowRadius:(CGFloat)shadowRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = shadowOffset;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowRadius = shadowRadius;
}

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
                      locations:(NSArray <NSNumber *>*)locations {
    for (CALayer *layer in self.layer.sublayers) {
        if ([layer.name isEqualToString:@"dh_gradientLayer"]) {
            [layer removeFromSuperlayer];
            break;
        }
    }
    NSMutableArray *colorArray = [NSMutableArray array];
    for (UIColor *color in colors) {
        [colorArray addObject:(__bridge id)color.CGColor];
    }
    // 渐变色
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.name = @"dh_gradientLayer";
    gl.frame = rect;
    gl.startPoint = startPoint;
    gl.endPoint = endPoint;
    gl.colors = colorArray;
    gl.locations = locations;
    [self.layer insertSublayer:gl atIndex:0];
}

- (void)dh_setGradientWithframe:(CGRect)rect
                     startPoint:(CGPoint)startPoint
                       endPoint:(CGPoint)endPoint
                         colors:(NSArray <UIColor *>*)colors {
    [self dh_setGradientWithframe:rect startPoint:startPoint endPoint:endPoint colors:colors locations:@[@(0.0f), @(1.0f)]];
}

/// 设置渐变背景色  从上到下
- (void)dh_setGradientVerWithframe:(CGRect)rect colors:(NSArray <UIColor *>*)colors {
    [self dh_setGradientWithframe:rect startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 1) colors:colors];
}

/// 设置渐变背景色  从左到右
- (void)dh_setGradientHorWithframe:(CGRect)rect colors:(NSArray <UIColor *>*)colors {
    [self dh_setGradientWithframe:rect startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colors:colors];
}

/// 设置渐变背景色  从上到下
- (void)dh_setGradientVerWithColors:(NSArray <UIColor *>*)colors {
    [self dh_setGradientVerWithframe:self.bounds colors:colors];
}

/// 设置渐变背景色  从左到右
- (void)dh_setGradientHorWithColors:(NSArray <UIColor *>*)colors {
    [self dh_setGradientHorWithframe:self.bounds colors:colors];
}

@end

@implementation UIView (Add)

- (void)dh_addSubviews:(NSArray *)subviews {
    for (UIView *v in subviews) {
        [self addSubview:v];
    }
}

- (void)dh_removeAllSubviews {
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

@end
