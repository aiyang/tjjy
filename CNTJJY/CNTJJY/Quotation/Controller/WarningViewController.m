//
//  WarningViewController.m
//  CNTJJY
//
//  Created by totrade on 16/1/28.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "WarningViewController.h"
#import "WarningTableViewCell.h"

#import "AddWarningView.h"
#import "CipherManage.h"

#import "SBJsonParser.h"

#import "WarningReq_DownObj.h"

#import "SomeSymbolsInstantData_DownObj.h"//需要刷新,所以只能重新获取了

#import "CustomAlertView.h"

#import "CentSetMode.h"

#define TopViewHeight 75.0f


@interface WarningViewController ()<UITableViewDataSource, UITableViewDelegate, CustomAlertViewDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *tableViewArr;

@property (nonatomic, strong)CustomAlertView *customAlertView;

@property (nonatomic, strong)AddWarningView *topView;

@property (nonatomic, strong)SomeSymbolsInstantData_DownObj *some_DownObj;//topView上的数据

//暂存当前选取的cell的req_DownObj
@property (nonatomic, strong)WarningReq_DownObj *currentCellReq_DownObj;
@property (nonatomic, assign)BOOL isAdd;//判断是增加还是修改预警线


@property (nonatomic, strong)NSDictionary *userInfoDic;//获取用户信息

@property (nonatomic, strong)CentSetMode *centSetMode;//个人中心设置,用户获取行情刷新的秒数
@property (nonatomic, strong)NSTimer *timer;

@property (nonatomic, strong)NSString *cellYClose;

@end

@implementation WarningViewController

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    NSLog(@"用户获取行情刷新的秒数:%@", _centSetMode.refreshSeconds);
    _centSetMode = [[CentSetMode alloc] init];
    CGFloat refreshTime = [_centSetMode.refreshSeconds floatValue];
    _timer = [NSTimer scheduledTimerWithTimeInterval:refreshTime target:self selector:@selector(refreshAction) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.navigationItem.title = @"预警设置";
//    self.navigationItem.title = [NSString stringWithFormat:@"%@:%@%@", self.exchangeCode, self.symbolName, self.symbolCode];
    
    self.navigationItem.title = _symbolName;
    
    

    
    //获取用户信息
    _userInfoDic = [DataManage readUserDefaultsObjectforKey:@"userInfo"];
    
    //获取查询数据(不可与获取用户信息顺序颠倒)
    [self handleWarningReq];
    
    //弹出框
    _customAlertView = [[CustomAlertView alloc] init];
    _customAlertView.delegete = self;

    //获取顶部View数据
    [self setPForTopDWithInterface:nil code:_symbolCode];
    
    //顶部View
    if (MAINSCREEN_WIDTH>MAINSCREEN_HEIGHT) {
        _topView = [[AddWarningView alloc] initWithFrame:CGRectMake(0, 64, MAINSCREEN_HEIGHT, MAINSCREEN_WIDTH)];
    }else{
        _topView = [[AddWarningView alloc] initWithFrame:CGRectMake(0, 64, MAINSCREEN_WIDTH, TopViewHeight)];
    }
    
    
    [self.view addSubview:_topView];
    

    

    
    if (MAINSCREEN_WIDTH>MAINSCREEN_HEIGHT) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                       64 + TopViewHeight,
                                                                       MAINSCREEN_HEIGHT,
                                                                       MAINSCREEN_WIDTH - 64 - TopViewHeight)
                                                      style:UITableViewStylePlain];
    }else{
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                       64 + TopViewHeight,
                                                                       MAINSCREEN_WIDTH,
                                                                       MAINSCREEN_HEIGHT - 64 - TopViewHeight)
                                                      style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_tableView];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WarningTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    

    
    //导航左侧返回键
    UIButton *leftButton = [UIButton backButtonWithImageName:@"back" target:self action:@selector(leftBarAction:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    //导航栏右侧按钮
    UIButton *rightButton = [UIButton buttonWithTitle:@"添加" target:self action:@selector(rightBarButtonAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    
}


- (void)leftBarAction:(UIBarButtonItem *)barButton
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
}



- (void)rightBarButtonAction:(UIBarButtonItem *)barButton
{
    _customAlertView.wLevel = _topView.priceLB.text;
    _isAdd = YES;
    [_customAlertView show];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableViewArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WarningTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];

    if (_cellYClose != nil) {
        cell.yClose = _cellYClose;
        cell.req_DownObj = [_tableViewArr objectAtIndex:indexPath.row];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WarningTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _currentCellReq_DownObj = cell.req_DownObj;
    _customAlertView.wLevel = _currentCellReq_DownObj.warningLevel;
    _isAdd = NO;
    [_customAlertView show];
}

//自定义弹出框的代理方法
- (void)customAlertViewAtIndex:(NSInteger)index output:(NSString *)output
{
    if (index == 0) {//增加或者修改
        if (_isAdd == YES) {//增加
            [self handleWarningAddWithWLevel:output];
        }else if (_isAdd == NO){//修改
            [self handleWarningChaWithWLevel:output];
        }
    }else if (index == 1){//取消
    }else if (index == 2){//删除
        if (_currentCellReq_DownObj.theId != nil) {
            [self handleWarningDelWithTheId:_currentCellReq_DownObj.theId];
        }
    }
    [_customAlertView disMiss];

}

//    预警增加(不影响调用但是有部分瑕疵)
- (void)handleWarningAddWithWLevel:(NSString *)wLevel
{

//    uid为用户id，mCode为交易所编码，pCode为产品编码，wLevel为预警值，cInfo为备注信息，action为固定值.
#warning "wLevel":@"9",//预警值,增加或修改均改动wLevel,显示也是显示wLevel wLevel不超过十万,保留四位小数点max=99999.9999
    
    NSTimeInterval theInterval = [[NSDate date] timeIntervalSince1970];
    NSString *theIntervalStr = [NSString stringWithFormat:@"%.0f", theInterval];
    
    //所有字段均为必传字段
    NSDictionary *add = @{@"action":@"add",
                          @"uid":[_userInfoDic objectForKey:@"userid"],
                          @"mCode":_exchangeCode,
                          @"pCode":_symbolCode,//3125
                          @"wLevel":wLevel,//预警值,增加或修改均改动wLevel,显示也是显示wLevel
                          @"cInfo":@"",//可置空
                          @"FixedLevel":_some_DownObj.c,//不可置空,//当前真实值
                          @"createtime":theIntervalStr,//不可置空
                          @"updatetime":theIntervalStr,//不可置空
                          @"issend":@"1"};//不可置空
    
        NSDictionary *enAdd = [CipherManage requestDicToPostBodyWithDic:add];
        [DataManage quotationWarningWithPostBody:enAdd success:^(id responseObject) {
            
                    NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
                    NSLog(@"行情预警接口---add:%@", dic);
            
            [self handleWarningReq];//增删改后再次刷新页面
        } failure:^(NSError *error) {
            
        }];
}

////预警删除(接口测试成功)
#pragma 预警删除传入的参数只有action,id(id为数据唯一标识,可通过查询操作得到)
- (void)handleWarningDelWithTheId:(NSString *)theId
{
        NSDictionary *del = @{@"action":@"del",
                              @"id":theId};
        NSDictionary *enDel = [CipherManage requestDicToPostBodyWithDic:del];
        [DataManage quotationWarningWithPostBody:enDel success:^(id responseObject) {
            
            NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
            NSLog(@"行情预警接口---del:%@", dic);
            
            [self handleWarningReq];//增删改后再次刷新页面
        } failure:^(NSError *error) {
            
        }];
}

#warning 修改操作  传入的参数 是不是只有action,id，mCode，pCode，wLevel，
//FixedLevel，createtime ，updatetime，cinfo cinfo可以为空
////预警修改//change(修改操作调用成功,也是有瑕疵的)
- (void)handleWarningChaWithWLevel:(NSString *)wLevel
{
    NSTimeInterval theInterval = [[NSDate date] timeIntervalSince1970];
    NSString *theIntervalStr = [NSString stringWithFormat:@"%.0f", theInterval];
    
        NSDictionary *cha = @{@"action":@"cha",
                              @"id":_currentCellReq_DownObj.theId,
                              @"mCode":_currentCellReq_DownObj.marketCode,
                              @"pCode":_currentCellReq_DownObj.productCode,
                              @"wLevel":wLevel,
                              @"FixedLevel":@"666",//修改时不用修改固定值的
                              @"createtime":_currentCellReq_DownObj.createtime,
                              @"updatetime":theIntervalStr,
                              @"cinfo":@"",
                              @"issend":@"1"};
        NSDictionary *enCha = [CipherManage requestDicToPostBodyWithDic:cha];
        [DataManage quotationWarningWithPostBody:enCha success:^(id responseObject) {
            
            NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
            NSLog(@"行情预警接口---cha:%@", dic);
            
            [self handleWarningReq];//增删改后再次刷新页面
        } failure:^(NSError *error) {
            
        }];
}

#warning 查询操作  传入的参数 只有action 和uid  对的
////预警查询(查询接口测试成功)
- (void)handleWarningReq
{
    _tableViewArr = [NSMutableArray array];
    
        NSDictionary *req = @{@"action":@"req",
                              @"uid":[_userInfoDic objectForKey:@"userid"]};
        NSDictionary *enReq = [CipherManage requestDicToPostBodyWithDic:req];
    
//        NSLog(@"req:%@", req);
    
        [DataManage quotationWarningWithPostBody:enReq success:^(id responseObject) {
            
            
    
            NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
//            NSLog(@"行情预警接口---req:%@", [dic objectForKey:@"result"]);
            NSString *request = [dic objectForKey:@"result"];
            SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
            NSArray *array = [jsonParser objectWithString:request];
            NSArray *req_DownObjArr = [WarningReq_DownObj modelArrWithDics:(NSMutableArray *)array];
            
         
            for (WarningReq_DownObj *req_DownObj in req_DownObjArr) {
                if ([req_DownObj.productCode isEqualToString:_symbolCode]) {
                    [_tableViewArr addObject:req_DownObj];
                }
            }

            [self.tableView reloadData];
    
        } failure:^(NSError *error) {
            
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
        _some_DownObj = arr[0];
        
        //为顶部View赋值
        _topView.nameLB.text = _symbolName;
        _topView.nameLB.numberOfLines = 0;
//        _topView.some_DownObj = _some_DownObj;
        _topView.priceLB.text = _some_DownObj.c;
        _topView.upDownLB.text = _some_DownObj.upDown;
        _topView.upDownRangeLB.text = _some_DownObj.upDownRange;
        
        if (_cellYClose == nil) {//空的时候再刷新
            _cellYClose = _some_DownObj.yclose;
            [_tableView reloadData];
        }
        
        
        
        UIColor *color = [[UIColor alloc] init];
        if ([_some_DownObj.c floatValue] > [_some_DownObj.yclose floatValue]) {
            color = [UIColor redColor];
            _topView.upDownLB.text = [NSString stringWithFormat:@"+%@", _some_DownObj.upDown];
            _topView.upDownRangeLB.text = [NSString stringWithFormat:@"+%@", _some_DownObj.upDownRange];
        }else{
            color = [UIColor greenColor];
        }
        _topView.priceLB.textColor = color;
        _topView.upDownLB.textColor = color;
        _topView.upDownRangeLB.textColor = color;
        
//        [_topView.nameLB setFrame:CGRectMake(_topView.frame.origin.x, _topView.frame.origin.y, 200, _topView.frame.size.height)];
//        [_topView.nameLB sizeToFit];
//        _topView.nameLB.center

        
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_timer invalidate];//界面小时结束刷新
}

- (void)refreshAction
{
    //获取顶部View数据
    [self setPForTopDWithInterface:nil code:_symbolCode];//刷新顶部数据
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
