//
//  UIView+DH.h
//  DHExpand
//
//  Created by bangju on 2019/3/28.
//  Copyright © 2019年 duan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DHTapGestureBlock)(UITapGestureRecognizer *tap);

@interface UIView (DH)

- (void)dh_setCornerRadius:(CGFloat)cornerRadius;
- (void)dh_setBorderColor:(UIColor*)borderColor;
- (void)dh_setCornerRadius:(CGFloat)cornerRadius borderColor:(UIColor*)borderColor;

// 添加单击手势
- (void)dh_addTarget:(id)target action:(SEL)action;

// 单击手势的回调
- (void)dh_addTapGestureBlock:(DHTapGestureBlock)tapGestureBlock;

@end

NS_ASSUME_NONNULL_END
