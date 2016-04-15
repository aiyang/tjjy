//
//  SomeSymbolsInstantData_DownObj.m
//  CNTJJY
//
//  Created by totrade on 16/1/14.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "SomeSymbolsInstantData_DownObj.h"
#import "TimeTools.h"

@implementation SomeSymbolsInstantData_DownObj

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super initWithDictionary:dic];
    if (self) {
        
    }
    return self;
    
}

//此处直接截取感觉不对,有的地方需要用到精确数字
- (NSString *)yclose
{
    NSString *temp = @"";
    temp = [TimeTools cutZero:_yclose];
    return temp;
}

- (NSString *)high
{
    NSString *temp = @"";
    temp = [TimeTools cutZero:_high];
    return temp;
}

- (NSString *)low
{
    NSString *temp = @"";
    temp = [TimeTools cutZero:_low];
    return temp;
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

//CGFloat swing = ([some_DownObj.high floatValue] - [some_DownObj.low floatValue]) / [some_DownObj.yclose floatValue];
//_swingLB.text = [NSString stringWithFormat:@"%.2f%%", swing];//双%代表%//振幅
- (NSString *)swing
{
    NSString *temp = @"";
    temp = [NSString stringWithFormat:@"%.4f",([_high floatValue] - [_low floatValue]) /[_yclose floatValue] * 100];
    if ([_yclose floatValue] <= 0.0f) {
        temp = [NSString stringWithFormat:@"%.4f",([_high floatValue] - [_low floatValue]) /[_o floatValue] * 100];
    }
    temp = [TimeTools cutZero:temp];
    temp = [NSString stringWithFormat:@"%@%%", temp];
    return temp;
}


#warning count大于0小于7,symbolsCodes最多可输入6个商品
+(NSString *)getUrlWithInterface:(NSString *)interface count:(NSInteger)count codes:(NSArray *)symbolsCodes
{
    
    //http://103.25.42.173:805/SomeSymbols.aspx?count=5&s1=OIL200&s2=OIL50&s3=OIL10&s4=LSAL&s5=LSCU
    NSString *temp_Str = [NSString string];
    
    for (NSInteger i = 0; i < symbolsCodes.count; i++) {
        temp_Str = [NSString stringWithFormat:@"%@&s%d=%@", temp_Str, i + 1, symbolsCodes[i]];
    }
    
    NSString *returnUrl = [NSString stringWithFormat:@"%@SomeSymbols.aspx?count=%d%@", interface, count, temp_Str];
    return returnUrl;
}

+(NSArray *)getUrlArrWithInterface:(NSString *)interface count:(NSInteger)count codes:(NSArray *)symbolsCodes
{
    
    //http://103.25.42.173:805/SomeSymbols.aspx?count=5&s1=OIL200&s2=OIL50&s3=OIL10&s4=LSAL&s5=LSCU
    
    NSMutableArray *tempUrlArr = [NSMutableArray array];

    for (NSInteger j = 0; j < symbolsCodes.count / 6; j++) {
        
        NSString *temp_TheUrl = [NSString string];
        for (NSInteger i = 0; i < 6; i++) {
            temp_TheUrl = [NSString stringWithFormat:@"%@&s%d=%@", temp_TheUrl, i + 1, symbolsCodes[j * 6 + i]];
        }
        
        NSString *subsUrl = [NSString stringWithFormat:@"%@SomeSymbols.aspx?count=%d%@", interface, 6, temp_TheUrl];
        [tempUrlArr addObject:subsUrl];
    }
    
    if (symbolsCodes.count % 6 != 0) {
    
        NSString *temp_TheUrl = [NSString string];
        for (NSInteger i = 0; i < symbolsCodes.count % 6; i++) {
            temp_TheUrl = [NSString stringWithFormat:@"%@&s%d=%@", temp_TheUrl, i + 1, symbolsCodes[tempUrlArr.count * 6 + i]];
        }
        
        NSString *subsUrl = [NSString stringWithFormat:@"%@SomeSymbols.aspx?count=%d%@", interface, symbolsCodes.count % 6, temp_TheUrl];
        [tempUrlArr addObject:subsUrl];
    }

    return tempUrlArr;
    
    
}



@end
