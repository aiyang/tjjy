//
//  SyCodeToExCode.m
//  CNTJJY
//
//  Created by totrade on 16/3/15.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "SyCodeToExCode.h"

@interface SyCodeToExCode ()

@property (nonatomic, strong)NSMutableDictionary *syCodeToExCodeDic;

@end

@implementation SyCodeToExCode

- (instancetype)init
{
    self = [super init];
    if (self) {
        _syCodeToExCodeDic = [NSMutableDictionary dictionaryWithDictionary:[DataManage readUserDefaultsObjectforKey:@"syCodeToExCode"]];
    }
    return self;
}

- (void)setSyC:(NSString *)syCode toExC:(NSString *)exCode
{
    [_syCodeToExCodeDic setObject:exCode forKey:syCode];
    [DataManage writeUserDefaultsObject:_syCodeToExCodeDic forKey:@"syCodeToExCode"];
}

- (NSString *)getExCFromSyC:(NSString *)syCode
{
    NSString *string = [_syCodeToExCodeDic objectForKey:syCode];
    if (string == nil) {
        string = @"NULL";
    }
    return string;
}

@end
