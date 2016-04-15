//1
//  AppDelegate.h
//  CNTJJY
//
//  Created by totrade on 16/1/12.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TabBarController.h"
#import "YRSideViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (nonatomic, strong)TabBarController *tabBar;
//抽屉效果
@property (strong,nonatomic) YRSideViewController *sideViewController;

@end

