//
//  TestWebViewController.m
//  CNTJJY
//
//  Created by totrade on 16/2/29.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "TestWebViewController.h"
#import "CipherManage.h"
#import "DataManage.h"

#define HOST @"http://www.cntjjy.com"

@interface TestWebViewController ()<UIWebViewDelegate>
@property (nonatomic, retain)UIWebView *webView;

@end

@implementation TestWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self testWebViewLoaded];

}

- (void)testWebViewLoaded
{
    
    self.navigationItem.title = _theTitle;
    
    if (!_webView) {
        
        if (MAINSCREEN_WIDTH>MAINSCREEN_HEIGHT) {
            self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN_HEIGHT, MAINSCREEN_WIDTH)];
        }else{
            self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT)];
        }
    }
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    self.webView.suppressesIncrementalRendering = YES;
    self.webView.paginationMode = UIWebPaginationModeUnpaginated;
    self.webView.scrollView.bounces = NO;
    [self.view addSubview:_webView];
    
//    NSHTTPCookieStorage *myCookie = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (NSHTTPCookie *cookie in [myCookie cookies]) {
//        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];//保存最后一次的cookie
//    }
    
    // 设定 cookie
//    NSDictionary * cookieInfo =  [NSDictionary dictionaryWithObjectsAndKeys:@"XXXX"
//                                  , NSHTTPCookieValue
//                                  , @"XXX"
//                                  , NSHTTPCookieName
//                                  , @"/"
//                                  , NSHTTPCookiePath
//                                  , @"XXXX"
//                                  , NSHTTPCookieDomain
////                                  ,NULL];
////    
////    NSHTTPCookie * userCookie = [NSHTTPCookie cookieWithProperties:cookieInfo];
////    [[NSHTTPCookieStorage sharedHTTPCookieStorage]setCookie:userCookie];
//    
////    <NSHTTPCookie version:0 name:"xlluser" value:"O%3A8%3A%22stdClass%22%3A6%3A%7Bs%3A4%3A%22name%22%3Bs%3A10%3A%22cntjjyTest%22%3Bs%3A3%3A%22uid%22%3Bs%3A32%3A%22D48E75AC58B182B62DEA730193A99548%22%3Bs%3A5%3A%22leave%22%3Bs%3A2%3A%2224%22%3Bs%3A3%3A%22pic%22%3Bs%3A20%3A%22%2Fuserpic%2F%E5%A4%B4%E5%83%8F1.png%22%3Bs%3A6%3A%22endate%22%3Bs%3A19%3A%222031-03-01+00%3A00%3A00%22%3Bs%3A7%3A%22regdate%22%3Bs%3A19%3A%222016-03-01+00%3A00%3A00%22%3B%7D" expiresDate:2016-03-04 03:38:50 +0000 created:2016-03-03 03:39:21 +0000 sessionOnly:FALSE domain:"www.cntjjy.com" path:"/" isSecure:FALSE>
//    
//    
//    NSString *cookieValue = @"O%3A8%3A%22stdClass%22%3A6%3A%7Bs%3A4%3A%22name%22%3Bs%3A10%3A%22cntjjyTest%22%3Bs%3A3%3A%22uid%22%3Bs%3A32%3A%22D48E75AC58B182B62DEA730193A99548%22%3Bs%3A5%3A%22leave%22%3Bs%3A2%3A%2224%22%3Bs%3A3%3A%22pic%22%3Bs%3A20%3A%22%2Fuserpic%2F%E5%A4%B4%E5%83%8F1.png%22%3Bs%3A6%3A%22endate%22%3Bs%3A19%3A%222031-03-01+00%3A00%3A00%22%3Bs%3A7%3A%22regdate%22%3Bs%3A19%3A%222016-03-01+00%3A00%3A00%22%3B%7D";
//    
//    // 设定 cookie
//    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:
//                            [NSDictionary dictionaryWithObjectsAndKeys:
//                             HOST, NSHTTPCookieDomain,
//                             @"*", NSHTTPCookiePath,
//                             cookieValue, NSHTTPCookieValue,
//                             nil]];
//    
//    // 设定 cookie 到 storage 中
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
//    
//
//    
//    // 寻找URL为HOST的相关cookie，不用担心，步骤2已经自动为cookie设置好了相关的URL信息
//    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:HOST]]; // 这里的HOST是你web服务器的域名地址
//    // 比如你之前登录的网站地址是abc.com（当然前面要加http://，如果你服务器需要端口号也可以加上端口号），那么这里的HOST就是http://abc.com
//    // 设置header，通过遍历cookies来一个一个的设置header
//    for (NSHTTPCookie *cookie in cookies){
//        // cookiesWithResponseHeaderFields方法，需要为URL设置一个cookie为NSDictionary类型的header，注意NSDictionary里面的forKey需要是@"Set-Cookie"
//        NSArray *headeringCookie = [NSHTTPCookie cookiesWithResponseHeaderFields:
//                                    [NSDictionary dictionaryWithObject:
//                                     [[NSString alloc] initWithFormat:@"%@=%@",[cookie name],[cookie value]]
//                                                                forKey:@"Set-Cookie"]
//                                                                          forURL:[NSURL URLWithString:HOST]];
//        
//        // 通过setCookies方法，完成设置，这样只要一访问URL为HOST的网页时，会自动附带上设置好的header
//        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:headeringCookie
//                                                           forURL:[NSURL URLWithString:HOST]
//                                                  mainDocumentURL:nil];
//    }
    
    
    
    
    //    行情中心
    //http://www.cntjjy.com/hangqing/
    //    多空对决
    //http://www.cntjjy.com/duokong/
    //    实时新闻
    //http://mobile.cntjjy.com/livenews/
    //    财经日历
    //http://mobile.cntjjy.com/calendar/
    //    账户诊断
    //http://www.cntjjy.com/zhenduan/
    //    用户注册
    //http://www.cntjjy.com/register/
    //    视频直播
    //http://www.cntjjy.com/zhibo/video.php
    //    文字直播
    //http://www.cntjjy.com/chat_new/
    //    网络课堂
    //http://www.cntjjy.com/lesson/primary/
    //    众赢大户室
    //http://www.cntjjy.com/index.php?m=proComment&c=index&a=init&commentator=48"
    
    
    //    1.url编码
    //    ios中http请求遇到汉字的时候，需要转化成UTF-8，用到的方法是：
    //    NSString * encodingString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    2.url解码
    //    请求后，返回的数据，如何显示的是这样的格式：%3A%2F%2F，此时需要我们进行UTF-8解码，用到的方法:
    //    NSString *str = [model.album_name stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    致力于ios开发
    
    //    //用户登录状态查询接口
    //#define userLoginStateQuery @"http://www.cntjjy.com/p/userDataAppInterface.php"//已改
    //    //String code="uid=84F1DD51A04B432E888D4E9E514D9B06&action=getUserStatus";//uid是个什么鬼????
    //    NSDictionary *postBody3 = @{@"uid":@"180C8ECDD9164452ACC481E89A5360D3",
    //                                @"action":@"getUserStatus"};
    //    NSDictionary *enPostBody3 = [CipherManage requestDicToPostBodyWithDic:postBody3];
    //
    //    [DataManage userLoginStateQueryWithPostBody:enPostBody3 success:^(id responseObject) {
    //        NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
    //
    //        NSLog(@"用户登录状态查询接口:%@", dic);
    //
    //    } failure:^(NSError *error) {
    //
    //    }];
    
//    [self setCookie];
//    
//    
    NSURL *theUrl = [[NSURL alloc] init];
//    theUrl = [[NSURL alloc] initWithString:_path];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:theUrl]];
    
//    [self test1];
    
    if ([_theTitle isEqualToString:@"众赢大户室"]) {
        
//        //用户登录状态查询接口
//#define userLoginStateQuery @"http://www.cntjjy.com/p/userDataAppInterface.php"//已改
//        //String code="uid=84F1DD51A04B432E888D4E9E514D9B06&action=getUserStatus";//uid是个什么鬼????
//        NSDictionary *postBody3 = @{@"uid":@"180C8ECDD9164452ACC481E89A5360D3", @"action":@"getUserStatus"};
//        NSDictionary *enPostBody3 = [CipherManage requestDicToPostBodyWithDic:postBody3];
//        
//        [DataManage userLoginStateQueryWithPostBody:enPostBody3 success:^(id responseObject) {
//            NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
//            
//            NSLog(@"用户登录状态查询接口:%@", dic);
//            
//            
//        } failure:^(NSError *error) {
//            
//        }];
        
        
        
        //        NSString *url = userBrowserAutoLogin;
        
        //    &loginname=%E4%B8%8A%E6%B5%B7%E6%B5%8B%E8%AF%955
        //    &password=670b14728ad9902aecba32e22fa4f6bd
        //    &backurl=http%3A%2F%2Fwww.cntjjy.com%2Findex.html
        //    &keepingLogin=checked
        
        //        NSDictionary *parameters = @{@"loginname":@"上海测试6",
        //                                     @"password":@"123456",
        //                                     @"keepingLogin":@"checked"};
        //
        //        NSString *getString = [CipherManage requestDicToGetParametersWithDic:parameters paswd:@"password"];
        //        NSString *newUrl = [NSString stringWithFormat:@"%@%@", url, getString];
        //        NSString *getUrl = [newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //        theUrl = [[NSURL alloc] initWithString:getUrl];
        //        [self.webView loadRequest:[NSURLRequest requestWithURL:theUrl]];
        
        
        NSURL *theUrl = [[NSURL alloc] initWithString:_path];
        [self.webView loadRequest:[NSURLRequest requestWithURL:theUrl]];
        
        
        
        
        
        
        //        [DataManage tempWithGetRequest:newUrl success:^(id responseObject) {
        //
        //
        //
        //           NSURL *theUrl = [[NSURL alloc] initWithString:_path];
        //            [self.webView loadRequest:[NSURLRequest requestWithURL:theUrl]];
        //
        //        } failure:^(NSError *error) {
        //
        //        }];
        
        
        
        
    }else if ([_theTitle isEqualToString:@"账户诊断"]){
        
        NSString *url = userBrowserAutoLogin;
        
        
        //    &loginname=%E4%B8%8A%E6%B5%B7%E6%B5%8B%E8%AF%955
        //    &password=670b14728ad9902aecba32e22fa4f6bd
        //    &backurl=http%3A%2F%2Fwww.cntjjy.com%2Findex.html
        //    &keepingLogin=checked
        
        NSDictionary *parameters = @{@"loginname":@"cntjjyTest",
                                     @"password":@"123456",
                                     @"backurl":_path,
                                     @"keepingLogin":@"checked"};
        
        NSString *getString = [CipherManage requestDicToGetParametersWithDic:parameters paswd:@"password"];
        NSString *newUrl = [NSString stringWithFormat:@"%@%@", url, getString];
        NSString *getUrl = [newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        theUrl = [[NSURL alloc] initWithString:getUrl];
        [self.webView loadRequest:[NSURLRequest requestWithURL:theUrl]];
        
        

        
        
    }else{
        NSString *url = userBrowserAutoLogin;
        
        
        //    &loginname=%E4%B8%8A%E6%B5%B7%E6%B5%8B%E8%AF%955
        //    &password=670b14728ad9902aecba32e22fa4f6bd
        //    &backurl=http%3A%2F%2Fwww.cntjjy.com%2Findex.html
        //    &keepingLogin=checked
        
        NSDictionary *parameters = @{@"loginname":@"上海测试6",
                                     @"password":@"123456",
                                     @"backurl":_path,
                                     @"keepingLogin":@"checked"};
        
        NSString *getString = [CipherManage requestDicToGetParametersWithDic:parameters paswd:@"password"];
        NSString *newUrl = [NSString stringWithFormat:@"%@%@", url, getString];
        NSString *getUrl = [newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        theUrl = [[NSURL alloc] initWithString:_path];
        [self.webView loadRequest:[NSURLRequest requestWithURL:theUrl]];
        
        
        
    }
    
    
    //    NSLog(@"%@", theUrl);
    

}


-(void)test1
{
    NSHTTPCookie *cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies[1];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookies];
    
    NSString *cookieValue = @"O%3A8%3A%22stdClass%22%3A6%3A%7Bs%3A4%3A%22name%22%3Bs%3A10%3A%22cntjjyTest%22%3Bs%3A3%3A%22uid%22%3Bs%3A32%3A%22D48E75AC58B182B62DEA730193A99548%22%3Bs%3A5%3A%22leave%22%3Bs%3A2%3A%2224%22%3Bs%3A3%3A%22pic%22%3Bs%3A20%3A%22%2Fuserpic%2F%E5%A4%B4%E5%83%8F1.png%22%3Bs%3A6%3A%22endate%22%3Bs%3A19%3A%222031-03-01+00%3A00%3A00%22%3Bs%3A7%3A%22regdate%22%3Bs%3A19%3A%222016-03-01+00%3A00%3A00%22%3B%7D";
    
    NSURL *url = [NSURL URLWithString:_path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
//    [cookieProperties setObject:@"livehall" forKey:NSHTTPCookieName];
    [cookieProperties setObject:cookieValue forKey:NSHTTPCookieValue];
    [cookieProperties setObject:HOST forKey:NSHTTPCookieDomain];
//    [cookieProperties setObject:HOST forKey:NSHTTPCookieOriginURL];
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"1.0" forKey:NSHTTPCookieVersion];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    [self.webView loadRequest:request];
    
    NSHTTPCookieStorage *myCookie = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [myCookie cookies]) {
        NSLog(@"------cookie------:\n%@\n", cookie);
    }
}
////第二次请求会自动带上cookie
//- (IBAction)test2:(id)sender {
//    NSURL *url = [NSURL URLWithString:@"http://api.skyfox.org/cookie.php"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [self.mywebview2 loadRequest:request];
//}

//设置cookie
- (void)setCookie{
  
        NSString *cookieValue = @"O%3A8%3A%22stdClass%22%3A6%3A%7Bs%3A4%3A%22name%22%3Bs%3A10%3A%22cntjjyTest%22%3Bs%3A3%3A%22uid%22%3Bs%3A32%3A%22D48E75AC58B182B62DEA730193A99548%22%3Bs%3A5%3A%22leave%22%3Bs%3A2%3A%2224%22%3Bs%3A3%3A%22pic%22%3Bs%3A20%3A%22%2Fuserpic%2F%E5%A4%B4%E5%83%8F1.png%22%3Bs%3A6%3A%22endate%22%3Bs%3A19%3A%222031-03-01+00%3A00%3A00%22%3Bs%3A7%3A%22regdate%22%3Bs%3A19%3A%222016-03-01+00%3A00%3A00%22%3B%7D";
    
    NSMutableDictionary *cookiePropertiesUser = [NSMutableDictionary dictionary];
    [cookiePropertiesUser setObject:@"cookie_user" forKey:NSHTTPCookieName];
    [cookiePropertiesUser setObject:cookieValue forKey:NSHTTPCookieValue];
    [cookiePropertiesUser setObject:HOST forKey:NSHTTPCookieDomain];
    [cookiePropertiesUser setObject:@"/" forKey:NSHTTPCookiePath];
    [cookiePropertiesUser setObject:@"1.0" forKey:NSHTTPCookieVersion];
    
    // set expiration to one month from now or any NSDate of your choosing
    // this makes the cookie sessionless and it will persist across web sessions and app launches
    /// if you want the cookie to be destroyed when your app exits, don't set this
    [cookiePropertiesUser setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
    
    NSHTTPCookie *cookieuser = [NSHTTPCookie cookieWithProperties:cookiePropertiesUser];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieuser];
}

//清除cookie
- (void)deleteCookie{
//    NSHTTPCookie *cookie;
//    
//    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    
//    NSArray *cookieAry = [cookieJar cookiesForURL: [NSURL URLWithString: _urlstr]];
//    
//    for (cookie in cookieAry) {
//        
//        [cookieJar deleteCookie: cookie];
//        
//    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
