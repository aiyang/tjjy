//
//  SingleExchangeAllSymbolsInstantData_DownObj.h
//  CNTJJY
//
//  Created by totrade on 16/1/14.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "BasicObject.h"

@interface SingleExchangeAllSymbolsInstantData_DownObj : BasicObject



//某个交易所所有商品即时数据
//singleExchangeAllSymbolsInstantData

//11个参数
//code（商品code）
//name（商品中文名称）
//t(时间戳)
//c(收盘价)
//o(开盘价)
//high(最高价)
//low(最低价)
//buy（买）
//sell（卖）
//yclose（昨收价）
//volume（即时成交量）

@property (nonatomic, strong)NSString *code;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *t;
@property (nonatomic, strong)NSString *c;
@property (nonatomic, strong)NSString *o;
@property (nonatomic, strong)NSString *high;
@property (nonatomic, strong)NSString *low;
@property (nonatomic, strong)NSString *buy;
@property (nonatomic, strong)NSString *sell;
@property (nonatomic, strong)NSString *yclose;
@property (nonatomic, strong)NSString *volume;


//自己补得字段,下行数据里没有
@property (nonatomic, strong)NSString *upDown;
@property (nonatomic, strong)NSString *upDownRange;

//涨跌=今收盘-昨收盘；
//涨跌幅=涨跌值/昨收盘*100%。

+(NSString *)getUrlWithInterface:(NSString *)interface code:(NSString *)exchCode;

@end
