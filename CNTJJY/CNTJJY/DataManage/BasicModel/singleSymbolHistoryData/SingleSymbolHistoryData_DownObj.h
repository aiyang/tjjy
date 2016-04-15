//
//  SingleSymbolHistoryData_DownObj.h
//  CNTJJY
//
//  Created by totrade on 16/1/18.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "BasicObject.h"

@interface SingleSymbolHistoryData_DownObj : BasicObject

//某个商品历史数据
//singleSymbolHistoryData

//t(时间戳)
//c(收盘价)
//o(开盘价)
//high(最高价)
//low(最低价)
//输出参数v代表成交量，a代表成交金额，建议不使用

@property (nonatomic, strong)NSString *t;
@property (nonatomic, strong)NSString *c;
@property (nonatomic, strong)NSString *o;
@property (nonatomic, strong)NSString *high;
@property (nonatomic, strong)NSString *low;
@property (nonatomic, strong)NSString *v;
@property (nonatomic, strong)NSString *a;

//获取最新的前top条
+(NSString *)getUrlInterface:(NSString *)interface code:(NSString *)symbolcode kType:(NSString *)kType top:(NSString *)top;

//通过start和stop时间获取多少条
+(NSString *)getUrlInterface:(NSString *)interface code:(NSString *)symbolcode kType:(NSString *)kType start:(NSString *)start stop:(NSString *)stop;

@end
