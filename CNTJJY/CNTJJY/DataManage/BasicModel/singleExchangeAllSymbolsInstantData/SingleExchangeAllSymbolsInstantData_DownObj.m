//
//  SingleExchangeAllSymbolsInstantData_DownObj.m
//  CNTJJY
//
//  Created by totrade on 16/1/14.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "SingleExchangeAllSymbolsInstantData_DownObj.h"
#import "TimeTools.h"

@implementation SingleExchangeAllSymbolsInstantData_DownObj

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super initWithDictionary:dic];
    if (self) {
        
    }
    return self;
    
}

- (NSString *)c
{
    NSString *temp = @"";
    temp = [TimeTools cutZero:_c];
    return temp;
}

- (NSString *)o
{
    NSString *temp = @"";
    temp = [TimeTools cutZero:_o];
    return temp;
}

- (NSString *)buy
{
    NSString *temp = @"";
    temp = [TimeTools cutZero:_buy];
    return temp;
}

- (NSString *)sell
{
    NSString *temp = @"";
    temp = [TimeTools cutZero:_sell];
    return temp;
}

//涨跌=今收盘-昨收盘；
//涨跌幅=涨跌值/昨收盘*100%。

- (NSString *)upDown
{
    NSString *temp = @"";
    temp = [NSString stringWithFormat:@"%.4f", [_c floatValue] - [_yclose floatValue]];
    temp = [TimeTools cutZero:temp];
    return temp;
    
}

- (NSString *)upDownRange
{
    NSString *temp = @"";
    temp = [NSString stringWithFormat:@"%.4f",([_c floatValue] - [_yclose floatValue]) /[_yclose floatValue] * 100];
    if ([_yclose floatValue] <= 0.0f) {
        temp = [NSString stringWithFormat:@"%.4f",([_c floatValue] - [_o floatValue]) /[_o floatValue] * 100];
    }
    temp = [TimeTools cutZero:temp];
    temp = [NSString stringWithFormat:@"%@%%", temp];
    return temp;
}

+(NSString *)getUrlWithInterface:(NSString *)interface code:(NSString *)exchCode
{
    //    http://103.25.42.173:805/ExchangeSymbol.aspx?exchCode=QILUCE
    NSString *returnUrl = [NSString stringWithFormat:@"%@ExchangeSymbol.aspx?exchCode=%@", interface, exchCode];
    return returnUrl;
}

@end
