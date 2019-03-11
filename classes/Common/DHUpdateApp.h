//
//  DHUpdateApp.h
//  DHExpand
//
//  Created by bangju on 2019/3/11.
//  Copyright © 2019年 duan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DHCheckCompletion)(NSString * currentVersion, NSString *storeVersion, NSString *openURLString, BOOL isUpdate);

NS_ASSUME_NONNULL_BEGIN

@interface DHUpdateApp : NSObject

+ (void)dh_checkForUpdatesWithAPPID:(NSString *)appId ;

+ (void)dh_checkForUpdatesWithAPPID:(NSString *)appId completion:(DHCheckCompletion)completion ;

@end

NS_ASSUME_NONNULL_END
