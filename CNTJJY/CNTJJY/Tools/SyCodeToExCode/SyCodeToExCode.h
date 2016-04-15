//
//  SyCodeToExCode.h
//  CNTJJY
//
//  Created by totrade on 16/3/15.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//


///通过该类将产品code和交易所code进行一一对应的关系,由于数据量较少,将其保存在NSUserDefaults中
#import <Foundation/Foundation.h>

@interface SyCodeToExCode : NSObject

//将产品code与交易所code形成key-value形式,并存于本地
- (void)setSyC:(NSString *)syCode toExC:(NSString *)exCode;
//通过产品code获取当前产品对应的交易所
- (NSString *)getExCFromSyC:(NSString *)syCode;

@end
