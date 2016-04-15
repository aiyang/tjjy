//
//  BasicObject.h
//  ToTrade
//
//  Created by totrade1 on 15/8/19.
//  Copyright (c) 2015年 ToTrade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasicObject : NSObject


- (instancetype)initWithDictionary:(NSDictionary *)dic;
//类方法

+ (instancetype)objectWithDictionary:(NSDictionary *)dic;
+ (NSMutableArray *)modelArrWithDics:(NSMutableArray *)dicArr;


@end
