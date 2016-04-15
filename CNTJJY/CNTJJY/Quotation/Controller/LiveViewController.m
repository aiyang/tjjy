//
//  LiveViewController.m
//  CNTJJY
//
//  Created by totrade on 16/3/2.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "LiveViewController.h"

@interface LiveViewController ()<UIWebViewDelegate>

@property (nonatomic, strong)NSDictionary *userInfoDic;

@property (nonatomic, strong)MBProgressHUD *hud;

@property (nonatomic, retain)UIWebView *webView;

@end

@implementation LiveViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadHUD];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
        
    //修改app的webView网页的默认User-Agent//一句话就可以了
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent" : @"CntjjyIOSAppWebClient/1.0.0",@"User-Agent" : @"CntjjyIOSAppWebClient/1.0.0"}];
    
    _userInfoDic = [DataManage readUserDefaultsObjectforKey:@"userInfo"];
    
    NSLog(@"%@", _userInfoDic);
    
    
    self.navigationItem.title = @"直播";
    
    
    if (MAINSCREEN_WIDTH>MAINSCREEN_HEIGHT) {
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN_HEIGHT, MAINSCREEN_WIDTH)];
    }else{
         self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT)];
    }
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    self.webView.suppressesIncrementalRendering = YES;
    self.webView.paginationMode = UIWebPaginationModeUnpaginated;
    self.webView.scrollView.bounces = NO;
    [self.view addSubview:_webView];
    
    if (_userInfoDic.count != 0) {
        //用户登录状态查询接口
        NSDictionary *postBody3 = @{@"uid":[_userInfoDic objectForKey:@"userid"],
                                    @"action":@"getUserStatus"};
        NSDictionary *enPostBody3 = [CipherManage requestDicToPostBodyWithDic:postBody3];
        
        [DataManage userLoginStateQueryWithPostBody:enPostBody3 success:^(id responseObject) {
            NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
            NSLog(@"用户登录状态查询接口:%@", dic);
            
            NSString *statusStr = [dic objectForKey:@"result"];
            if (![statusStr isEqualToString:@"userLogined"]) {
                
                NSURL *url = [[NSURL alloc] initWithString:@"http://192.168.200.14/5/spzb/"];
                [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
                
            }else{
                
                NSString *url = userBrowserAutoLogin;
              //  NSLog(@"-----**---- %@",[_userInfoDic objectForKey:@"loginname"]);
                NSDictionary *parameters = @{@"loginname":[_userInfoDic objectForKey:@"loginname"],
                                             @"password":[_userInfoDic objectForKey:@"paswd"],//paswd
                                             @"backurl":@"http://192.168.200.14/5/spzb/",
                                             @"keepingLogin":@"checked"};
                NSString *getString = [CipherManage requestDicToGetParametersWithDic:parameters paswd:@"password"];
                NSString *newUrl = [NSString stringWithFormat:@"%@%@", url, getString];
                NSString *getUrl = [newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *theUrl = [[NSURL alloc] initWithString:getUrl];
                [self.webView loadRequest:[NSURLRequest requestWithURL:theUrl]];
            }
            
        } failure:^(NSError *error) {
            
        }];
    }else{
//        NSURL *url = [[NSURL alloc] initWithString:@"http://www.cntjjy.com/chat_new/"];
        NSURL *url = [[NSURL alloc] initWithString:@"http://192.168.200.14/5/spzb/"];
        //http://192.168.200.14/5/spzb/
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
//
    }
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_hud hideAnimated:YES];
    NSLog(@"webViewDidFinishLoad");
}

// 加载MBProgressHUD
- (void)loadHUD
{
    if (!_hud) {
        //        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [_hud showAnimated:YES];
}


@end
