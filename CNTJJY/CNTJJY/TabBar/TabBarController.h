//
//  TabBarController.h
//  CNTJJY
//
//  Created by totrade on 16/1/12.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QuotViewController.h"
#import "NewsViewController.h"
#import "DiscoverViewController.h"
#import "LiveViewController.h"
#import "CentViewController.h"

@interface TabBarController : UITabBarController

@property (nonatomic, strong)QuotViewController *quotVC;
@property (nonatomic, strong)NewsViewController *newsVC;
@property (nonatomic, strong)DiscoverViewController *discoverVC;
@property (nonatomic, strong)LiveViewController *liveVC;
@property (nonatomic, strong)CentViewController *centVC;

@end
