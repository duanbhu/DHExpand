//
//  DHUpdateApp.m
//  DHExpand
//
//  Created by bangju on 2019/3/11.
//  Copyright © 2019年 duan. All rights reserved.
//

#import "DHUpdateApp.h"
#import "UIViewController+DHAlert.h"

@implementation DHUpdateApp

+ (void)dh_checkForUpdatesWithAPPID:(NSString *)appId {
    
    [self dh_checkForUpdatesWithAPPID:appId completion:^(NSString *currentVersion, NSString *storeVersion, NSString *openURLString, BOOL isUpdate) {
        if (isUpdate) {
            [self showAlertViewTitle:@"发现新版本" msg:[NSString stringWithFormat:@"检测到新版本%@,是否更新？",storeVersion] openUrl:openURLString];
        }
    }];
}

+ (void)dh_checkForUpdatesWithAPPID:(NSString *)appId completion:(DHCheckCompletion)completion {
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    __block NSString *currentVersion = infoDic[@"CFBundleShortVersionString"];
    NSURLRequest *request;
    
    if (!appId || [appId isEqualToString:@""]) {
        // 需要填写appID
        return ;
    }
    request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",appId]]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // 不更新
                if (completion) {
                    completion(currentVersion,nil,nil,NO);
                }
            });
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([appInfoDic[@"resultCount"] integerValue] == 0) {
                // 检测出未上架的APP或者查询不到
                if (completion) {
                    completion(currentVersion,nil,nil,NO);
                }
                return;
            }
            
            NSDictionary *infoDict = appInfoDic[@"results"][0] ;
            NSString *appStoreVersion = infoDict[@"version"];
            
            BOOL isUpdate = [self isUpdateWithCurrentVerson:currentVersion storeVerson:appStoreVersion];
            if (completion) {
                completion(currentVersion,appStoreVersion,infoDict[@"trackViewUrl"],isUpdate);
            }
        });
    }];
    [task resume];
}

/**
 比较应用在App Store里的版本号和当前版本号，来确定是不是最新版本
 按照.分割字符串，然后逐级比较版本大小。

 @param currentVersion 当前版本号
 @param storeVersion 商店的版本号
 @return YES : 商店本号大于当前版本，需要更新；
          NO : 商店当前版本号 <= 当前版本，不需要更新，
 */
+ (BOOL)isUpdateWithCurrentVerson:(NSString *)currentVersion storeVerson:(NSString *)storeVersion {
    
    NSArray *currentArr = [currentVersion componentsSeparatedByString:@"."];
    NSArray *storeArr = [storeVersion componentsSeparatedByString:@"."];
    
    NSInteger maxCount = MAX(currentArr.count, storeArr.count);
    
    for (int i = 0; i < maxCount; i ++) {
        
        NSInteger current_i_tmp = 0;
        if (i < currentArr.count) {
            current_i_tmp = [currentArr[i] integerValue];
        }
        
        NSInteger store_i_tmp = 0;
        if (i < storeArr.count) {
            store_i_tmp = [storeArr[i] integerValue];
        }
        
        // 当前版本小于商店版本，需要更新
        if (current_i_tmp < store_i_tmp) {
            return YES ;
        }
        // 当前位数相同，跳出当前循环，比较下一位
        else if (current_i_tmp == store_i_tmp) {
            continue;
        }
        // 当前版本大于商店版本，不需要更新
        else {
            return NO ;
        }
    }
    // 当前版本和商店版本一样
    return NO ;
}

// 弹出更新提示
+ (void)showAlertViewTitle:(NSString *)title msg:(NSString *)msg openUrl:(NSString *)openUrl {
    
    UIViewController *currentVC = [self getCurrentVC];
    [currentVC dh_alertTitle:title msg:msg actionTitles:@[@"下次再说",@"更新"] actionCallBack:^(NSInteger index) {
        if (index) {
            [self launchAppStoreWithITunesString:openUrl];
        }
    }];
}

// 打开App Store 更新软件
+ (void)launchAppStoreWithITunesString:(NSString *) iTunesString {
    
    NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:iTunesURL options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:iTunesURL];
        }
    });
}

@end
