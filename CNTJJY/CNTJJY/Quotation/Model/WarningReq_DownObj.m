//
//  WarningReq_DownObj.m
//  CNTJJY
//
//  Created by totrade on 16/2/26.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "WarningReq_DownObj.h"

@implementation WarningReq_DownObj

- (instancetype)init
{
    self = [self init];
    if (self) {
        
    }
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _theId = value;
    }else{
        [super setValue:value forKey:key];
    }
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end
