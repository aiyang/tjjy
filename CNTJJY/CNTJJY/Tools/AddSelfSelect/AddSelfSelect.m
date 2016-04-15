//
//  AddSelfSelect.m
//  CNTJJY
//
//  Created by totrade on 16/3/12.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "AddSelfSelect.h"

@implementation AddSelfSelect

- (instancetype)init
{
    self = [super init];
    if (self) {
//首次登录时默认自选五个
//现货白银（津贵），现货重油50T（齐鲁）OIL50，沥青50T（天矿）TPA50  ?，现货镍（津贵）NI  写死5个
#warning 默认自选品种：现货白银（津贵），现货重油50T（齐鲁），沥青50T（天矿），现货镍（津贵）!!!

        
        NSDictionary *theDic = [DataManage readUserDefaultsObjectforKey:@"addSelDic"];

        
        //判断程序是不是第一次走这个方法(该方法独立,不与appdelegate中的联用)
        if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstGetSelfSelect"]){
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstGetSelfSelect"];
//            if (theDic.count == 0) {
                NSDictionary *addSelDic = @{@"ql":@{@"OIL50":@"现货重油50T"},
                                            @"ht":@{@"XAGUSD":@"[T]现货白银", @"NI":@"[T]现货镍"}};
            [[NSUserDefaults standardUserDefaults]setObject:@"ql" forKey:@"OIL50"];
            [[NSUserDefaults standardUserDefaults]setObject:@"ht" forKey:@"XAGUSD"];
            [[NSUserDefaults standardUserDefaults]setObject:@"ht" forKey:@"NI"];
                _addSelDic = [NSMutableDictionary dictionaryWithDictionary:addSelDic];
                [DataManage writeUserDefaultsObject:addSelDic forKey:@"addSelDic"];
//            }else{
//                _addSelDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                              [NSMutableDictionary dictionaryWithDictionary:[theDic objectForKey:@"ql"]], @"ql",
//                              [NSMutableDictionary dictionaryWithDictionary:[theDic objectForKey:@"ht"]], @"ht", nil];
//            }
        }else{
            if (theDic.count == 0) {
                _addSelDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                              [NSMutableDictionary dictionary], @"ql",
                              [NSMutableDictionary dictionary], @"ht", nil];
            }else{
                _addSelDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                              [NSMutableDictionary dictionaryWithDictionary:[theDic objectForKey:@"ql"]], @"ql",
                              [NSMutableDictionary dictionaryWithDictionary:[theDic objectForKey:@"ht"]], @"ht", nil];
                
            }
        }
        
        ////        //判断程序是否首次运行(该方法与appdelegate中的联用)
        //        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        //            NSLog(@"第一次启动3");
        //
        //        }else{
        //
        //        }
        
    }
    return self;
}

- (void)setSelfSelectWith:(SingleExchangeAllSymbolsInstantData_DownObj *)single_DownObj interface:(NSString *)interface
{
    NSDictionary *dic1 = [DataManage readUserDefaultsObjectforKey:@"addSelDic"];
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 [NSMutableDictionary dictionaryWithDictionary:[dic1 objectForKey:@"ql"]], @"ql",
                                 [NSMutableDictionary dictionaryWithDictionary:[dic1 objectForKey:@"ht"]], @"ht", nil];
     NSString * type = [[NSUserDefaults standardUserDefaults]objectForKey:single_DownObj.code];
    NSArray *tempArr = [[dic2 objectForKey:type] allKeys];
    
    NSLog(@"%@-----,%@",tempArr,single_DownObj.code);
    
    if (![tempArr containsObject:single_DownObj.code]) {
        [[NSUserDefaults standardUserDefaults]setObject:interface forKey:single_DownObj.code];
        [[dic2 objectForKey:interface] setObject:single_DownObj.name forKey:single_DownObj.code];
        
    }else if ([tempArr containsObject:single_DownObj.code]){
       
        [[dic2 objectForKey:type] removeObjectForKey:single_DownObj.code];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:single_DownObj.code];
    }
    
    [DataManage writeUserDefaultsObject:dic2 forKey:@"addSelDic"];
}


@end
