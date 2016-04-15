//
//  WebViewViewController.m
//  CNTJJY
//
//  Created by totrade on 16/2/15.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "WebViewViewController.h"
#import "TestWebViewController.h"


@interface WebViewViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSArray *titleArr;
@property (nonatomic, strong)NSArray *urlArr;

@end

@implementation WebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = _theTitle;
    self.navigationController.navigationBarHidden = NO ;
//        //修改app的webView网页的默认User-Agent//一句话就可以了
//        //        UIWebView* tempWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
//        [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent" : @"CntjjyIOSAppWebClient/1.0.0",
//                                                                  @"User-Agent" : @"CntjjyIOSAppWebClient/1.0.0"}];
//    
//    _titleArr = @[@"行情中心", @"多空对决", @"实时新闻", @"财经日历", @"账户诊断", @"用户注册", @"视频直播", @"文字直播", @"网络课堂", @"众赢大户室"];
//    
//    _urlArr = @[@"http://www.cntjjy.com/hangqing/",
//                @"http://www.cntjjy.com/duokong/",
//                @"http://mobile.cntjjy.com/livenews/",
//                @"http://mobile.cntjjy.com/calendar/",
//                @"http://www.cntjjy.com/zhenduan/",
//                @"http://www.cntjjy.com/register/",
//                @"http://www.cntjjy.com/zhibo/video.php",
//                @"http://www.cntjjy.com/chat_new/",
//                @"http://www.cntjjy.com/lesson/primary/",
//                @"http://www.cntjjy.com/index.php?m=proComment&c=index&a=init&commentator=48"];
    
    
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
    //http://www.cntjjy.com/index.php?m=proComment&c=index&a=init&commentator=48
    
    if (MAINSCREEN_WIDTH>MAINSCREEN_HEIGHT) {
         _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN_HEIGHT, MAINSCREEN_WIDTH) style:UITableViewStylePlain];
    }else{
         _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT) style:UITableViewStylePlain];
    }
    
   
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
    

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    cell.textLabel.text = [_titleArr objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TestWebViewController *testWVC = [[TestWebViewController alloc] init];
    testWVC.theTitle = [_titleArr objectAtIndex:indexPath.row];
    testWVC.path = [_urlArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:testWVC animated:YES];
    
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
