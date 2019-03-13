//
//  DHUpdateApp.h
//  DHExpand
//
//  Created by bangju on 2019/3/11.
//  Copyright © 2019年 duan. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 检验结束后的回调

 @param currentVersion 当前版本
 @param storeVersion App Store中的版本
 @param openURLString URL App在App Store中的地址
 @param isUpdate 是否需要更新
 */
typedef void (^DHCheckCompletion)(NSString * currentVersion, NSString *storeVersion, NSString *openURLString, BOOL isUpdate);

NS_ASSUME_NONNULL_BEGIN

@interface DHUpdateApp : NSObject


/**
 检验是不是最新版本，提示去App Store更新

 @param appId Apple id （在App Store Connect中查看）
 */
+ (void)dh_checkForUpdatesWithAPPID:(NSString *)appId ;


/**
 检验是不是最新版本

 @param appId Apple id （在App Store Connect中查看）
 @param completion 检验结束后的回调
 */
+ (void)dh_checkForUpdatesWithAPPID:(NSString *)appId completion:(DHCheckCompletion)completion ;

@end

NS_ASSUME_NONNULL_END
