//
//  NetworkRequest_Obj.h
//  CNTJJY
//
//  Created by totrade on 16/1/14.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id responseObject);
typedef void(^FailureBlock)(NSError *error);

@interface NetworkRequest_Obj : NSObject

//某几个商品的即时数据
//someSymbolsInstantData
+ (void)someSymbolsInstantDataWithUrl:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//某个商品即时数据
//singleSymbolInstantData
+ (void)singleSymbolInstantDataWithUrl:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//某个交易所所有商品即时数据
//singleExchangeAllSymbolsInstantData
+ (void)singleExchangeAllSymbolsInstantDataWithWithUrl:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//某个商品历史数据
//singleSymbolHistoryData
+ (void)singleSymbolHistoryDataWithUrl:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

+ (void)requestDataByTag:(NSNumber *)tag url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;



//用户信息调用接口
+ (void)userInfoCalledWithUrl:(NSString *)url postBody:(NSDictionary *)postBody successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

////用户登录密码验证接口
+ (void)userLoginPassWordCheckWithUrl:(NSString *)url postBody:(NSDictionary *)postBody successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
//用户登录状态查询接口
+ (void)userLoginStateQueryWithUrl:(NSString *)url postBody:(NSDictionary *)postBody successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
//用户浏览器自动登录接口
+ (void)userBrowserAutoLoginWithUrl:(NSString *)url postBody:(NSDictionary *)postBody successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
//用户站内信接口
+ (void)userLetterStationWithUrl:(NSString *)url postBody:(NSDictionary *)postBody successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//行情预警接口
+ (void)quotationWarningWithUrl:(NSString *)url postBody:(NSDictionary *)postBody successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//用户浏览器自动登录接口(get)
+ (void)userBrowserAutoLoginWithGetUrl:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//轮播图片接口
+ (void)discoverImageRequest:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

//自选搜索
+ (void)optionalSearchRequest:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

@end
