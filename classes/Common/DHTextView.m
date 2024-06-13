//
//  DHTextView.m
//  DHExpand
//
//  Created by duan on 2019/4/24.
//  Copyright © 2019年 duan. All rights reserved.
//

#import "DHTextView.h"

@interface DHTextView()

@property (nonatomic, strong) UILabel  *placeholderLab;

@end

@implementation DHTextView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_placeholderLab) {
        UIEdgeInsets textContainerInset = self.textContainerInset;
        CGFloat lineFragmentPadding = self.textContainer.lineFragmentPadding;
        CGFloat x = lineFragmentPadding + textContainerInset.left + self.layer.borderWidth;
        CGFloat y = textContainerInset.top + self.layer.borderWidth;
        CGFloat width = CGRectGetWidth(self.bounds) - x - textContainerInset.right - self.layer.borderWidth;
        CGFloat height = [self.placeholderLab sizeThatFits:CGSizeMake(width, 0)].height;
        self.placeholderLab.frame = CGRectMake(x, y, width, height);
    }
}

- (void)textViewDidChange {
    _placeholderLab.hidden = self.text.length;
    if (self.autoHeight) {
        CGSize size = [self sizeThatFits:CGSizeMake(CGRectGetWidth(self.frame), 0)];
        CGRect rect = self.frame;
        rect.size.height = size.height > _autoHeight ? _autoHeight : size.height;
        self.frame = rect;
    }
    
    if (self.textDidChangeHandle) {
        self.textDidChangeHandle(self.text, self.frame.size);
    }
}

#pragma mark - setter

- (void)setText:(NSString *)text {
    [super setText:text];
    _placeholderLab.hidden = text.length;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    _placeholderLab.font = font;
}

- (void)setPlaceholder:(NSString *)placeholder {
    self.placeholderLab.text = placeholder;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    self.placeholderLab.textColor = placeholderColor;
}

#pragma mark - getter

- (UILabel *)placeholderLab {
    if (!_placeholderLab) {
        _placeholderLab = [UILabel new];
        _placeholderLab.textColor = [UIColor grayColor];
        _placeholderLab.font = self.font;
        _placeholderLab.numberOfLines = 0;
        [self addSubview:_placeholderLab];
    }
    return _placeholderLab;
}

@end
