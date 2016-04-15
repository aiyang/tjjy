//
//  CustomAlertView.h
//  Study_Window
//
//  Created by totrade on 15/11/30.
//  Copyright © 2015年 CNPC. All rights reserved.
//

//自定义AlertView弹出框,在增加预警处使用
#import <UIKit/UIKit.h>

@protocol CustomAlertViewDelegate <NSObject>

- (void)customAlertViewAtIndex:(NSInteger)index output:(NSString *)output;

@end

@interface CustomAlertView : UIView

@property (nonatomic, assign)id<CustomAlertViewDelegate>delegete;

@property (strong, nonatomic) IBOutlet UIView *backView;


@property (nonatomic, strong)NSString *wLevel;



- (void)show;

- (void)disMiss;

@end
