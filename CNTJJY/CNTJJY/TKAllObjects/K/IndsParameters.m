//
//  IndsParameters.m
//  CNTJJY
//
//  Created by totrade on 16/2/25.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#pragma 用于指标的参数设定
#import "IndsParameters.h"

#import "DataManage.h"//内部调用不会造成循环调用

@interface IndsParameters ()



@property (nonatomic, strong)NSMutableDictionary *indsDic;

@end

@implementation IndsParameters

//使用@property声明属性,需要同时重写set和get方法时时,需要用@synthesize
//@synthesize ma_PMS = _ma_PMS;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _indsDic = [NSMutableDictionary dictionaryWithDictionary:[DataManage readUserDefaultsObjectforKey:@"indsDic"]];
        
    }
    return self;
}

//@property (nonatomic, strong)NSArray *ma_PMS;
//@property (nonatomic, strong)NSArray *boll_PMS;
//@property (nonatomic, strong)NSArray *macd_PMS;
//@property (nonatomic, strong)NSArray *kdj_PMS;
//@property (nonatomic, strong)NSArray *rsi_PMS;
//@property (nonatomic, strong)NSArray *bias_PMS;
//@property (nonatomic, strong)NSArray *cci_PMS;


//
//- (void)setMa_PMS:(NSArray *)ma_PMS
//{
//    [_indsDic setObject:ma_PMS forKey:@"ma_PMS"];
//    _ma_PMS = ma_PMS;
//    
//}



//- (void)setBoll_PMS:(NSArray *)boll_PMS
//{
//    [_indsDic setObject:boll_PMS forKey:@"boll_PMS"];
//    _boll_PMS = boll_PMS;
//}
//
//- (void)setMacd_PMS:(NSArray *)macd_PMS
//{
//    [_indsDic setObject:macd_PMS forKey:@"macd_PMS"];
//    _macd_PMS = macd_PMS;
//}
//
//- (void)setKdj_PMS:(NSArray *)kdj_PMS
//{
//    [_indsDic setObject:kdj_PMS forKey:@"kdj_PMS"];
//    _kdj_PMS = kdj_PMS;
//}
//
//- (void)setRsi_PMS:(NSArray *)rsi_PMS
//{
//    [_indsDic setObject:rsi_PMS forKey:@"rsi_PMS"];
//    _rsi_PMS = rsi_PMS;
//}
//
//- (void)setBias_PMS:(NSArray *)bias_PMS
//{
//    [_indsDic setObject:bias_PMS forKey:@"bias_PMS"];
//    _bias_PMS = bias_PMS;
//}
//
//- (void)setCci_PMS:(NSArray *)cci_PMS
//{
//    [_indsDic setObject:cci_PMS forKey:@"cci_PMS"];
//    _cci_PMS = cci_PMS;
//}

- (NSArray *)ma_PMS
{
    NSArray *array = [_indsDic objectForKey:@"ma_PMS"];
    if (array == nil) {
        array = @[@"5", @"10", @"20", @"60"];
    }
    return array;
}

- (NSArray *)boll_PMS
{
    NSArray *array = [_indsDic objectForKey:@"boll_PMS"];
    array = [_indsDic objectForKey:@"boll_PMS"];
    if (array == nil) {
        array = @[@"20"];
    }
    return array;
}

- (NSArray *)macd_PMS
{
    NSArray *array = [_indsDic objectForKey:@"macd_PMS"];
    if (array == nil) {
        array = @[@"12", @"26", @"9"];
    }
    return array;
}

- (NSArray *)kdj_PMS
{
    NSArray *array = [_indsDic objectForKey:@"kdj_PMS"];
    if (array == nil) {
        array = @[@"9", @"3", @"3"];
    }
    return array;
}

- (NSArray *)rsi_PMS
{
    NSArray *array = [_indsDic objectForKey:@"rsi_PMS"];
    if (array == nil) {
        array = @[@"6", @"12", @"24"];
    }
    return array;
}

- (NSArray *)bias_PMS
{
    NSArray *array = [_indsDic objectForKey:@"bias_PMS"];
    if (array == nil) {
        array = @[@"6", @"12", @"24"];
    }
    return array;
}

- (NSArray *)cci_PMS
{
    NSArray *array = [_indsDic objectForKey:@"cci_PMS"];
    if (array == nil) {
        array = @[@"14"];
    }
    return array;
}

- (NSArray *)PSY_PMS
{
    NSArray *array = [_indsDic objectForKey:@"psy_PMS"];
    if (array == nil) {
        array = @[@"12", @"6"];
    }
    return array;
}

- (NSArray *)OBV_PMS
{
    NSArray *array = [_indsDic objectForKey:@"obv_PMS"];
    if (array == nil) {
        array = @[@"30"];
    }
    return array;
}

- (NSArray *)VOL_PMS
{
    NSArray *array = [_indsDic objectForKey:@"vol_PMS"];
    if (array == nil) {
        array = @[@"5", @"10"];
    }
    return array;
}




- (NSArray *)getIndPMSWithType:(IndPMSType)type
{
    _indsDic = [NSMutableDictionary dictionaryWithDictionary:[DataManage readUserDefaultsObjectforKey:@"indsDic"]];
    
    NSArray *array = [NSArray array];
        switch (type) {
            case MAInd:{
                array = [self ma_PMS];//为什么这样可以
            }
            break;
    
            case BOLLInd:{
                array = [self boll_PMS];
            }
             break;
    
            case MACDInd:{
                array = [self macd_PMS];
            }
            break;
    
            case KDJInd:{
                array = [self kdj_PMS];
            }
            break;
    
            case RSIInd:{
                array = [self rsi_PMS];
            }
            break;
    
            case BIASInd:{
                array = [self bias_PMS];
            }
            break;
    
            case CCIInd:{
                array = [self cci_PMS];
            }
            break;
                
            case PSYInd:{
                array = [self PSY_PMS];
            }
                break;
                
            case OBVInd:{
                array = [self OBV_PMS];
            }
                break;
                
            case VOLInd:{
                array = [self VOL_PMS];
            }
                break;
                
            default:{
                array = nil;
            }
                break;
        }
    return array;
}

//用作存储
- (void)setIndArr:(NSArray *)indArr forKey:(NSString *)indName
{
    [_indsDic setObject:indArr forKey:indName];
    [DataManage writeUserDefaultsObject:_indsDic forKey:@"indsDic"];
}





@end
