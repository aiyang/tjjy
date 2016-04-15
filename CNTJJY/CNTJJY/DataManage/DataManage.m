//
//  DataManage.m
//  CNTJJY
//
//  Created by totrade on 16/1/14.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "DataManage.h"

//网络请求类
#import "NetworkRequest_Obj.h"
//某几个商品的即时数据基本数据类
#import "SomeSymbolsInstantData_DownObj.h"
//某个商品即时数据基本数据类
#import "SingleSymbolInstantData_DownObj.h"
//某个交易所所有商品即时数据基本数据类
#import "SingleExchangeAllSymbolsInstantData_DownObj.h"
//某个商品历史数据（k线数据)基本数据类
#import "SingleSymbolHistoryData_DownObj.h"

//SBJson解析类
#import "SBJsonParser.h"

//加密解密类
#import "CipherManage.h"

@implementation DataManage

+(DataManage *)shareInstance
{
    static DataManage *dataManage;
    @synchronized(self) {//线程锁
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            dataManage = [[super allocWithZone:NULL] init];

#warning 初始化单例的属性,这样是否可行呢???
            dataManage.qlSymbols_Arr = [NSMutableArray array];
            dataManage.indsDic = [NSMutableDictionary dictionary];
            dataManage.isGravity = YES;

        });
    }
    return dataManage;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self) {
        return [self shareInstance];
    }
    return nil;
}

- (id)copyWithZone:(NSZone*)zone
{
    return self;
}









//某几个商品的即时数据
//someSymbolsInstantData
+ (void)someSymbolsInstantDataWithInterface:(NSString *)interface count:(NSInteger)count codes:(NSArray *)symbolsCodes success:(Success)success failure:(Failure)failure;
{
    NSArray *urlArr = [SomeSymbolsInstantData_DownObj getUrlArrWithInterface:interface count:count codes:symbolsCodes];
    for (NSInteger i = 0; i < urlArr.count; i++) {
        NSString *str = [urlArr objectAtIndex:i];
        
        [NetworkRequest_Obj someSymbolsInstantDataWithUrl:str successBlock:^(id responseObject) {
            
            
            NSArray *arr = [SomeSymbolsInstantData_DownObj modelArrWithDics:responseObject];
            
            success(arr);
            
        } failureBlock:^(NSError *error) {
            NSLog(@"%@", error);
        }];
    }

}

//某个交易所所有商品即时数据
//singleExchangeAllSymbolsInstantData
+ (void)singleExchangeAllSymbolsInstantDataWithInterface:(NSString *)interface code:(NSString *)exchCode success:(Success)success failure:(Failure)failure{
    
    
    
    NSString *url = [SingleExchangeAllSymbolsInstantData_DownObj getUrlWithInterface:interface code:exchCode];
    
    
    [NetworkRequest_Obj singleExchangeAllSymbolsInstantDataWithWithUrl:url successBlock:^(id responseObject) {
        //        NSLog(@"%@", responseObject);
        NSArray *arr = [SingleExchangeAllSymbolsInstantData_DownObj modelArrWithDics:responseObject];
        success(arr);
    } failureBlock:^(NSError *error) {
        failure(error);
    }];
    
}




//某个商品历史数据
//singleSymbolHistoryData
+ (void)singleSymbolHistoryDataWithInterface:(NSString *)interface code:(NSString *)symbolcode kType:(NSString *)kType top:(NSString *)top start:(NSString *)start stop:(NSString *)stop success:(Success)success failure:(Failure)failure
{
    NSString *url = [NSString string];
    if (start.length != 0) {
        url = [SingleSymbolHistoryData_DownObj getUrlInterface:interface code:symbolcode kType:kType start:start stop:stop];
        
       // NSLog(@"%@", url);
        
    }else if (start.length == 0){
        url = [SingleSymbolHistoryData_DownObj getUrlInterface:interface code:symbolcode kType:kType top:top];
    }
    [NetworkRequest_Obj singleSymbolHistoryDataWithUrl:url successBlock:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *arr = [SingleSymbolHistoryData_DownObj modelArrWithDics:responseObject];
            success(arr);
        }else{
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

//用于行情和自选页面
+ (void)requestDataByTag:(NSNumber *)tag interface:(NSString *)interface exCode:(NSString *)exchCode syCodes:(NSArray *)symbolsCodes success:(Success)success failure:(Failure)failure;
{
    if (symbolsCodes != nil) {//自选商品
        
        NSArray *urlArr = [SomeSymbolsInstantData_DownObj getUrlArrWithInterface:interface count:symbolsCodes.count codes:symbolsCodes];
        for (NSInteger i = 0; i < urlArr.count; i++) {
            NSString *subUrl = [urlArr objectAtIndex:i];
            
            [NetworkRequest_Obj requestDataByTag:tag url:subUrl successBlock:^(id responseObject) {
                
                
                NSNumber *key = nil;
                for (id subKey  in [responseObject allKeys]) {
                    if ([subKey isKindOfClass:[NSNumber class]]) {
                        key = subKey;
                    }
                }
                NSArray *arr = [SomeSymbolsInstantData_DownObj modelArrWithDics:[responseObject objectForKey:key]];
                
                success(@{key:arr, @"isCache":[responseObject objectForKey:@"isCache"]});
                
            } failureBlock:^(NSError *error) {
                
            }];
            
        }
    }else if(exchCode != nil){//某个交易所商品
        NSString *url = [SingleExchangeAllSymbolsInstantData_DownObj getUrlWithInterface:interface code:exchCode];
        
        
        [NetworkRequest_Obj requestDataByTag:tag url:url successBlock:^(id responseObject) {
         
//            NSLog(@"某个交易所商品:%@", url);
            
//        NSNumber *key = @([[[responseObject allKeys] objectAtIndex:0] integerValue]);
            NSNumber *key = nil;
            for (id subKey  in [responseObject allKeys]) {
                if ([subKey isKindOfClass:[NSNumber class]]) {
                    key = subKey;
                }
            }
            
        NSArray *arr = [SingleExchangeAllSymbolsInstantData_DownObj modelArrWithDics:[responseObject objectForKey:key]];

            
        success(@{key:arr});
            
        } failureBlock:^(NSError *error) {
            
        }];

    }
}



//不建议使用的接口
//某个商品即时数据
//singleSymbolInstantData
//+ (void)singleSymbolInstantDataWithInterface:(NSString *)interface code1:(NSString *)symbolcode code2:(NSString *)exchCode
//{
//    NSString *url = [SingleSymbolInstantData_DownObj getUrlInterface:interface code1:symbolcode code2:exchCode];
//    
//    [NetworkRequest_Obj someSymbolsInstantDataWithUrl:url successBlock:^(id responseObject) {
//        NSLog(@"%@", responseObject);
//    } failureBlock:^(NSError *error) {
//        NSLog(@"%@", error);
//    }];
//}










//UserDefaults相关操作
+ (void)writeUserDefaultsObject:(id)object forKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];//是一个单例
    //存入数据
    [userDefaults setObject:object forKey:key];
    [userDefaults synchronize];  //同步,存入磁盘中
}

+ (id)readUserDefaultsObjectforKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];//是一个单例
    id object = [userDefaults objectForKey:key];//[userInfo objectForKey:@"userId"]
    if (object == nil) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        return dic;
    }else{
        return object;
    }
   
}

+ (void)removeUserDefaultsObjectForKey:(NSString *)key
{
    //获取单例
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];//是一个单例
    //删除数据
    [userDefaults removeObjectForKey:key];
    [userDefaults synchronize];  //同步,存入磁盘中
}












//用户相关接口
//用户登录密码验证接口
+ (void)userLoginPassWordCheckWithPostBody:(NSDictionary *)postBody success:(Success)success failure:(Failure)failure
{
     NSString *url = userLoginPassWordCheck;
    
    [NetworkRequest_Obj userLoginPassWordCheckWithUrl:url postBody:postBody successBlock:^(id responseObject) {
        success(responseObject);
    } failureBlock:^(NSError *error) {
        failure(error);
    }];
}


////用户登录状态查询接口
+ (void)userLoginStateQueryWithPostBody:(NSDictionary *)postBody success:(Success)success failure:(Failure)failure
{
     NSString *url = userLoginStateQuery;
    [NetworkRequest_Obj userLoginStateQueryWithUrl:url postBody:postBody successBlock:^(id responseObject) {
        success(responseObject);
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}


////用户信息调用接口
+ (void)userInfoCalledWithPostBody:(NSDictionary *)postBody success:(Success)success failure:(Failure)failure
{
     NSString *url = userInfoCalled;
    
    [NetworkRequest_Obj userInfoCalledWithUrl:url postBody:postBody successBlock:^(id responseObject) {
        success(responseObject);
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];


}
////用户站内信接口
+ (void)userLetterStationWithPostBody:(NSDictionary *)postBody success:(Success)success failure:(Failure)failure
{
    NSString *url = userLetterStation;
    

    [NetworkRequest_Obj userLetterStationWithUrl:url postBody:postBody successBlock:^(id responseObject) {
        success(responseObject);
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);
        
        
    }];
}

//行情预警接口
+ (void)quotationWarningWithPostBody:(NSDictionary *)postBody success:(Success)success failure:(Failure)failure
{
    NSString *url = quotationWarning;
    [NetworkRequest_Obj quotationWarningWithUrl:url postBody:postBody successBlock:^(id responseObject) {
        success(responseObject);
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

////用户浏览器自动登录接口
+ (void)userBrowserAutoLoginWithPostBody:(NSDictionary *)postBody success:(Success)success failure:(Failure)failure
{
    NSString *url = userBrowserAutoLogin;
    [NetworkRequest_Obj userBrowserAutoLoginWithUrl:url postBody:postBody successBlock:^(id responseObject) {
        success(responseObject);
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}


//用户浏览器自动登录接口(get请求)
+ (void)userBrowserAutoLoginWithGetParameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure
{
    NSString *url = userBrowserAutoLogin;
    
//    &loginname=%E4%B8%8A%E6%B5%B7%E6%B5%8B%E8%AF%955
//    &password=670b14728ad9902aecba32e22fa4f6bd
//    &backurl=http%3A%2F%2Fwww.cntjjy.com%2Findex.html
//    &keepingLogin=checked
    
    NSString *getString = [CipherManage requestDicToGetParametersWithDic:parameters paswd:@"password"];
    
    NSString *newUrl = [NSString stringWithFormat:@"%@%@", url, getString];
    

    
    [NetworkRequest_Obj userBrowserAutoLoginWithGetUrl:newUrl successBlock:^(id responseObject) {
        success(responseObject);
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

//临时使用
+ (void)tempWithPostRequest:(NSString *)url PostBody:(NSDictionary *)postBody success:(Success)success failure:(Failure)failure
{
    [NetworkRequest_Obj userBrowserAutoLoginWithUrl:url postBody:postBody successBlock:^(id responseObject) {
        success(responseObject);
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

//临时使用
+ (void)tempWithGetRequest:(NSString *)url success:(Success)success failure:(Failure)failure
{
    [NetworkRequest_Obj userBrowserAutoLoginWithGetUrl:url successBlock:^(id responseObject) {
        success(responseObject);
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}


+ (void)discoverImageRequest:(NSString *)url success:(Success)success failure:(Failure)failure{
    
    [NetworkRequest_Obj discoverImageRequest:url successBlock:^(id responseObject) {
        success(responseObject);
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);
        failure(error);
    }];
    
}


+ (void)optionalSearchRequest:(NSString *)url success:(Success)success failure:(Failure)failure{
    [NetworkRequest_Obj optionalSearchRequest:url successBlock:^(id responseObject) {
        success(responseObject) ;
    } failureBlock:^(NSError *error) {
        failure(error);
    }] ;
}

@end
