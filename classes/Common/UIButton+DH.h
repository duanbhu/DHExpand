//
//  UIButton+DH.h
//  DHExpand
//
//  Created by bangju on 2019/3/27.
//  Copyright © 2019年 duan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (DH)

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

@end

NS_ASSUME_NONNULL_END
