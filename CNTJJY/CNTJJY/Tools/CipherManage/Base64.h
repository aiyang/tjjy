//
//  Base64.h
//  TestObj
//
//  Created by totrade on 16/2/16.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

//base64转码解码类
#import <Foundation/Foundation.h>

@interface Base64 : NSObject

+(NSString *)encode:(NSData *)data;
+(NSData *)decode:(NSString *)dataString;

@end
