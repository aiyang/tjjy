//
//  NewsViewController.m
//  CNTJJY
//
//  Created by totrade on 16/1/12.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "NewsViewController.h"

#import "DataManage.h"

#import "CipherManage.h"
#import "GTMBase64.h"

#import "SBJsonParser.h"

@interface NewsViewController ()<UIWebViewDelegate>

@property (nonatomic, strong)MBProgressHUD *hud;

@property (nonatomic, retain)UIWebView *webView;


@end

@implementation NewsViewController




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    //用户登录状态查询接口
//#define userLoginStateQuery @"http://www.cntjjy.com/p/userDataAppInterface.php"//已改
//    //String code="uid=84F1DD51A04B432E888D4E9E514D9B06&action=getUserStatus";//uid是个什么鬼????
//    NSDictionary *postBody3 = @{@"uid":@"180C8ECDD9164452ACC481E89A5360D3", @"action":@"getUserStatus"};
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
    
        [self loadHUD];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    
    
//用户信息调用接口
//#define userInfoCalled @"http://www.cntjjy.com/p/userDataAppInterface.php"//接口已改
//fcea920f7412b5da7be0cf42b8c93759 md5加密用户密码（小写）
//String code="loginname=上海测试5&paswd=fcea920f7412b5da7be0cf42b8c93759&action=getUserInfoBypwd";
//    NSDictionary *postBody1 = @{@"loginname":@"上海测试6", @"paswd":@"123456", @"action":@"getUserInfoBypwd"};
//    NSDictionary *enPostBody1 = [CipherManage requestDicToPostBodyWithDic:postBody1 paswd:@"paswd"];
//    
//    [DataManage userInfoCalledWithPostBody:enPostBody1 success:^(id responseObject) {
//        
//        NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
//        
//        NSLog(@"用户信息调用接口:%@", dic);
//        
//    } failure:^(NSError *error) {
//        
//    }];
//
////    //用户登录密码验证接口
////#define userLoginPassWordCheck @"http://www.cntjjy.com/p/userDataAppInterface.php"//接口已改
////code="loginname=上海测试5&paswd=fcea920f7412b5da7be0cf42b8c93759&action=checkUserPassword";
//    NSDictionary *postBody2 = @{@"loginname":@"上海测试6", @"paswd":@"123456", @"action":@"checkUserPassword"};
//    NSDictionary *enPostBody = [CipherManage requestDicToPostBodyWithDic:postBody2 paswd:@"paswd"];
//    
//    [DataManage userLoginPassWordCheckWithPostBody:enPostBody success:^(id responseObject) {
//        NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
//        
//        NSLog(@"用户登录密码验证接口:%@", dic);//Correct代表对的
//    } failure:^(NSError *error) {
//        
//    }];
//    
//    //用户登录状态查询接口
//#define userLoginStateQuery @"http://www.cntjjy.com/p/userDataAppInterface.php"//已改
////String code="uid=84F1DD51A04B432E888D4E9E514D9B06&action=getUserStatus";//uid是个什么鬼????
//    NSDictionary *postBody3 = @{@"uid":@"180C8ECDD9164452ACC481E89A5360D3", @"action":@"getUserStatus"};
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
    
    
//    上海测试5UID:84F1DD51A04B432E888D4E9E514D9B06
//    上海测试6UID:180C8ECDD9164452ACC481E89A5360D3
    
    
//    userid="userid=84F1DD51A04B432E888D4E9E514D9B06&action=mail";userid为用户id，action为message时返回用户未查阅的订阅消息，为mail时返回用户尚未查阅的站内信。
    
//    ////用户站内信接口
//#define userLetterStation @"http://www.cntjjy.com/clientCenter/?m=Ucenter&c=Pubmess&a=index"
    //两个?一个查询mail的,一个查询message的?
//    String code="userid=84F1DD51A04B432E888D4E9E514D9B06&action=mail";
//    String code="userid=84F1DD51A04B432E888D4E9E514D9B06&action=message";
//    NSDictionary *postBody4 = @{@"userid":@"180C8ECDD9164452ACC481E89A5360D3", @"action": @"mail"};
//    NSDictionary *enPostBody4 = [CipherManage requestDicToPostBodyWithDic:postBody4];
    
//    NSDictionary *postBody5 = @{@"userid":@"84F1DD51A04B432E888D4E9E514D9B06", @"action": @"message"};//180C8ECDD9164452ACC481E89A5360D3
//    NSDictionary *enPostBody5 = [CipherManage requestDicToPostBodyWithDic:postBody5];
    
//    [DataManage userLetterStationWithPostBody:enPostBody4 success:^(id responseObject) {
//        NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
//        
//        NSLog(@"用户站内信接口---mail:%@", dic);
//    } failure:^(NSError *error) {
//        
//    }];
    
    //des:对 J70vo+Nd2Lg= 为什么会是空的???
    
//    [DataManage userLetterStationWithPostBody:enPostBody5 success:^(id responseObject) {
//        NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
//
//        NSLog(@"用户站内信接口---message:%@", dic);
//    } failure:^(NSError *error) {
//        
//    }];
    


//行情预警接口
#define quotationWarning @"http://www.cntjjy.com/p/appDataInterface.php"

//预警增加
//code="action=add&uid=03DCAC9198FB4304A21F39D3AF157541&mCode=makretCode001&pCode=productCode001&wLevel=1&cInfo=cInfo001";
    
//    action=add&
//    uid=03DCAC9198FB4304A21F39D3AF157541&
//    mCode=makretCode00&
//    pCode=productCode001&
//    wLevel=3000&
//    cInfo=cInfo001&
//    FixedLevel=2000&
//    createtime=1455876023&
//    updatetime=1455876023
//    NSDictionary *userInfoDic = [DataManage readUserDefaultsObjectforKey:@"userInfo"];
////    uid为用户id，mCode为交易所编码，pCode为产品编码，wLevel为预警值，cInfo为备注信息，action为固定值。
//    NSDictionary *add = @{@"action":@"add",
//                          @"uid":@"03DCAC9198FB4304A21F39D3AF157541",
//                          @"mCode":@"makretCode001",
//                          @"pCode":@"productCode001",
//                          @"wLevel":@"1",
//                          @"cInfo":@"cInfo001"};
//    
//    add = @{@"action":@"add",
//            @"uid":@"03DCAC9198FB4304A21F39D3AF157541",
//            @"mCode":@"makretCode001",
//            @"pCode":@"productCode001",
//            @"wLevel":@"1",
//            @"cInfo":@"cInfo001",
//            @"FixedLevel":@"2000",
//            @"createtime":@"1455876023",
//            @"updatetime":@"1455876023"};
//    
//    NSDictionary *enAdd = [CipherManage requestDicToPostBodyWithDic:add];
//    [DataManage quotationWarningWithPostBody:enAdd success:^(id responseObject) {
//                NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
//                NSLog(@"行情预警接口---add:%@", dic);
//    } failure:^(NSError *error) {
//        
//    }];
////预警修改
////code="action=cha&id=8&mCode=makretCode002&pCode=productCode001&wLevel=1&cInfo=cInfo001";
//    NSDictionary *cha = @{@"action":@"cha",
//                          @"id":@"8",
//                          @"mCode":@"makretCode002",
//                          @"pCode":@"productCode001",
//                          @"wLevel":@"1",
//                          @"cInfo":@"cInfo001"};
//    NSDictionary *enCha = [CipherManage requestDicToPostBodyWithDic:cha];
//    [DataManage quotationWarningWithPostBody:enCha success:^(id responseObject) {
//        NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
//        NSLog(@"行情预警接口---cha:%@", dic);
//    } failure:^(NSError *error) {
//        
//    }];
////预警删除
////code="action=del&id=7";
//    NSDictionary *del = @{@"action":@"del", @"id":@"7"};
//    NSDictionary *enDel = [CipherManage requestDicToPostBodyWithDic:del];
//    [DataManage quotationWarningWithPostBody:enDel success:^(id responseObject) {
//        NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
//        NSLog(@"行情预警接口---del:%@", dic);
//    } failure:^(NSError *error) {
//        
//    }];
////预警查询
//code="action=req&uid=03DCAC9198FB4304A21F39D3AF157541";
//    NSDictionary *req = @{@"action":@"req", @"uid":@"180C8ECDD9164452ACC481E89A5360D3"};
//    NSDictionary *enReq = [CipherManage requestDicToPostBodyWithDic:req];
//    [DataManage quotationWarningWithPostBody:enReq success:^(id responseObject) {
//      
//        NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
//        NSLog(@"行情预警接口---req:%@", [dic objectForKey:@"result"]);
//        NSString *request = [dic objectForKey:@"result"];
//        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
//        NSArray *array = [jsonParser objectWithString:request];
//        NSLog(@"行情预警接口array:%@---dic:%@---class:%@", array, array[0], [array[0] class]);
    
//    NSJSONSerialization
//    ios5中apple增加了解析JSON的api——NSJSONSerialization。网上已经有人做过测试，NSJSONSerialization在效率上完胜SBJSON、TouchJSON、YAJL、JSONKit、NextiveJson。详情见这里。既然apple为我们提供了这么良好的工具，我们没理由不用吧。
//    NSJSONSerialization提供了将JSON数据转换为Foundation对象（一般都是NSDictionary和NSArray）和Foundation对象转换为JSON数据（可以通过调用isValidJSONObject来判断Foundation对象是否可以转换为JSON数据）。
    
//    } failure:^(NSError *error) {
//        
//    }];
    
    
//        ////用户浏览器自动登录接口
//    #define userBrowserAutoLogin @"http://www.cntjjy.com/index.php?m=member&c=account&a=app_login"
//    
////        &loginname=%E4%B8%8A%E6%B5%B7%E6%B5%8B%E8%AF%955
////        &password=670b14728ad9902aecba32e22fa4f6bd
////        &backurl=http%3A%2F%2Fwww.cntjjy.com%2Findex.html
////        &keepingLogin=checked
//    NSDictionary *parameters = @{@"loginname":@"nihao6",
//                                 @"password":@"123456",
//                                 @"keepingLogin":@"checked"};
//    
//     [DataManage userBrowserAutoLoginWithGetParameters:parameters success:^(id responseObject) {
//         
//         NSLog(@"%@", responseObject);
//         
//     } failure:^(NSError *error) {
//         
//     }];
    
    
    self.navigationItem.title = @"实时新闻";
//    self.view.backgroundColor = [UIColor whiteColor];
    
    if (MAINSCREEN_WIDTH>MAINSCREEN_HEIGHT) {
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN_HEIGHT, MAINSCREEN_WIDTH)];
    }else{
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT)];
    }
    self.webView.backgroundColor = [UIColor whiteColor];
    
    if (MAINSCREEN_WIDTH>MAINSCREEN_HEIGHT) {
         self.webView.scrollView.contentSize = CGSizeMake(MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT);
    }else{
        self.webView.scrollView.contentSize = CGSizeMake(MAINSCREEN_HEIGHT, MAINSCREEN_WIDTH);
    }
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    self.webView.suppressesIncrementalRendering = YES;
    self.webView.paginationMode = UIWebPaginationModeUnpaginated;
    self.webView.scrollView.bounces = NO;
    [self.view addSubview:_webView];
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://mobile.cntjjy.com/livenews/"];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];

    
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
        _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    }
    [_hud showAnimated:YES];
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
