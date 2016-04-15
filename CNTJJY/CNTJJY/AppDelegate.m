//
//  AppDelegate.m
//  CNTJJY
//
//  Created by totrade on 16/1/12.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "AppDelegate.h"
#import "JPUSHService.h"



#import "QuotViewController.h"
#import "SingleExchangeAllSymbolsInstantData_DownObj.h"
#import "SvUDIDTools.h"
#import "CipherManage.h"

#import "CustomNavigationController.h"
#import "DetailViewController.h"//进行点对点跳转
#import "LeftViewController.h"


static NSString *appKey = @"aaaa3296bffa6c0c260f75e6";
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;

@interface AppDelegate ()<UIAlertViewDelegate>

@property (nonatomic, strong)UIAlertView *alertView;
@property (nonatomic, strong)NSString *mCode;
@property (nonatomic, strong)NSString *pCode;
@property (nonatomic, assign)NSInteger type;



@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //修改电池栏颜色
//    View controller-based status bar appearance = NO//info.plist 里面 添加
//    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];//    然后加上
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];

    
    //由于齐鲁数据的特殊性,所以之后用作判断
    [self setPForDWithInterface:QL_WANGGUAN code:@"QILUCE"];
    return YES;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
//    //修改app的webView网页的默认User-Agent//一句话就可以了
//    //        UIWebView* tempWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
//    [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent" : @"nihao", @"User-Agent" : @"nihao"}];

    self.tabBar = [[TabBarController alloc] init];
    
    
    LeftViewController *leftViewController=[[LeftViewController alloc]init];
    leftViewController.view.backgroundColor=[UIColor colorFromHexCode:@"#242424"];
    
    _sideViewController=[[YRSideViewController alloc]initWithNibName:nil bundle:nil];
    _sideViewController.rootViewController=self.tabBar;
    _sideViewController.leftViewController=leftViewController;
    _sideViewController.leftViewShowWidth=0;
    _sideViewController.needSwipeShowMenu=false;//默认开启的可滑动展示
    //动画效果可以被自己自定义，具体请看api
    self.window.rootViewController=_sideViewController;
//    self.window.rootViewController = _tabBar;
    
    [self.window makeKeyAndVisible];
    
    //判断用户是否首次运行app(第一个步骤)
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }
    
    
    
    
    // Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    // Required
    //如需兼容旧版本的方式，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化和同时使用pushConfig.plist文件声明appKey等配置内容。
    [JPUSHService setupWithOption:launchOptions appKey:appKey channel:channel apsForProduction:isProduction];
    
    //注册
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidLoginNotification object:nil];

    


 
    return YES;
}

- (void)setPForDWithInterface:(NSString *)interface code:(NSString *)code
{
    DataManage *dataManage = [DataManage shareInstance];
    [DataManage singleExchangeAllSymbolsInstantDataWithInterface:interface code:code success:^(id responseObject) {
       
//        NSLog(@"怎么没有呢%@", responseObject);
        for (SingleExchangeAllSymbolsInstantData_DownObj *single_DownObj in responseObject) {
            
            [dataManage.qlSymbols_Arr addObject:single_DownObj.code];
        }

    } failure:^(NSError *error) {
        
    }];
    
}


//通知方法
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    //调用接口
//    DLog(@"\n\n极光推送注册成功\n\n");
    
    //通知后台registrationID
    //获取registrationID
    NSLog(@"registrationID:%@",[JPUSHService registrationID]);
    
    [self judgeAppFirstLaunch];
  
    //注销通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kJPFNetworkDidLoginNotification object:nil];
}



- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken:%@", deviceToken);

 

    
//    //读取用于信息
    NSDictionary *userInfoDic = [DataManage readUserDefaultsObjectforKey:@"userInfo"];
    if (userInfoDic.count != 0) {
        NSSet *set = [NSSet setWithObjects:[userInfoDic objectForKey:@"roleid"], nil];
        NSLog(@"%@", set);
        
        [JPUSHService setTags:set alias:[userInfoDic objectForKey:@"userid"] fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
            NSLog(@"iResCode:%d---iTags:%@---iAlias:%@", iResCode, iTags, iAlias);
            
        }];
    }
    
    // Required
    [JPUSHService registerDeviceToken:deviceToken];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"\n------接收推送通知------:\n%@\n", userInfo);
//    ------接收推送通知------:
//    {
//        "_j_msgid" = 3227397197;
//        aps =     {
//            alert = nihao;
//            badge = 1;
//            sound = default;
//        };
//        mCode = 111;
//        pCode = 222;
//        type = 2;
//    }
    
    
    NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    _mCode = [userInfo objectForKey:@"mCode"];
    _pCode = [userInfo objectForKey:@"pCode"];
    _type = [[userInfo objectForKey:@"type"] integerValue];
    switch (_type) {
        case 0:{//广播
            _alertView = [[UIAlertView alloc] initWithTitle:@"广播提示"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
        }
            break;
        case 1:{//群组
             _alertView = [[UIAlertView alloc] initWithTitle:@"群组提示"
                                                     message:message
                                                    delegate:self
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:nil, nil];
            
        }
            break;
        case 2:{//精准
               _alertView = [[UIAlertView alloc] initWithTitle:@"精准提示"
                                                       message:message
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:@"查看", nil];
        }
            break;
            
        default:
            break;
    }
    
    [_alertView show];

    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    

}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
      NSLog(@"didFailToRegisterForRemoteNotificationsWithError:%@", error);
    
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
 
#pragma 程序将要进入前台时:
        [application setApplicationIconBadgeNumber:0];//把badge置为0,只有把他注释了才行
//        [application cancelAllLocalNotifications];//取消所有通知,目前先不取消,不好用了
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (_type == 2) {
        if (buttonIndex == 1) {
            DetailViewController *detailVC = [[DetailViewController alloc] init];
            detailVC.symbolName = @"推送跳转";
            detailVC.symbolCode = _pCode;
            //            detailVC.y_Close = cell.y_Close;
            detailVC.hidesBottomBarWhenPushed = YES;
            //    [self.navigationController pushViewController:detailVC animated:YES];
            CustomNavigationController *detailNC = [[CustomNavigationController alloc] initWithRootViewController:detailVC];
            
            [_tabBar.quotVC.navigationController presentViewController:detailNC animated:YES completion:^{
                
            }];
            
        }
    }
    

}



//判断用户是否是第一次运行app,如果是调用接口
- (void)judgeAppFirstLaunch
{
    //判断程序是否首次运行
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        NSLog(@"第一次启动1");
        NSString *udid = [SvUDIDTools UDID];
        NSLog(@"udid in keychain %@", udid);
        NSLog(@"current identityForVendor %@", [UIDevice currentDevice].identifierForVendor);
        
        //获取registrationID
        NSLog(@"registrationID:%@",[JPUSHService registrationID]);
        
        //首次开启应用
        NSString *url = @"http://www.cntjjy.com/p/appDataInterface.php";
        NSDictionary *postBody = @{@"action":@"insertFid",
                                   @"fid":udid,
                                   @"ver":@"iOS",
                                   @"registrationID":[JPUSHService registrationID]};
        NSDictionary *enPostBody = [CipherManage requestDicToPostBodyWithDic:postBody];
        [DataManage tempWithPostRequest:url PostBody:enPostBody success:^(id responseObject) {
            NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
            NSLog(@"首次开启应用上传udid结果:%@", [dic objectForKey:@"result"]);
        } failure:^(NSError *error) {
            
        }];
        
    }else{
               NSLog(@"不是第一次启动1");
    }
    
}

@end
