//
//  DHViewController.m
//  DHExpand
//
//  Created by duan on 2019/3/13.
//  Copyright © 2019年 duan. All rights reserved.
//

#import "DHViewController.h"
#import "UIViewController+DHAlert.h"
#import "UIButton+VerificationCode.h"
#import "NSString+Time.h"
#import "UIButton+DH.h"
#import "UILabel+DH.h"
#import "UIView+DH.h"
#import "MBProgressHUD+DH.h"

@interface DHViewController ()

@end

@implementation DHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DHAlertConfig *config = [DHAlertConfig defaultConfig];
    config.normalColor = [UIColor blackColor];
    config.singleTitle = @"我知道了";
    config.actionTextColors = @{@"确定":[UIColor purpleColor]};
    UIButton *alertBtn = [UIButton dh_buttonWithTitle:@"alert title"
                                           titleColor:[UIColor whiteColor]
                                             fontSize:14
                                      backgroundColor:[UIColor purpleColor]
                                         cornerRadius:0];
    alertBtn.frame = CGRectMake(10, 100, 80, 40);
    [alertBtn addTarget:self action:@selector(alert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alertBtn];
    
    UIButton *codeBtn = [UIButton dh_buttonWithTitle:@"获取验证码"
                                          titleColor:[UIColor blackColor]
                                            fontSize:14
                                     backgroundColor:[UIColor greenColor]
                                        cornerRadius:5];
    codeBtn.frame = CGRectMake(100, 100, 80, 40);
    [self.view addSubview:codeBtn];
    
    UIButton *thirdBtn = [UIButton dh_buttonWithTitle:@"third button"
                                           titleColor:[UIColor blackColor]
                                             fontSize:14];
    thirdBtn.frame = CGRectMake(190, 100, 80, 40);
    //[thirdBtn addTarget:self action:@selector(alert1) forControlEvents:UIControlEventTouchUpInside];
    [thirdBtn dh_addTouchActionBlock:^{
        thirdBtn.selected = !thirdBtn.isSelected;
        //[MBProgressHUD dh_showTipsMessage:@"操作成功" toView:self.view];
    }];
    [self.view addSubview:thirdBtn];
    
    UIButton *sheetBtn = [UIButton dh_buttonWithTitle:@"action sheet"
                                           titleColor:[UIColor blackColor]
                                             fontSize:14];
    sheetBtn.frame = CGRectMake(280, 100, 80, 40);
    [sheetBtn addTarget:self action:@selector(actionSheet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sheetBtn];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 180, 200, 40)];
    label1.text = [@"1400365418956" dh_becomeDate];
    [self.view addSubview:label1];
    
    // 当前时间
    NSString *tmp = [NSString dh_getCurrentTimestamp];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 230, 200, 40)];
    label2.text = [tmp dh_displayTime];
    [self.view addSubview:label2];
    
    // 70s前
    NSString *tmp1 = [NSString stringWithFormat:@"%ld",tmp.integerValue - 70000];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 280, 200, 40)];
    label3.text = [tmp1 dh_displayTime];
    [self.view addSubview:label3];
    
    NSString *tmp2 = [NSString stringWithFormat:@"%ld",tmp.integerValue + 80000];
    UILabel *label4 = [UILabel dh_labelWithTitle:[tmp2 dh_displayTime]
                                       textColor:[UIColor redColor]
                                        fontSize:16];
    label4.frame = CGRectMake(10, 320, 200, 40);
    [self.view addSubview:label4];
    
    UIButton *likeBtn = [UIButton dh_buttonWithTitle:@"456" titleColor:[UIColor blackColor] fontSize:14];
    [likeBtn setImage:[UIImage imageNamed:@"weibiaoti1"] forState:UIControlStateNormal];
    [likeBtn setImage:[UIImage imageNamed:@"weibiaoti1-2"] forState:UIControlStateSelected];
    [likeBtn dh_setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
    [likeBtn dh_setBackgroundColor:[UIColor greenColor] forState:UIControlStateSelected];
    [likeBtn dh_setBorderColor:[UIColor greenColor] forState:UIControlStateNormal];
    [likeBtn dh_setBorderColor:[UIColor redColor] forState:UIControlStateSelected];
    likeBtn.frame = CGRectMake(10, 370, 70, 30);
    likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    [likeBtn addTarget:self action:@selector(sdsd:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:likeBtn];
    
    
    [likeBtn dh_setGradientHorWithColors:@[[UIColor redColor], [UIColor blackColor]]];
    
    [likeBtn dh_setGradientVerWithColors:@[[UIColor whiteColor], [UIColor blackColor]]];

    
    [likeBtn dh_setGradientHorWithColors:@[[UIColor redColor], [UIColor blackColor]]];

}

- (void)sdsd:(UIButton*)sender {
    sender.selected = !sender.isSelected;
}

// UIAlertController

- (void)alert {
    
//    [self dh_alertTitle:@"提示"
//                    msg:@"setup after loading the view."
//           actionTitles:@[@"取消",@"确定"]
//         actionCallBack:^(NSInteger index) {
//             NSLog(@"点击了第%ld个",index);
//         }];
    [self dh_alertTitle:@"温馨提示" message:@"setup after loading the view." sureHandler:^{
        
    }];
}

- (void)alert1 {
    
    [self dh_alertTitle:@"提示"
                    msg:@"选择一个吧！"
           actionTitles:@[@"选项一",@"选项二",@"选项三"]
         actionCallBack:^(NSInteger index) {
             NSLog(@"点击了第%ld个",index);
         }];
}

- (void)actionSheet {
    
    [self dh_actionSheetTitle:nil
                          msg:@""
                 actionTitles:@[@"选项一",@"选项二",@"选项三",@"取消",@"选项other"]
               actionCallBack:^(NSInteger index) {
                   NSLog(@"点击了第%ld个",index);
               }];
}

// 获取验证码
- (void)getVerificationCode:(UIButton*)sender {
    [sender dh_openCountdown];
}

@end
