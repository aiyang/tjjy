//
//  SingleSymbolHistoryData_DownObj.m
//  CNTJJY
//
//  Created by totrade on 16/1/18.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "SingleSymbolHistoryData_DownObj.h"

@implementation SingleSymbolHistoryData_DownObj

//获取最新的前top条
+(NSString *)getUrlInterface:(NSString *)interface code:(NSString *)symbolcode kType:(NSString *)kType top:(NSString *)top
{
    //http://103.25.42.173:805/History.aspx?symbolCode=AG200&top=100&type=day
    NSString *returnUrl = [NSString stringWithFormat:@"%@History.aspx?symbolCode=%@&top=%@&type=%@", interface, symbolcode, top, kType];
    return returnUrl;
    
}

//通过start和stop时间获取多少条
+(NSString *)getUrlInterface:(NSString *)interface code:(NSString *)symbolcode kType:(NSString *)kType start:(NSString *)start stop:(NSString *)stop
{
    // http://103.25.42.173:805/History.aspx?symbolCode=AG200&start=1452614400&stop=1452700800&type=day
    NSString *returnUrl = [NSString stringWithFormat:@"%@History.aspx?symbolCode=%@&start=%@&stop=%@&type=%@", interface, symbolcode, start, stop, kType];
    return returnUrl;
    
    
}

@end
