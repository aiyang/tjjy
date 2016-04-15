//
//  SingleSymbolInstantData_DownObj.m
//  CNTJJY
//
//  Created by totrade on 16/1/14.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "SingleSymbolInstantData_DownObj.h"

@implementation SingleSymbolInstantData_DownObj


+(NSString *)getUrlInterface:(NSString *)interface code1:(NSString *)symbolcode code2:(NSString *)exchCode
{
//    http://103.25.42.173:805/ExchangeSymbol.aspx?symbolCode=USD&exchCode=mt4
//    ExchangeSymbol.aspx?symbolCode=USD&exchCode=mt4
    NSString *returnUrl = [NSString stringWithFormat:@"%@ExchangeSymbol.aspx?symbolCode=%@&exchCode=%@", interface, symbolcode, exchCode];
    return returnUrl;
}

@end
