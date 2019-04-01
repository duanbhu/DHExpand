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

- (void)dh_addTapGestureTarget:(id)target action:(SEL)action {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
}

- (void)dh_addTapGestureBlock:(DHTapGestureBlock)tapGestureBlock {
    objc_setAssociatedObject(self, _cmd, tapGestureBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self dh_addTapGestureTarget:self action:@selector(clickedHandldTap:)];
}

- (void)clickedHandldTap:(UITapGestureRecognizer*)tap {
    DHTapGestureBlock tapGestureBlock = objc_getAssociatedObject(self, @selector(dh_addTapGestureBlock:));
    if (tapGestureBlock) {
        tapGestureBlock(tap);
    }
}

@end
