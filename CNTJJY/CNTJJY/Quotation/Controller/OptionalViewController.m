//
//  OptionalViewController.m
//  CNTJJY
//
//  Created by iOS on 16/4/8.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "OptionalViewController.h"
#define SegH 40.0

#import "QuotTableViewCell.h"
#import "QuotTableViewHeaderView.h"
#import "AddSelfSelect.h"//自选类
#import "SomeSymbolsInstantData_DownObj.h"
#import "CustomNavigationController.h"
#import "DetailViewController.h"
#import "AddSelViewController.h"
#import "CentSetMode.h"


@interface OptionalViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *rightButton ;
}
@property (nonatomic, strong)AddSelfSelect *addSelfSelect;
@property (nonatomic, strong)NSMutableDictionary *addSelDataDic;
@property (nonatomic, strong)UITableView * OptionalTableView ;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)CentSetMode *centSetMode;

@end

@implementation OptionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的自选";
    
    self.view.backgroundColor = [UIColor whiteColor];
    _centSetMode = [[CentSetMode alloc] init];
    CGFloat refreshTime = [_centSetMode.refreshSeconds floatValue];
    _timer = [NSTimer scheduledTimerWithTimeInterval:refreshTime target:self selector:@selector(refreshAction) userInfo:nil repeats:YES];
    [_timer fire];

    
    
    if (MAINSCREEN_WIDTH>MAINSCREEN_HEIGHT) {
        _OptionalTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,  0, MAINSCREEN_HEIGHT, MAINSCREEN_WIDTH - 64) style:UITableViewStylePlain];
    }else{
        _OptionalTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,  0, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    }
    _OptionalTableView.delegate = self;
    _OptionalTableView.dataSource = self;
    _OptionalTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_OptionalTableView];
    
    [_OptionalTableView registerClass:[QuotTableViewHeaderView class] forHeaderFooterViewReuseIdentifier:@"headerReuse"];
    [_OptionalTableView registerNib:[UINib nibWithNibName:@"QuotTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    //_OptionalTableView.backgroundColor = [UIColor redColor];
    
    UIButton *addSelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    addSelButton.layer.cornerRadius = 3.0f;
    addSelButton.layer.masksToBounds = YES;

    [addSelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addSelButton.backgroundColor = [UIColor colorFromHexCode:@"#FF5322"];
    
    if (MAINSCREEN_WIDTH>MAINSCREEN_HEIGHT) {
        addSelButton.frame = CGRectMake(20, MAINSCREEN_WIDTH - 50, MAINSCREEN_HEIGHT - 40, 40);
    }else{
        addSelButton.frame = CGRectMake(20, MAINSCREEN_HEIGHT - 50, MAINSCREEN_WIDTH - 40, 40);
    }
    [addSelButton setTitle:@"添加自选" forState:UIControlStateNormal];
    [addSelButton addTarget:self action:@selector(addSelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addSelButton];

    rightButton = [UIButton buttonWithTitle:@"编辑" target:self action:@selector(rightBarAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];

    [self refreshAction];
    
}


-(void)refreshAction{
    
    _addSelDataDic = [NSMutableDictionary dictionary];
    _addSelfSelect = [[AddSelfSelect alloc] init];//初始化
    [self requestDataWithTag:0 interface:QL_WANGGUAN exCode:nil syCodes:[[_addSelfSelect.addSelDic objectForKey:@"ql"] allKeys]];
    [self requestDataWithTag:0 interface:HT_WANGGUAN exCode:nil syCodes:[[_addSelfSelect.addSelDic objectForKey:@"ht"] allKeys]];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self refreshAction];
}


- (void)addSelAction:(UIButton *)button
{
    AddSelViewController *addSelVC = [[AddSelViewController alloc] init];
    addSelVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addSelVC animated:YES];
}




- (void)requestDataWithTag:(NSInteger)tag interface:(NSString *)interface exCode:(NSString *)exchCode syCodes:(NSArray *)symbolsCodes
{
    self.tableView_Arr = [NSMutableArray array];
    [_OptionalTableView reloadData];
    [DataManage requestDataByTag:@(tag) interface:interface exCode:exchCode syCodes:symbolsCodes success:^(id responseObject) {

        NSNumber *key = nil;
        
      //  NSLog(@"--**--- %@",[responseObject allKeys]);
        for (id subKey  in [responseObject allKeys]) {
            if ([subKey isKindOfClass:[NSNumber class]]) {
                key = subKey;
            }
        }
        NSArray *arr=[NSArray array];
        
        arr = [responseObject objectForKey:key];
        
        if (0 == [key integerValue]) {
            
            NSMutableArray *sumSyCodesArray = [NSMutableArray array];
            [sumSyCodesArray addObjectsFromArray:[[_addSelfSelect.addSelDic objectForKey:@"ql"] allKeys]];
            [sumSyCodesArray addObjectsFromArray:[[_addSelfSelect.addSelDic objectForKey:@"ht"] allKeys]];
            
            for (NSInteger i = 0; i < arr.count; i++) {
                SomeSymbolsInstantData_DownObj *some_DownObj = arr[i];
                if ([sumSyCodesArray containsObject:some_DownObj.code]) {
                    [_addSelDataDic setObject:some_DownObj forKey:some_DownObj.code];
                }
            }
            _tableView_Arr = [NSMutableArray arrayWithArray:[_addSelDataDic allValues]];
            [_OptionalTableView reloadData];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    QuotTableViewHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerReuse"];
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
    
    QuotTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
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
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  UITableViewCellEditingStyleDelete ;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
      SingleExchangeAllSymbolsInstantData_DownObj *single_DownObj = [self.tableView_Arr objectAtIndex:indexPath.row];

        [_addSelfSelect setSelfSelectWith:single_DownObj interface:nil];
        
        [self.tableView_Arr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
- (void)rightBarAction:(UIButton *)barButton{
    if (_OptionalTableView.editing == YES ) {
        _OptionalTableView.editing = NO ;
        [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    }
    else{
        _OptionalTableView.editing = YES ;
        
        [rightButton setTitle:@"完成" forState:UIControlStateNormal];

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
