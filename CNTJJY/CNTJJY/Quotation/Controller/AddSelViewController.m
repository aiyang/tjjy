//
//  AddSelViewController.m
//  CNTJJY
//
//  Created by totrade on 16/1/15.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#define SegH 40.0

#import "AddSelViewController.h"
#import "AddSelTableViewCell.h"
#import "AddSelTableViewHeaderView.h"

#import "LiveViewController.h"


#import "HYSegmentedControl.h"//顶部选择器

#import "DataManage.h"
#import "AddSelfSelect.h"

#import "SyCodeToExCode.h"

#import "OptionalSearchViewController.h"

@interface AddSelViewController ()<HYSegmentedControlDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)HYSegmentedControl *topSegmentedControl;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *tableView_Arr;
@property (nonatomic, strong)NSString *exchange_Str;//用户选择的交易所

@property (nonatomic, strong)AddSelfSelect *addSelfSelect;

@property (nonatomic, strong)SyCodeToExCode *syCodeToExCode;


@end

@implementation AddSelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"添加自选";
    
    //消除controller第一个视图是scrollView时自动偏移的影响
   
    UIView *cleanOffsetView ;
    if (MAINSCREEN_WIDTH > MAINSCREEN_HEIGHT) {
        cleanOffsetView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, 1)];
        
    }else{
        cleanOffsetView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, 1)];
    }
    [self.view addSubview:cleanOffsetView];
    
    _addSelfSelect = [[AddSelfSelect alloc] init];
    
    
    //导航栏右侧按钮
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.frame = CGRectMake(self.view.frame.size.width-35, 30, 25, 25) ;
    [rightButton setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBarAction:) forControlEvents:UIControlEventTouchUpInside];
   // rightButton = [UIButton buttonWithTitle:@"搜索" target:self action:@selector(rightBarAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    //    天矿所
    //    津贵所
    //    齐鲁商品
    //    上海金
    //    纸黄金
    //    国际外汇
    //    国际黄金
    self.topSegmentedControl = [[HYSegmentedControl alloc] initWithOriginY:64 Titles:@[@"天矿所", @"津贵所", @"齐鲁商品", @"上海金", @"纸黄金", @"国际外汇", @"国际黄金"] delegate:self] ;
    [self.view addSubview:_topSegmentedControl];
    
    
    
    if (MAINSCREEN_WIDTH > MAINSCREEN_HEIGHT) {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + SegH, MAINSCREEN_HEIGHT, MAINSCREEN_WIDTH - 64 - SegH) style:UITableViewStylePlain];
        
    }else{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + SegH, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT - 64 - SegH) style:UITableViewStylePlain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

    [self.tableView registerClass:[AddSelTableViewHeaderView class] forHeaderFooterViewReuseIdentifier:@"headerReuse"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AddSelTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    //调取默认值,默认天矿所
    [self setPForDWithInterface:HT_WANGGUAN code:@"TMRE"];
    self.exchange_Str = @"天矿所";
    
    
}

- (void)rightBarAction:(UIButton *)barButton
{
//    LiveViewController *liveVC = [[LiveViewController alloc] init];
//    liveVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:liveVC animated:YES];
     OptionalSearchViewController * searchVC = [[OptionalSearchViewController alloc]init];
    searchVC.view.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.75];
    searchVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:searchVC animated:YES completion:^{
        
    }];

   

}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    //準備搜尋前，把上面調整的TableView調整回全屏幕的狀態，如果要產生動畫效果，要另外執行animation代碼
    return YES;
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    //搜尋結束後，恢復原狀，如果要產生動畫效果，要另外執行animation代碼
    return YES;
}
#pragma mark Content Filtering
- (void)filterContentForSearchText:(NSString*)searchText
{
    
}
#pragma mark --UISearchBarDelegate 协议方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{

}
#pragma mark - UISearchDisplayController Delegate Methods
//当文本内容发生改变时候，向表视图数据源发出重新加载消息
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    [self filterContentForSearchText:searchString];
    return YES;
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
    AddSelTableViewHeaderView *headerView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerReuse"];
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
    AddSelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    cell.single_DownObj = [self.tableView_Arr objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    //选择哪一行,则增加某个商品
    SingleExchangeAllSymbolsInstantData_DownObj *single_DownObj = [self.tableView_Arr objectAtIndex:indexPath.row];
    
    //存储时,key为code,value为name
    //有空查一下setObject forKey和setValue forKey的区别
    if ([self.exchange_Str isEqualToString:@"齐鲁商品"]) {
//        NSArray *tempArr = [[dataManage.addSel_Dic objectForKey:@"ql"] allKeys];
//        if (![tempArr containsObject:single_DownObj.code]) {
//        [[dataManage.addSel_Dic objectForKey:@"ql"] setObject:single_DownObj.name forKey:single_DownObj.code];
//        }else if ([tempArr containsObject:single_DownObj.code]){
//        [[dataManage.addSel_Dic objectForKey:@"ql"] removeObjectForKey:single_DownObj.code];
//        }
        [_addSelfSelect setSelfSelectWith:single_DownObj interface:@"ql"];
    
    }else{
//        NSArray *tempArr = [[dataManage.addSel_Dic objectForKey:@"ht"] allKeys];
//        if (![tempArr containsObject:single_DownObj.code]) {
//        [[dataManage.addSel_Dic objectForKey:@"ht"] setObject:single_DownObj.name forKey:single_DownObj.code];
//        }else if ([tempArr containsObject:single_DownObj.code]){
//        [[dataManage.addSel_Dic objectForKey:@"ht"] removeObjectForKey:single_DownObj.code];
//        }
        [_addSelfSelect setSelfSelectWith:single_DownObj interface:@"ht"];
    }
    
    
}

//顶部选择器代理方法
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    NSLog(@"%d",index);
    self.tableView_Arr = [NSArray array];
    
#warning 要学会使用switch语句,虽然没什么卵用
    //         0        1         2         3          4         5         6
    //    @[@"天矿所", @"津贵所", @"齐鲁商品", @"上海金", @"纸黄金", @"国际外汇", @"国际黄金"]
    
    //     0        1         2         3          4         5         6           7
    //    @[@"自选", @"天矿所", @"津贵所", @"齐鲁商品", @"上海金", @"纸黄金", @"国际外汇", @"国际黄金"]
    //                TMRE     TJPME    QILUCE      SGE       PGOLD     MT4         WGJS
    
    switch (index) {
        case 0:{
            [self setPForDWithInterface:HT_WANGGUAN code:@"TMRE"];
            NSLog(@"天矿所");
            self.exchange_Str = @"天矿所";
            break;//假若给case加个大括号,那么break放在大括号里面或者外面都可以
        }
        case 1:{
            [self setPForDWithInterface:HT_WANGGUAN code:@"TJPME"];
            self.exchange_Str = @"津贵所";
            NSLog(@"津贵所");
            break;
        }
        case 2:{
            [self setPForDWithInterface:QL_WANGGUAN code:@"QILUCE"];
            self.exchange_Str = @"齐鲁商品";
            NSLog(@"齐鲁商品");
            break;
        }
        case 3:{
            [self setPForDWithInterface:HT_WANGGUAN code:@"SGE"];
            self.exchange_Str = @"上海金";
            NSLog(@"上海金");
            break;
        }
        case 4:{
            [self setPForDWithInterface:HT_WANGGUAN code:@"PGOLD"];
            self.exchange_Str = @"纸黄金";
            NSLog(@"纸黄金");
            break;
        }
        case 5:{
            [self setPForDWithInterface:HT_WANGGUAN code:@"MT4"];
            self.exchange_Str = @"国际外汇";
            NSLog(@"国际外汇");
            break;
        }
        case 6:{
            [self setPForDWithInterface:HT_WANGGUAN code:@"WGJS"];
            self.exchange_Str = @"国际黄金";
            NSLog(@"国际黄金");
            break;
        }
        default:
            break;
    }
    
    
    [self.tableView reloadData];
    
    
}

- (void)setPForDWithInterface:(NSString *)interface code:(NSString *)code
{
    [DataManage singleExchangeAllSymbolsInstantDataWithInterface:interface code:code success:^(id responseObject) {
    
        self.tableView_Arr = responseObject;
        [self.tableView reloadData];
        
        //建立商品code和交易所code一一对应关系

            _syCodeToExCode = [[SyCodeToExCode alloc] init];
            //这里行不行呢?
            for (SingleExchangeAllSymbolsInstantData_DownObj *singel_DownObj in _tableView_Arr) {
                if (_tableView_Arr.count != 0) {
                    [_syCodeToExCode setSyC:singel_DownObj.code toExC:code];
                }
            }
        
            
        
    } failure:^(NSError *error) {
        
    }];
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
