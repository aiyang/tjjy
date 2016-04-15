//
//  CiphertextManage.m
//  CNTJJY
//
//  Created by totrade on 16/1/13.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "CiphertextManage.h"

#import <CommonCrypto/CommonDigest.h>


static const int SBOX_LENGTH = 256;


@implementation CiphertextManage

+ (NSString *)getMd5_32Bit:(NSString *)string{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, string.length, digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}


+(NSString *)encrypt_Rc4:(NSString *)string withKey:(NSString *)key{
    
    //    NSArray *r_key = [NSArray array];
    NSMutableArray *r_sBox = [NSMutableArray array];
    
    r_sBox = [[CiphertextManage frameSBox:key] mutableCopy];
    unichar code[string.length];
    
    int i = 0;
    int j = 0;
    for (int n = 0; n < string.length; n++) {
        i = (i + 1) % SBOX_LENGTH;
        j = (j + [[r_sBox objectAtIndex:i]integerValue]) % SBOX_LENGTH;
        [r_sBox exchangeObjectAtIndex:i withObjectAtIndex:j];
        
        int index=([r_sBox[i] integerValue]+[r_sBox[j] integerValue]);
        
        int rand=([r_sBox[(index%SBOX_LENGTH)] integerValue]);
        
        code[n]=(rand  ^  (int)[string characterAtIndex:n]);
    }
    const unichar* buffer;
    buffer = code;
    
    return  [NSString stringWithCharacters:buffer length:string.length];
}

+ (NSString*)decrypt_Rc4:(NSString*)string withKey:(NSString*)key
{
    return [CiphertextManage encrypt_Rc4:string withKey:key];
}


+(NSArray *)frameSBox:(NSString *)keyValue{
    
    NSMutableArray *sBox = [[NSMutableArray alloc] initWithCapacity:SBOX_LENGTH];
    
    int j = 0;
    
    for (int i = 0; i < SBOX_LENGTH; i++) {
        [sBox addObject:[NSNumber numberWithInteger:i]];
    }
    
    for (int i = 0; i < SBOX_LENGTH; i++) {
        j = (j + [sBox[i] integerValue] + [keyValue characterAtIndex:(i % keyValue.length)]) % SBOX_LENGTH;
        [sBox exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    
    return [NSArray arrayWithArray:sBox];
}

@end
