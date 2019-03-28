//
//  UIButton+DH.m
//  DHExpand
//
//  Created by bangju on 2019/3/27.
//  Copyright © 2019年 duan. All rights reserved.
//

#import "UIButton+DH.h"
#import <objc/runtime.h>


@implementation UIButton (DH)

+ (instancetype)dh_buttonWithTitle:(NSString *)title
                        titleColor:(UIColor*)titleColor
                          fontSize:(NSInteger)fontSize {
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    return button;
}

+ (instancetype)dh_buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(NSInteger)fontSize imageName:(NSString *)imageName {
    UIButton *button = [self dh_buttonWithTitle:title titleColor:titleColor fontSize:fontSize];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return button;
}

+ (instancetype)dh_buttonWithTitle:(NSString *)title
                        titleColor:(UIColor*)titleColor
                          fontSize:(NSInteger)fontSize
                   backgroundColor:(UIColor*)backgroundColor
                      cornerRadius:(CGFloat)cornerRadius {
    
    UIButton *button = [self dh_buttonWithTitle:title titleColor:titleColor fontSize:fontSize];
    button.backgroundColor = backgroundColor;
    button.layer.cornerRadius = cornerRadius;
    button.clipsToBounds = YES;
    return button;
}

@end
