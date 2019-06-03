//
//  DHTextView.h
//  DHExpand
//
//  Created by bangju on 2019/4/24.
//  Copyright © 2019年 duan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DHTextView : UITextView

@property (nonatomic, strong) NSString  *placeholder;

@property (nonatomic, strong) UIColor   *placeholderColor;

/**
 * autoHeight > 0,自适应高度，autoHeight 为最大高度
 */
@property (nonatomic, assign) CGFloat  autoHeight;

@property (nonatomic, copy)  void (^textDidChangeHandle)(NSString *text, CGSize textViewSize);

@end

NS_ASSUME_NONNULL_END
