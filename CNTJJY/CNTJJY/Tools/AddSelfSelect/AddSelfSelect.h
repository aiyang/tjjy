//
//  AddSelfSelect.h
//  CNTJJY
//
//  Created by totrade on 16/3/12.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

///将用户的自选产品保存到本地
#import <Foundation/Foundation.h>
#import "SingleExchangeAllSymbolsInstantData_DownObj.h"


@interface AddSelfSelect : NSObject

@property (nonatomic, strong)NSMutableDictionary *addSelDic;

//保存用户的自选产品到本地,通过字典的形式,将汇通和齐鲁的分开保存
- (void)setSelfSelectWith:(SingleExchangeAllSymbolsInstantData_DownObj *)single_DownObj interface:(NSString *)interface;

@end
