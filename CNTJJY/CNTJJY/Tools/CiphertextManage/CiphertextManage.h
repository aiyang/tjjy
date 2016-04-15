//
//  CiphertextManage.h
//  CNTJJY
//
//  Created by totrade on 16/1/13.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CiphertextManage : NSObject

//MD5加密
+ (NSString *)getMd5_32Bit:(NSString *)string;
//RC4加密
+(NSString *)encrypt_Rc4:(NSString *)string withKey:(NSString *)key;
//RC4解密
+ (NSString*)decrypt_Rc4:(NSString*)string withKey:(NSString*)key;

//+ (NSString *)base


//NSData* originData = [originStr dataUsingEncoding:NSASCIIStringEncoding];
//
//NSString* encodeResult = [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//
//NSLog(@"encodeResult:%@",encodeResult);
//
//
//NSData* decodeData = [[NSData alloc] initWithBase64EncodedString:encodeResult options:0];
//
//NSString* decodeStr = [[NSString alloc] initWithData:decodeData encoding:NSASCIIStringEncoding];

@end
