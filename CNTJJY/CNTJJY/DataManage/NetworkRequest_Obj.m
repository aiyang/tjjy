//
//  NetworkRequest_Obj.m
//  CNTJJY
//
//  Created by totrade on 16/1/14.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "NetworkRequest_Obj.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"

@implementation NetworkRequest_Obj

//某几个商品的即时数据
//someSymbolsInstantData
+ (void)someSymbolsInstantDataWithUrl:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    NSString *uTF8url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:30];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //没有缓存,想办法在断网的时候可以显示缓存的内容
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [NSString stringWithFormat:@"%@/%d.aa", docPath, [uTF8url hash]];
    
    id result = [NSKeyedUnarchiver unarchiveObjectWithFile:path];

    
    [manager GET:uTF8url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        BOOL result = [NSKeyedArchiver archiveRootObject:responseObject toFile:path];
        successBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id result = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        successBlock(result);
        failureBlock(error);
        
    }];
    
}

//某个商品即时数据
//singleSymbolInstantData
+ (void)singleSymbolInstantDataWithUrl:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    NSString *uTF8url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:30];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //没有缓存,想办法在断网的时候可以显示缓存的内容
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [NSString stringWithFormat:@"%@/%d.aa", docPath, [uTF8url hash]];
    
    id result = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (result != nil) {
        successBlock(result);
    }
    
    [manager GET:uTF8url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
    BOOL result = [NSKeyedArchiver archiveRootObject:responseObject toFile:path];
        
        successBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id result = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        successBlock(result);
        
        failureBlock(error);
        
    }];
}

//某个交易所所有商品即时数据
//singleExchangeAllSymbolsInstantData
+ (void)singleExchangeAllSymbolsInstantDataWithWithUrl:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    NSString *uTF8url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:30];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //没有缓存,想办法在断网的时候可以显示缓存的内容
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [NSString stringWithFormat:@"%@/%d.aa", docPath, [uTF8url hash]];
    id result = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    if (result != nil) {
        successBlock(result);
    }
    
    [manager GET:uTF8url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        BOOL result = [NSKeyedArchiver archiveRootObject:responseObject toFile:path];
        successBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id result = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        successBlock(result);
        failureBlock(error);
        
    }];
}

//某个商品历史数据
//singleSymbolHistoryData
+ (void)singleSymbolHistoryDataWithUrl:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    NSString *uTF8url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:30];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //没有缓存,想办法在断网的时候可以显示缓存的内容
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [NSString stringWithFormat:@"%@/%d.aa", docPath, [uTF8url hash]];
    id result = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (result != nil) {
        successBlock(result);
    }
    
    
    [manager GET:uTF8url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        BOOL result = [NSKeyedArchiver archiveRootObject:responseObject toFile:path];
        successBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        id result = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        successBlock(result);
        failureBlock(error);
        
    }];
}


//用于首页行情网络请求
+ (void)requestDataByTag:(NSNumber *)tag url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
{
    NSString *uTF8url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:30];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //没有缓存,想办法在断网的时候可以显示缓存的内容
    //获取路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //拼接路径
    NSString *path = [NSString stringWithFormat:@"%@/%d.aa", docPath, [uTF8url hash]];
    id result = [NSKeyedUnarchiver unarchiveObjectWithFile:path];//存入数据
    
    
    if (result != nil) {
        successBlock(@{tag:result, @"isCache":@"YES"});
    }
    
    NSLog(@"uTF8url=%@",uTF8url);
    
    [manager GET:uTF8url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        BOOL result = [NSKeyedArchiver archiveRootObject:responseObject toFile:path];//存储并返回存储结果
        successBlock(@{tag:responseObject, @"isCache":@"NO"});
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        if (result != nil) {
        successBlock(@{tag:result, @"isCache":@"YES"});//请求失败,则取缓存数据
        }
        failureBlock(error);
        
    }];
}



//用户登录密码验证接口
+ (void)userLoginPassWordCheckWithUrl:(NSString *)url postBody:(NSDictionary *)postBody successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    NSString *uTF8url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:30];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:uTF8url parameters:postBody success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//用户登录状态查询接口
+ (void)userLoginStateQueryWithUrl:(NSString *)url postBody:(NSDictionary *)postBody successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    NSString *uTF8url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:30];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:uTF8url parameters:postBody success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//
//用户浏览器自动登录接口
+ (void)userBrowserAutoLoginWithUrl:(NSString *)url postBody:(NSDictionary *)postBody successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    NSString *uTF8url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:30];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:uTF8url parameters:postBody success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}


//用户浏览器自动登录接口(get)
+ (void)userBrowserAutoLoginWithGetUrl:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
#warning 难道我之前用的不是stringByAddingPercentEscapesUsingEncoding???
    NSString *uTF8url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"uTF8url:%@", uTF8url);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:30];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:uTF8url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

//用户信息调用接口
+ (void)userInfoCalledWithUrl:(NSString *)url postBody:(NSDictionary *)postBody successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    NSString *uTF8url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:30];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:uTF8url parameters:postBody success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
//用户站内信接口
+ (void)userLetterStationWithUrl:(NSString *)url postBody:(NSDictionary *)postBody successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    NSString *uTF8url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:30];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:uTF8url parameters:postBody success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

//行情预警接口
+ (void)quotationWarningWithUrl:(NSString *)url postBody:(NSDictionary *)postBody successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    NSString *uTF8url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:30];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:uTF8url parameters:postBody success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

+ (void)discoverImageRequest:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    
    NSString *uTF8url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:30];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer =  [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:uTF8url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        failureBlock(error);
    }];

}

// 自选搜索
+ (void)optionalSearchRequest:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    //   NSString *uTF8url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //  NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //   NSString *path = [NSString stringWithFormat:@"%@/%d.aa", docPath, [uTF8url hash]];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSMutableString *result = [[NSMutableString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        [result replaceOccurrencesOfString:@"\\" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [result length])];
        
        result = [(NSString *)result substringFromIndex:1];//截取掉下标1之后的字符串
        
        result = [(NSString *)result substringToIndex:result.length-1];//截取掉下标1之后的字符串
        
        
        NSString *jsonstring =result;
        
        NSData *data=[jsonstring dataUsingEncoding:NSUTF8StringEncoding];
        
        NSArray * array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
       
            
        successBlock(array);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        //NSLog(@"=====%@  ---- %@",error,operation);
        failureBlock(error);
        
    }];

    
}

@end
