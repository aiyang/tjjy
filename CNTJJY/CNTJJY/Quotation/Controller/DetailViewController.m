//
//  DetailViewController.m
//  CNTJJY
//
//  Created by totrade on 16/1/18.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//


#import "DetailViewController.h"
#import "CustomNavigationController.h"

#import "WarningViewController.h"


#import "TBackView.h"
#import "KBackView.h"

#import "DataManage.h"

#import "SingleSymbolHistoryData_DownObj.h"
#import "SomeSymbolsInstantData_DownObj.h"

#import "DatatTansfer.h"

#import "TimeTools.h"
#import "nightMode.h"

#import "XCTimeSegControl.h"


#import "CentSetMode.h"

#import "SyCodeToExCode.h"

#import "CustomFont.h"

#import "LoginViewController.h"



@interface DetailViewController ()<XCTimeSegControlDelegate>

@property (strong, nonatomic) IBOutlet UIView *divideLine0;
@property (strong, nonatomic) IBOutlet UIView *divideLine1;
@property (strong, nonatomic) IBOutlet UIView *divideLine2;
@property (strong, nonatomic) IBOutlet UIView *divideLine3;
@property (strong, nonatomic) IBOutlet UIView *divideLine4;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *TKBack_Bottom;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *timeScroHeight;


@property (nonatomic, strong)NightMode *nightMode;

@property (strong, nonatomic) IBOutlet UIView *tkTopView;

@property (strong, nonatomic) IBOutlet UIView *tk_BackView;
@property (strong, nonatomic) IBOutlet XCTimeSegControl *timeSegControl;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *PorLanButton_bottom;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *PorLanButton_trailing;


@property (nonatomic, assign)NSInteger selIndex;//记录porSelTKView和lanSelTKView的横线的位置

@property (nonatomic, strong)TBackView *tBackView;
@property (nonatomic, strong)KBackView *kBackView;


@property (nonatomic, strong)NSString *kType;
@property (nonatomic, assign)BOOL isTLine;

@property (nonatomic, assign)BOOL isPortrait;

@property (nonatomic, strong)NSString *start;
@property (nonatomic, strong)NSString *stop;


@property (nonatomic, strong)CentSetMode *centSetMode;//个人中心设置,用户获取行情刷新的秒数
@property (nonatomic, strong)NSTimer *timer;

@property (nonatomic, strong)SyCodeToExCode *syCodeToExCode;


@end

@implementation DetailViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.navigationItem.title = [NSString stringWithFormat:@"%@:%@", self.symbolName, self.symbolCode];
    
    //设置导航条标题
    self.navigationItem.title = _symbolName;
    

//    self.navi
    self.navigationController.navigationBar.barTintColor = [UIColor colorFromHexCode:@"#242424"];//背景颜色?
    
    
    _nightMode = [[NightMode alloc] init];
    
    _tkTopView.backgroundColor = _nightMode.tkTopViewColor;
    self.view.backgroundColor = _nightMode.backGroundColor;
    self.tk_BackView.backgroundColor = _nightMode.backGroundColor;
    
    [self setDivideLineColor];
    
    //导航左侧返回键
    UIButton *leftButton = [UIButton backButtonWithImageName:@"back" target:self action:@selector(leftBarButtonAction:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];

    //导航栏右侧按钮
    UIButton *rightButton = [UIButton buttonWithTitle:@"预警" target:self action:@selector(rightBarButtonAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
  
    _kType = @"min1";
    _isTLine = YES;
    _start = [[TimeTools getTLineStartStop] objectAtIndex:0];
    _stop = [[TimeTools getTLineStartStop] objectAtIndex:1];
    
    
    //时间选择器//为何不可以???
    _timeSegControl.delegate = self;
    
   
    
    [self.porLanButton addTarget:self action:@selector(changePorLan:) forControlEvents:UIControlEventTouchUpInside];
    [_porLanButton setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
    _porLanButton.layer.masksToBounds = YES;
    _porLanButton.layer.cornerRadius = 3.0f;
//    _porLanButton.layer.borderColor = [UIColor greenColor].CGColor;
//    _porLanButton.layer.borderWidth = 1.0f;
    _isPortrait = YES;
    
}


- (void)changePorLan:(UIButton *)button
{
    //一旦点击按钮,只能手动切换横竖屏
    
    NSLog(@"hengshuping------");
    DataManage *dataManage = [DataManage shareInstance];
    dataManage.isGravity = YES;
    
    if (_isPortrait == YES) {
            [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];//这句话是防止手动先把设备置为横屏,导致下面的语句失效.
            [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
        
    
        
    }else if (_isPortrait == NO){
            [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];//这句话是防止手动先把设备置为竖屏,导致下面的语句失效.
            [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
        //    状态栏旋转
            [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
    }
    
    dataManage.isGravity = NO;

    
//        if (_isPortrait == YES) {
//            UIApplication *application=[UIApplication sharedApplication];
//            [application setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
//            application.keyWindow.transform=CGAffineTransformMakeRotation(M_PI);
//            
//        }else{
//            UIApplication *application=[UIApplication sharedApplication];
//            [application setStatusBarOrientation:UIInterfaceOrientationPortrait];
//            application.keyWindow.transform=CGAffineTransformMakeRotation(0);
//        }
    
    

//    [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact];
//    [UITraitCollection traitCollectionWithVerticalSizeClass:UIUserInterfaceSizeClassRegular];
    

    
//      [self.view setNeedsLayout];
    
//    UIContentContainer
//    self willTransitionToTraitCollection:<#(nonnull UITraitCollection *)#> withTransitionCoordinator:<#(nonnull id<UIViewControllerTransitionCoordinator>)#>

    _isPortrait = !_isPortrait;
}

//- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
//{
//    
//}

//viewWillTransitionToSize:withTransitionCoordinator:

//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
//{
//    
//}
//
//- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection
//              withTransitionCoordinator:(id )coordinator
//{
//    [super willTransitionToTraitCollection:newCollection
//                 withTransitionCoordinator:coordinator];
//    [coordinator animateAlongsideTransition:^(id  context) {
//        if (newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
//        } else {
//        }
//        [self.view setNeedsLayout];
//    } completion:nil];
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];


}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.view.frame.size.width > self.view.frame.size.height) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
//        [_porLanButton setBackgroundImage:[UIImage imageNamed:@"portrait"] forState:UIControlStateNormal];
        [_porLanButton setImage:[UIImage imageNamed:@"portrait"] forState:UIControlStateNormal];
      
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
//        [_porLanButton setBackgroundImage:[UIImage imageNamed:@"landscape"] forState:UIControlStateNormal];
        [_porLanButton setImage:[UIImage imageNamed:@"landscape"] forState:UIControlStateNormal];
    }
    

    [_tk_BackView setHidden:NO];
    

    
    //    //只能在这里获取得到
    [self setPForDWithInterface:nil code:_symbolCode];
    //这个接口不一定放这里吧
    [self setPForTopDWithInterface:nil code:_symbolCode];
    
    if (!_kBackView) {
        _kBackView = [[KBackView alloc] initWithFrame:_tk_BackView.bounds];
    }
    _kBackView.target = self.navigationController;
    if (!_tBackView) {
        _tBackView = [[TBackView alloc] initWithFrame:_tk_BackView.bounds];
    }
    
    if (_isTLine) {
        [self.tk_BackView addSubview:_tBackView];
        [_tBackView startTline];
    }else{
        [self.tk_BackView addSubview:_kBackView];
        [_kBackView startKline];
    }
    

    
    NSLog(@"用户获取行情刷新的秒数:%@", _centSetMode.refreshSeconds);
    _centSetMode = [[CentSetMode alloc] init];
    CGFloat refreshTime = [_centSetMode.refreshSeconds floatValue];
    _timer = [NSTimer scheduledTimerWithTimeInterval:refreshTime target:self selector:@selector(refreshAction) userInfo:nil repeats:YES];
    [_timer fire];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_tk_BackView setHidden:YES];
    
    //该界面消失后,使该界面支持横竖屏
    DataManage *dataManage = [DataManage shareInstance];
    dataManage.isGravity = YES;
    
    [super viewDidDisappear:animated];
    [_timer invalidate];//界面小时结束刷新
}


#pragma mark ----XCTimeSegControlDelegate-------li

- (void)indexButton:(id)tkindex index:(NSInteger)index
{
    [self portraitLandscapeButtonActionWithIndex:index];
    if (index != 0) {
        
        self.porLanButton.hidden = YES ;
        self.PorLanButton_trailing.constant = 5 ;
        self.TKBack_Bottom.constant = 30 ;
        [self performSelector:@selector(modifyConstant) withObject:nil afterDelay:0.1f];
        
        
    }
    else{
        self.PorLanButton_bottom.constant = 100 ;
        self.PorLanButton_trailing.constant = 35 ;
        self.TKBack_Bottom.constant = 80 ;
        [self performSelector:@selector(modifyConstant) withObject:nil afterDelay:0.01f];
        
    }
}

-(void)modifyConstant{
  

    if (_selIndex != 0){
        self.PorLanButton_bottom.constant = (_tk_BackView.frame.size.height - 60) * 2 / 5 - 20 + 30 + 30 + 20;
        self.porLanButton.hidden = NO ;
    }
    [_kBackView setFrame:_tk_BackView.bounds];
    [_tBackView setFrame:_tk_BackView.bounds];

    
}







//获取K线数据
- (void)setPForDWithInterface:(NSString *)interface code:(NSString *)code
{
    DataManage *dataManage = [DataManage shareInstance];
    NSString *interFace_Str = [NSString string];
    if ([dataManage.qlSymbols_Arr containsObject:self.symbolCode]) {
        interFace_Str = QL_WANGGUAN;
    }else{
        interFace_Str = HT_WANGGUAN;
    }
    
    [DataManage singleSymbolHistoryDataWithInterface:interFace_Str code:self.symbolCode kType:_kType top:@"100" start:_start stop:_stop success:^(id responseObject) {
        
        if (_start.length == 0) {
            //由于请求是异步加载的,所以当使用缓存数据时,kBackView,tBackView还没来得及创建,分时图是不需要它的
            [DatatTansfer getInitialIndsDataWithDadaArr:responseObject];//计算指标在获取到数据之后即进行计算
            self.kBackView.dataArr = responseObject;
            [_kBackView startKline];//开始画K线
        }else{
            self.tBackView.dataArr = responseObject;
            self.tBackView.y_Colse = _y_Close;
            self.tBackView.y_O = _y_O;
            [_tBackView startTline];
        }

        
    } failure:^(NSError *error) {
        NSLog(@"***");
    }];
}

//获取顶部数据,使用获取某几个商品的即时数据
- (void)setPForTopDWithInterface:(NSString *)interface code:(NSString *)code
{
    DataManage *dataManage = [DataManage shareInstance];
    NSString *interFace_Str = [NSString string];
    
    if ([dataManage.qlSymbols_Arr containsObject:self.symbolCode]) {
        interFace_Str = QL_WANGGUAN;
    }else{
        interFace_Str = HT_WANGGUAN;
    }
    
        [DataManage someSymbolsInstantDataWithInterface:interFace_Str count:1 codes:@[code] success:^(id responseObject) {
            NSArray *arr = responseObject;
            if (arr.count != 0) {
                SomeSymbolsInstantData_DownObj *some_DownObj = arr[0];
                [self setTopValueWith:some_DownObj];
            }
 
          
            
        } failure:^(NSError *error) {
            
        }];
}





//横竖屏
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration{
    
    [_tBackView setFrame:_tk_BackView.bounds];
    [_kBackView setFrame:_tk_BackView.bounds];

    
    if (interfaceOrientation == UIInterfaceOrientationPortrait) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
        [_porLanButton setImage:[UIImage imageNamed:@"landscape"] forState:UIControlStateNormal];

    }else{
        [self.navigationController setNavigationBarHidden:YES animated:NO];

        [_porLanButton setImage:[UIImage imageNamed:@"portrait"] forState:UIControlStateNormal];

    }
    //UIInterfaceOrientationPortraitUpsideDown可以不算做竖屏
}



- (void)setTopValueWith:(SomeSymbolsInstantData_DownObj *)some_DownObj
{

    if (_y_Close.length == 0) {
        _y_Close = some_DownObj.yclose;
        [_tBackView startTline];
    }else if ([_y_Close floatValue] <= 0){
        _y_O = some_DownObj.o;
         [_tBackView startTline];
    }
    
    
    _symbolNameLB.text = _symbolName;
    _yCloseLB.text = some_DownObj.yclose;
    
    NSString *newPrice = some_DownObj.c;
    if (newPrice.length >= 8) {
        newPrice = [newPrice substringWithRange:NSMakeRange(0, 7)];
    }
    _nwePriceLB.text = newPrice;
    _upDownLB.text = some_DownObj.upDown;
    _upDownRangeLB.text = some_DownObj.upDownRange;
    _hLB.text = some_DownObj.high;
    _lLB.text = some_DownObj.low;
    _oLB.text = some_DownObj.o;
    _buyLB.text = some_DownObj.buy;
    _sellLB.text = some_DownObj.sell;
    _swingLB.text = some_DownObj.swing;
    
    _symbolNameLB.textColor = _nightMode.syNameColor;


    UIColor *color = [[UIColor alloc] init];
    if ([some_DownObj.c floatValue] > [some_DownObj.yclose floatValue]) {
        color = [UIColor redColor];
        _upDownIV.image = [UIImage imageNamed:@"up"];
    }else{
        color = [UIColor colorFromHexCode:@"#01ae4d"];
        _upDownIV.image = [UIImage imageNamed:@"down"];
    }
    _nwePriceLB.textColor = color;
    _upDownLB.textColor = color;
    _upDownRangeLB.textColor = color;
    
    
    _swingLB.textColor = _nightMode.yCloseColor;
    _yCloseLB.textColor = _nightMode.yCloseColor;
   
    UIColor *red = [UIColor redColor];
    UIColor *green = [UIColor colorFromHexCode:@"#01ae4d"];
    if ([some_DownObj.high floatValue] > [some_DownObj.yclose floatValue]) {
        _hLB.textColor = red;
    }else{
        _hLB.textColor = green;
    }
    
    if ([some_DownObj.low floatValue] > [some_DownObj.yclose floatValue]) {
        _lLB.textColor = red;
    }else{
        _lLB.textColor = green;
    }
    
    if ([some_DownObj.o floatValue] > [some_DownObj.yclose floatValue]) {
        _oLB.textColor = red;
    }else{
        _oLB.textColor = green;
    }
    
    if ([some_DownObj.buy floatValue] > [some_DownObj.yclose floatValue]) {
        _buyLB.textColor = red;
    }else{
        _buyLB.textColor = green;
    }
    
    if ([some_DownObj.sell floatValue] > [some_DownObj.yclose floatValue]) {
        _sellLB.textColor = red;
    }else{
        _sellLB.textColor = green;
    }
    
    
}



- (void)leftBarButtonAction:(UIBarButtonItem *)barButton
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)rightBarButtonAction:(UIBarButtonItem *)barButton
{
    NSDictionary *userInfoDic = [DataManage readUserDefaultsObjectforKey:@"userInfo"];
    if (userInfoDic.count != 0) {
        WarningViewController *warningVC = [[WarningViewController alloc] init];
        _syCodeToExCode = [[SyCodeToExCode alloc] init];
        NSString *exchangeCode = [_syCodeToExCode getExCFromSyC:_symbolCode];
        warningVC.symbolCode = _symbolCode;
        warningVC.symbolName = _symbolName;
        warningVC.exchangeCode = exchangeCode;
        warningVC.nwePrice = _nwePriceLB.text;
        warningVC.upDown = _upDownLB.text;
        warningVC.upDownRange = _upDownRangeLB.text;
        //    [self.navigationController pushViewController:warningVC animated:YES];
        CustomNavigationController *warningNC = [[CustomNavigationController alloc] initWithRootViewController:warningVC];
        [self.navigationController presentViewController:warningNC animated:YES completion:^{
            
        }];
    }else{
//        [ShowToast showMessage:@"请登录再进行预警操作"];
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        //        loginVC.hidesBottomBarWhenPushed = YES;
        //        CustomNavigationController *loginNC = [[CustomNavigationController alloc] initWithRootViewController:loginVC];
        //        [self.navigationController presentViewController:loginNC animated:YES completion:^{
        //
        //        }];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    

}

- (void)portraitLandscapeButtonActionWithIndex:(NSInteger)index
{
    //    type （必选，K线种类，min1\min5\min15\min30\min60\day\week\month）
    
    _selIndex = index;
    if (index == 0) {
        _isTLine = YES;
        _start = [[TimeTools getTLineStartStop] objectAtIndex:0];
        _stop = [[TimeTools getTLineStartStop] objectAtIndex:1];
        
    }else{
        _isTLine = NO;
        _start = nil;
        _stop = nil;
    }
    
    switch (index) {
        case 0:{
            [_kBackView setHidden:YES];
            [_tBackView setHidden:NO];
            [self.tk_BackView addSubview:_tBackView];
            _kType = @"min1";
            
        }
            break;
        case 1:{
            [_kBackView setHidden:NO];
            [_tBackView setHidden:YES];
            [self.tk_BackView addSubview:_kBackView];
            _kType = @"min5";
        }
            break;
        case 2:{
            [_kBackView setHidden:NO];
            [_tBackView setHidden:YES];
            [self.tk_BackView addSubview:_kBackView];
            _kType = @"min15";
        }
            break;
        case 3:{
            [_kBackView setHidden:NO];
            [_tBackView setHidden:YES];
            [self.tk_BackView addSubview:_kBackView];
            _kType = @"min30";
        }
            break;
        case 4:{
            [_kBackView setHidden:NO];
            [_tBackView setHidden:YES];
            [self.tk_BackView addSubview:_kBackView];
            _kType = @"min60";
        }
            break;
        case 5:{
            [_kBackView setHidden:NO];
            [_tBackView setHidden:YES];
            [self.tk_BackView addSubview:_kBackView];
            _kType = @"day";//240请求不到数据,用周代替了
        }
            break;
        case 6:{
            [_kBackView setHidden:NO];
            [_tBackView setHidden:YES];
            [self.tk_BackView addSubview:_kBackView];
            _kType = @"week";
        }
            break;
        case 7:{
            [_kBackView setHidden:NO];
            [_tBackView setHidden:YES];
            [self.tk_BackView addSubview:_kBackView];
            _kType = @"month";
        }
            break;
            
        case 8:{
            [_kBackView setHidden:NO];
            [_tBackView setHidden:YES];
            [self.tk_BackView addSubview:_kBackView];
            _kType = @"year";
        }
            break;
            
        default:
            break;
    }
    
    [self setPForDWithInterface:nil code:_symbolCode];
    [self setPForTopDWithInterface:nil code:_symbolCode];
}



- (void)refreshAction
{
    if (_selIndex == 0) {
        _start = [[TimeTools getTLineStartStop] objectAtIndex:0];
        _stop = [[TimeTools getTLineStartStop] objectAtIndex:1];
        [self setPForDWithInterface:nil code:_symbolCode];//进行分时图刷新
    }
    [self setPForTopDWithInterface:nil code:_symbolCode];//进行顶部数据刷新

    
    NSLog(@"k线详情界面刷新");
}

- (void)setDivideLineColor
{
//    _nightMode = [[NightMode alloc] init];
    _divideLine0.backgroundColor = _nightMode.divideLineColor;
    _divideLine1.backgroundColor = _nightMode.divideLineColor;
    _divideLine2.backgroundColor = _nightMode.divideLineColor;
    _divideLine3.backgroundColor = _nightMode.divideLineColor;
    _divideLine4.backgroundColor = _nightMode.divideLineColor;
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
