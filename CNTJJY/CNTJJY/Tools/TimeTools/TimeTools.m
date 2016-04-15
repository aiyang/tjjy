//
//  TimeTools.m
//  CNTJJY
//
//  Created by totrade on 16/1/29.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "TimeTools.h"
#import "sys/utsname.h"

@implementation TimeTools

+ (NSString *)getNowTime
{
    NSDate *contractTimeDate = [NSDate new];
    NSLog(@"控制台输出时间比实际时间:%@", contractTimeDate);//2015-07-29 08:04:16 +0000,控制台输出时间比实际时间少8小时,好吧,在label上也是这么显示的
    //这样就没有8小时的差值了,但是秒数不对啊!!!
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy/MM/dd HH:mm"];//hh代表12小时
    NSString *localDateStr = [formatter1 stringFromDate:contractTimeDate];
    NSLog(@"控制台输出时间%@", localDateStr);
    return localDateStr;
}

//从当前时间到早上6点,一共多少分钟就请求多少个数
+ (NSString *)getTLineRequestCount
{
    //获取当前时间的时,分
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitHour| NSCalendarUnitMinute;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate new]];
    NSInteger hour = [comps hour];
    NSInteger minute = [comps minute];
    if (hour < 6) {
        hour = hour + 24;
    }
    NSInteger nowMinuts = hour * 60 + minute;//现在时间转化分钟数
    NSInteger sixMinuts = 6 * 60;//6:00转换分钟数
    NSString *requestCount = [NSString stringWithFormat:@"%d", nowMinuts - sixMinuts];
    
    return requestCount;
    
}

+ (NSArray *)getTLineStartStop
{
    NSDate *contractTimeDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString *sixDate = [formatter stringFromDate:contractTimeDate];
    sixDate = [NSString stringWithFormat:@"%@%@", sixDate, @" 06:00:00"];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *sixDate2 = [formatter dateFromString:sixDate];
    NSTimeInterval sixInterval = [sixDate2 timeIntervalSince1970];//今日06:00点的时间戳
    NSString *sixString = [NSString stringWithFormat:@"%.0f", sixInterval];
    
    
    NSTimeInterval nowInterval = [[NSDate date] timeIntervalSince1970];//当前时间的时间戳
    NSString *nowString = [NSString stringWithFormat:@"%.0f", nowInterval];
    return @[sixString, nowString];
}

+ (BOOL)JudgeisSystemNightMode
{
    //获取当前时间的时,分
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitHour| NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate new]];
    NSInteger hour = [comps hour];
    NSInteger minute = [comps minute];
    NSInteger second = [comps second];
    
    NSInteger point7 = 7 * 60 * 60;
    NSInteger point19 = 19 * 60 * 60;
    
    NSInteger pointCurrent = hour * 60 * 60 + minute * 60 + second;
    
    
    if (point7 < pointCurrent && pointCurrent < point19) {//NO
        return NO;
    }else{//7:00--19:00
        return YES;
    }

}

+ (NSArray *)getNewDateArrWithDateArr:(NSArray *)dateArr count:(NSInteger)count
{
    double firstInterval = 0.0f;
    double lastInterval = 0.0f;
    if (dateArr.count == 1) {
        firstInterval = [[dateArr[0] firstObject] doubleValue];
        lastInterval = [[dateArr[0] lastObject] doubleValue];
    }else{
        firstInterval = [[dateArr firstObject] doubleValue];
        lastInterval = [[dateArr lastObject] doubleValue];
    }
    
    double theGap = fabs(firstInterval - lastInterval) / (double)(count - 1);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSMutableArray *returnArr = [NSMutableArray array];
    for (NSInteger i = 0; i < count; i++) {
        NSTimeInterval tempDouble = lastInterval + i * theGap;
        NSDate *tempDate = [NSDate dateWithTimeIntervalSince1970:tempDouble];
        NSString *dateStr = [formatter stringFromDate:tempDate];
        [returnArr addObject:dateStr];
    }
    return returnArr;
}

+ (NSString *)getDateStringFromTimeInterval:(NSString *)interval
{

    double timeInterval = [interval doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];//转成date后时间少了8个小时??
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateString = [formatter stringFromDate:date];//把date转成字符串后又恢复正常了??
//    NSLog(@"%@---%@", date, dateString);
    return dateString;
}

+ (NSString *)getWarnDateStringFromTimeInterval:(NSString *)interval
{
    double timeInterval = [interval doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];//转成date后时间少了8个小时??
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [formatter stringFromDate:date];//把date转成字符串后又恢复正常了??
    //    NSLog(@"%@---%@", date, dateString);
    return dateString;
}


+ (NSString *)cutZero:(NSString *)stringFloat
{
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    int i = length-1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0'/*0x30*/) {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return returnString;
}

//+ (NSString*)deviceString
//{
//    // 需要#import "sys/utsname.h"
//    struct utsname systemInfo;
//    uname(&systemInfo);
//    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
//    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
//    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
//    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
//    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
//    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
//    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
//    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
//    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
//    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
//    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
//    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
//    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
//    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
//    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
//    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
//    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
//    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
//    NSLog(@"NOTE: Unknown device type: %@", deviceString);
//    return deviceString;
//}

@end
