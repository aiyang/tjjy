//
//  DatatTansfer.m
//  Study_KLine_2
//
//  Created by totrade on 16/1/20.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//


#import "DatatTansfer.h"
#import "SingleSymbolHistoryData_DownObj.h"
#import "StockInds.h"//新的股势指标
#import "DataManage.h"
#import "IndsParameters.h"


@implementation DatatTansfer


#warning 供外部使用的类方法共11个!!!即获取所有指标数据,candle,ma,boll,macd,kdj,rsi,bias,cci,分时图,时间
//----------------------获取所有指标数据----------------------
////打算把指标计算重新归为一个类,那么这样的好处就是,每次进行K线动作时,不用再重复了
+(void)getInitialIndsDataWithDadaArr:(NSArray *)dataArr
{
    DataManage *dataManage = [DataManage shareInstance];
    IndsParameters *indsPMS = [[IndsParameters alloc] init];
    
    NSArray *arr_Candle = [StockInds get_Candle_WithDataArr:dataArr];
    NSArray *arr_Ma = [StockInds get_MA_WithDataArr:dataArr indexArr:indsPMS.ma_PMS];//4
    NSArray *bollArr = [StockInds get_BOLL_WithDataArr:dataArr indexArr:indsPMS.boll_PMS];
    NSArray *arr_Macd = [StockInds get_MACD_WithDataArr:dataArr indexArr:indsPMS.macd_PMS];
    NSArray *arr_Kdj = [StockInds get_KDJ_WithDataArr:dataArr indexArr:indsPMS.kdj_PMS];
    NSArray *arr_Rsi = [StockInds get_RSI_withDataArr:dataArr indexArr:indsPMS.rsi_PMS];
    NSArray *arr_Bias = [StockInds get_BIAS_withDataArr:dataArr indexArr:indsPMS.bias_PMS];
    NSArray *arr_Cci = [StockInds get_CCI_WithDataArr:dataArr indexArr:indsPMS.cci_PMS];
    NSArray *arr_Date = [StockInds get_Date_witDataArr:dataArr];
    
    //后补的几个
    NSArray *arr_Psy = [StockInds get_PSY_WithDataArr:dataArr indexArr:indsPMS.PSY_PMS];
    NSArray *arr_Obv = [StockInds get_OBV_WithDataArr:dataArr indexArr:indsPMS.OBV_PMS];
    NSArray *arr_Vol = [StockInds get_VOL_WithDataArr:dataArr indexArr:indsPMS.VOL_PMS];
    
    
    [dataManage.indsDic setObject:arr_Candle forKey:@"arr_Candle"];
    [dataManage.indsDic setObject:arr_Ma forKey:@"arr_Ma"];
    [dataManage.indsDic setObject:bollArr forKey:@"arr_Boll"];
    [dataManage.indsDic setObject:arr_Macd forKey:@"arr_Macd"];
    [dataManage.indsDic setObject:arr_Kdj forKey:@"arr_Kdj"];
    [dataManage.indsDic setObject:arr_Rsi forKey:@"arr_Rsi"];
    [dataManage.indsDic setObject:arr_Bias forKey:@"arr_Bias"];
    [dataManage.indsDic setObject:arr_Cci forKey:@"arr_Cci"];
    [dataManage.indsDic setObject:arr_Date forKey:@"arr_Date"];
    
    [dataManage.indsDic setObject:arr_Psy forKey:@"arr_Psy"];
    [dataManage.indsDic setObject:arr_Obv forKey:@"arr_Obv"];
    [dataManage.indsDic setObject:arr_Vol forKey:@"arr_Vol"];

    
}





#warning ----------------------------------分时线----------------------------------
//处理原始数据,得到数组,数组中存放点坐标
+ (NSArray *)handleTLineDataWith:(NSArray *)arr With_W:(CGFloat)w with_H:(CGFloat)h yClose:(NSString *)yClose
{
    
//    //获取原始数据
//    DataManage *dataManage = [DataManage shareInstance];
//    NSArray *initialCandleArr = [dataManage.indsDic objectForKey:@"arr_Candle"];
//    NSArray *cArr = [initialCandleArr objectAtIndex:3];
    //如果分时图也调用这个算法,则在请求数据时,必须要一开始就调用getInitialIndsDataWithDadaArr,浪费时间
    
    NSMutableArray *cArr = [NSMutableArray array];
    NSMutableArray *tArr = [NSMutableArray array];
    for (SingleSymbolHistoryData_DownObj *single_DownObj in arr) {
        [tArr addObject:single_DownObj.t];
        [cArr addObject:single_DownObj.c];
    }
    NSString *firstTime = [tArr objectAtIndex:0];


    NSMutableArray *tLineArr = [NSMutableArray array];//存储分时线的sum/n数据,另一条线的画法
    NSArray *tempCArr = [[cArr reverseObjectEnumerator] allObjects];//将数组中的数据逆序排列
    CGFloat tempSum = 0.0;
    for (NSInteger i = 0; i < tempCArr.count; i ++) {
        tempSum += [tempCArr[i] floatValue];
        [tLineArr addObject:[NSNumber numberWithFloat:(tempSum / (i + 1))]];
    }
    tLineArr = (NSMutableArray *)[[tLineArr reverseObjectEnumerator] allObjects];//将数组中的数据逆序排列

    
  
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[firstTime doubleValue]];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitHour| NSCalendarUnitMinute;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    NSInteger hour = [comps hour];
    NSInteger minute = [comps minute];
    
    
    CGFloat maxF = [[DatatTansfer get_Max_WithArray:cArr] floatValue];
    
    CGFloat minF = [[DatatTansfer get_Min_WithArray:cArr] floatValue];

    CGFloat midF = [yClose floatValue];
    
    //最大最小值与yClose的差值的绝对值的最大值
    CGFloat bestGap = fabs(maxF - midF) > fabs(minF - midF) ? fabs(maxF - midF) : fabs(minF - midF);

    maxF = midF + bestGap;
    minF = minF - bestGap;
    
    NSMutableArray *upDownArr = [NSMutableArray array];
    NSMutableArray *upDownRangeArr = [NSMutableArray array];
    for (NSInteger i = 1; i < 6; i ++) {
        CGFloat upF = midF + (bestGap * (6 - i) / 5);
        [upDownArr addObject:[NSNumber numberWithFloat:upF]];
        [upDownRangeArr addObject:[NSNumber numberWithFloat:100 * (bestGap * (6 - i) / 5) / midF]];
    }
    [upDownArr addObject:[NSNumber numberWithFloat:midF]];
    [upDownRangeArr addObject:[NSNumber numberWithFloat:0.0f]];
    for (NSInteger i = 1; i < 6; i ++) {
        CGFloat downF = midF - (bestGap * i / 5);
        [upDownArr addObject:[NSNumber numberWithFloat:downF]];
        [upDownRangeArr addObject:[NSNumber numberWithFloat:100 * (- bestGap * i / 5) / midF]];

    }
    
    
    
    //数据最大差值
    CGFloat dataGap = maxF - minF;
    
    //这个数组用于存储已计算好的坐标
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSInteger i = 0; i < cArr.count; i++) {
        //换算成的y点坐标
        CGFloat y = h * (maxF - [[cArr objectAtIndex:i] floatValue]) / dataGap;
        //换算成的x坐标
        CGFloat x = w * ((hour - 6) * 60 + minute - i) / 1440;
        
        CGPoint point = CGPointMake(x, y);
        
        //从point到字符串:NSStringFromCGPoint
        //从字符串到point:CGPointFromString
        //感觉rect,size什么的都可以这么干
        [tempArr addObject:NSStringFromCGPoint(point)];
    }
    
    //另一条分时线
    NSMutableArray *temp2Arr = [NSMutableArray array];
    for (NSInteger i = 0; i < tLineArr.count; i++) {
        //换算成的y点坐标
        CGFloat y = h * (maxF - [[tLineArr objectAtIndex:i] floatValue]) / dataGap;
        //换算成的x坐标
        CGFloat x = w * ((hour - 6) * 60 + minute - i) / 1440;
        
        CGPoint point = CGPointMake(x, y);
        
        //从point到字符串:NSStringFromCGPoint
        //从字符串到point:CGPointFromString
        //感觉rect,size什么的都可以这么干
        [temp2Arr addObject:NSStringFromCGPoint(point)];
    }
    
//     NSLog(@"%@___数据有差异", upDownArr);
//    [tempArr addObject:upDownArr];
//    [tempArr addObject:upDownRangeArr];
    return @[tempArr, upDownArr, upDownRangeArr, temp2Arr];
}


#warning ----------------------------------K线----------------------------------
//蜡烛图和MA图以及蜡烛图和boll图需要放一起,因为需要找出最大最小值
//w:显示宽度 h:显示高度 kWidth:K线宽度(蜡烛图的宽度) loc:数据起点位置
+(NSArray *)getUI_CandleMa_WithW:(CGFloat)width h:(CGFloat)height kW:(CGFloat)kWidth loc:(NSInteger)location cCount:(NSInteger)cCount
{
    //获取原始数据
    DataManage *dataManage = [DataManage shareInstance];
    NSArray *initialCandleArr = [dataManage.indsDic objectForKey:@"arr_Candle"];
    NSArray *initialMaArr = [dataManage.indsDic objectForKey:@"arr_Ma"];
    
    //根据原始数据,获取子数组//此处判断依然有问题
    NSArray *candleArr = [DatatTansfer getSubArrWithArr:initialCandleArr loc:location count:cCount];
    NSArray *maArr = [DatatTansfer getSubArrWithArr:initialMaArr loc:location count:cCount];
    
    //获取X轴
    NSArray *x_Arr = [DatatTansfer getYingLineArr_XWithData:[initialCandleArr objectAtIndex:0] With_W:width kWidth:kWidth];
    
//    NSLog(@"nnnnnnnn:%d---%@", dataCount, [candleArr objectAtIndex:0]);
    
    
    NSMutableArray *maxMinArr = [NSMutableArray array];
    [maxMinArr addObjectsFromArray:candleArr];
    [maxMinArr addObjectsFromArray:maArr];
    
    //找出数据中最大最小值
    NSArray *maxMin_Arr = [DatatTansfer findMaxMinWithArr:maxMinArr];
    NSNumber *maxN = [maxMin_Arr objectAtIndex:0];
    NSNumber *minN = [maxMin_Arr objectAtIndex:1];
    CGFloat maxF = [maxN floatValue];
    CGFloat minF = [minN floatValue];
    
    //数据最大差值
    CGFloat valueGap = maxF - minF;
    
    NSArray *oArr = [candleArr objectAtIndex:0];
    NSArray *hArr = [candleArr objectAtIndex:1];
    NSArray *lArr = [candleArr objectAtIndex:2];
    NSArray *cArr = [candleArr objectAtIndex:3];
    
    NSArray *ma5Arr = [maArr objectAtIndex:0];
    NSArray *ma10Arr = [maArr objectAtIndex:1];
    NSArray *ma20Arr = [maArr objectAtIndex:2];
    NSArray *ma60Arr = [maArr objectAtIndex:3];
    
    NSMutableArray *returnArr = [NSMutableArray array];
    for (NSInteger i = 0; i < [[x_Arr objectAtIndex:0] count]; i++) {
        CGFloat ying_x = [[x_Arr[0] objectAtIndex:i] floatValue];//影线X轴
        CGFloat candle_x = [[x_Arr[1] objectAtIndex:i] floatValue];//蜡烛X轴
        
        CGFloat y_o = CGFLOAT_MAX;
        CGFloat y_h = CGFLOAT_MAX;
        CGFloat y_l = CGFLOAT_MAX;
        CGFloat y_c = CGFLOAT_MAX;
        
        CGFloat y_ma5 = CGFLOAT_MAX;
        CGFloat y_ma10 = CGFLOAT_MAX;
        CGFloat y_ma20 = CGFLOAT_MAX;
        CGFloat y_ma60 = CGFLOAT_MAX;
        
        if (i < oArr.count) {
            y_o = (height - BottomEdge * 2)*(maxF - [oArr[i] floatValue])/valueGap + TopEdge;
        }
        if (i < hArr.count) {
            y_h = (height - BottomEdge  * 2)*(maxF - [hArr[i] floatValue])/valueGap  + TopEdge;
        }
        if (i < lArr.count) {
            y_l = (height - BottomEdge  * 2)*(maxF - [lArr[i] floatValue])/valueGap  + TopEdge;
        }
        if (i < cArr.count) {
            y_c = (height - BottomEdge  * 2)*(maxF - [cArr[i] floatValue])/valueGap  + TopEdge;
        }
        
        if (i < ma5Arr.count) {
            y_ma5 = (height - BottomEdge * 2)*(maxF - [ma5Arr[i] floatValue])/valueGap  + TopEdge;
        }
        if (i < ma10Arr.count) {
            y_ma10 = (height - BottomEdge * 2)*(maxF - [ma10Arr[i] floatValue])/valueGap  + TopEdge;
        }
        if (i < ma20Arr.count) {
            y_ma20 = (height - BottomEdge * 2)*(maxF - [ma20Arr[i] floatValue])/valueGap  + TopEdge;
        }
        if (i < ma60Arr.count) {
            y_ma60 = (height - BottomEdge * 2)*(maxF - [ma60Arr[i] floatValue])/valueGap  + TopEdge;
        }
        
        CGPoint point_o = CGPointMake(candle_x, y_o);
        CGPoint point_h = CGPointMake(ying_x, y_h);
        CGPoint point_l = CGPointMake(ying_x, y_l);
        CGPoint point_c = CGPointMake(candle_x, y_c);
        
        CGPoint point_ma5 = CGPointMake(ying_x, y_ma5);
        CGPoint point_ma10 = CGPointMake(ying_x, y_ma10);
        CGPoint point_ma20 = CGPointMake(ying_x, y_ma20);
        CGPoint point_ma60 = CGPointMake(ying_x, y_ma60);
        
        NSArray *small_Arr = @[NSStringFromCGPoint(point_o),//最高价/0
                               NSStringFromCGPoint(point_h),//最低价/1
                               NSStringFromCGPoint(point_l),//开盘价/2
                               NSStringFromCGPoint(point_c),//收盘价/3
                               NSStringFromCGPoint(point_ma5),//五日均线/4
                               NSStringFromCGPoint(point_ma10),//十日均线/5
                               NSStringFromCGPoint(point_ma20),//二十日均线/6
                               NSStringFromCGPoint(point_ma60)];//六十日均线/7
        
        [returnArr addObject:small_Arr];
    }
    
    CGFloat edgeF = 10 * (height - BottomEdge * 2) / valueGap; //每个单位的像素点代表多少实际值
    CGFloat maxFF = maxF + edgeF;
    CGFloat minFF = minF - edgeF;
    CGFloat valueGapGap = maxFF - minFF;
    
    //NSLog(@"%@", returnArr);
    
    return @[returnArr, @[[NSNumber numberWithFloat:maxFF], [NSNumber numberWithFloat:valueGapGap]]];

    
}

+(NSArray *)getUI_CandleBoll_WithW:(CGFloat)width h:(CGFloat)height kW:(CGFloat)kWidth loc:(NSInteger)location  cCount:(NSInteger)cCount
{
    //获取原始数据
    DataManage *dataManage = [DataManage shareInstance];
    NSArray *initialCandleArr = [dataManage.indsDic objectForKey:@"arr_Candle"];
    NSArray *initialBollArr = [dataManage.indsDic objectForKey:@"arr_Boll"];
    

    
    //根据原始数据,获取子数组//此处判断依然有问题
    NSArray *candleArr = [DatatTansfer getSubArrWithArr:initialCandleArr loc:location count:cCount];
    NSArray *bollArr = [DatatTansfer getSubArrWithArr:initialBollArr loc:location count:cCount];
    //获取X轴
    NSArray *x_Arr = [DatatTansfer getYingLineArr_XWithData:[initialCandleArr objectAtIndex:0] With_W:width kWidth:kWidth];
    
    NSMutableArray *maxMinArr = [NSMutableArray array];
    [maxMinArr addObjectsFromArray:candleArr];
    [maxMinArr addObjectsFromArray:bollArr];
    
    //找出数据中最大最小值
    NSArray *maxMin_Arr = [DatatTansfer findMaxMinWithArr:maxMinArr];
    NSNumber *maxN = [maxMin_Arr objectAtIndex:0];
    NSNumber *minN = [maxMin_Arr objectAtIndex:1];
    CGFloat maxF = [maxN floatValue];
    CGFloat minF = [minN floatValue];
    
    //数据最大差值
    CGFloat valueGap = maxF - minF;
    
    NSArray *oArr = [candleArr objectAtIndex:0];
    NSArray *hArr = [candleArr objectAtIndex:1];
    NSArray *lArr = [candleArr objectAtIndex:2];
    NSArray *cArr = [candleArr objectAtIndex:3];
    
    NSArray *bollUpArr = [bollArr objectAtIndex:0];
    NSArray *bollMiddleArr = [bollArr objectAtIndex:1];
    NSArray *bollDownArr = [bollArr objectAtIndex:2];
    
    NSMutableArray *returnArr = [NSMutableArray array];
    for (NSInteger i = 0; i < [[x_Arr objectAtIndex:0] count]; i++) {
        CGFloat ying_x = [[x_Arr[0] objectAtIndex:i] floatValue];//影线X轴
        CGFloat candle_x = [[x_Arr[1] objectAtIndex:i] floatValue];//蜡烛X轴
        
        CGFloat y_o = CGFLOAT_MAX;
        CGFloat y_h = CGFLOAT_MAX;
        CGFloat y_l = CGFLOAT_MAX;
        CGFloat y_c = CGFLOAT_MAX;
        
        CGFloat y_bollUp = CGFLOAT_MAX;
        CGFloat y_bollMiddle = CGFLOAT_MAX;
        CGFloat y_bollDown = CGFLOAT_MAX;
 
        
        if (i < oArr.count) {
            y_o = (height - BottomEdge * 2)*(maxF - [oArr[i] floatValue])/valueGap + TopEdge;
        }
        if (i < hArr.count) {
            y_h = (height - BottomEdge * 2)*(maxF - [hArr[i] floatValue])/valueGap + TopEdge;
        }
        if (i < lArr.count) {
            y_l = (height - BottomEdge * 2)*(maxF - [lArr[i] floatValue])/valueGap + TopEdge;
        }
        if (i < cArr.count) {
            y_c = (height - BottomEdge * 2)*(maxF - [cArr[i] floatValue])/valueGap + TopEdge;
        }
        
        if (i < bollUpArr.count) {
            y_bollUp = (height - BottomEdge * 2)*(maxF - [bollUpArr[i] floatValue])/valueGap + TopEdge;
        }
        if (i < bollMiddleArr.count) {
            y_bollMiddle = (height - BottomEdge * 2)*(maxF - [bollMiddleArr[i] floatValue])/valueGap + TopEdge;
        }
        if (i < bollDownArr.count) {
            y_bollDown = (height - BottomEdge * 2)*(maxF - [bollDownArr[i] floatValue])/valueGap + TopEdge;
        }
 
        
        CGPoint point_o = CGPointMake(candle_x, y_o);
        CGPoint point_h = CGPointMake(ying_x, y_h);
        CGPoint point_l = CGPointMake(ying_x, y_l);
        CGPoint point_c = CGPointMake(candle_x, y_c);
        
        CGPoint point_bollUp = CGPointMake(ying_x, y_bollUp);
        CGPoint point_bollMiddle = CGPointMake(ying_x, y_bollMiddle);
        CGPoint point_bollDown = CGPointMake(ying_x, y_bollDown);
        
        NSArray *small_Arr = @[NSStringFromCGPoint(point_o),//最高价/0
                               NSStringFromCGPoint(point_h),//最低价/1
                               NSStringFromCGPoint(point_l),//开盘价/2
                               NSStringFromCGPoint(point_c),//收盘价/3
                               NSStringFromCGPoint(point_bollUp),//布林上/4
                               NSStringFromCGPoint(point_bollMiddle),//布林中/5
                               NSStringFromCGPoint(point_bollDown)//布林下/6
                               ];
        
        [returnArr addObject:small_Arr];
        
    }
    
    CGFloat edgeF = 10 * (height - BottomEdge * 2) / valueGap; //每个单位的像素点代表多少实际值
    CGFloat maxFF = maxF + edgeF;
    CGFloat minFF = minF - edgeF;
    CGFloat valueGapGap = maxFF - minFF;
    
    
    return @[returnArr, @[[NSNumber numberWithFloat:maxFF], [NSNumber numberWithFloat:valueGapGap]]];
}

+(NSArray *)getUI_Macd_WithW:(CGFloat)width h:(CGFloat)height kW:(CGFloat)kWidth loc:(NSInteger)location  cCount:(NSInteger)cCount
{

    //获取原始数据
    DataManage *dataManage = [DataManage shareInstance];
    NSArray *initialCandleArr = [dataManage.indsDic objectForKey:@"arr_Candle"];
    NSArray *initialMacdArr = [dataManage.indsDic objectForKey:@"arr_Macd"];

    
    //根据原始数据,获取子数组//此处判断依然有问题
    NSArray *macdArr = [DatatTansfer getSubArrWithArr:initialMacdArr loc:location count:cCount];
    
    NSArray *difArr = [macdArr objectAtIndex:0];
    NSArray *deaArr = [macdArr objectAtIndex:1];
    NSArray *macd_Arr = [macdArr objectAtIndex:2];
    
    NSArray *maxMin_Arr = [DatatTansfer findMaxMinWithArr:macdArr];
    NSNumber *maxN = [maxMin_Arr objectAtIndex:0];
    NSNumber *minN = [maxMin_Arr objectAtIndex:1];
    CGFloat maxF = [maxN floatValue];
    CGFloat minF = [minN floatValue];
 
    CGFloat valueGap = maxF - minF;
    //    获取X轴数组
    NSArray *x_Arr = [DatatTansfer getYingLineArr_XWithData:[initialCandleArr objectAtIndex:0] With_W:width kWidth:kWidth];
    
    NSMutableArray *returnArr = [NSMutableArray array];
    for (NSInteger i = 0; i < [[x_Arr objectAtIndex:0] count]; i++) {
        CGFloat x = [[x_Arr[0] objectAtIndex:i] floatValue];
        CGFloat y_dif = CGFLOAT_MAX;
        CGFloat y_dea = CGFLOAT_MAX;
        CGFloat y_macd = CGFLOAT_MAX;
        CGFloat y_ling_macd = (height - BottomEdge * 2)* (maxF - 0)/ valueGap + TopEdge;
        if (i < difArr.count) {
            y_dif = (height - BottomEdge * 2)* (maxF - [difArr[i] floatValue])/ valueGap + TopEdge;
        }
        if (i < deaArr.count) {
            y_dea = (height - BottomEdge * 2)* (maxF - [deaArr[i] floatValue])/ valueGap + TopEdge;
            
        }
        if (i < macd_Arr.count) {
            y_macd = (height - BottomEdge * 2)* (maxF - [macd_Arr[i] floatValue])/ valueGap + TopEdge;
            
        }
        
        CGPoint point_Dif = CGPointMake(x, y_dif);
        CGPoint point_Dea = CGPointMake(x, y_dea);
        CGPoint point_Macd = CGPointMake(x, y_macd);
        CGPoint point_Ling_Macd = CGPointMake(x, y_ling_macd);
        
        NSArray *pointSmallArr = @[NSStringFromCGPoint(point_Dif),///0
                                   NSStringFromCGPoint(point_Dea),///1
                                   NSStringFromCGPoint(point_Macd),///2
                                   NSStringFromCGPoint(point_Ling_Macd)];///3
        
        [returnArr addObject:pointSmallArr];
        
    }
    
    CGFloat edgeF = 10 * valueGap / (height - BottomEdge * 2); //每个单位像素点对应多少实际值,再算出10像素点对应的实际值
    CGFloat maxFF = maxF + edgeF;
    CGFloat minFF = minF - edgeF;
//    CGFloat valueGapGap = maxFF - minFF;
    
    return @[returnArr, @[[NSNumber numberWithFloat:maxFF], [NSNumber numberWithFloat:minFF]], macdArr];
}


+(NSArray *)getUI_Kdj_WithW:(CGFloat)width h:(CGFloat)height kW:(CGFloat)kWidth loc:(NSInteger)location cCount:(NSInteger)cCount
{
    
    //获取原始数据
    DataManage *dataManage = [DataManage shareInstance];
    NSArray *initialCandleArr = [dataManage.indsDic objectForKey:@"arr_Candle"];
    NSArray *initialKdjArr = [dataManage.indsDic objectForKey:@"arr_Kdj"];
    

    
    //根据原始数据,获取子数组//此处判断依然有问题
    NSArray *kdjArr = [DatatTansfer getSubArrWithArr:initialKdjArr loc:location count:cCount];
    
    NSArray *kArr = [kdjArr objectAtIndex:0];
    NSArray *dArr = [kdjArr objectAtIndex:1];
    NSArray *jArr = [kdjArr objectAtIndex:2];
    
    NSArray *maxMin_Arr = [DatatTansfer findMaxMinWithArr:kdjArr];
    NSNumber *maxN = [maxMin_Arr objectAtIndex:0];
    NSNumber *minN = [maxMin_Arr objectAtIndex:1];
    CGFloat maxF = [maxN floatValue];
    CGFloat minF = [minN floatValue];
    
    CGFloat valueGap = maxF - minF;
    //    获取X轴数组
    NSArray *x_Arr = [DatatTansfer getYingLineArr_XWithData:[initialCandleArr objectAtIndex:0] With_W:width kWidth:kWidth];
    
    NSMutableArray *returnArr = [NSMutableArray array];
    for (NSInteger i = 0; i < [[x_Arr objectAtIndex:0] count]; i++) {
        CGFloat x = [[x_Arr[0] objectAtIndex:i] floatValue];
        CGFloat y_k = CGFLOAT_MAX;
        CGFloat y_d = CGFLOAT_MAX;
        CGFloat y_j = CGFLOAT_MAX;
        if (i < kArr.count) {
            y_k = (height - BottomEdge * 2)* (maxF - [kArr[i] floatValue])/ valueGap + TopEdge;
        }
        if (i < dArr.count) {
            y_d = (height - BottomEdge * 2)* (maxF - [dArr[i] floatValue])/ valueGap + TopEdge;
            
        }
        if (i < jArr.count) {
            y_j = (height - BottomEdge * 2)* (maxF - [jArr[i] floatValue])/ valueGap + TopEdge;
            
        }
        
        CGPoint point_K = CGPointMake(x, y_k);
        CGPoint point_D = CGPointMake(x, y_d);
        CGPoint point_J = CGPointMake(x, y_j);
        
        NSArray *pointSmallArr = @[NSStringFromCGPoint(point_K),///0
                                   NSStringFromCGPoint(point_D),///1
                                   NSStringFromCGPoint(point_J)];///2
        
        [returnArr addObject:pointSmallArr];
        
    }
    
    CGFloat edgeF = 10 * valueGap / (height - BottomEdge * 2); //每个单位像素点对应多少实际值,再算出10像素点对应的实际值
    CGFloat maxFF = maxF + edgeF;
    CGFloat minFF = minF - edgeF;
    //    CGFloat valueGapGap = maxFF - minFF;
    
    return @[returnArr, @[[NSNumber numberWithFloat:maxFF], [NSNumber numberWithFloat:minFF]], kdjArr];
}

+(NSArray *)getUI_Rsi_WithW:(CGFloat)width h:(CGFloat)height kW:(CGFloat)kWidth loc:(NSInteger)location cCount:(NSInteger)cCount
{
    //获取原始数据
    DataManage *dataManage = [DataManage shareInstance];
    NSArray *initialCandleArr = [dataManage.indsDic objectForKey:@"arr_Candle"];
    NSArray *initialRsiArr = [dataManage.indsDic objectForKey:@"arr_Rsi"];
    
    
    //根据原始数据,获取子数组//此处判断依然有问题
    NSArray *rsiArr = [DatatTansfer getSubArrWithArr:initialRsiArr loc:location count:cCount];
    
    NSArray *rArr = [rsiArr objectAtIndex:0];
    NSArray *sArr = [rsiArr objectAtIndex:1];
    NSArray *iArr = [rsiArr objectAtIndex:2];
    
    NSArray *maxMin_Arr = [DatatTansfer findMaxMinWithArr:rsiArr];
    NSNumber *maxN = [maxMin_Arr objectAtIndex:0];
    NSNumber *minN = [maxMin_Arr objectAtIndex:1];
    CGFloat maxF = [maxN floatValue];
    CGFloat minF = [minN floatValue];
    
    CGFloat valueGap = maxF - minF;
    //    获取X轴数组
    NSArray *x_Arr = [DatatTansfer getYingLineArr_XWithData:[initialCandleArr objectAtIndex:0] With_W:width kWidth:kWidth];
    
    NSMutableArray *returnArr = [NSMutableArray array];
    for (NSInteger i = 0; i < [[x_Arr objectAtIndex:0] count]; i++) {
        CGFloat x = [[x_Arr[0] objectAtIndex:i] floatValue];
        CGFloat y_r = CGFLOAT_MAX;
        CGFloat y_s = CGFLOAT_MAX;
        CGFloat y_i = CGFLOAT_MAX;
        if (i < rArr.count) {
            y_r = (height - BottomEdge * 2)* (maxF - [rArr[i] floatValue])/ valueGap + TopEdge;
        }
        if (i < sArr.count) {
            y_s = (height - BottomEdge * 2)* (maxF - [sArr[i] floatValue])/ valueGap + TopEdge;
            
        }
        if (i < iArr.count) {
            y_i = (height - BottomEdge * 2)* (maxF - [iArr[i] floatValue])/ valueGap + TopEdge;
            
        }
        
        CGPoint point_R = CGPointMake(x, y_r);
        CGPoint point_S = CGPointMake(x, y_s);
        CGPoint point_I = CGPointMake(x, y_i);
        
        NSArray *pointSmallArr = @[NSStringFromCGPoint(point_R),///0
                                   NSStringFromCGPoint(point_S),///1
                                   NSStringFromCGPoint(point_I)];///2
        
        [returnArr addObject:pointSmallArr];
        
    }
    
    CGFloat edgeF = 10 * valueGap / (height - BottomEdge * 2); //每个单位像素点对应多少实际值,再算出10像素点对应的实际值
    CGFloat maxFF = maxF + edgeF;
    CGFloat minFF = minF - edgeF;
    //    CGFloat valueGapGap = maxFF - minFF;
    
    return @[returnArr, @[[NSNumber numberWithFloat:maxFF], [NSNumber numberWithFloat:minFF]], rsiArr];
}

+(NSArray *)getUI_Bias_WithW:(CGFloat)width h:(CGFloat)height kW:(CGFloat)kWidth loc:(NSInteger)location  cCount:(NSInteger)cCount
{
    //获取原始数据
    DataManage *dataManage = [DataManage shareInstance];
    NSArray *initialCandleArr = [dataManage.indsDic objectForKey:@"arr_Candle"];
    NSArray *initialBiasArr = [dataManage.indsDic objectForKey:@"arr_Bias"];

    
    //根据原始数据,获取子数组//此处判断依然有问题
    NSArray *biasArr = [DatatTansfer getSubArrWithArr:initialBiasArr loc:location count:cCount];
    
    NSArray *iArr = [biasArr objectAtIndex:0];
    NSArray *aArr = [biasArr objectAtIndex:1];
    NSArray *sArr = [biasArr objectAtIndex:2];
    
    NSArray *maxMin_Arr = [DatatTansfer findMaxMinWithArr:biasArr];
    NSNumber *maxN = [maxMin_Arr objectAtIndex:0];
    NSNumber *minN = [maxMin_Arr objectAtIndex:1];
    CGFloat maxF = [maxN floatValue];
    CGFloat minF = [minN floatValue];
    
    CGFloat valueGap = maxF - minF;
    //    获取X轴数组
    NSArray *x_Arr = [DatatTansfer getYingLineArr_XWithData:[initialCandleArr objectAtIndex:0] With_W:width kWidth:kWidth];
    
    NSMutableArray *returnArr = [NSMutableArray array];
    for (NSInteger i = 0; i < [[x_Arr objectAtIndex:0] count]; i++) {
        CGFloat x = [[x_Arr[0] objectAtIndex:i] floatValue];
        CGFloat y_i = CGFLOAT_MAX;
        CGFloat y_a = CGFLOAT_MAX;
        CGFloat y_s = CGFLOAT_MAX;
        if (i < iArr.count) {
            y_i = (height - BottomEdge * 2)* (maxF - [iArr[i] floatValue])/ valueGap + TopEdge;
        }
        if (i < aArr.count) {
            y_a = (height - BottomEdge * 2)* (maxF - [aArr[i] floatValue])/ valueGap + TopEdge;
            
        }
        if (i < sArr.count) {
            y_s = (height - BottomEdge * 2)* (maxF - [sArr[i] floatValue])/ valueGap + TopEdge;
            
        }
        
        CGPoint point_I = CGPointMake(x, y_i);
        CGPoint point_A = CGPointMake(x, y_a);
        CGPoint point_S = CGPointMake(x, y_s);
        
        NSArray *pointSmallArr = @[NSStringFromCGPoint(point_I),///0
                                   NSStringFromCGPoint(point_A),///1
                                   NSStringFromCGPoint(point_S)];///2
        
        [returnArr addObject:pointSmallArr];
        
    }
    
    CGFloat edgeF = 10 * valueGap / (height - BottomEdge * 2); //每个单位像素点对应多少实际值,再算出10像素点对应的实际值
    CGFloat maxFF = maxF + edgeF;
    CGFloat minFF = minF - edgeF;
    //    CGFloat valueGapGap = maxFF - minFF;
    
    return @[returnArr, @[[NSNumber numberWithFloat:maxFF], [NSNumber numberWithFloat:minFF]], biasArr];
}

+(NSArray *)getUI_Psy_WithW:(CGFloat)width h:(CGFloat)height kW:(CGFloat)kWidth loc:(NSInteger)location cCount:(NSInteger)cCount
{
    //获取原始数据
    DataManage *dataManage = [DataManage shareInstance];
    NSArray *initialCandleArr = [dataManage.indsDic objectForKey:@"arr_Candle"];
    NSArray *initialPsyArr = [dataManage.indsDic objectForKey:@"arr_Psy"];
    
    //根据原始数据,获取子数组//此处判断依然有问题
    NSArray *psyArr = [DatatTansfer getSubArrWithArr:initialPsyArr loc:location count:cCount];
    
    NSArray *psy_Arr = [psyArr objectAtIndex:0];
    NSArray *psyMaArr = [psyArr objectAtIndex:1];
    
    NSArray *maxMin_Arr = [DatatTansfer findMaxMinWithArr:psyArr];
    NSNumber *maxN = [maxMin_Arr objectAtIndex:0];
    NSNumber *minN = [maxMin_Arr objectAtIndex:1];
    CGFloat maxF = [maxN floatValue];
    CGFloat minF = [minN floatValue];
    
    CGFloat valueGap = maxF - minF;
    //    获取X轴数组
    NSArray *x_Arr = [DatatTansfer getYingLineArr_XWithData:[initialCandleArr objectAtIndex:0] With_W:width kWidth:kWidth];
    
    NSMutableArray *returnArr = [NSMutableArray array];
    for (NSInteger i = 0; i < [[x_Arr objectAtIndex:0] count]; i++) {
        CGFloat x = [[x_Arr[0] objectAtIndex:i] floatValue];
        CGFloat y_psy = CGFLOAT_MAX;
        CGFloat y_psyMa = CGFLOAT_MAX;
        if (i < psy_Arr.count) {
            y_psy = (height - BottomEdge * 2)* (maxF - [psy_Arr[i] floatValue])/ valueGap + TopEdge;
        }
        if (i < psyMaArr.count) {
            y_psyMa = (height - BottomEdge * 2)* (maxF - [psyMaArr[i] floatValue])/ valueGap + TopEdge;
            
        }
   
        
        CGPoint point_Psy = CGPointMake(x, y_psy);
        CGPoint point_PsyMa = CGPointMake(x, y_psyMa);
        
        NSArray *pointSmallArr = @[NSStringFromCGPoint(point_Psy),///0
                                   NSStringFromCGPoint(point_PsyMa)];///1
        
        [returnArr addObject:pointSmallArr];
        
    }
    
    CGFloat edgeF = 10 * valueGap / (height - BottomEdge * 2); //每个单位像素点对应多少实际值,再算出10像素点对应的实际值
    CGFloat maxFF = maxF + edgeF;
    CGFloat minFF = minF - edgeF;
    
    return @[returnArr, @[[NSNumber numberWithFloat:maxFF], [NSNumber numberWithFloat:minFF]], psyArr];
}

+(NSArray *)getUI_Obv_WithW:(CGFloat)width h:(CGFloat)height kW:(CGFloat)kWidth loc:(NSInteger)location cCount:(NSInteger)cCount
{
    //获取原始数据
    DataManage *dataManage = [DataManage shareInstance];
    NSArray *initialCandleArr = [dataManage.indsDic objectForKey:@"arr_Candle"];
    NSArray *initialObvArr = [dataManage.indsDic objectForKey:@"arr_Obv"];
    
    
    //根据原始数据,获取子数组//此处判断依然有问题
    NSArray *obvArr = [DatatTansfer getSubArrWithArr:initialObvArr loc:location count:cCount];
    
    
    NSArray *obv_Arr = [obvArr objectAtIndex:0];
    NSArray *maObvArr = [obvArr objectAtIndex:1];
    
    NSArray *maxMin_Arr = [DatatTansfer findMaxMinWithArr:obvArr];
    NSNumber *maxN = [maxMin_Arr objectAtIndex:0];
    NSNumber *minN = [maxMin_Arr objectAtIndex:1];
    CGFloat maxF = [maxN floatValue];
    CGFloat minF = [minN floatValue];
    
//    NSLog(@"obvArr:%@---%f---%f",obvArr, maxF, minF);

    
    CGFloat valueGap = maxF - minF;
    //    获取X轴数组
    NSArray *x_Arr = [DatatTansfer getYingLineArr_XWithData:[initialCandleArr objectAtIndex:0] With_W:width kWidth:kWidth];
    
    NSMutableArray *returnArr = [NSMutableArray array];
    for (NSInteger i = 0; i < [[x_Arr objectAtIndex:0] count]; i++) {
        CGFloat x = [[x_Arr[0] objectAtIndex:i] floatValue];
        CGFloat y_obv = CGFLOAT_MAX;
        CGFloat y_obvMa = CGFLOAT_MAX;
        if (i < obv_Arr.count) {
            y_obv = (height - BottomEdge * 2)* (maxF - [obv_Arr[i] floatValue])/ valueGap + TopEdge;
        }
        if (i < maObvArr.count) {
            y_obvMa = (height - BottomEdge * 2)* (maxF - [maObvArr[i] floatValue])/ valueGap + TopEdge;
        }
        
        
        CGPoint point_Obv = CGPointMake(x, y_obv);
        CGPoint point_MaObv = CGPointMake(x, y_obvMa);
        
        NSArray *pointSmallArr = @[NSStringFromCGPoint(point_Obv),///0
                                   NSStringFromCGPoint(point_MaObv)];///1
        
        [returnArr addObject:pointSmallArr];
        
    }
    
    CGFloat edgeF = 10 * valueGap / (height - BottomEdge * 2); //每个单位像素点对应多少实际值,再算出10像素点对应的实际值
    CGFloat maxFF = maxF + edgeF;
    CGFloat minFF = minF - edgeF;
    
    return @[returnArr, @[[NSNumber numberWithFloat:maxFF], [NSNumber numberWithFloat:minFF]], obvArr];
}

+(NSArray *)getUI_Vol_WithW:(CGFloat)width h:(CGFloat)height kW:(CGFloat)kWidth loc:(NSInteger)location cCount:(NSInteger)cCount
{
    //获取原始数据
    DataManage *dataManage = [DataManage shareInstance];
    NSArray *initialCandleArr = [dataManage.indsDic objectForKey:@"arr_Candle"];
    NSArray *initialVolArr = [dataManage.indsDic objectForKey:@"arr_Vol"];
    
    //根据原始数据,获取子数组//此处判断依然有问题
    NSArray *volArr = [DatatTansfer getSubArrWithArr:initialVolArr loc:location count:cCount];
    
    
    NSArray *vol_Arr = [volArr objectAtIndex:0];
    NSArray *maVol1Arr = [volArr objectAtIndex:1];
    NSArray *maVol2Arr = [volArr objectAtIndex:2];

    
    
    NSArray *maxMin_Arr = [DatatTansfer findMaxMinWithArr:volArr];
    NSNumber *maxN = [maxMin_Arr objectAtIndex:0];
    NSNumber *minN = [maxMin_Arr objectAtIndex:1];
    CGFloat maxF = [maxN floatValue];
    CGFloat minF = [minN floatValue];
    
    CGFloat valueGap = maxF - minF;
    //    获取X轴数组
    NSArray *x_Arr = [DatatTansfer getYingLineArr_XWithData:[initialCandleArr objectAtIndex:0] With_W:width kWidth:kWidth];
    
    NSMutableArray *returnArr = [NSMutableArray array];
    for (NSInteger i = 0; i < [[x_Arr objectAtIndex:0] count]; i++) {
        CGFloat x = [[x_Arr[0] objectAtIndex:i] floatValue];
        CGFloat y_vol = CGFLOAT_MAX;
        CGFloat y_maVol1 = CGFLOAT_MAX;
        CGFloat y_maVol2 = CGFLOAT_MAX;
        CGFloat y_vol_ling = (height - BottomEdge * 2)* (maxF - minF)/ valueGap + TopEdge;//零点

        if (i < vol_Arr.count) {
            y_vol = (height - BottomEdge * 2)* (maxF - [vol_Arr[i] floatValue])/ valueGap + TopEdge;
        }
        if (i < maVol1Arr.count) {
            y_maVol1 = (height - BottomEdge * 2)* (maxF - [maVol1Arr[i] floatValue])/ valueGap + TopEdge;
        }
        if (i < maVol2Arr.count) {
            y_maVol2 = (height - BottomEdge * 2)* (maxF - [maVol2Arr[i] floatValue])/ valueGap + TopEdge;
        }
        
        
        
        CGPoint point_Vol = CGPointMake(x, y_vol);
        CGPoint point_Vol_Ling = CGPointMake(x, y_vol_ling);
        CGPoint point_MaVol1 = CGPointMake(x, y_maVol1);
        CGPoint point_MaVol2 = CGPointMake(x, y_maVol2);

        
        NSArray *pointSmallArr = @[NSStringFromCGPoint(point_Vol),///0
                                   NSStringFromCGPoint(point_Vol_Ling),//1
                                   NSStringFromCGPoint(point_MaVol1),//2
                                   NSStringFromCGPoint(point_MaVol2)];//3
        
        [returnArr addObject:pointSmallArr];
        
    }
    
    CGFloat edgeF = 10 * valueGap / (height - BottomEdge * 2); //每个单位像素点对应多少实际值,再算出10像素点对应的实际值
    CGFloat maxFF = maxF + edgeF;
    CGFloat minFF = minF - edgeF;
    
    return @[returnArr, @[[NSNumber numberWithFloat:maxFF], [NSNumber numberWithFloat:minFF]], volArr];
    
    

    
    return nil;
}

+(NSArray *)getUI_Cci_WithW:(CGFloat)width h:(CGFloat)height kW:(CGFloat)kWidth loc:(NSInteger)location cCount:(NSInteger)cCount
{
    //获取原始数据
    DataManage *dataManage = [DataManage shareInstance];
    NSArray *initialCandleArr = [dataManage.indsDic objectForKey:@"arr_Candle"];
    NSArray *initialCciArr = [dataManage.indsDic objectForKey:@"arr_Cci"];
    
    
    //根据原始数据,获取子数组//此处判断依然有问题
    NSArray *biasArr = [DatatTansfer getSubArrWithArr:@[initialCciArr] loc:location count:cCount];
    
    NSArray *cciArr = [biasArr objectAtIndex:0];

    NSArray *maxMin_Arr = [DatatTansfer findMaxMinWithArr:biasArr];
    NSNumber *maxN = [maxMin_Arr objectAtIndex:0];
    NSNumber *minN = [maxMin_Arr objectAtIndex:1];
    CGFloat maxF = [maxN floatValue];
    CGFloat minF = [minN floatValue];
    
    
    CGFloat valueGap = maxF - minF;
    //    获取X轴数组
    NSArray *x_Arr = [DatatTansfer getYingLineArr_XWithData:[initialCandleArr objectAtIndex:0] With_W:width kWidth:kWidth];
    
    NSMutableArray *returnArr = [NSMutableArray array];
    for (NSInteger i = 0; i < [[x_Arr objectAtIndex:0] count]; i++) {
        CGFloat x = [[x_Arr[0] objectAtIndex:i] floatValue];
        CGFloat y_cci = CGFLOAT_MAX;
 
        if (i < cciArr.count) {
            y_cci = (height - BottomEdge * 2)* (maxF - [cciArr[i] floatValue])/ valueGap + TopEdge;
        }
        
        CGPoint point_Cci = CGPointMake(x, y_cci);
        
        NSArray *pointSmallArr = @[NSStringFromCGPoint(point_Cci)];///0
        
        [returnArr addObject:pointSmallArr];

    }
    
    
    CGFloat edgeF = 10 * valueGap / (height - BottomEdge * 2); //每个单位像素点对应多少实际值,再算出10像素点对应的实际值
    CGFloat maxFF = maxF + edgeF;
    CGFloat minFF = minF - edgeF;
    //    CGFloat valueGapGap = maxFF - minFF;
    
    return @[returnArr, @[[NSNumber numberWithFloat:maxFF], [NSNumber numberWithFloat:minFF]], @[cciArr]];
}





+(NSArray *)getUI_Press_WithW:(CGFloat)width h:(CGFloat)height kW:(CGFloat)kWidth loc:(NSInteger)location cCount:(NSInteger)cCount maOrBoll:(NSInteger)maOrBollIndex
{
    //获取原始数据
    DataManage *dataManage = [DataManage shareInstance];
    NSArray *initialCandleArr = [dataManage.indsDic objectForKey:@"arr_Candle"];
    NSArray *initialMaArr = [NSArray array];
    if (maOrBollIndex == 0) {
        initialMaArr = [dataManage.indsDic objectForKey:@"arr_Ma"];
    }else{
        initialMaArr = [dataManage.indsDic objectForKey:@"arr_Boll"];
    }
    NSArray *initialDateArr = [dataManage.indsDic objectForKey:@"arr_Date"];


    
    //根据原始数据,获取子数组//此处判断依然有问题
    NSArray *candleArr = [DatatTansfer getSubArrWithArr:initialCandleArr loc:location count:cCount];
    NSArray *maArr = [DatatTansfer getSubArrWithArr:initialMaArr loc:location count:cCount];
    NSArray *dateArr = [DatatTansfer getSubArrWithArr:initialDateArr loc:location count:cCount];

    
    
    //获取X轴
    NSArray *x_Arr = [DatatTansfer getYingLineArr_XWithData:[initialCandleArr objectAtIndex:0] With_W:width kWidth:kWidth];
    
    
    NSMutableArray *maxMinArr = [NSMutableArray array];
    [maxMinArr addObjectsFromArray:candleArr];
    [maxMinArr addObjectsFromArray:maArr];
    
    //找出数据中最大最小值
    NSArray *maxMin_Arr = [DatatTansfer findMaxMinWithArr:maxMinArr];
    CGFloat maxF = [[maxMin_Arr objectAtIndex:0] floatValue];
    CGFloat minF = [[maxMin_Arr objectAtIndex:1] floatValue];
    
    //数据最大差值
    CGFloat valueGap = maxF - minF;
    
    NSArray *cArr = [candleArr objectAtIndex:3];
    
    NSArray *ying_xArr = [x_Arr objectAtIndex:0];
    //
    NSMutableArray *returnArr = [NSMutableArray array];
        for (NSInteger i = 0; i < cArr.count; i++) {
            CGFloat x = [[ying_xArr objectAtIndex:i] floatValue];
            CGFloat y_c = CGFLOAT_MAX;
    //
            if (i < cArr.count) {
                y_c = (height - BottomEdge * 2)*(maxF - [cArr[i] floatValue])/valueGap + TopEdge;
            }
    //
            NSArray *smallArr = @[[NSNumber numberWithFloat:x], [NSNumber numberWithFloat:y_c]];
            [returnArr addObject:smallArr];
        }
    
//    NSLog(@"longPress:%@", returnArr);
    
    
    
    return @[returnArr, dateArr, candleArr];
    
    
}

#warning ---------------------------------------通用类---------------------------------------

//通用类:求最大
+ (NSNumber *)get_Max_WithArray:(NSArray *)array
{
    CGFloat maxFloat = 0;
//    for (NSString *string in array) {
//        CGFloat singleF = [string floatValue];
//        maxFloat = maxFloat > singleF ? maxFloat : singleF;
//    }
    if (array.count != 0) {
        maxFloat = [array[0] floatValue];
    }

    for (NSInteger i = 1; i < array.count; i++) {
        CGFloat singleF = [array[i] floatValue];
        maxFloat = maxFloat > singleF ? maxFloat : singleF;
    }
    
    NSNumber *maxNumber = [NSNumber numberWithFloat:maxFloat];
    return maxNumber;
}

//通用类:求最小
+ (NSNumber *)get_Min_WithArray:(NSArray *)array
{
    CGFloat minFloat = CGFLOAT_MAX;
//    for (NSString *string in array) {
//        CGFloat singleF = [string floatValue];
//        minFloat = minFloat < singleF ? minFloat : singleF;
//    }
    
    if (array.count != 0) {
        minFloat = [array[0] floatValue];
    }
    
//    CGFloat minFloat = [array[0] floatValue];
    for (NSInteger i = 1; i < array.count; i++) {
        CGFloat singleF = [array[i] floatValue];
        minFloat = minFloat < singleF ? minFloat : singleF;
    }
    
    NSNumber *minNumber = [NSNumber numberWithFloat:minFloat];
    return minNumber;
}

//通用类:求平均
+ (NSNumber *)get_Sum_WithArray:(NSArray *)array
{
    CGFloat sumFloat = 0;
    for (NSString *string in array) {
        CGFloat singleF = [string floatValue];
        sumFloat = sumFloat + singleF;
    }
    NSNumber *sumNumber = [NSNumber numberWithFloat:sumFloat];
    return sumNumber;
}



//通用类:获取数组中的子数组
+ (NSArray *)getSubArrWithArr:(NSArray *)dataArr loc:(NSInteger)location count:(NSInteger)count
{
    
    
    NSMutableArray *returnArr = [NSMutableArray array];
    for (NSInteger i = 0; i < dataArr.count; i++) {
        NSArray *smallArr = [dataArr objectAtIndex:i];
        NSInteger theCount = count + location;
        
        //        NSLog(@"%@---smallArr1", smallArr);
        
        //        smallArr.count - location
        if (theCount > smallArr.count) {
            
            NSInteger thecount = smallArr.count - location - 1;
            //
            if (thecount > 0) {
                smallArr = [smallArr subarrayWithRange:NSMakeRange(location, thecount)];
            }else{
                smallArr = [smallArr subarrayWithRange:NSMakeRange(0, 0)];
            }
            
        }else{
            
            smallArr = [smallArr subarrayWithRange:NSMakeRange(location, count)];
            
            
        }
        
        [returnArr addObject:smallArr];
    }
    
    
    return returnArr;
}

//通用类:获取影线和蜡烛图的X轴数组
+ (NSArray *)getYingLineArr_XWithData:(NSArray *)arr With_W:(CGFloat)w kWidth:(CGFloat)kWidth
{
    
    CGFloat yingX = w -(YWIDTH / 2 + kWidth / 2) - RightEdge;//设置影线X轴的初始值,即第一个值
    CGFloat cancleX = w - (kWidth +  YWIDTH / 2) - RightEdge;//设置蜡烛图的初始X轴的值,即第一个值
    
    NSMutableArray *yXArr = [NSMutableArray arrayWithObject:[NSNumber numberWithFloat:yingX]];
    NSMutableArray *cXArr = [NSMutableArray arrayWithObject:[NSNumber numberWithFloat:cancleX]];
    
    for (NSInteger i = 0; i < arr.count - 1; i++) {//减一才能保证与dataArr个数一样
        yingX -= (kWidth + YWIDTH + SPACE);//SPACE代表每个蜡烛图之间的距离
        cancleX -= (kWidth + YWIDTH + SPACE);
        
        [yXArr addObject:[NSNumber numberWithFloat:yingX]];
        [cXArr addObject:[NSNumber numberWithFloat:cancleX]];
    }
    
    return @[yXArr, cXArr];
}

//通用类:找出最大最小值,传入的array可能是一维数组或者二维数组
+ (NSArray *)findMaxMinWithArr:(NSArray *)arr
{
    NSMutableArray *tempArr = [NSMutableArray array];
    id theObject = [arr objectAtIndex:0];
    if ([theObject isKindOfClass:[NSArray class]]) {//二维数组
        for (NSArray *smallArray in arr) {
            [tempArr addObjectsFromArray:smallArray];
        }
    }else{//一维数组
        for (NSInteger i = 0; i < arr.count; i++) {
            [tempArr addObject:[arr objectAtIndex:i]];
        }
    }
    NSNumber *max = [DatatTansfer get_Max_WithArray:tempArr];
    
    NSNumber *min = [DatatTansfer get_Min_WithArray:tempArr];
    
    return @[max, min];
}


@end
