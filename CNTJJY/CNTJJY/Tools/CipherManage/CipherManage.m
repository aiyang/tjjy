//
//  CipherManage.m
//  TestDes
//
//  Created by totrade on 16/2/17.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "CipherManage.h"

#import <CommonCrypto/CommonCrypto.h>
#import "Base64.h"
#import "GTMBase64.h"

@implementation CipherManage

+ (NSString *)getMd5_32Bit:(NSString *)string{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, string.length, digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}

+(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key
{
    NSString *plaintext = nil;
    
    NSInteger textLenght = cipherText.length;
    
//    NSData *cipherdata = [Base64 decode:cipherText];
     NSData *cipherdata = [GTMBase64 decodeString:cipherText];
    
//    const Byte iv[] = {1,2,3,4,5,6,7,8};
    
    unsigned char buffer[textLenght];//原来为1024后来改为3072,由于有时数据量太大
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,//| kCCOptionECBMode
                                          [key UTF8String], kCCKeySizeDES,
                                          (Byte *)[[key dataUsingEncoding:NSUTF8StringEncoding] bytes],
                                          [cipherdata bytes], [cipherdata length],
                                          buffer, textLenght,//原来为1024后来改为3072,由于有时数据量太大
                                          &numBytesDecrypted);
    if(cryptStatus == kCCSuccess) {
        NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
    }
    return plaintext;
}


+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key
{
    
    //    const Byte iv[] = {1,2,3,4,5,6,7,8};
    NSString *ciphertext = nil;
    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[3072];//原来为1024后来改为3072,由于有时数据量太大
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding, //| kCCOptionECBMode
                                          [key UTF8String], kCCKeySizeDES,
                                          (Byte *)[[key dataUsingEncoding:NSUTF8StringEncoding] bytes],
                                          [textData bytes], dataLength,
                                          buffer, 3072,//原来为1024后来改为3072,由于有时数据量太大
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [GTMBase64 encodeBase64Data:data];
    }
    //
    NSMutableString *resultStr = [NSMutableString stringWithString:ciphertext];
    if (resultStr.length > 77) {
        [resultStr insertString:@"\n" atIndex:76];
    }
    NSString *returnStr = [NSString stringWithFormat:@"%@\n", resultStr];
    return returnStr;
}

//url编码
+ (NSString *)urlEncodeToPercentEscapeString:(NSString *) input
{
    // Encode all the reserved characters, per RFC 3986
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    
      CFStringRef forceEscaped = CFSTR("!*'();:@&=+$,/?%#[]");
    
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)input,
                                                              CFSTR(" "),
                                                             forceEscaped,// (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",//@"!$&'()*+,-./:;=?@_~%#[]"//CFSTR("!*'();:@&=+$,/?%#[]"
                                                              kCFStringEncodingUTF8));
    return outputStr;

}

//url解码
+ (NSString *)urlDecodeFromPercentEscapeString:(NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];

#warning 目前把uer解码中的@"+"转为@" "注释掉了,依然不影响
//    [outputStr replaceOccurrencesOfString:@"+"
//                               withString:@" "
//                                  options:NSLiteralSearch
//                                    range:NSMakeRange(0, [outputStr length])];
    
    return [input stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}



+ (NSDictionary *)responseDataToDictionaryWithData:(NSData *)data
{
    
    //data转字符串
    NSString *str1 = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];


    //字符串url解码
    NSString *str2 = [CipherManage urlDecodeFromPercentEscapeString:str1];
    
    //des解密
    NSString *str3 = [CipherManage decryptUseDES:str2 key:@"X8Ssw93l"];
    
    
    
    
    NSArray *array = [str3 componentsSeparatedByString:@"&"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    for (NSString *subStr in array) {
        NSArray *subArray = [subStr componentsSeparatedByString:@"="];
   
        if (subArray.count == 2) {
            [dic setObject:subArray[1] forKey:subArray[0]];
        }else{
            [dic setObject:subArray[0] forKey:@"result"];//没有&和=不代表是错的,有可能返回值就是一个纯数字或纯字符串
        }
        
    }
    return dic;//返回为空说明array为空,则解码出现问题
}

+ (NSDictionary *)requestDicToPostBodyWithDic:(NSDictionary *)dic paswd:(NSString *)paswd
{
    
    NSArray *keysArray = [dic allKeys];
    
    NSString *passWord_MD5 = [CipherManage getMd5_32Bit:[dic objectForKey:@"paswd"]];
    
    NSString *string = [NSString stringWithFormat:@"paswd=%@", passWord_MD5];
    for (NSInteger i = 0; i < keysArray.count; i++) {
        if (![keysArray[i] isEqualToString:@"paswd"]) {
            string = [NSString stringWithFormat:@"%@&%@=%@", string, keysArray[i], [dic objectForKey:keysArray[i]]];
        }
    }
    
    NSString *enString = [CipherManage encryptUseDES:string key:@"X8Ssw93l"];
    
//    由于AFNetWorking使用AFHTTPRequestSerializer已经将url转码,故url转码不需要
//    NSString *urlEnCodeStr = [CipherManage urlEncodeToPercentEscapeString:enString];
    
    NSDictionary *dictionary = @{@"code":enString};
    return dictionary;
}

+ (NSDictionary *)requestDicToPostBodyWithDic:(NSDictionary *)dic
{
    NSArray *keysArray = [dic allKeys];
    NSString *string = [NSString stringWithFormat:@"%@=%@", keysArray[0], [dic objectForKey:keysArray[0]]];
    
    for (NSInteger i = 1; i < keysArray.count; i++) {
        string = [NSString stringWithFormat:@"%@&%@=%@", string, keysArray[i], [dic objectForKey:keysArray[i]]];
    }
    
    NSLog(@"%@", string);
    
    NSString *enString = [CipherManage encryptUseDES:string key:@"X8Ssw93l"];
    
//    由于AFNetWorking使用AFHTTPRequestSerializer已经将url转码,故url转码不需要
//    NSString *urlEnCodeStr = [CipherManage urlEncodeToPercentEscapeString:enString];
    
    NSDictionary *dictionary = @{@"code":enString};

    return dictionary;
}

+ (NSString *)requestDicToGetParametersWithDic:(NSDictionary *)dic paswd:(NSString *)paswd
{
    //    &loginname=%E4%B8%8A%E6%B5%B7%E6%B5%8B%E8%AF%955
    //    &password=670b14728ad9902aecba32e22fa4f6bd
    //    &backurl=http%3A%2F%2Fwww.cntjjy.com%2Findex.html
    //    &keepingLogin=checked
    NSArray *keysArray = [dic allKeys];
    
    NSString *passWord_MD5 = [CipherManage getMd5_32Bit:[dic objectForKey:@"password"]];
    NSString *string = [NSString stringWithFormat:@"&password=%@", passWord_MD5];
    for (NSInteger i = 0; i < keysArray.count; i++) {
        if (![keysArray[i] isEqualToString:@"password"]) {
            string = [NSString stringWithFormat:@"%@&%@=%@", string, keysArray[i], [dic objectForKey:keysArray[i]]];
        }
    }
    
//    NSString *urlEnCodeStr = [CipherManage urlEncodeToPercentEscapeString:string];
    
    return string;
}



@end
