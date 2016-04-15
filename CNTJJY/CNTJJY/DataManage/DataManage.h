//
//  DataManage.h
//  CNTJJY
//
//  Created by totrade on 16/1/14.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import <Foundation/Foundation.h>




#warning 该类为一个单例,采用单例模式,已设置线程锁
typedef void(^Success)(id responseObject);
typedef void(^Failure)(NSError *error);
@interface DataManage : NSObject


+(DataManage *)shareInstance;

@property (nonatomic, assign)BOOL isGravity;

@property (nonatomic, strong)NSMutableArray *qlSymbols_Arr;//用于判断商品是否是齐鲁的

@property (nonatomic, strong)NSMutableDictionary *indsDic;//用于存储计算后的各种指标数据


//UserDefaults相关操作
//写入
+ (void)writeUserDefaultsObject:(id)object forKey:(NSString *)key;
//读取
+ (id)readUserDefaultsObjectforKey:(NSString *)key;
//移除
+ (void)removeUserDefaultsObjectForKey:(NSString *)key;

//数据库字段//商品:symbol//交易所:exchange

//某几个商品的即时数据//someSymbolsInstantData
+ (void)someSymbolsInstantDataWithInterface:(NSString *)interface count:(NSInteger)count codes:(NSArray *)symbolsCodes success:(Success)success failure:(Failure)failure;

//某个交易所所有商品即时数据//singleExchangeAllSymbolsInstantData
+ (void)singleExchangeAllSymbolsInstantDataWithInterface:(NSString *)interface code:(NSString *)exchCode success:(Success)success failure:(Failure)failure;

//某个商品即时数据//singleSymbolInstantData,建议使用someSymbolsInstantData接口
//+ (void)singleSymbolInstantDataWithInterface:(NSString *)interface code1:(NSString *)symbolcode code2:(NSString *)exchCode success:(Success)success failure:(Failure)failure;

//某个商品历史数据（k线数据）//singleSymbolHistoryData
+ (void)singleSymbolHistoryDataWithInterface:(NSString *)interface code:(NSString *)symbolcode kType:(NSString *)kType top:(NSString *)top start:(NSString *)start stop:(NSString *)stop success:(Success)success failure:(Failure)failure;

//用于行情和自选页面
+ (void)requestDataByTag:(NSNumber *)tag interface:(NSString *)interface exCode:(NSString *)exchCode syCodes:(NSArray *)symbolsCodes success:(Success)success failure:(Failure)failure;


//用户相关接口
//////用户信息调用接口
+ (void)userInfoCalledWithPostBody:(NSDictionary *)postBody success:(Success)success failure:(Failure)failure;
//用户登录密码验证接口
+ (void)userLoginPassWordCheckWithPostBody:(NSDictionary *)postBody success:(Success)success failure:(Failure)failure;
////用户登录状态查询接口
+ (void)userLoginStateQueryWithPostBody:(NSDictionary *)postBody success:(Success)success failure:(Failure)failure;
////用户站内信接口
+ (void)userLetterStationWithPostBody:(NSDictionary *)postBody success:(Success)success failure:(Failure)failure;
//行情预警接口
+ (void)quotationWarningWithPostBody:(NSDictionary *)postBody success:(Success)success failure:(Failure)failure;
////用户浏览器自动登录接口
+ (void)userBrowserAutoLoginWithPostBody:(NSDictionary *)postBody success:(Success)success failure:(Failure)failure;
//用户浏览器自动登录接口(get请求)
+ (void)userBrowserAutoLoginWithGetParameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;

+ (void)tempWithPostRequest:(NSString *)url PostBody:(NSDictionary *)postBody success:(Success)success failure:(Failure)failure;
+ (void)tempWithGetRequest:(NSString *)url success:(Success)success failure:(Failure)failure;

//轮播图片接口
+ (void)discoverImageRequest:(NSString *)url success:(Success)success failure:(Failure)failure;

+ (void)optionalSearchRequest:(NSString *)url success:(Success)success failure:(Failure)failure;

@end
