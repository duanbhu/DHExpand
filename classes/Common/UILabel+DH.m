//
//  UILabel+DH.m
//  DHExpand
//
//  Created by duan on 2019/3/27.
//  Copyright © 2019年 duan. All rights reserved.
//

#import "UILabel+DH.h"

@implementation UILabel (DH)

+ (instancetype)dh_labelWithTitle:(NSString *)title
                        textColor:(UIColor *)textColor
                             font:(UIFont *)font {
    UILabel *label = [[self alloc] init];
    label.text = title ;
    label.textColor = textColor;
    label.font = font;
    return label;
}

- (NSMutableAttributedString *)dh_attributedText {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    if (!attributedString) {
        attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    }
    return attributedString;
}

/** 设置label的字体、颜色 */
- (void)dh_setAttributedTextFont:(UIFont*)font textColor:(UIColor*)textColor range:(NSRange)range {
    NSMutableAttributedString *attributedString = [self dh_attributedText];
    [attributedString addAttribute:NSFontAttributeName value:font range:range];
    [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    self.attributedText = attributedString;
}

/** 设置label的字体 */
- (void)dh_setAttributedTextFont:(UIFont*)font range:(NSRange)range {
    NSMutableAttributedString *attributedString = [self dh_attributedText];
    [attributedString addAttribute:NSFontAttributeName value:font range:range];
    self.attributedText = attributedString;
}

/** 设置label的颜色 */
- (void)dh_setAttributedTextColor:(UIColor*)textColor range:(NSRange)range {
    NSMutableAttributedString *attributedString = [self dh_attributedText];
    [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    self.attributedText = attributedString;
}

- (void)dh_addAttribute:(NSAttributedStringKey)name value:(id)value range:(NSRange)range {
    NSMutableAttributedString *attributedString = [self dh_attributedText];
    [attributedString addAttribute:name value:value range:range];
    self.attributedText = attributedString;
}

/** 行间距 */
- (void)dh_setLineSpacing:(CGFloat)lineSpacing {
    [self dh_setLineSpacing:lineSpacing paragraphSpacing:0 range:NSMakeRange(0, self.text.length)];
}

/** 行间距  段落间距 */
- (void)dh_setLineSpacing:(CGFloat)lineSpacing paragraphSpacing:(CGFloat)paragraphSpacing {
    [self dh_setLineSpacing:lineSpacing paragraphSpacing:paragraphSpacing range:NSMakeRange(0, self.text.length)];
}

/** 行间距  段落间距  */
- (void)dh_setLineSpacing:(CGFloat)lineSpacing paragraphSpacing:(CGFloat)paragraphSpacing range:(NSRange)range {
    NSMutableAttributedString *attributedString = [self dh_attributedText];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    // 行间距设置为verticalSpacing
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.paragraphSpacing = paragraphSpacing;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    self.attributedText = attributedString;
}

/** 字间距 */
- (void)dh_setWordSpacing:(CGFloat)wordSpacing {
    NSMutableAttributedString *attributedString = [self dh_attributedText];
    [attributedString addAttribute:NSKernAttributeName value:@(wordSpacing) range:NSMakeRange(0, [attributedString length])];
    self.attributedText = attributedString;
}

@end
