//
//  CentSetViewController.m
//  CNTJJY
//
//  Created by totrade on 16/2/15.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "CentSetViewController.h"

#import "CentSetMode.h"
#import "ShowToast.h"

@interface CentSetViewController ()<UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UISwitch *pushSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *nightSwitch;
@property (strong, nonatomic) IBOutlet UIButton *refreshLeftButton;
@property (strong, nonatomic) IBOutlet UIButton *refreshRightButton;
@property (strong, nonatomic) IBOutlet UIButton *cleanButton;
@property (strong, nonatomic) IBOutlet UILabel *refreshSecondsLB;

@property (nonatomic, assign)NSInteger seconds;


@property (nonatomic, strong)CentSetMode *centSetMode;//设置中心数据管理




@end

@implementation CentSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"设置";
    _pushSwitch.transform = CGAffineTransformMakeScale(0.9, 0.9);
    _nightSwitch.transform = CGAffineTransformMakeScale(0.9, 0.9);

    [_refreshLeftButton setImage:[UIImage imageNamed:@"leftArrowDid"] forState:UIControlStateHighlighted];
    [_refreshRightButton setImage:[UIImage imageNamed:@"rightArrowDid"] forState:UIControlStateHighlighted];
    
    self.cleanButton.titleLabel.textAlignment = NSTextAlignmentLeft ;
    //_centSetMode = [[CentSetMode alloc] init];

    [self setInterfaceValue];
    
    
}
- (IBAction)refreshLeftButtonAction:(UIButton *)sender {
    _seconds--;
    if (_seconds < 5) {
        _seconds = 5;
    }
    _centSetMode.refreshSeconds = [NSString stringWithFormat:@"%d秒", _seconds];
    _refreshSecondsLB.text = _centSetMode.refreshSeconds;
}
- (IBAction)refreshRightButtonAction:(UIButton *)sender {
    _seconds++;
    if (_seconds > 15) {
        _seconds = 15;
    }
    _centSetMode.refreshSeconds = [NSString stringWithFormat:@"%d秒", _seconds];
    _refreshSecondsLB.text = _centSetMode.refreshSeconds;
}

- (IBAction)pushSwitchAction:(UISwitch *)sender {
    _centSetMode.isPush = sender.on;
}

- (IBAction)nightSwitchAction:(UISwitch *)sender{
    
    _centSetMode.isNightMode = sender.on;
}

- (IBAction)recoverButton:(UIButton *)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你要恢复默认设置吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 10;
    [alertView show];
    
}
- (IBAction)cleanButton:(UIButton *)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你要清除所有缓存吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 11;
    [alertView show];


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

//为界面控件赋值
- (void)setInterfaceValue
{
    _centSetMode = [[CentSetMode alloc] init];
    _refreshSecondsLB.text = _centSetMode.refreshSeconds;
    _pushSwitch.on = _centSetMode.isPush;
    _nightSwitch.on = _centSetMode.isNightMode;
    
    _seconds = [[_centSetMode.refreshSeconds stringByReplacingOccurrencesOfString:@"秒" withString:@""] integerValue];
    

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
