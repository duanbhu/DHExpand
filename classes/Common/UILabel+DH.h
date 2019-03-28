//
//  UILabel+DH.h
//  DHExpand
//
//  Created by bangju on 2019/3/27.
//  Copyright © 2019年 duan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (DH)

+ (instancetype)dh_labelWithTitle:(NSString *)title
                        textColor:(UIColor *)textColor
                         fontSize:(NSInteger)fontSize;

- (NSMutableAttributedString *)dh_attributedText;

/** 设置label的字体、颜色 */
- (void)dh_setAttributedTextFont:(UIFont*)font textColor:(UIColor*)textColor range:(NSRange)range;

/** 设置label的字体 */
- (void)dh_setAttributedTextFont:(UIFont*)font range:(NSRange)range;

/** 设置label的颜色 */
- (void)dh_setAttributedTextColor:(UIColor*)textColor range:(NSRange)range;

/** 行间距 */
- (void)dh_setLineSpacing:(CGFloat)lineSpacing;

/** 字间距 */
- (void)dh_setWordSpacing:(CGFloat)wordSpacing;

@end

NS_ASSUME_NONNULL_END
