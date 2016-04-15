//
//  CentViewController.m
//  CNTJJY
//
//  Created by totrade on 16/1/12.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "CentViewController.h"

#import "CentSetViewController.h"
#import "LoginViewController.h"

#import "WebViewViewController.h"//加载个人中心的webView网页

#import "DataManage.h"

#import "UIImageView+WebCache.h"
#import "JPUSHService.h"

#import "AboutUsViewController.h"//关于我们界面

#import "CentSheZhiViewController.h"




@interface CentViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIImageView *headIV;
@property (strong, nonatomic) IBOutlet UIImageView *starIV;
@property (strong, nonatomic) IBOutlet UILabel *userNameLB;


@property (nonatomic, strong)NSArray *tableView_Arr;
@property (nonatomic, strong)NSArray *cellTitleArray;

@property (strong, nonatomic) IBOutlet UIButton *loginButton;


@end

@implementation CentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView_Arr = @[@[@"极速开户", @"我的权限",@"账户诊断"],@[ @"风险提示"],@[@"天金加银微信", @"意见反馈", @"关于我们", @"联系客服"]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
  //  self.tableView.bounces = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
    [self setTableViewSeparatorInset];
    
    

    _headIV.layer.cornerRadius = _headIV.bounds.size.width/2;;
    _headIV.layer.masksToBounds = YES;
//    _headIV.layer.borderColor = [UIColor colorFromHexCode:@"#F0F2F2"].CGColor;
//    _headIV.layer.borderWidth = 1.0f;

    

    UIButton *rightButton = [UIButton settingButtonWithtitle:@"设置" target:self action:@selector(barButtonAction:)];
    
    if (self.view.frame.size.width>self.view.frame.size.height) {
        rightButton.frame = CGRectMake(self.view.frame.size.height- 100, 30, 60, 25) ;
    }else{
        rightButton.frame = CGRectMake(self.view.frame.size.width- 100, 30, 60, 25) ;
    }
   
    rightButton.backgroundColor = [UIColor clearColor];
    [self.view addSubview:rightButton];
    
  

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES ;

    [self setUserCenterShow];
}

//右上角设置
- (void)barButtonAction:(UIBarButtonItem *)barButton
{
    CentSheZhiViewController *centSetVC = [[CentSheZhiViewController alloc] init];
   // CentSetViewController *centSetVC = [[CentSetViewController alloc]init];
    centSetVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:centSetVC animated:YES];
}

- (IBAction)loginButtonAction:(UIButton *)sender {
    NSString *loginButtonString = self.loginButton.titleLabel.text;
    if ([loginButtonString isEqualToString:@"登录"]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }else if ([loginButtonString isEqualToString:@"退出账户"]){
       // 注销账户 清理web cookie
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies])
        {
            [storage deleteCookie:cookie];
        }

        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定要注销登录吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 99;
        [alertView show];
        

        
    }

}

- (void)setUserCenterShow
{
    //读取用于信息
    NSDictionary *userInfoDic = [DataManage readUserDefaultsObjectforKey:@"userInfo"];
    NSLog(@"%d", userInfoDic.count);
    
    if (userInfoDic.count == 0) {
//        self.loginButton.titleLabel.text = @"登录";//这句话有时不好用
        [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
        self.userNameLB.text = nil;
        self.starIV.image = nil;
        self.headIV.image = [UIImage imageNamed:@"u14"];
    }else{
        [self.loginButton setTitle:@"退出账户" forState:UIControlStateNormal];
        self.userNameLB.text = [userInfoDic objectForKey:@"truename"];
        self.starIV.image = [UIImage imageNamed:[NSString stringWithFormat:@"vip%@", [userInfoDic objectForKey:@"rolelevel"]]];
        NSString *string = [NSString stringWithFormat:@"%@%@", @"http://www.cntjjy.com/", [userInfoDic objectForKey:@"logopic"]];
        NSURL *imageUrl = [[NSURL alloc] initWithString:string];
        [self.headIV sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"u14"]];
    
    }
    
  
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return 3 ;
    }
    if (section ==1) {
        return 1 ;
    }
    return 4 ;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3 ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0 ;
    }
    return 20 ;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((self.tableView.frame.size.height-40)/8.0f <44) {
        return  44 ;
    }
    NSLog(@"=========%f",(self.tableView.frame.size.height -44*3) / 8.0f) ;
    return (self.tableView.frame.size.height-40) / 8.0f;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
//   cell = [UITableViewCell alloc] initWithStyle:(UITableViewCellStyle) reuseIdentifier:<#(nullable NSString *)#>
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    self.cellTitleArray = [self.tableView_Arr objectAtIndex:indexPath.section];
    cell.textLabel.text = [self.cellTitleArray objectAtIndex:indexPath.row];
    

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == 2 && indexPath.section == 2) {
        
        AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc] init];
        aboutUsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutUsVC animated:YES];
        
    }else if (indexPath.row == 3 && indexPath.section == 2){
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您需要拨打咨询热线400-6698-119吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
        alertView.tag = 66;
        [alertView show];
        
        
    }else{
        WebViewViewController *webViewVC = [[WebViewViewController alloc] init];
        
        self.cellTitleArray = [self.tableView_Arr objectAtIndex:indexPath.section];
        
        webViewVC.theTitle = [self.cellTitleArray objectAtIndex:indexPath.row];
       // webViewVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:webViewVC animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//点击后颜色反转
    

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)setTableViewSeparatorInset
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1 && alertView.tag == 66) {//拨打热线
        //使用telprompt/tel这两种方式界面表现不一样
        NSString *telStr = [NSString stringWithFormat:@"telprompt://%@", @"400-6698-119"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];
    }else if (buttonIndex == 1 && alertView.tag == 99){//确认注销
                
        [DataManage removeUserDefaultsObjectForKey:@"userInfo"];
        [self setUserCenterShow];
        [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
        
        //关闭推送
        NSSet *set = [[NSSet alloc] init];
        [JPUSHService setTags:set alias:@"" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
            
            NSLog(@"iResCode:%d---iTags:%@---iAlias:%@", iResCode, iTags, iAlias);
            
        }];
    }
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
