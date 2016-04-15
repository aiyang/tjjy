//
//  LoginViewController.m
//  CNTJJY
//
//  Created by totrade on 16/2/15.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "LoginViewController.h"

#import "CipherManage.h"
#import "ShowToast.h"
#import "DataManage.h"
#import "JPUSHService.h"
#import "SvUDIDTools.h"

#import "TestWebViewController.h"//好奇怪的解决方式


@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UIView *userNameBackView;
@property (strong, nonatomic) IBOutlet UIView *passWordBackName;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@property (strong, nonatomic) IBOutlet UITextField *userNameTF;
@property (strong, nonatomic) IBOutlet UITextField *passWordTF;




@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"用户登录";
    self.navigationController.navigationBarHidden = NO ;
    
    //设置按钮的显示效果
    [self setTheLayer];
    
    
    [self.loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    
}


- (void)loginButtonAction:(UIButton *)button
{
    [self handleUserLoginPassWordCheck];
//    [self handleUserInfoCalled];

}

- (void)handleUserLoginPassWordCheck
{
    //    //用户登录密码验证接口
    //#define userLoginPassWordCheck @"http://www.cntjjy.com/p/userDataAppInterface.php"//接口已改
    //code="loginname=上海测试5&paswd=fcea920f7412b5da7be0cf42b8c93759&action=checkUserPassword";
    
    NSString *loginName = self.userNameTF.text;//@"上海测试6"
    NSString *passWord = self.passWordTF.text;//@"123456"
    
    //设置上传参数
    NSDictionary *postBody2 = @{@"loginname":loginName,
                                @"paswd":passWord,
                                @"action":@"checkUserPassword"};
    //对参数进行加密
    NSDictionary *enPostBody = [CipherManage requestDicToPostBodyWithDic:postBody2 paswd:@"paswd"];
    
    [DataManage userLoginPassWordCheckWithPostBody:enPostBody success:^(id responseObject) {
        
        NSLog(@"!!!:%@", responseObject);
        
        NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
        
        NSLog(@"用户登录密码验证接口:%@", dic);//Correct代表对的
        if ([[dic objectForKey:@"result"] isEqualToString:@"pwdCorrect"]) {
            [ShowToast showMessage:@"登录成功"];
            
            [self handleUserInfoCalled];
            
        }else if([[dic objectForKey:@"result"] isEqualToString:@"pwdError"]){
            [ShowToast showMessage:@"密码错误"];
        }else if ([[dic objectForKey:@"result"] isEqualToString:@"userNoExist"]){
            [ShowToast showMessage:@"用户不存在"];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)handleUserInfoCalled
{
    
    NSString *loginName = self.userNameTF.text;//@"上海测试6"
    NSString *passWord = self.passWordTF.text;//@"123456"
    
    //用户信息调用接口
    //#define userInfoCalled @"http://www.cntjjy.com/p/userDataAppInterface.php"//接口已改
    //fcea920f7412b5da7be0cf42b8c93759 md5加密用户密码（小写）
    //String code="loginname=上海测试5&paswd=fcea920f7412b5da7be0cf42b8c93759&action=getUserInfoBypwd";
    NSDictionary *postBody1 = @{@"loginname":loginName,
                                @"paswd":passWord,
                                @"action":@"getUserInfoBypwd"};
    NSDictionary *enPostBody1 = [CipherManage requestDicToPostBodyWithDic:postBody1 paswd:@"paswd"];
    
    [DataManage userInfoCalledWithPostBody:enPostBody1 success:^(id responseObject) {
        
        NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
        
        NSLog(@"用户信息调用接口:%@", dic);
        
        NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                            loginName, @"loginname",
                                            passWord,@"paswd", nil];
        [newDic addEntriesFromDictionary:dic];
        
        
        [self upLoadUid:[newDic objectForKey:@"userid"]];
        
        //登录成功后将用户信息写入本地,用户名密码也同步写到本地吧
        [DataManage writeUserDefaultsObject:newDic forKey:@"userInfo"];
        
        
        //读取用于信息
        NSDictionary *userInfoDic = [DataManage readUserDefaultsObjectforKey:@"userInfo"];
        if (userInfoDic.count != 0) {
            
            NSSet *set = [NSSet setWithObjects:[userInfoDic objectForKey:@"roleid"], nil];
            
            NSLog(@"%@", set);
            
            
            [JPUSHService setTags:set alias:[userInfoDic objectForKey:@"userid"] fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                
                NSLog(@"iResCode:%d---iTags:%@---iAlias:%@", iResCode, iTags, iAlias);
                
            }];
        }
        
        
//        NSString *url = userBrowserAutoLogin;
//        
//        //    &loginname=%E4%B8%8A%E6%B5%B7%E6%B5%8B%E8%AF%955
//        //    &password=670b14728ad9902aecba32e22fa4f6bd
//        //    &backurl=http%3A%2F%2Fwww.cntjjy.com%2Findex.html
//        //    &keepingLogin=checked
//        
//        NSDictionary *parameters = @{@"loginname":@"上海测试6",
//                                     @"password":@"123456",
//                                     @"keepingLogin":@"checked"};
//        
//        NSString *getString = [CipherManage requestDicToGetParametersWithDic:parameters paswd:@"password"];
//        NSString *newUrl = [NSString stringWithFormat:@"%@%@", url, getString];
//        NSString *getUrl = [newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSURL *theUrl = [[NSURL alloc] initWithString:getUrl];
//        
//        NSLog(@"theUrl:%@", theUrl);
        
        
        
//        用户信息调用接口:{
//            enddate = "2030-01-01 00:00:00";
//            loginpwd = e10adc3949ba59abbe56e057f20f883e;
//            logopic = "/userpic/180C8ECDD9164452ACC481E89A5360D3.png";
//            rolelevel = 6;
//            rolename = "\U4e94\U661f\U5ba2\U6237(V5)";
//            truename = "\U5929\U5929\U5929\U5929";显示true
//            userid = 180C8ECDD9164452ACC481E89A5360D3;
//        }
        
        
//        {
//            enddate = "2031-03-01 00:00:00";
//            loginpwd = e10adc3949ba59abbe56e057f20f883e;
//            logopic = "/userpic/\U5934\U50cf1.png";
//            roleid = 9063A12A65A24799B4E2A69FB8EB53D0;//用作标签
//            rolelevel = 4;
//            rolename = "\U4e09\U661f\U5ba2\U6237(V3)";
//            truename = cntjjyTest;
//            userid = D48E75AC58B182B62DEA730193A99548;//用作别名
//        }
        
        
//        [self loadWebView];
        
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
    } failure:^(NSError *error) {
        
    }];
}

//每次登陆成功后向服务器上传相关参数
- (void)upLoadUid:(NSString *)uid
{
        NSString *udid = [SvUDIDTools UDID];
        //用户每次登录成功并获取用户信息之后
        NSString *url = @"http://www.cntjjy.com/p/appDataInterface.php";
        NSDictionary *postBody = @{@"action":@"insertUID",
                                   @"uid":uid,
                                   @"fid":udid};
        NSDictionary *enPostBody = [CipherManage requestDicToPostBodyWithDic:postBody];
        [DataManage tempWithPostRequest:url PostBody:enPostBody success:^(id responseObject) {
            NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
            NSLog(@"用户每次登录成功并获取用户信息之后:%@", [dic objectForKey:@"result"]);
        } failure:^(NSError *error) {
            
        }];
}



- (void)setTheLayer
{
    _passWordTF.secureTextEntry = YES;
    
    //_userNameBackView.layer.cornerRadius = 3.0f;
    _userNameBackView.layer.masksToBounds = YES;
    _userNameBackView.layer.borderColor = [UIColor colorFromHexCode:@"#F0F2F2"].CGColor;
    _userNameBackView.layer.borderWidth = 1.0f;
    
    //_passWordBackName.layer.cornerRadius = 3.0f;
    _passWordBackName.layer.masksToBounds = YES;
    _passWordBackName.layer.borderColor = [UIColor colorFromHexCode:@"#F0F2F2"].CGColor;
    _passWordBackName.layer.borderWidth = 1.0f;
    
    _loginButton.layer.cornerRadius = 3.0f;
    _loginButton.layer.masksToBounds = YES;
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_passWordTF resignFirstResponder];
    [_userNameTF resignFirstResponder];
}


- (void)loadWebView
{
    TestWebViewController *testVC = [[TestWebViewController alloc] init];
    testVC.theTitle = @"账户诊断";
    testVC.path = @"http://www.cntjjy.com/zhenduan/";
    [testVC testWebViewLoaded];
//    [self.view addSubview:testVC.view];
//    [testVC.view setHidden:YES];
    
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
