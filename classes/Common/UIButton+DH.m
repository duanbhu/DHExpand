//
//  UIButton+DH.m
//  DHExpand
//
//  Created by duan on 2019/3/27.
//  Copyright © 2019年 duan. All rights reserved.
//

#import "UIButton+DH.h"
#import <objc/runtime.h>

@interface UIButton()

@property (nonatomic, strong) NSMutableDictionary  <NSNumber *, UIColor *>*backgroundColorDict;

@property (nonatomic, strong) NSMutableDictionary  <NSNumber *, UIColor *>*borderColorDict;

@end


@implementation UIButton (DH)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod([self class], @selector(setHighlighted:)),class_getInstanceMethod([self class], @selector(dh_setHighlighted:)));
        
        method_exchangeImplementations(class_getInstanceMethod([self class], @selector(setEnabled:)),class_getInstanceMethod([self class], @selector(dh_setEnabled:)));
        
        method_exchangeImplementations(class_getInstanceMethod([self class], @selector(setSelected:)),class_getInstanceMethod([self class], @selector(dh_setSelected:)));
    });
}

+ (instancetype)dh_buttonWithTitle:(NSString *)title
                        titleColor:(UIColor *)titleColor
                              font:(UIFont *)font {
    UIButton *button = [[self alloc] init];
    button.titleLabel.font = font;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    return button;
}

+ (instancetype)dh_buttonWithTitle:(NSString *)title
                        titleColor:(UIColor*)titleColor
                              font:(UIFont *)font
                         imageName:(NSString*)imageName {
    UIButton *button = [self dh_buttonWithTitle:title titleColor:titleColor font:font];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return button;
}

+ (instancetype)dh_buttonWithTitle:(NSString *)title
                        titleColor:(UIColor*)titleColor
                              font:(UIFont *)font
                   backgroundColor:(UIColor*)backgroundColor
                      cornerRadius:(CGFloat)cornerRadius {
    UIButton *button = [self dh_buttonWithTitle:title titleColor:titleColor font:font];
    button.backgroundColor = backgroundColor;
    button.layer.cornerRadius = cornerRadius;
    button.clipsToBounds = YES;
    return button;
}

+ (instancetype)dh_buttonWithTitle:(NSString *)title
                        titleColor:(UIColor*)titleColor
                          fontSize:(NSInteger)fontSize {
    return [self dh_buttonWithTitle:title titleColor:titleColor font:[UIFont systemFontOfSize:fontSize]];
}

+ (instancetype)dh_buttonWithTitle:(NSString *)title
                        titleColor:(UIColor *)titleColor
                          fontSize:(NSInteger)fontSize
                         imageName:(NSString *)imageName {
    return [self dh_buttonWithTitle:title titleColor:titleColor font:[UIFont systemFontOfSize:fontSize] imageName:imageName];
}

+ (instancetype)dh_buttonWithTitle:(NSString *)title
                        titleColor:(UIColor*)titleColor
                          fontSize:(NSInteger)fontSize
                   backgroundColor:(UIColor*)backgroundColor
                      cornerRadius:(CGFloat)cornerRadius {
    return [self dh_buttonWithTitle:title titleColor:titleColor font:[UIFont systemFontOfSize:fontSize] backgroundColor:backgroundColor cornerRadius:cornerRadius];
}

/**
 UIControlEventTouchUpInside
 
 @param touchActionBlock 按钮点击的回调
 */
- (void)dh_addTouchActionBlock:(DHTouchActionBlock)touchActionBlock {
    objc_setAssociatedObject(self, _cmd, touchActionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
}

// 点击按钮
- (void)clickedButton:(UIButton*)sender {
    DHTouchActionBlock touchActionBlock = objc_getAssociatedObject(self, @selector(dh_addTouchActionBlock:));
    if (touchActionBlock) {
        touchActionBlock();
    }
}

/** ======================================================================= */
/** 修改是按钮的响应区域  */
- (UIEdgeInsets)responseInsets {
    return [objc_getAssociatedObject(self, @selector(setResponseInsets:)) UIEdgeInsetsValue];
}

- (void)setResponseInsets:(UIEdgeInsets)responseInsets {
    objc_setAssociatedObject(self, _cmd, [NSValue valueWithUIEdgeInsets:responseInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)dh_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, self.responseInsets)) {
        return [super pointInside:point withEvent:event];
    }
    else {
        CGRect rect = UIEdgeInsetsInsetRect(self.bounds, self.responseInsets);
        return CGRectContainsPoint(rect, point) ;
    }
}

/** ======================================================================= */
#pragma mark - public method

- (void)dh_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    if (backgroundColor) {
        [self.backgroundColorDict setObject:backgroundColor forKey:@(state)];
    }
    if (self.state == state) {
        self.backgroundColor = backgroundColor;
    }
}

- (void)dh_setBorderColor:(UIColor *)borderColor forState:(UIControlState)state {
    if (borderColor) {
        [self.borderColorDict setObject:borderColor forKey:@(state)];
    }
    if (self.state == state) {
        if (!self.layer.borderWidth) {
            self.layer.borderWidth = 1;
        }
        self.layer.borderColor = borderColor.CGColor;
    }
}

- (UIColor *)dh_backgroundColorForState:(UIControlState)state {
    return self.backgroundColorDict[@(state)];
}

- (UIColor *)dh_borderColorForState:(UIControlState)state {
    return self.borderColorDict[@(state)];
}

#pragma mark - private method
- (void)updateButton {
    
    UIColor *backgroundColor = self.backgroundColorDict[@(self.state)];
    if (backgroundColor) {
        self.backgroundColor = backgroundColor;
    }
    
    UIColor *borderColor = self.borderColorDict[@(self.state)];
    if (borderColor) {
        self.layer.borderColor = borderColor.CGColor;
    }
}

#pragma mark - override

- (void)dh_setHighlighted:(BOOL)highlighted {
    [self dh_setHighlighted:highlighted];
    [self updateButton];
}

- (void)dh_setSelected:(BOOL)selected {
    [self dh_setSelected:selected];
    [self updateButton];
}

- (void)dh_setEnabled:(BOOL)enabled {
    [self dh_setEnabled:enabled];
    [self updateButton];
}

#pragma mark - setter and getter

// 存放背景色的字典
- (NSMutableDictionary<NSNumber *,UIColor *> *)backgroundColorDict {
    NSMutableDictionary *backgroundColorDict = objc_getAssociatedObject(self, _cmd);
    if (!backgroundColorDict) {
        backgroundColorDict = [NSMutableDictionary dictionary];
        self.backgroundColorDict = backgroundColorDict;
    }
    return backgroundColorDict;
}

- (void)setBackgroundColorDict:(NSMutableDictionary<NSNumber *,UIColor *> *)backgroundColorDict {
    objc_setAssociatedObject(self, @selector(backgroundColorDict), backgroundColorDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 存放边框色的字典
- (NSMutableDictionary<NSNumber *,UIColor *> *)borderColorDict {
    NSMutableDictionary *borderColorDict = objc_getAssociatedObject(self, _cmd);
    if (!borderColorDict) {
        borderColorDict = [NSMutableDictionary dictionary];
        self.borderColorDict = borderColorDict;
    }
    return borderColorDict;
}

- (void)setBorderColorDict:(NSMutableDictionary<NSNumber *,UIColor *> *)borderColorDict {
    objc_setAssociatedObject(self, @selector(borderColorDict), borderColorDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
