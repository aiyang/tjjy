//
//  RC4_Basic.m
//  Study_RC4_3
//
//  Created by totrade on 16/1/28.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "RC4_Basic.h"
#import "GTMBase64.h"


typedef unsigned longULONG;

/*初始化函数*/
//参数1是一个256长度的char型数组，定义为: unsigned char sBox[256];
//参数2是密钥，其内容可以随便定义：char key[256];
//参数3是密钥的长度，Len = strlen(key);
void rc4_init(unsigned char*s, unsigned char*key, unsigned long Len)
{
    int i = 0, j = 0;
    char k[256] = { 0 };
    unsigned char tmp = 0;
    for (i = 0; i<256; i++)
    {
        s[i] = i;
        k[i] = key[i%Len];
    }
    for (i = 0; i<256; i++)
    {
        j = (j + s[i] + k[i]) % 256;
        tmp = s[i];
        s[i] = s[j];//交换s[i]和s[j]
        s[j] = tmp;
    }
}

/*加解密*/
void rc4_crypt(unsigned char*s, unsigned char*Data, unsigned long Len)
{
    int i = 0, j = 0, t = 0;
    unsigned long k = 0;
    unsigned char tmp;
    for (k = 0; k<Len; k++)
    {
        i = (i + 1) % 256;
        j = (j + s[i]) % 256;
        tmp = s[i];
        s[i] = s[j];//交换s[x]和s[y]
        s[j] = tmp;
        t = (s[i] + s[j]) % 256;
        Data[k] ^= s[t];
        //        printf("%c\n", Data[k]);
        ////        Byte数组－> NSData
        //        Byte byte = Data[k];
        //        NSData *adata = [[NSData alloc] initWithBytes:byte length:24];
        //
        ////        NSData－> NSString
        //        NSString
        //        *aString = [[NSString alloc] initWithData:adata encoding:NSUTF8StringEncoding];
    }
    
    
}

static const int SBOX_LENGTH = 256;
//static const int KEY_MIN_LENGTH = 1;

@implementation RC4_Basic


+(NSString *)rc4With:(NSString *)str key:(NSString *)theKey
{

    
    unsigned char s[256] = { 0 }, s2[256] = { 0 };//S-box

    
    char key[256] = "965f7809313aa231b7390640b0ce4a2cX8Ssw93lswiKC94Nsk2";
    char pData[512] = "loginname=testUser001&paswd=e10adc3949ba59abbe56e057f20f883e&action=checkUserPassword";
    
    
    
//    char key[256];
//    unsigned char keyCode;
//    NSMutableArray *arr1 = [NSMutableArray array];
//    for (NSInteger i = 0; i < theKey.length; i++) {
//        [arr1 addObject:[theKey substringWithRange:NSMakeRange(i, 1)]];
//    }
//    
//    for (int i = 0; i < arr1.count; ++i) {
//        sscanf([[arr1 objectAtIndex:i] UTF8String], "%s", &keyCode);
//        key[i] = keyCode;
//    }
    
    
    
    
//    char pData[512];
//    unsigned char pDataCode;
//
//    NSMutableArray *arr2 = [NSMutableArray array];
//    for (NSInteger i = 0; i < str.length; i++) {
//       [arr2 addObject:[str substringWithRange:NSMakeRange(i, 1)]];
//    }
//    
//    for (int i = 0; i < arr2.count ; ++i) {
//        sscanf([[arr2 objectAtIndex:i] UTF8String], "%s", &pDataCode);
//        pData[i] = pDataCode;
//    }
    
    
    
    unsigned long len = strlen(pData);
    int i;
    



    
    rc4_init(s, (unsigned char*)key, strlen(key));//已经完成了初始化
    //    printf("完成对S[i]的初始化，如下：\n\n");
    for (i = 0; i<256; i++)
    {
        //        printf("%02X", s[i]);
        if (i && (i + 1) % 16 == 0){
            
        }
        //            putchar('\n');
    }
    //    printf("\n\n");
    for (i = 0; i<256; i++)//用s2[i]暂时保留经过初始化的s[i]，很重要的！！！
    {
        s2[i] = s[i];
    }
    //    printf("已经初始化，现在加密:\n\n");
    rc4_crypt(s, (unsigned char*)pData, len);//加密
    
    NSData *data = [GTMBase64 encodeBytes:pData length:len];
    NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
    NSLog(@"加密后:\n\n\n:%@", result);
    

//    //rc4_init(s,(unsignedchar*)key,strlen(key));//初始化密钥
//    rc4_crypt(s2, (unsigned char*)pData, len);//解密
//    printf("解密后pData=%s", pData);
    
    
    
    return [RC4_Basic encodeToPercentEscapeString:result];
}


+ (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    // Encode all the reserved characters, per RFC 3986
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)input,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
    return outputStr;
}

+ (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


@end
