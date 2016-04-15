//
//  TabBarController.m
//  CNTJJY
//
//  Created by totrade on 16/1/12.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "TabBarController.h"
#import "CustomNavigationController.h"
#import "DetailViewController.h"




@interface TabBarController ()

@end

@implementation TabBarController

// 支持设备自动旋转
- (BOOL)shouldAutorotate
{
    return NO;
}

//支持设备旋转的方向
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //NSLog(@"-*-*-    %@",[[self.viewControllers lastObject] supportedInterfaceOrientations]);
  //  return UIInterfaceOrientationMaskPortrait ;
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
    
}

//当前viewcontroller默认的屏幕方向
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.quotVC = [[QuotViewController alloc] init];
    CustomNavigationController *qutoNC = [[CustomNavigationController alloc] initWithRootViewController:_quotVC];
    
//    self.newsVC = [[NewsViewController alloc] init];
//    CustomNavigationController *newsNC = [[CustomNavigationController alloc] initWithRootViewController:_newsVC];
    
    self.liveVC = [[LiveViewController alloc] init];
    CustomNavigationController *liveNC = [[CustomNavigationController alloc] initWithRootViewController:_liveVC];
    
    self.discoverVC = [[DiscoverViewController alloc]init];
    CustomNavigationController *discoverNC = [[CustomNavigationController alloc]initWithRootViewController:_discoverVC];
    
    self.centVC = [[CentViewController alloc] init];
    CustomNavigationController *centNC = [[CustomNavigationController alloc] initWithRootViewController:_centVC];
    
    qutoNC.tabBarItem.title = @"行情";
    liveNC.tabBarItem.title = @"直播";
    
    discoverNC.tabBarItem.title = @"发现";
    centNC.tabBarItem.title = @"个人中心";
    
    
    
    //qutoNC.tabBarItem.imageInsets = UIEdgeInsetsMake(2, 2, 2, 2);
    UIImage *qutoImage = [self reSizeImage:[UIImage imageNamed:@"hq"]] ;
    qutoNC.tabBarItem.image = qutoImage;
    UIImage *liveImage = [self reSizeImage:[UIImage imageNamed:@"zb"]] ;
    liveNC.tabBarItem.image = liveImage;
    UIImage *centImage =[self reSizeImage:[UIImage imageNamed:@"grzx"]] ;
    centNC.tabBarItem.image = centImage;
    UIImage *discoverImage = [self reSizeImage:[UIImage imageNamed:@"fx"]] ;
    discoverNC.tabBarItem.image = discoverImage;
    
//    qutoNC.tabBarItem.selectedImageInsets = UIEdgeInsetsMake(2, 2, 2, 2);
    

        
        
       // selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//图片按照原样渲染
       // normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
       // if (SystemVersion<= 7.1) {//适配，解决图片在7.1 以下 不自适应
       //     self.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    
            
      //  }
       
   
    UIImage *qutoImage1 = [self reSizeImage:[UIImage imageNamed:@"hq1"]] ;
    qutoNC.tabBarItem.selectedImage = qutoImage1;
    UIImage *liveImage1 = [self reSizeImage:[UIImage imageNamed:@"zb1"]] ;
    liveNC.tabBarItem.selectedImage = liveImage1;
    UIImage *centImage1 =[self reSizeImage:[UIImage imageNamed:@"grzx1"]] ;
    centNC.tabBarItem.selectedImage = centImage1;
    UIImage *discoverImage1 = [self reSizeImage:[UIImage imageNamed:@"fx1"]] ;

    discoverNC.tabBarItem.selectedImage = discoverImage1 ;
    
    self.quotVC.navigationItem.title = @"行情";
    self.discoverVC.navigationItem.title = @"发现";
    self.newsVC.navigationItem.title = @"直播";
    //    self.centVC.navigationItem.title = @"个人中心";
    
    self.tabBar.tintColor = [UIColor orangeColor];
    
    
    CGRect frame = CGRectMake(0.0, 0, self.view.frame.size.width, 49);
    UIView *v = [[UIView alloc] initWithFrame:frame];
    //[v setBackgroundColor:[UIColor colorFromHexCode:@"#4e4e4e"]];
    v.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f] ;
    [self.tabBar insertSubview:v atIndex:0];
    
    self.viewControllers = @[qutoNC, liveNC, discoverNC ,centNC];
    
    
    //设置所有返回键//模态推出的界面不受此控制
    UIImage* image = [UIImage imageNamed:@"back"];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(10, image.size.width, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-400.f, 0) forBarMetrics:UIBarMetricsDefault];
    
}

// 缩小图片
- (UIImage *)reSizeImage:(UIImage *)image{
    CGSize imageSize = image.size ;
    CGFloat imageW = imageSize.width-4 ;
    CGFloat imageH = imageSize.height-4 ;
    UIGraphicsBeginImageContext(CGSizeMake(imageW,imageH));
    [image drawInRect:CGRectMake(0, 0, imageW, imageH)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage ;

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
