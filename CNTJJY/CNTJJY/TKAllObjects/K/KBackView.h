//
//  KBackView.h
//  Study_KLine_2
//
//  Created by totrade on 16/1/20.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface KBackView : UIView

@property (nonatomic, assign)id target;
@property (nonatomic, strong)NSArray *dataArr;//接收原始数据
@property (nonatomic, assign)NSInteger majorIndex;
@property (nonatomic, assign)NSInteger minorIndex;

- (void)startKline;

@end
