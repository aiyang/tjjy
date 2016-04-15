//
//  StockInds.m
//  Study_StockInds
//
//  Created by totrade on 16/2/5.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "StockInds.h"
#import "SingleSymbolHistoryData_DownObj.h"


//#define F_TO_STR(parameter) [NSString stringWithFormat:@"%f",parameter]
#define F_TO_STR(parameter) [NSNumber numberWithFloat:parameter]

//加减乘除枚举
typedef NS_ENUM(NSInteger, OperationType){
    plus = 0,
    minus,
    multipe,
    divide
};

//数据类型枚举
typedef enum {
    theOpen = 0,
    theHigh,
    theLow,
    theClose,
    theTime,
    theVol
}TheDataType;


@implementation StockInds

+ (NSArray *)get_Vol_witDataArr:(NSArray *)dataArr
{
    NSArray *volArr = [StockInds getArrFromDataArr:dataArr withTheDataType:theVol];
    return @[volArr];
}

+ (NSArray *)get_Date_witDataArr:(NSArray *)dataArr
{
    NSArray *timeArr = [StockInds getArrFromDataArr:dataArr withTheDataType:theTime];
    return @[timeArr];
}

//Candle
+ (NSArray *)get_Candle_WithDataArr:(NSArray *)dataArr
{
    NSArray *openArr = [StockInds getArrFromDataArr:dataArr withTheDataType:theOpen];
    NSArray *highArr = [StockInds getArrFromDataArr:dataArr withTheDataType:theHigh];
    NSArray *lowArr = [StockInds getArrFromDataArr:dataArr withTheDataType:theLow];
    NSArray *closeArr = [StockInds getArrFromDataArr:dataArr withTheDataType:theClose];
//    NSArray *timeArr = [StockInds getArrFromDataArr:dataArr withTheDataType:theTime];
    return @[openArr, highArr, lowArr, closeArr];
    
}

//1、	MA均线：
//MA1:MA(CLOSE,M1);
//MA2:MA(CLOSE,M2);
//MA3:MA(CLOSE,M3);
//MA4:MA(CLOSE,M4);

//MA通用类(index为参数,也为缺省值/返回一维数组)
+ (NSArray *)middleMA_WithArray:(NSArray *)arr index:(NSInteger)index
{
    
    //假设dataArr有100个数据,那么传回去只能有96个,
#warning 数组的第一个值就是最新的,所以不用考虑逆序吧!!!
    NSMutableArray *returnArr = [NSMutableArray array];
    NSInteger count = arr.count - index + 1;
    for (NSInteger i = 0; i < count; i++) {
        NSArray *smallArr = [NSArray array];
        smallArr = [arr subarrayWithRange:NSMakeRange(i, index)];
//        NSString *avg = [smallArr valueForKeyPath:@"@avg.floatValue"];
        NSNumber *avg = [StockInds get_Avg_WithArray:smallArr];

        [returnArr addObject:avg];
    }
    
////    重新换一个算法,先把所有数据除以index,再挨个取完相加
//    NSArray *sumAvgArr = [StockInds get_sumAvgArr_WithArray:arr index:index];
//    NSMutableArray *returnArr = [NSMutableArray array];
//    NSInteger count = arr.count - index + 1;
//    for (NSInteger i = 0; i < count; i++) {
//        NSArray *smallArr = [NSArray array];
//        smallArr = [sumAvgArr subarrayWithRange:NSMakeRange(i, index)];
//        //        NSString *avg = [smallArr valueForKeyPath:@"@avg.floatValue"];
//        NSNumber *sum = [StockInds get_Sum_WithArray:smallArr];
//        
//        [returnArr addObject:sum];
//    }
    
    return returnArr;
}

//STD通用类(index为参数,也为缺省值/返回一维数组)
+ (NSArray *)middleSTD_WithArray:(NSArray *)arr index:(NSInteger)index
{
    //之前算的是错的,应该是根据index算出来的是标准差数组
//    即5日,10日或20日等的标准差数组
    NSMutableArray *returnArr = [NSMutableArray array];
    NSInteger count = arr.count - index + 1;
    for (NSInteger i = 0; i < count; i++) {
        NSArray *smallArr = [NSArray array];
        smallArr = [arr subarrayWithRange:NSMakeRange(i, index)];
//        NSString *avg = [smallArr valueForKeyPath:@"@avg.floatValue"];
        CGFloat avg = [[StockInds get_Avg_WithArray:smallArr] floatValue];
        
        //这一步求smallArr其平均值的差的平方之和
        CGFloat sumSqrt = 0;
        for (NSInteger j = 0; j < smallArr.count; j++) {
            CGFloat x = fabsf([smallArr[j] floatValue] - avg);
            sumSqrt += powf(x, 2.0f);
        }
        CGFloat theSqrtf = sqrtf(sumSqrt / index);
        
        [returnArr addObject:[NSNumber numberWithFloat:theSqrtf]];
    }
    
    return returnArr;
}

//EMA通用类(index为参数,也为缺省值/返回一维数组)
+ (NSArray *)middleEMA_WithArray:(NSArray *)arr index:(NSInteger)index
{
    NSMutableArray *returnArr = [NSMutableArray array];
    //求1至index的总和
    NSInteger sumIndex = 0;
    for (NSInteger i = 1; i < index + 1; i++) {
        sumIndex += i;
    }
    NSInteger count = arr.count - index + 1;
    for (NSInteger i = 0; i < count; i++) {
        NSArray *smallArr = [NSArray array];
        smallArr = [arr subarrayWithRange:NSMakeRange(i, index)];
        CGFloat emaFloat = 0;
        for (NSInteger j = 0; j < index; j++) {
            CGFloat the_J = index - j;
            emaFloat += (the_J / sumIndex) * [smallArr[j] floatValue];
        }
        [returnArr addObject:F_TO_STR(emaFloat)];
    }
    return returnArr;
}

//LLV通用类(index为参数,也为缺省值/返回一维数组)
//LLV:检索index天内最低值
+ (NSArray *)middleLLV_WithArray:(NSArray *)arr index:(NSInteger)index
{
    NSMutableArray *returnArr = [NSMutableArray array];
    NSInteger count = arr.count - index + 1;
    for (NSInteger i = 0; i < count; i++) {
        NSArray *smallArr = [NSArray array];
        smallArr = [arr subarrayWithRange:NSMakeRange(i, index)];
//        CGFloat llv = [[smallArr valueForKeyPath:@"@min.floatValue"] floatValue];
        CGFloat llv = [[StockInds get_Min_WithArray:smallArr] floatValue];

        [returnArr addObject:F_TO_STR(llv)];
    }
    return returnArr;
}
//HHV通用类(index为参数,也为缺省值/返回一维数组)
//HHV:检索index天内最高值
+ (NSArray *)middleHHV_WithArray:(NSArray *)arr index:(NSInteger)index
{
    NSMutableArray *returnArr = [NSMutableArray array];
    NSInteger count = arr.count - index + 1;
    for (NSInteger i = 0; i < count; i++) {
        NSArray *smallArr = [NSArray array];
        smallArr = [arr subarrayWithRange:NSMakeRange(i, index)];
//        CGFloat hhv = [[arr valueForKeyPath:@"@max.floatValue"] floatValue];
        CGFloat hhv = [[StockInds get_Max_WithArray:smallArr] floatValue];

        [returnArr addObject:F_TO_STR(hhv)];
    }

    return returnArr;
}

//SMA通用类(index为参数,也为缺省值/返回一维数组)
//SMA:是EMA增加了权重参数
//若Y=SMA(X,N,M) 则 Y=(M*X+(N-M)*Y')/N, 其中Y'表示上一周期Y值,N必须大于M。
//weight为权重,sma还没怎么理解,暂时weight暂时定为1吧,文档里也是1
+ (NSArray *)middleSMA_WithArray:(NSArray *)arr index:(NSInteger)index weight:(NSInteger)weight
{
    NSMutableArray *returnArr = [NSMutableArray array];
    NSInteger count = arr.count - index + 1;
    for (NSInteger i = 0; i < count; i++) {
        NSArray *smallArr = [NSArray array];
        smallArr = [arr subarrayWithRange:NSMakeRange(i, index)];
//        NSString *avg = [smallArr valueForKeyPath:@"@avg.floatValue"];
        NSNumber *avg = [StockInds get_Avg_WithArray:smallArr];

        [returnArr addObject:avg];
    }
    return returnArr;
}

//REF(CLOSE,1);//代表前一天的收盘价,1为参数
//REF通用类(index为参数,也为缺省值/返回一维数组)
+ (NSArray *)middleREF_WithArray:(NSArray *)arr index:(NSInteger)index
{
    NSMutableArray *returnArr = [NSMutableArray array];
    NSArray *subArr = [arr subarrayWithRange:NSMakeRange(1, arr.count - 1)];
    [returnArr addObjectsFromArray:subArr];
    return returnArr;
}



//加减乘除:plus/minus/multipe/divide
//数组与数组运算
+ (NSArray *)arrOperationWithArr1:(NSArray *)arr1 toArr2:(NSArray *)arr2 operationType:(OperationType)operationType
{
    NSMutableArray *returnArr = [NSMutableArray array];
    NSInteger count = arr1.count < arr2.count ? arr1.count : arr2.count;
    for (NSInteger i = 0; i < count; i++) {
        CGFloat firstF = [[arr1 objectAtIndex:i] floatValue];
        CGFloat firstL = [[arr2 objectAtIndex:i] floatValue];
        
//        NSString *resultStr = [NSString string];
        NSNumber *resultStr = nil;

        
        switch (operationType) {
            case plus:{
                resultStr = F_TO_STR((firstF + firstL));
            }
                break;
                
            case minus:{
                resultStr = F_TO_STR((firstF - firstL));
            }
                break;
                
            case multipe:{
                resultStr = F_TO_STR((firstF * firstL));
            }
                break;
                
            case divide:{
                resultStr = F_TO_STR((firstF / firstL));
            }
                break;
                
            default:
                break;
        }
        
        [returnArr addObject:resultStr];
        
    }

    
    return returnArr;
  
}

//加减乘除:plus/minus/multipe/divide
//数组与常数运算
+ (NSArray *)arrOperationWithArr:(NSArray *)arr theInt:(NSInteger)theInt operationType:(OperationType)operationType
{
    NSMutableArray *returnArr = [NSMutableArray array];
   
    for (NSInteger i = 0; i < arr.count; i++) {
        CGFloat firstF = [[arr objectAtIndex:i] floatValue];
     
        
//        NSString *resultStr = [NSString string];
        NSNumber *resultStr = nil;

        
        
        switch (operationType) {
            case plus:{
            }
                break;
                
            case minus:{
                resultStr = F_TO_STR((firstF - theInt));
            }
                break;
                
            case multipe:{
                resultStr = F_TO_STR((firstF * theInt));
            }
                break;
                
            case divide:{
            }
                break;
                
            default:
                break;
        }
        
        [returnArr addObject:resultStr];
        
    }
    
    
    return returnArr;
    
}

#warning 获取数据类型还没写!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

+ (NSArray *)getArrFromDataArr:(NSArray *)dataArr withTheDataType:(TheDataType)theDataType
{
    NSMutableArray *returnArr = [NSMutableArray array];

    switch (theDataType) {
        case theOpen:{
            
            for (SingleSymbolHistoryData_DownObj *single_DownObj in dataArr) {
                [returnArr addObject:single_DownObj.o];
            }
            
        }
        break;
            
        case theHigh:{
            
            for (SingleSymbolHistoryData_DownObj *single_DownObj in dataArr) {
                [returnArr addObject:single_DownObj.high];
            }
            
        }
        break;
            
        case theLow:{
            
            for (SingleSymbolHistoryData_DownObj *single_DownObj in dataArr) {
                [returnArr addObject:single_DownObj.low];
            }
            
        }
        break;
            
        case theClose:{
            for (SingleSymbolHistoryData_DownObj *single_DownObj in dataArr) {
                [returnArr addObject:single_DownObj.c];
            }
            
            
        }
        break;
           
        case theTime:{
            
            for (SingleSymbolHistoryData_DownObj *single_DownObj in dataArr) {
                [returnArr addObject:single_DownObj.t];
            }
            
        }
            break;
            
        case theVol:{
            
            for (SingleSymbolHistoryData_DownObj *single_DownObj in dataArr) {
                [returnArr addObject:single_DownObj.v];
            }
            
        }
            break;
            
        default:
            break;
    }
    
    return returnArr;

}

//NSMutableArray *returnArr = [NSMutableArray array];
//NSInteger count = arr.count - index + 1;
//for (NSInteger i = 0; i < count; i++) {
//    NSArray *smallArr = [NSArray array];
//    smallArr = [arr subarrayWithRange:NSMakeRange(i, index)];
//}

//---------------------MA---------------------
//返回数组为二维数组,returnArr元素个数由indexArr.count决定
//MA1:MA(CLOSE,M1);
//MA2:MA(CLOSE,M2);
//MA3:MA(CLOSE,M3);
//MA4:MA(CLOSE,M4);
+ (NSArray *)get_MA_WithDataArr:(NSArray *)dataArr indexArr:(NSArray *)indexArr
{
    
    NSArray *closeArr = [StockInds getArrFromDataArr:dataArr withTheDataType:theClose];
    
    NSMutableArray *returnArr = [NSMutableArray array];
    for (NSString *indexStr in indexArr) {
        NSArray *singleArr = [StockInds middleMA_WithArray:closeArr index:[indexStr integerValue]];
        [returnArr addObject:singleArr];
    }
    return returnArr;
}

//---------------------BOLL---------------------
//返回数组为二维数组,returnArr元素个数为3个
//布林线:MA(CLOSE,N);
//布林线上限:布林线+2*STD(CLOSE,N);
//布林线下限:布林线-2*STD(CLOSE,N);
+ (NSArray *)get_BOLL_WithDataArr:(NSArray *)dataArr indexArr:(NSArray *)indexArr
{
    NSInteger index = [[indexArr objectAtIndex:0] integerValue];
    NSArray *closeArr = [StockInds getArrFromDataArr:dataArr withTheDataType:theClose];
    NSMutableArray *returnArr = [NSMutableArray array];
    
    NSArray *bollMidArr = [StockInds middleMA_WithArray:closeArr index:index];//中
    
    NSArray *stdArr = [StockInds middleSTD_WithArray:closeArr index:index];
    

    
    NSArray *doubleStdArr = [StockInds arrOperationWithArr1:stdArr toArr2:stdArr operationType:plus];
    
//    NSLog(@"stdArr:%@", stdArr);
    
    
    
    
    NSArray *bollUpArr = [StockInds arrOperationWithArr1:bollMidArr toArr2:doubleStdArr operationType:plus];
    NSArray *bollDownArr = [StockInds arrOperationWithArr1:bollMidArr toArr2:doubleStdArr operationType:minus];
    
//    for (NSInteger i = 0; i < bollMidArr.count; i++) {
//        NSLog(@"%@---%@---%@", bollUpArr[i], bollMidArr[i], bollDownArr[i]);
//    }
    
 
    [returnArr addObject:bollUpArr];
    [returnArr addObject:bollMidArr];
    [returnArr addObject:bollDownArr];
    
    return returnArr;
}

//---------------------MACD---------------------
//返回数组为二维数组,returnArr元素个数为3个
//indexArr包含SHORT,LONG,MID这三个参数
//DIF:EMA(CLOSE,SHORT)-EMA(CLOSE,LONG);
//DEA:EMA(DIF,MID);
//MACD:(DIF-DEA)*2
+ (NSArray *)get_MACD_WithDataArr:(NSArray *)dataArr indexArr:(NSArray *)indexArr
{
    NSArray *closeArr = [StockInds getArrFromDataArr:dataArr withTheDataType:theClose];
    NSMutableArray *returnArr = [NSMutableArray array];
    
    NSArray *shortEmaArr = [StockInds middleEMA_WithArray:closeArr index:[indexArr[0] integerValue]];
    NSArray *longEmaArr = [StockInds middleEMA_WithArray:closeArr index:[indexArr[1] integerValue]];
    
    NSArray *difArr = [StockInds arrOperationWithArr1:shortEmaArr toArr2:longEmaArr operationType:minus];
    
    NSArray *deaArr = [StockInds middleEMA_WithArray:difArr index:[indexArr[2] integerValue]];
    
    NSArray *difMinusDeaArr = [StockInds arrOperationWithArr1:difArr toArr2:deaArr operationType:minus];
    
    NSArray *macdArr = [StockInds arrOperationWithArr1:difMinusDeaArr toArr2:difMinusDeaArr operationType:plus];
    
    [returnArr addObject:difArr];
    [returnArr addObject:deaArr];
    [returnArr addObject:macdArr];
    
    return returnArr;
}

//---------------------KDJ---------------------
//返回数组为二维数组,returnArr元素个数为3个
//indexArr包含N,M1,M2这三个参数
//RSV:=(CLOSE-LLV(LOW,N))/(HHV(HIGH,N)-LLV(LOW,N))*100;
//K:SMA(RSV,M1,1);
//D:SMA(K,M2,1);
//J:3*K-2*D;
+ (NSArray *)get_KDJ_WithDataArr:(NSArray *)dataArr indexArr:(NSArray *)indexArr
{
    NSArray *closeArr = [StockInds getArrFromDataArr:dataArr withTheDataType:theClose];
    NSArray *highArr = [StockInds getArrFromDataArr:dataArr withTheDataType:theHigh];
    NSArray *lowArr = [StockInds getArrFromDataArr:dataArr withTheDataType:theLow];
    NSMutableArray *returnArr = [NSMutableArray array];
    
    NSArray *llvArr = [StockInds middleLLV_WithArray:lowArr index:[indexArr[0] integerValue]];
    NSArray *hhvArr = [StockInds middleHHV_WithArray:highArr index:[indexArr[0] integerValue]];
    
    NSMutableArray *closeMinusLlvArr = [NSMutableArray array];
    for (NSInteger i = 0; i < llvArr.count; i ++) {
        CGFloat closeF = [[closeArr objectAtIndex:i] floatValue];
        CGFloat llvF = [[llvArr objectAtIndex:i] floatValue];
        [closeMinusLlvArr addObject:F_TO_STR((closeF - llvF))];
    }
    
    NSArray *hhvMinusLlvArr = [StockInds arrOperationWithArr1:hhvArr toArr2:llvArr operationType:minus];
    
    NSArray *theArr = [StockInds arrOperationWithArr1:closeMinusLlvArr toArr2:hhvMinusLlvArr operationType:divide];
    NSArray *rsvArr = [StockInds arrOperationWithArr:theArr theInt:100 operationType:multipe];
    
    NSArray *kArr = [StockInds middleSMA_WithArray:rsvArr index:[indexArr[1] integerValue] weight:1];
    
    NSArray *dArr = [StockInds middleSMA_WithArray:kArr index:[indexArr[2] integerValue] weight:1];
    
    NSArray *k3Arr = [StockInds arrOperationWithArr:kArr theInt:3 operationType:multipe];
    NSArray *d2Arr = [StockInds arrOperationWithArr:dArr theInt:2 operationType:multipe];
    
    NSArray *jArr = [StockInds arrOperationWithArr1:k3Arr toArr2:d2Arr operationType:minus];
    
    [returnArr addObject:kArr];
    [returnArr addObject:dArr];
    [returnArr addObject:jArr];
    
    return returnArr;
}

//---------------------RSI---------------------
//返回数组为二维数组,returnArr元素个数为3个
//indexArr包含N1,N2,N3这三个参数
//LC:=REF(CLOSE,1);
//RSI1:SMA(MAX(CLOSE-LC,0),N1,1)/SMA(ABS(CLOSE-LC),N1,1)*100;
//RSI2:SMA(MAX(CLOSE-LC,0),N2,1)/SMA(ABS(CLOSE-LC),N2,1)*100;
//RSI3:SMA(MAX(CLOSE-LC,0),N3,1)/SMA(ABS(CLOSE-LC),N3,1)*100;
+ (NSArray *)get_RSI_withDataArr:(NSArray *)dataArr indexArr:(NSArray *)indexArr
{
    NSArray *closeArr = [StockInds getArrFromDataArr:dataArr withTheDataType:theClose];
    NSMutableArray *returnArr = [NSMutableArray array];
    NSArray *lcArr = [StockInds middleREF_WithArray:closeArr index:1];
    
    NSMutableArray *maxArr = [NSMutableArray array];
    NSMutableArray *absArr = [NSMutableArray array];
    for (NSInteger i = 0; i < closeArr.count; i++) {
        CGFloat closeF = [closeArr[i] floatValue];
        CGFloat lcF = 0.0f;
        if (i < lcArr.count) {
            lcF = [lcArr[i] floatValue];
        }
        CGFloat maxF = closeF > lcF ? closeF : lcF;
        [maxArr addObject:F_TO_STR(maxF)];
        CGFloat absF = fabs(closeF - lcF);
        [absArr addObject:F_TO_STR(absF)];
    }
    
    for (NSString *indexStr in indexArr) {
        [returnArr addObject:[StockInds get_SingleRSI_withMaxArr:maxArr absArr:absArr index:[indexStr integerValue]]];
    }
    
    
    return returnArr;
}

+ (NSArray *)get_SingleRSI_withMaxArr:(NSArray *)maxArr absArr:(NSArray *)absArr index:(NSInteger)index
{
    NSArray *smaMaxArr = [StockInds middleSMA_WithArray:maxArr index:index weight:1];
    NSArray *smaAbsArr = [StockInds middleSMA_WithArray:absArr index:index weight:1];
    
    NSArray *maxDivAbsArr = [StockInds arrOperationWithArr1:smaMaxArr toArr2:smaAbsArr operationType:divide];
    
    NSArray *singleRsiArr = [StockInds arrOperationWithArr:maxDivAbsArr theInt:100 operationType:multipe];
    
    return singleRsiArr;
}

//---------------------BIAS---------------------
//返回数组为二维数组,returnArr元素个数为3个
//indexArr包含N1,N2,N3这三个参数
//BIAS1 :(CLOSE-MA(CLOSE,N1))/MA(CLOSE,N1)*100;
//BIAS2 :(CLOSE-MA(CLOSE,N2))/MA(CLOSE,N2)*100;
//BIAS3 :(CLOSE-MA(CLOSE,N3))/MA(CLOSE,N3)*100;
+ (NSArray *)get_BIAS_withDataArr:(NSArray *)dataArr indexArr:(NSArray *)indexArr
{
    NSArray *closeArr = [StockInds getArrFromDataArr:dataArr withTheDataType:theClose];
    NSMutableArray *returnArr = [NSMutableArray array];
    
    for (NSString *indexStr in indexArr) {
        [returnArr addObject:[StockInds get_SingleBIAS_withArr:closeArr index:[indexStr integerValue]]];
    }
    
    return returnArr;
}

+ (NSArray *)get_SingleBIAS_withArr:(NSArray *)arr index:(NSInteger)index
{
    NSArray *maArr = [StockInds middleMA_WithArray:arr index:index];
    
    NSArray *closeDivMaArr = [StockInds arrOperationWithArr1:arr toArr2:maArr operationType:divide];
    
    NSArray *minus1Arr = [StockInds arrOperationWithArr:closeDivMaArr theInt:1 operationType:minus];
    
    NSArray *biasArr = [StockInds arrOperationWithArr:minus1Arr theInt:100 operationType:multipe];
    
    return biasArr;
}


//---------------------CCI---------------------
//返回数组为一维数组
//TYP:=(HIGH+LOW+CLOSE)/3;
//CCI:(TYP-MA(TYP,N))/(0.015*AVEDEV(TYP,N));
+ (NSArray *)get_CCI_WithDataArr:(NSArray *)dataArr indexArr:(NSArray *)indexArr
{
    NSInteger index = [[indexArr objectAtIndex:0] integerValue];
    NSArray *closeArr = [StockInds getArrFromDataArr:dataArr withTheDataType:theClose];
    NSArray *highArr = [StockInds getArrFromDataArr:dataArr withTheDataType:theHigh];
    NSArray *lowArr = [StockInds getArrFromDataArr:dataArr withTheDataType:theLow];
    
    NSMutableArray *returnArr = [NSMutableArray array];
    
    NSMutableArray *typArr = [NSMutableArray array];
    for (NSInteger i = 0; i < dataArr.count; i++) {
        NSArray *smallArr = @[closeArr[i], highArr[i], lowArr[i]];
        NSString *avg = [smallArr valueForKeyPath:@"@avg.floatValue"];
        [typArr addObject:avg];
    }
    
    
    NSArray *maTypArr = [StockInds middleMA_WithArray:typArr index:index];
    
//    AVEDEV(TYP,N)//    (0.015*AVEDEV(TYP,N))
    NSMutableArray *avedevArr = [NSMutableArray array];
    for (NSInteger i = 0; i < maTypArr.count; i++) {
        CGFloat maTypF = [maTypArr[i] floatValue];
        CGFloat avedevSumF = 0;
        for (NSInteger j = 0; j < index; j++) {
            avedevSumF += fabs([typArr[i + j] floatValue] - maTypF);
        }
        
        CGFloat avedevF = avedevSumF / index * 0.015f;//    (0.015*AVEDEV(TYP,N))
        [avedevArr addObject:F_TO_STR(avedevF)];
    }
    

//    (TYP-MA(TYP,N))
    NSArray *typMaTypArr = [StockInds arrOperationWithArr1:typArr toArr2:maTypArr operationType:minus];

    
    NSArray *cciArr = [StockInds arrOperationWithArr1:typMaTypArr toArr2:avedevArr operationType:divide];
    
    [returnArr addObjectsFromArray:cciArr];
    
    return returnArr;
}

//---------------------PSY---------------------
+ (NSArray *)get_PSY_WithDataArr:(NSArray *)dataArr indexArr:(NSArray *)indexArr
{
//    indexArr = @[@"12", @"6"];//存的顺序为N,M
    NSArray *closeArr = [StockInds getArrFromDataArr:dataArr withTheDataType:theClose];
    NSArray *refArr = [StockInds middleREF_WithArray:closeArr index:1];//缺省为1
    NSMutableArray *upDownArr = [NSMutableArray array];
    
    for (NSInteger i = 0; i < refArr.count; i++) {
        CGFloat upDownF = [closeArr[i] floatValue] - [refArr[i] floatValue];
        [upDownArr addObject:[NSNumber numberWithFloat:upDownF]];
    }
    
    NSMutableArray *psyArr = [NSMutableArray array];
    NSInteger index_N = [[indexArr objectAtIndex:0] integerValue];
    for (NSInteger i = 0; i < upDownArr.count - index_N + 1; i++) {
        
        //*-*-*-*-*-*-*-*-*-*-*-
        
        if (upDownArr.count < index_N){
            index_N = upDownArr.count ;
        }
        NSArray *subArr = [upDownArr subarrayWithRange:NSMakeRange(i, index_N)];
        NSInteger upCount = 0;
        for (NSInteger j = 0; j < subArr.count; j++) {
            if ([subArr[j] floatValue] > 0) {
                upCount++;
            }
        }
        CGFloat psyF = (upCount * 100) / (CGFloat)[subArr count];
        [psyArr addObject:[NSNumber numberWithFloat:psyF]];
    }
    
    NSArray *psyMaArr = [StockInds middleMA_WithArray:psyArr index:[indexArr[1] integerValue]];
    
    return @[psyArr, psyMaArr];
}

//---------------------OBV---------------------
+ (NSArray *)get_OBV_WithDataArr:(NSArray *)dataArr indexArr:(NSArray *)indexArr
{
//    indexArr = @[@"30"];
    NSArray *volArr = [[StockInds get_Vol_witDataArr:dataArr] objectAtIndex:0];
    NSArray *closeArr = [StockInds getArrFromDataArr:dataArr withTheDataType:theClose];
    NSArray *refArr = [StockInds middleREF_WithArray:closeArr index:1];//缺省为1
    
    NSMutableArray *vaArr = [NSMutableArray array];
    for (NSInteger i = 0; i < refArr.count; i++) {
        CGFloat closeF = [closeArr[i] floatValue];
        CGFloat refF = [refArr[i] floatValue];
        CGFloat vaF = 0.0;
        if (closeF > refF) {
            vaF = [volArr[i] floatValue];
        }else{
            vaF = [volArr[i] floatValue] * -1;
        }
        [vaArr addObject:[NSNumber numberWithFloat:vaF]];
    }
    
    NSMutableArray *newVaArr = [NSMutableArray array];
    for (NSInteger i = 0; i < refArr.count; i ++) {
        CGFloat closeF = [closeArr[i] floatValue];
        CGFloat refF = [refArr[i] floatValue];
        if (closeF == refF) {
            [newVaArr addObject:@"0.0"];

        }else{
            [newVaArr addObject:vaArr[i]];
        }
    }
    
    NSMutableArray *obvArr = [NSMutableArray array];
    for (NSInteger i = 0; i < newVaArr.count; i++) {
        NSArray *subArr = [newVaArr subarrayWithRange:NSMakeRange(0, i+1)];
        NSNumber *sumN = [StockInds get_Sum_WithArray:subArr];
        [obvArr addObject:sumN];
    }
    
    NSArray *maObvArr = [StockInds middleMA_WithArray:obvArr index:[indexArr[0] integerValue]];
    
    
    return @[obvArr, maObvArr];
}

//---------------------VOL---------------------
+ (NSArray *)get_VOL_WithDataArr:(NSArray *)dataArr indexArr:(NSArray *)indexArr
{
//    indexArr = @[@"5", @"10"];//M1,M2
    NSArray *volArr = [[StockInds get_Vol_witDataArr:dataArr] objectAtIndex:0];
    NSArray *maVol1 = [StockInds middleMA_WithArray:volArr index:[indexArr[0] integerValue]];
    NSArray *maVol2 = [StockInds middleMA_WithArray:volArr index:[indexArr[1] integerValue]];

    return @[volArr, maVol1, maVol2];
}




//将数组中的每个值用index平均,然后返回新数组
+ (NSArray *)get_sumAvgArr_WithArray:(NSArray *)array index:(NSInteger)index
{
    NSMutableArray *sumAvgArr = [NSMutableArray array];
    for (NSString *string in array) {
        CGFloat singleF = [string floatValue] / index;
        [sumAvgArr addObject:[NSNumber numberWithFloat:singleF]];
    }
    return sumAvgArr;
}

//传入为字符串型数组
//求平均
+ (NSNumber *)get_Avg_WithArray:(NSArray *)array
{
    CGFloat sumFloat = 0;
    for (NSString *string in array) {
        CGFloat singleF = [string floatValue];
        sumFloat = sumFloat + singleF;
    }
    NSNumber *avgNumber = [NSNumber numberWithFloat:(sumFloat / array.count)];
    return avgNumber;
}

//求最大
+ (NSNumber *)get_Max_WithArray:(NSArray *)array
{
    CGFloat maxFloat = 0;
    for (NSString *string in array) {
        CGFloat singleF = [string floatValue];
        maxFloat = maxFloat > singleF ? maxFloat : singleF;
    }
    NSNumber *maxNumber = [NSNumber numberWithFloat:maxFloat];
    return maxNumber;
}

//求最小
+ (NSNumber *)get_Min_WithArray:(NSArray *)array
{
    CGFloat minFloat = CGFLOAT_MAX;
    for (NSString *string in array) {
        CGFloat singleF = [string floatValue];
        minFloat = minFloat < singleF ? minFloat : singleF;
    }
    NSNumber *minNumber = [NSNumber numberWithFloat:minFloat];
    return minNumber;
}

//求和
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

@end
