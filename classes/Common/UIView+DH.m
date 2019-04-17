//
//  UIView+DH.m
//  DHExpand
//
//  Created by bangju on 2019/3/28.
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
