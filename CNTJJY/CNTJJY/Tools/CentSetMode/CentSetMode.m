//
//  CentSetMode.m
//  CNTJJY
//
//  Created by totrade on 16/3/9.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "CentSetMode.h"
#import "NightMode.h"
#import "JPUSHService.h"

@interface CentSetMode ()

@property (nonatomic, strong)NightMode *nightMode;

@property (nonatomic, strong)NSMutableDictionary *userInfoDic;
@property (nonatomic, strong)NSMutableDictionary *centSetDic;

@end

@implementation CentSetMode

@synthesize refreshSeconds = _refreshSeconds;
@synthesize isPush = _isPush;
@synthesize isNightMode = _isNightMode;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _nightMode = [[NightMode alloc] init];
        _userInfoDic = [DataManage readUserDefaultsObjectforKey:@"userInfo"];
        _centSetDic = [NSMutableDictionary dictionaryWithDictionary:[DataManage readUserDefaultsObjectforKey:@"centSet"]];
       //[self cacheSize];
        
    }
    return self;
}

- (void)setRefreshSeconds:(NSString *)refreshSeconds
{
    [_centSetDic setObject:refreshSeconds forKey:@"refreshSeconds"];
    [DataManage writeUserDefaultsObject:_centSetDic forKey:@"centSet"];//保存设置到本地
    _refreshSeconds = refreshSeconds;
}

- (NSString *)refreshSeconds
{
    NSString *string = [_centSetDic objectForKey:@"refreshSeconds"];
    if (string.length == 0) {
        string = @"5秒";
    }
    return string;
}

- (void)setIsPush:(BOOL)isPush
{
    [_centSetDic setObject:@(isPush) forKey:@"isPush"];
    [DataManage writeUserDefaultsObject:_centSetDic forKey:@"centSet"];//保存设置到本地
    
    if (_userInfoDic.count != 0) {
        if (isPush) {
            NSSet *set = [NSSet setWithObjects:[_userInfoDic objectForKey:@"roleid"], nil];
            [JPUSHService setTags:set alias:[_userInfoDic objectForKey:@"userid"] fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
            }];
        }else{
            //关闭推送
            NSSet *set = [[NSSet alloc] init];
            [JPUSHService setTags:set alias:@"" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
            }];
        }
    }
    
    _isPush = isPush;
}

- (BOOL)isPush
{
    BOOL tempIsPush;
    if (_userInfoDic.count == 0) {//未登陆情况下,推送默认关闭
        tempIsPush = NO;
    }else{//登陆情况下
        if (_centSetDic.count == 0) {//默认开启,即用户未设置过
            tempIsPush = YES;
        }else{//用户设置过的情况下,跟随用户的设置
            tempIsPush = [[_centSetDic objectForKey:@"isPush"] boolValue];
        }
    }
    
    return tempIsPush;
}



- (void)setIsNightMode:(BOOL)isNightMode
{
    NSNumber *nightMode = [NSNumber numberWithBool:isNightMode];
    [DataManage writeUserDefaultsObject:nightMode forKey:@"nightMode"];
    
    _isNightMode = isNightMode;
}

- (BOOL)isNightMode
{
    return _nightMode.isNightMode;
}


- (void)recover//恢复默认
{
    [DataManage removeUserDefaultsObjectForKey:@"centSet"];
    [DataManage removeUserDefaultsObjectForKey:@"nightMode"];
}
- (void)clean//清除缓存
{
    //用户缓存主要存在两个地方,一个是UserDefaults,一个是沙盒主要使用了Documents

//    UserDefaults中存的数据如下:
//    addSel_Dic//记录用户自选
//    centSet //个人中心设置
//    indsDic //指标参数设置
//    userInfo  //用户登录信息
//    codeToMarkCode //记录商品和交易所之间的一一对应关系
//    nightMode  //记录用户选择的日夜模式
    
//    [DataManage removeUserDefaultsObjectForKey:@"addSel_Dic"];//将弃用
//    [DataManage removeUserDefaultsObjectForKey:@"centSet"];
//    [DataManage removeUserDefaultsObjectForKey:@"indsDic"];
//    [DataManage removeUserDefaultsObjectForKey:@"userInfo"];//暂时不清除
//    [DataManage removeUserDefaultsObjectForKey:@"codeToMarkCode"];//暂时不清除
//    [DataManage removeUserDefaultsObjectForKey:@"nightMode"];
    
//    [DataManage removeUserDefaultsObjectForKey:@"addSelDic"];//暂时不清除
    
    

//通过遍历全清
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSDictionary *dic = [userDefaults dictionaryRepresentation];
//    for (id  key in dic) {
////        [userDefaults removeObjectForKey:key];
//        NSLog(@"%@", key);
//    }
//    [userDefaults synchronize];
    
    //清除沙盒文件
//    [DataManage ]
    [self clearFile];
 
}

//清除沙盒的Documents文件夹中的缓存
- ( void )clearFile
{
    
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask , YES ) firstObject ];
    
    NSLog(@"%@", cachPath);
    
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    NSLog(@"%@", files);
    for ( NSString * p in files) {
        NSError * error = nil ;
        NSString * path = [cachPath stringByAppendingPathComponent:p];
        NSLog(@"%@", path);
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
        }
    }
    
}

+(CGFloat)cacheSize{
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask , YES ) firstObject ];
     NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    NSInteger cacheSiz = 0 ;
    for ( NSString * p in files) {
        NSError * error = nil ;
        NSString * path = [cachPath stringByAppendingPathComponent:p];
        NSLog(@"%@", path);
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            NSInteger filesize = 0 ;
           filesize = [[[ NSFileManager defaultManager ] attributesOfItemAtPath:path error:&error] fileSize];
            cacheSiz = cacheSiz+filesize ;
        }
    }

    NSLog(@"%ld  ------- %f",cacheSiz ,cacheSiz/(1000.0*1000.0)) ;
    
    return cacheSiz/1000.0 ;
}




@end
