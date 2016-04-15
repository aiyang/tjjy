//
//  BasicObject.m
//  ToTrade
//
//  Created by totrade1 on 15/8/19.
//  Copyright (c) 2015年 ToTrade. All rights reserved.
//

#import "BasicObject.h"



@implementation BasicObject

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dic];
        
        
        
    }
    return self;
}

//dicArr指字典中所包含的数组
+ (NSMutableArray *)modelArrWithDics:(NSMutableArray *)dicArr
{
    //此数组中所存储的应该是以model型存储的数据
    NSMutableArray *innerArr = [NSMutableArray array];
    //由于数组中存储的是字典,此处取出遍历数组中的字典
    for (NSDictionary *innerDic in dicArr) {
        id innerObject = [[self class] objectWithDictionary:innerDic];
        [innerArr addObject:innerObject];
    }
    return innerArr;
}



+ (instancetype)objectWithDictionary:(NSDictionary *)dic
{
    //此处创建并返回model类?
    id object = [[[self class] alloc] initWithDictionary:dic];
    return object;
}



- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end
