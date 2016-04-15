//
//  DatatTansfer.h
//  Study_KLine_2
//
//  Created by totrade on 16/1/20.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#warning 该类主要用于将原始数据转换成相对应的分时图和K线图的在界面显示的坐标点

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//kWith代表蜡烛空心的宽度

@interface DatatTansfer : NSObject


#warning -----------------
//处理分时线原始数据,得到数组,数组中存放点坐标
+ (NSArray *)handleTLineDataWith:(NSArray *)arr With_W:(CGFloat)w with_H:(CGFloat)h yClose:(NSString *)yClose;

+(void)getInitialIndsDataWithDadaArr:(NSArray *)dataArr;
+(NSArray *)getUI_CandleMa_WithW:(CGFloat)width h:(CGFloat)height kW:(CGFloat)kWidth loc:(NSInteger)location cCount:(NSInteger)cCount;
+(NSArray *)getUI_CandleBoll_WithW:(CGFloat)width h:(CGFloat)height kW:(CGFloat)kWidth loc:(NSInteger)location cCount:(NSInteger)cCount;
+(NSArray *)getUI_Macd_WithW:(CGFloat)width h:(CGFloat)height kW:(CGFloat)kWidth loc:(NSInteger)location cCount:(NSInteger)cCount;
+(NSArray *)getUI_Kdj_WithW:(CGFloat)width h:(CGFloat)height kW:(CGFloat)kWidth loc:(NSInteger)location cCount:(NSInteger)cCount;
+(NSArray *)getUI_Rsi_WithW:(CGFloat)width h:(CGFloat)height kW:(CGFloat)kWidth loc:(NSInteger)location cCount:(NSInteger)cCount;
+(NSArray *)getUI_Bias_WithW:(CGFloat)width h:(CGFloat)height kW:(CGFloat)kWidth loc:(NSInteger)location cCount:(NSInteger)cCount;
+(NSArray *)getUI_Cci_WithW:(CGFloat)width h:(CGFloat)height kW:(CGFloat)kWidth loc:(NSInteger)location cCount:(NSInteger)cCount;
+(NSArray *)getUI_Press_WithW:(CGFloat)width h:(CGFloat)height kW:(CGFloat)kWidth loc:(NSInteger)location cCount:(NSInteger)cCount maOrBoll:(NSInteger)maOrBollIndex;

//后补的几个
+(NSArray *)getUI_Psy_WithW:(CGFloat)width h:(CGFloat)height kW:(CGFloat)kWidth loc:(NSInteger)location cCount:(NSInteger)cCount;
+(NSArray *)getUI_Obv_WithW:(CGFloat)width h:(CGFloat)height kW:(CGFloat)kWidth loc:(NSInteger)location cCount:(NSInteger)cCount;
+(NSArray *)getUI_Vol_WithW:(CGFloat)width h:(CGFloat)height kW:(CGFloat)kWidth loc:(NSInteger)location cCount:(NSInteger)cCount;

@end
