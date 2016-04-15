//
//  CipherManage.h
//  TestDes
//
//  Created by totrade on 16/2/17.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CipherManage : NSObject

//32位MD5加密
+ (NSString *)getMd5_32Bit:(NSString *)string;


//加密的Key目前是固定的@"X8Ssw93l"

//Des加密
+(NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key;
//Des解密
+(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key;

//url编码
+ (NSString *)urlEncodeToPercentEscapeString:(NSString *) input;
//url解码
+ (NSString *)urlDecodeFromPercentEscapeString:(NSString *) input;

//下行的data数据转换为字典
+ (NSDictionary *)responseDataToDictionaryWithData:(NSData *)data;
//上行字典转为加密形式字典
//上行不带passWord
+ (NSDictionary *)requestDicToPostBodyWithDic:(NSDictionary *)dic;
//上行带passWord
+ (NSDictionary *)requestDicToPostBodyWithDic:(NSDictionary *)dic paswd:(NSString *)paswd;
//用于用户浏览器自动登录
+ (NSString *)requestDicToGetParametersWithDic:(NSDictionary *)dic paswd:(NSString *)paswd;

@end
