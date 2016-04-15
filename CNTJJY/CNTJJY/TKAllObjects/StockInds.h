//
//  StockInds.h
//  Study_StockInds
//
//  Created by totrade on 16/2/5.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockInds : NSObject

//date
+ (NSArray *)get_Date_witDataArr:(NSArray *)dataArr;
//Candle
+ (NSArray *)get_Candle_WithDataArr:(NSArray *)dataArr;
//MA
+ (NSArray *)get_MA_WithDataArr:(NSArray *)dataArr indexArr:(NSArray *)indexArr;
//BOLL
+ (NSArray *)get_BOLL_WithDataArr:(NSArray *)dataArr indexArr:(NSArray *)indexArr;
//MACD
+ (NSArray *)get_MACD_WithDataArr:(NSArray *)dataArr indexArr:(NSArray *)indexArr;
//KDJ
+ (NSArray *)get_KDJ_WithDataArr:(NSArray *)dataArr indexArr:(NSArray *)indexArr;
//RSI
+ (NSArray *)get_RSI_withDataArr:(NSArray *)dataArr indexArr:(NSArray *)indexArr;
//BIAS
+ (NSArray *)get_BIAS_withDataArr:(NSArray *)dataArr indexArr:(NSArray *)indexArr;
//CCI
+ (NSArray *)get_CCI_WithDataArr:(NSArray *)dataArr indexArr:(NSArray *)indexArr;
//PSY
+ (NSArray *)get_PSY_WithDataArr:(NSArray *)dataArr indexArr:(NSArray *)indexArr;
//OBV
+ (NSArray *)get_OBV_WithDataArr:(NSArray *)dataArr indexArr:(NSArray *)indexArr;
//VOL
+ (NSArray *)get_VOL_WithDataArr:(NSArray *)dataArr indexArr:(NSArray *)indexArr;

@end
