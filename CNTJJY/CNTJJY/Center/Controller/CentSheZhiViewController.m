//
//  CentSheZhiViewController.m
//  CNTJJY
//
//  Created by iOS on 16/4/12.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "CentSheZhiViewController.h"

#import "CentSheZhiTableViewCell.h"

#import "CentSheZhiTableViewCell2.h"

#import "CenSheZhiTableViewCell3.h"

#import "CentSetMode.h"

@interface CentSheZhiViewController ()<UITableViewDelegate ,UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView * setTableView ;
}
@property (nonatomic, strong)CentSetMode *centSetMode;

@property (nonatomic, assign)NSInteger seconds;

@end

@implementation CentSheZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //_centSetMode = [[CentSetMode alloc] init];
    self.navigationItem.title = @"设置";
    self.navigationController.navigationBarHidden = NO ;
    [self setInterfaceValue];
    
    
    if (self.view.frame.size.width>self.view.frame.size.height) {
        setTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width) style:UITableViewStylePlain];
    }else{
        setTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    }
    setTableView.backgroundColor = [UIColor colorWithWhite:0.93f alpha:1.0f];
    setTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    [setTableView registerClass:[CentSheZhiTableViewCell class] forCellReuseIdentifier:@"centerSetCell"];
    setTableView.delegate = self ;
    setTableView.dataSource = self ;
    [self.view addSubview:setTableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1 ){
        return 2 ;
        
    }
    return 1 ;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4 ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CentSheZhiTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"centerSetCell" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",@"行情刷新频率",_centSetMode.refreshSeconds] ;
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
        [cell.leftBtn addTarget:self action:@selector(leftBtnCilck:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightBtn addTarget:self action:@selector(rightBtnCilck:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell ;
    }
    if (indexPath.section == 1) {
        NSString * str = [NSString stringWithFormat:@"CentSheZhiTableViewCell2%ld%ld",(long)indexPath.section,(long)indexPath.row];
        CentSheZhiTableViewCell2 * cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[CentSheZhiTableViewCell2 alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
            cell.kaiGuan.tag = indexPath.row + 10086 ;
            [cell.kaiGuan addTarget:self action:@selector(swiftCilck:) forControlEvents:UIControlEventValueChanged];

        }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"推送消息" ;
            cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
            cell.kaiGuan.on = _centSetMode.isPush ;
        }
        else{
            cell.textLabel.text = @"开启夜间模式";
            cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
            cell.kaiGuan.on = _centSetMode.isNightMode ;
        }
        return cell ;
        }
    if (indexPath.section == 2) {
        CenSheZhiTableViewCell3 * cell = [tableView dequeueReusableCellWithIdentifier:@"CenSheZhiTableViewCell3"];
        if (cell == nil) {
            cell = [[CenSheZhiTableViewCell3 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CenSheZhiTableViewCell3"];
            
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
        if ([CentSetMode cacheSize]<10.0f ) {
            cell.cacheLabel.text = [NSString stringWithFormat:@"%.2fK",[CentSetMode cacheSize]];
        }
        else{
             cell.cacheLabel.text = [NSString stringWithFormat:@"%.2fM",[CentSetMode cacheSize]/1000.0];
        }
        cell.cacheLabel.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f] ;
        cell.textLabel.text = @"清理缓存" ;
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
        return cell ;
    }
    
    else {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
        }
        cell.textLabel.text = @"恢复默认" ;
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
        cell.textLabel.textAlignment = NSTextAlignmentCenter ;
        return cell ;
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10 ;
}

-(void)leftBtnCilck:(UIButton *)btn{
    NSLog(@"---%@",[btn superview]);
    CentSheZhiTableViewCell * cell = (CentSheZhiTableViewCell *)[btn superview];
    _seconds--;
    if (_seconds < 5) {
        _seconds = 5;
    }
    _centSetMode.refreshSeconds = [NSString stringWithFormat:@"%ld秒", (long)_seconds];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",@"行情刷新频率",_centSetMode.refreshSeconds] ;
}



-(void)rightBtnCilck:(UIButton *)btn{
    CentSheZhiTableViewCell * cell = (CentSheZhiTableViewCell *)[btn superview];

    _seconds++;
    if (_seconds > 15) {
        _seconds = 15;
    }
    _centSetMode.refreshSeconds = [NSString stringWithFormat:@"%ld秒", (long)_seconds];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",@"行情刷新频率",_centSetMode.refreshSeconds] ;
}

-(void)swiftCilck:(UISwitch *)sender{
    if (sender.tag == 10086) {
        _centSetMode.isPush = sender.on;
    }
    else{
        _centSetMode.isNightMode = sender.on;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你要清除所有缓存吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 11;
        [alertView show];
    }
    if (indexPath.section == 3) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你要恢复默认设置吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 10;
        [alertView show];

    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10) {//恢复默认设置
        if (buttonIndex == 1) {
            [_centSetMode recover];
            [self setInterfaceValue];//重新为界面赋值
            
            [ShowToast showInBackMessage:@"恢复完成"];
        }
        
    }else if (alertView.tag == 11){//清除缓存
        if (buttonIndex == 1) {
            [_centSetMode clean];
            [self setInterfaceValue];//重新为界面赋值
            
            [ShowToast showInBackMessage:@"清除完成"];
            
        }
        
    }
}


- (void)setInterfaceValue
{
    _centSetMode = [[CentSetMode alloc] init];
    _seconds = [[_centSetMode.refreshSeconds stringByReplacingOccurrencesOfString:@"秒" withString:@""] integerValue];
    [setTableView reloadData];
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
