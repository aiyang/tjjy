//
//  IndsParameters.h
//  CNTJJY
//
//  Created by totrade on 16/2/25.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, IndPMSType){
    MAInd = 0,
    BOLLInd,
    MACDInd,
    KDJInd,
    RSIInd,
    BIASInd,
    CCIInd,
    PSYInd,
    OBVInd,
    VOLInd
};

#pragma 用于指标的参数设定
@interface IndsParameters : NSObject

@property (nonatomic, strong)NSArray *ma_PMS;
@property (nonatomic, strong)NSArray *boll_PMS;
@property (nonatomic, strong)NSArray *macd_PMS;
@property (nonatomic, strong)NSArray *kdj_PMS;
@property (nonatomic, strong)NSArray *rsi_PMS;
@property (nonatomic, strong)NSArray *bias_PMS;
@property (nonatomic, strong)NSArray *cci_PMS;
@property (nonatomic, strong)NSArray *PSY_PMS;
@property (nonatomic, strong)NSArray *OBV_PMS;
@property (nonatomic, strong)NSArray *VOL_PMS;



- (NSArray *)getIndPMSWithType:(IndPMSType)type;

- (void)setIndArr:(NSArray *)indArr forKey:(NSString *)indName;//单个赋值
//- (void)saveAllChangeParameters;//参数改变后,调用该方法保存到本地

@end
