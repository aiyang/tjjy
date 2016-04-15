//
//  OptionalSearchViewController.m
//  CNTJJY
//
//  Created by iOS on 16/4/13.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "OptionalSearchViewController.h"
#import "AddSelTableViewCell.h"


#import "AFNetworking.h"
#import "SearchModel.h"

#import "AddSelfSelect.h"

@interface OptionalSearchViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    UITableView * searchTableView ;
    UITextField * searchFil ;
    CGFloat SW ;
    CGFloat SH ;
}

@property (nonatomic ,strong) NSMutableArray * dataArray ;
@property (nonatomic ,strong) NSMutableArray * searchArray ;
@property (nonatomic, strong)AddSelfSelect *addSelfSelect;

@end

@implementation OptionalSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.view.frame.size.width>self.view.frame.size.height) {
        SW = self.view.frame.size.height ;
        SH = self.view.frame.size.width ;
    }else{
        SW = self.view.frame.size.width ;
        SH = self.view.frame.size.height ;
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _addSelfSelect = [[AddSelfSelect alloc] init];
    
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 64)];
    navView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.95 alpha:1.0];
    [self.view addSubview:navView];
    
    searchFil = [[UITextField alloc]initWithFrame:CGRectMake(40, 28, SW-90, 30)];
    searchFil.backgroundColor = [UIColor whiteColor];
    searchFil.delegate = self ;
    UIImageView * leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    leftImageView.image = [UIImage imageNamed:@"search"];
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(10, 28, 30, 30)];
    [leftView addSubview:leftImageView] ;
    leftView.backgroundColor = [UIColor whiteColor];
    [navView addSubview:leftView];
    //searchFil.leftViewMode = UITextFieldViewModeAlways;
    //searchFil.leftView = leftView ;
    [searchFil addTarget:self action:@selector(searchFilCilck:) forControlEvents:UIControlEventEditingChanged];
    searchFil.placeholder = @"请输入品种名称或代码" ;
    searchFil.clearButtonMode = UITextFieldViewModeWhileEditing;
    [navView addSubview:searchFil];
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.frame = CGRectMake(SW-40, 28, 30, 30);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithWhite:0.3f alpha:1.0f] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:cancelBtn];
    
    searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    searchTableView.delegate = self ;
    searchTableView.dataSource = self ;
    searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [searchTableView registerNib:[UINib nibWithNibName:@"AddSelTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [self.view addSubview:searchTableView];

    
    _dataArray = [[NSMutableArray alloc]init];
    _searchArray = [[NSMutableArray alloc]init];
    
    NSString * url = @"http://103.25.42.173:8034/api/codeclassinfo?s=all" ;
    
    [DataManage optionalSearchRequest:url success:^(id responseObject) {
        NSArray * array = (NSArray *)responseObject ;
        for (int i = 0; i<array.count ; i++) {
            NSDictionary * dic = array[i];
            SearchModel * model = [SearchModel modelObjectWithDictionary:dic];
            [_dataArray addObject:model];
            
        }

    } failure:^(NSError *error) {
        [ShowToast showInBackMessage:@"请检查网络"];
    }] ;
   
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}







- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _searchArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddSelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    SearchModel *model = [self.searchArray objectAtIndex:indexPath.row];
    cell.single_DownObj.code = model.symbolCode ;
    cell.single_DownObj.name = model.symbolName ;
    cell.exch_name = model.exchName ;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //选择哪一行,则增加某个商品

    
    AddSelTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //存储时,key为code,value为name
    //有空查一下setObject forKey和setValue forKey的区别
    if ([cell.exch_name isEqualToString:@"齐鲁所"]) {
        //        NSArray *tempArr = [[dataManage.addSel_Dic objectForKey:@"ql"] allKeys];
        //        if (![tempArr containsObject:single_DownObj.code]) {
        //        [[dataManage.addSel_Dic objectForKey:@"ql"] setObject:single_DownObj.name forKey:single_DownObj.code];
        //        }else if ([tempArr containsObject:single_DownObj.code]){
        //        [[dataManage.addSel_Dic objectForKey:@"ql"] removeObjectForKey:single_DownObj.code];
        //        }
        [_addSelfSelect setSelfSelectWith:cell.single_DownObj interface:@"ql"];
        
    }else{
        //        NSArray *tempArr = [[dataManage.addSel_Dic objectForKey:@"ht"] allKeys];
        //        if (![tempArr containsObject:single_DownObj.code]) {
        //        [[dataManage.addSel_Dic objectForKey:@"ht"] setObject:single_DownObj.name forKey:single_DownObj.code];
        //        }else if ([tempArr containsObject:single_DownObj.code]){
        //        [[dataManage.addSel_Dic objectForKey:@"ht"] removeObjectForKey:single_DownObj.code];
        //        }
        [_addSelfSelect setSelfSelectWith:cell.single_DownObj interface:@"ht"];
    }
    
    
}


-(void)viewDidAppear:(BOOL)animated{

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES ;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
   // NSLog(@"11111111");
    return YES ;
}
-(void)searchFilCilck:(UITextField *)textF{
    NSLog(@"===== %@",textF.text);
    if (_dataArray.count!=0) {
      
        [_searchArray removeAllObjects];
        for (int i = 0; i<_dataArray.count ; i++) {
            SearchModel * model = _dataArray[i];
            if([model.symbolName rangeOfString:textF.text options:NSCaseInsensitiveSearch].location !=NSNotFound){
                //NSLog(@"---- %@",model.symbolName);
                [_searchArray addObject:model];
               // continue ;
                
            }
            else if([model.symbolCode rangeOfString:textF.text options:NSCaseInsensitiveSearch].location !=NSNotFound) {
                [_searchArray addObject:model];

            }
        }
        
        searchTableView.frame = CGRectMake(0, 64,SW, SH-64);
        if (_searchArray.count == 0) {
            searchTableView.frame = CGRectMake(0, 64, 0, 0);
        }
        
        
        [searchTableView reloadData];
    }else{
        searchTableView.frame = CGRectMake(0, 64, 0, 0);
        [searchTableView reloadData];

    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
   // NSLog(@"------ %@ --- %@",textField.text,searchFil.text);
    NSLog(@"array  ==  %d",_dataArray.count);
    
    return  YES ;
}


-(void)cancelBtnCilck{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self dismissViewControllerAnimated:YES completion:^{
        
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
