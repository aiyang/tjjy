//
//  QuotViewController.m
//  CNTJJY
//
//  Created by totrade on 16/1/12.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#define SegH 40.0

#import "QuotViewController.h"
#import "CustomNavigationController.h"

#import "GuideInterface.h"


#import "QuotTableViewCell.h"

#import "QuotTableViewHeaderView.h"

#import "DetailViewController.h"//详情




#import "HYSegmentedControl.h"//顶部选择器

#import "CiphertextManage.h"//密文管理

#import "DataManage.h"//数据管理

#import "DetailViewController.h"

#import "SingleExchangeAllSymbolsInstantData_DownObj.h"


#import "MessageViewController.h"//消息页面

#import "SvUDIDTools.h"

#import "CipherManage.h"
#import "SBJsonParser.h"


#import "CentSetMode.h"


#import "SomeSymbolsInstantData_DownObj.h"

#import "SyCodeToExCode.h"

#import "OptionalViewController.h"//自选视图控制器

#import "AppDelegate.h"  
#import "YRSideViewController.h"


@interface QuotViewController ()<HYSegmentedControlDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong)NSString *upDateUrl;//获取升级app的地址

@property (nonatomic, strong)HYSegmentedControl *topSegmentedControl;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *tableView_Arr;
//@property (nonatomic, strong)NSMutableArray *addSelf_NoArr;
//@property (nonatomic, strong)NSMutableArray *addSelf_YesArr;


@property (nonatomic, assign)NSInteger segIndex;

@property (nonatomic, strong)GuideInterface *guideInterface;



@property (nonatomic, strong)CentSetMode *centSetMode;//个人中心设置,用户获取行情刷新的秒数
@property (nonatomic, strong)NSString *interface;//用于刷新
@property (nonatomic, strong)NSString *exchangeCode;//用于刷新
@property (nonatomic, strong)NSTimer *timer;

@property (nonatomic, strong)NSMutableDictionary *addSelDataDic;

@property (nonatomic, strong)SyCodeToExCode *syCodeToExCode;

@property (nonatomic, assign)CGPoint theContentOffset;

//抽屉
@property (nonatomic, strong) YRSideViewController *sideViewController;

@end

@implementation QuotViewController

- (BOOL)shouldAutorotate
{
        return NO;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}





- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    self.sideViewController=[delegate sideViewController];
    if (self.view.frame.size.width>self.view.frame.size.height) {
        self.sideViewController.leftViewShowWidth=self.view.frame.size.height*0.816;
    }else{
        self.sideViewController.leftViewShowWidth=self.view.frame.size.width*0.816;
    }
    
    self.sideViewController.needSwipeShowMenu=true;//默认开启的可滑动展示

    
    
    
    
    if (_segIndex == 0) {
//        _addSelf_NoArr = [NSMutableArray array];
//        _addSelf_YesArr = [NSMutableArray array];
        [self requestDataWithTag:1 interface:HT_WANGGUAN exCode:@"TMRE" syCodes:nil];
        _interface = HT_WANGGUAN;
        _exchangeCode = @"TMRE";
    }else{
        
    }

//    调取默认值,默认自选
//    self.exchange_Str = @"自选";

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"-------- %f ---- %f",self.view.frame.size.width ,self.view.frame.size.height);
    NSLog(@"用户获取行情刷新的秒数:%@", _centSetMode.refreshSeconds);
    _centSetMode = [[CentSetMode alloc] init];
    CGFloat refreshTime = [_centSetMode.refreshSeconds floatValue];
    _timer = [NSTimer scheduledTimerWithTimeInterval:refreshTime target:self selector:@selector(refreshAction) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  // NSArray * array = [[NSBundle mainBundle] loadNibNamed:@"QuotViewController" owner:self options:nil];
   // NSLog(@"%@",array);
    // Do any additional setup after loading the view from its nib.
    UIView *cleanOffsetView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    cleanOffsetView.backgroundColor = [UIColor redColor];
    [self.view addSubview:cleanOffsetView];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hySegmentedControlSelectDic:) name:@"btnTag" object:nil];
//    self.thePush =  
    
    [self judgeAppFirstLaunch];
    
//    [self judgeAppVersion];

    self.topSegmentedControl = [[HYSegmentedControl alloc] initWithOriginY:64 Titles:@[ @"天矿所", @"津贵所", @"齐鲁商品", @"上海金", @"纸黄金", @"国际外汇", @"国际黄金"] delegate:self];
    [self.view addSubview:_topSegmentedControl];
    
    UIButton *addSelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    addSelButton.layer.cornerRadius = 3.0f;
    addSelButton.layer.masksToBounds = YES;
//    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    button.layer.borderWidth = 1.0f;
    
    
    if (MAINSCREEN_WIDTH>MAINSCREEN_HEIGHT) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + SegH, MAINSCREEN_HEIGHT, MAINSCREEN_WIDTH - 64 - SegH - 100 - 10) style:UITableViewStylePlain];
    }else{
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + SegH, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT - 64 - SegH - 100 - 10) style:UITableViewStylePlain];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    

    
    [self.tableView registerClass:[QuotTableViewHeaderView class] forHeaderFooterViewReuseIdentifier:@"headerReuse"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QuotTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    //导航栏左侧按钮
    //UIButton *leftButton = [UIButton buttonWithTitle:@"消息" target:self action:@selector(leftBarAction:)];
    UIButton * leftButton  = [UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.frame = CGRectMake(10, 30, 25, 20) ;
    [leftButton setBackgroundImage:[UIImage imageNamed:@"chouti"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBarAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    //导航栏右侧按钮
    UIButton *rightButton = [UIButton buttonWithTitle:@"自选" target:self action:@selector(rightBarAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];

}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
//    [self.tableView setFrame:CGRectMake(0, 94, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT - 145 - 50)];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    QuotTableViewHeaderView *headerView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerReuse"];
    return headerView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableView_Arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (self.tableView_Arr.count != 0) {
        cell.get_DownObj = [self.tableView_Arr objectAtIndex:indexPath.row];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    QuotTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.symbolName = cell.nameLB.text;
    detailVC.symbolCode = cell.code;
    detailVC.y_Close = cell.y_Close;
    detailVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:detailVC animated:YES];
    CustomNavigationController *detailNC = [[CustomNavigationController alloc] initWithRootViewController:detailVC];
    
    [self.navigationController presentViewController:detailNC animated:YES completion:^{
        
    }];
    
}

- (void)leftBarAction:(UIButton *)barButton
{
//    MessageViewController *messageVC = [[MessageViewController alloc] init];
//    messageVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:messageVC animated:YES];
    [self.sideViewController showLeftViewController:true];
}
- (void)rightBarAction:(UIButton *)barButton
{
    OptionalViewController *optionalVC = [[OptionalViewController alloc] init];
    optionalVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:optionalVC animated:YES];
}



- (void)hySegmentedControlSelectDic:(NSNotification *)notification{
    
    //    获取tag
    NSString* tag=[[notification userInfo] objectForKey:@"btnTag"];
    //    根据tag加载数据
    [self hySegmentedControlSelectAtIndex:[tag intValue]];
    //    改变顶部index
    [self.topSegmentedControl changeSegmentedControlWithIndex:[tag intValue]];
    //    隐藏抽屉
    [self.sideViewController hideSideViewController:true];
}


//顶部选择器代理方法
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{

    _theContentOffset = CGPointMake(0, 0);
    
   
    _segIndex = index;
    
   
    
    if (MAINSCREEN_WIDTH>MAINSCREEN_HEIGHT) {
        [self.tableView setFrame:CGRectMake(0, 64 + SegH, MAINSCREEN_HEIGHT, MAINSCREEN_WIDTH - 64 - SegH - 44)];
    }else{
        [self.tableView setFrame:CGRectMake(0, 64 + SegH, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT - 64 - SegH - 44)];
    }
    
    

    
#warning 要学会使用switch语句,虽然没什么卵用
//     0        1         2         3          4         5         6           7
//    @[@"自选", @"天矿所", @"津贵所", @"齐鲁商品", @"上海金", @"纸黄金", @"国际外汇", @"国际黄金"]
//                TMRE     TJPME    QILUCE      SGE       PGOLD     MT4         WGJS
    
    switch (index) {
        case 0:{
            [self requestDataWithTag:1 interface:HT_WANGGUAN exCode:@"TMRE" syCodes:nil];
            _interface = HT_WANGGUAN;
            _exchangeCode = @"TMRE";
            break;
        }
        case 1:{
            [self requestDataWithTag:2 interface:HT_WANGGUAN exCode:@"TJPME" syCodes:nil];
            _interface = HT_WANGGUAN;
            _exchangeCode = @"TJPME";
            break;
        }
        case 2:{
            [self requestDataWithTag:3 interface:QL_WANGGUAN exCode:@"QILUCE" syCodes:nil];
            _interface = QL_WANGGUAN;
            _exchangeCode = @"QILUCE";
            break;
        }
        case 3:{
            [self requestDataWithTag:4 interface:HT_WANGGUAN exCode:@"SGE" syCodes:nil];
            _interface = HT_WANGGUAN;
            _exchangeCode = @"SGE";
            break;
        }
        case 4:{
            [self requestDataWithTag:5 interface:HT_WANGGUAN exCode:@"PGOLD" syCodes:nil];
            _interface = HT_WANGGUAN;
            _exchangeCode = @"PGOLD";
            break;
        }
        case 5:{
            [self requestDataWithTag:6 interface:HT_WANGGUAN exCode:@"MT4" syCodes:nil];
            _interface = HT_WANGGUAN;
            _exchangeCode = @"MT4";
            break;
        }
        case 6:{
            [self requestDataWithTag:7 interface:HT_WANGGUAN exCode:@"WGJS" syCodes:nil];
            _interface = HT_WANGGUAN;
            _exchangeCode = @"WGJS";
            break;
        }
        default:
            break;
    }
    
}




- (void)requestDataWithTag:(NSInteger)tag interface:(NSString *)interface exCode:(NSString *)exchCode syCodes:(NSArray *)symbolsCodes
{
    self.tableView_Arr = [NSMutableArray array];
    [_tableView reloadData];
    [DataManage requestDataByTag:@(tag) interface:interface exCode:exchCode syCodes:symbolsCodes success:^(id responseObject) {
        
        
//        NSInteger key = [[[responseObject allKeys] objectAtIndex:0] integerValue];
        NSNumber *key = nil;
        
       // NSLog(@"--**--- %@",[responseObject allKeys]);
        for (id subKey  in [responseObject allKeys]) {
            if ([subKey isKindOfClass:[NSNumber class]]) {
                key = subKey;
            }
        }
        NSArray *arr = [responseObject objectForKey:key];
        
        if (_segIndex == [key integerValue]) {
            
     
             _tableView_Arr = [NSMutableArray arrayWithArray:arr];
            }

            [_tableView reloadData];
            _tableView.contentOffset =  _theContentOffset;
        

        
        
        
    } failure:^(NSError *error) {
        
    }];
    
    //建立商品code和交易所code一一对应关系
    if (tag != 0) {
//        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[DataManage readUserDefaultsObjectforKey:@"codeToMarkCode"]];
        _syCodeToExCode = [[SyCodeToExCode alloc] init];
        //这里行不行呢?
        for (SingleExchangeAllSymbolsInstantData_DownObj *singel_DownObj in _tableView_Arr) {
            if (_tableView_Arr.count != 0) {
//                [dic setObject:exchCode forKey:singel_DownObj.code];
                [_syCodeToExCode setSyC:singel_DownObj.code toExC:exchCode];
            }
        }
//        [DataManage writeUserDefaultsObject:dic forKey:@"codeToMarkCode"];
        
    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _theContentOffset = scrollView.contentOffset;

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _theContentOffset = scrollView.contentOffset;

}





//判断用户是否是第一次运行app,如果是启动引导页
- (void)judgeAppFirstLaunch
{
    
    //判断程序是否首次运行
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        NSLog(@"第一次启动2");
        //加载引导页
        _guideInterface = [[GuideInterface alloc] init];
        [_guideInterface setShowPageWithImageArray:@[@"page1", @"page2", @"page3"]];
        [_guideInterface guideInterfaceButtonTarget:self action:@selector(guideInterfaceButtonAction:)];
        [_guideInterface show];
        
    }else{
        NSLog(@"不是第一次启动2");
        [self judgeAppVersion];
    }
    
}


//加载引导图
- (void)guideInterfaceButtonAction:(UIButton *)button
{
    [_guideInterface disMiss];
    [self judgeAppVersion];
}

//
- (void)judgeAppVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];//CFShow(infoDictionary);
#warning 获取App名称,版本.
    // app名称
    // NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app build版本
    // NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    // app版本
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];//version
    NSInteger appVersionInteger = [[appVersion stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
    
    
    // 获取最新版本号
    NSString *url = @"http://www.cntjjy.com/p/appDataInterface.php";
    NSDictionary *postBody = @{@"action":@"getAppVer"};
    NSDictionary *enPostBody = [CipherManage requestDicToPostBodyWithDic:postBody];
    [DataManage tempWithPostRequest:url PostBody:enPostBody success:^(id responseObject) {
        NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
        
        NSLog(@"%@", dic);
        
        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
        NSDictionary *theDic = [jsonParser objectWithString:[dic objectForKey:@"result"]];
        NSString *appNewVersion = [theDic objectForKey:@"IosVer"];
        _upDateUrl = [theDic objectForKey:@"IosUrl"];
        NSInteger appNewVersionInteger = [[appNewVersion stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
        
        if (appNewVersionInteger > appVersionInteger) {
            NSString *alertMessage = [NSString stringWithFormat:@"app版本已升级至%@,您可前往升级", appNewVersion];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:alertMessage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前往", nil];
            alertView.delegate = self;
            [alertView show];
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString *upDateUrl = @"https://itunes.apple.com/us/app/shang-pin-tong/id1056516708?mt=8";
//        _upDateUrl
       upDateUrl = @"http://www.cntjjy.com";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:upDateUrl]];
        
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.sideViewController.leftViewShowWidth=0;
    self.sideViewController.needSwipeShowMenu=false;
    [_timer invalidate];//界面小时结束刷新
}

- (void)refreshAction
{
         [self requestDataWithTag:_segIndex interface:_interface exCode:_exchangeCode syCodes:nil];
        NSLog(@"刷新:%ld", (long)_segIndex);
    
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
