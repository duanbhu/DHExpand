//
//  NSString+Time.m
//  DHXuanWuJi
//
//  Created by duan on 2018/3/29.
//  Copyright © 2019年 duan. All rights reserved.
//

#import "NSString+Time.h"
#import "NSDate+DH.h"

@implementation NSString (Time)

/**
 时间戳转化为时间字符串 根据当前时间来判断该时间怎样显示

 @return 时间字符串
 */
- (NSString *)dh_displayTime {
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    NSCalendar *calendar = [NSCalendar calendar];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate =  [NSDate dateWithTimeIntervalSince1970:[self dateLine]];
    
    if (createdAtDate.isToday) { // 今天
        // 手机当前时间
        NSDate *nowDate = [NSDate date];
        NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *cmps = [calendar components:unit fromDate:createdAtDate toDate:nowDate options:0];
        
        if (cmps.hour >= 1) {
            // 时间间隔 >= 1小时
            return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            
        } else if (cmps.minute >= 1) {
            // 1小时 > 时间间隔 >= 1分钟
            return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            
        } else {
            // 1分钟 > 分钟
            return @"刚刚";
        }
    } else if (createdAtDate.isYesterday) {
        // 昨天
        fmt.dateFormat = @"昨天 HH:mm:ss";
        return [fmt stringFromDate:createdAtDate];
        
    } else if (createdAtDate.isThisYear){
        // 今年
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdAtDate];
    }
    else{
        // 其他
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createdAtDate];
    }
}

#pragma mark - 时间戳转化为时间字符串

/**
 将时间戳规范化，转化为标准时间格式
 
 @param dateFormat 如： dateFormat = @"yyyy-MM-dd HH:mm:ss";
 @return 时间
 */
- (NSString*)dh_becomeDateForWithFormat:(NSString*)dateFormat {
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = dateFormat;
    NSDate *createdAtDate =  [NSDate dateWithTimeIntervalSince1970:[self dateLine]];
    
    return [fmt stringFromDate:createdAtDate];
}

/**
 年-月-日 时-分-秒
 
 @return 年-月-日 时-分-秒
 */
- (NSString*)dh_becomeDate {
    return [self dh_becomeDateForWithFormat:@"yyyy-MM-dd HH:mm"];
}

//获取当前时间戳(以毫秒为单位)
+ (NSString *)dh_getCurrentTimestamp {
    
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970] * 1000];
    
    return timeSp;
}

/**
 将秒转换成时分秒

 @param totalSeconds 秒
 @return 1:32:52
 */
+ (NSString *)dh_formattedSeconds:(int)totalSeconds {
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
}


// 在不同系统上，时间戳的位数不同（10位的和13位的）
- (NSInteger)dateLine {
    if (self.length == 10) {
        return [self integerValue];
    }
    else if (self.length == 13) {
        return [self integerValue] / 1000.0;
    }
    else {
        return 0;
    }
}

@end
