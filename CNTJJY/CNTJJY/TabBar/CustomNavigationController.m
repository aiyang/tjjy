//
//  CustomNavigationController.m
//  Study_PortraitLandscape_6
//
//  Created by totrade on 16/2/21.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "CustomNavigationController.h"
#import "DetailViewController.h"


@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

// 支持设备自动旋转
- (BOOL)shouldAutorotate
{
    if ([self.topViewController isKindOfClass:[DetailViewController class]]) { // 如果是这个 vc 则支持自动旋转
        DataManage *dataManage = [DataManage shareInstance];
        return dataManage.isGravity;
    }else{
        return NO;
    }
}

//支持设备旋转的方向
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    NSLog(@"------ %@",[self.viewControllers lastObject]) ;

    if ([self.topViewController isKindOfClass:[DetailViewController class]]) {
        return [[self.viewControllers lastObject] supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskPortrait ;
    
}



//当前viewcontroller默认的屏幕方向
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self ;
    // Do any additional setup after loading the view.
    
//    self.navigationBar.tintColor = [UIColor whiteColor];//字体颜色?
    self.navigationBar.barTintColor = [UIColor blackColor];//背景颜色?
    
    
    ////    self.navigationController.navigationBar.backgroundColor = [UIColor cyanColor];//不能这么设置
    //    self.navigationController.navigationBar.barTintColor = [UIColor cyanColor];
    
    //    控制导航栏的模糊效果
//        self.navigationBar.translucent = NO;//打开关闭模糊属性//模糊与否影响坐标
//
//    self.navigationBar.backgroundColor = [UIColor blackColor];
    
//    //改变title颜色
//    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                                     [UIColor whiteColor], UITextAttributeTextColor,
//                                                                     [UIColor whiteColor], UITextAttributeTextShadowColor,
//                                                                     [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
//                                                                     [UIFont fontWithName:@"Arial-Bold" size:0.0], UITextAttributeFont,
//                                                                     nil]];
    
    //改变title颜色
    [self.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    
//    UITableView 

    
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
