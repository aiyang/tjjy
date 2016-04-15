//
//  AboutUsViewController.m
//  CNTJJY
//
//  Created by totrade on 16/3/7.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)NSArray *tableView_Arr;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];//是一个单例
//     NSString *tmpDir = NSTemporaryDirectory();
//    NSLog(@"%@", tmpDir);

//    NSLog(@"%@", [DataManage readUserDefaultsObjectforKey:@"addSel_Dic"]);
    
    
    self.navigationItem.title = @"关于我们";
    self.navigationController.navigationBarHidden = NO ;
    
    self.tableView_Arr = @[@"公司介绍", @"功能介绍", @"风险提示", @"微信公众号", @"版本号"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
    [self setTableViewSeparatorInset];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuse = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse];
        
    }
    UIView *view ;
    if (MAINSCREEN_WIDTH < MAINSCREEN_HEIGHT) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, MAINSCREEN_WIDTH, 0.5f)];
    }
    else{
         view = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, MAINSCREEN_HEIGHT, 0.5f)];
    }
    
    view.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:view];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    cell.textLabel.text = [self.tableView_Arr objectAtIndex:indexPath.row];
    if (indexPath.row == 4) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        cell.detailTextLabel.text = appVersion;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
