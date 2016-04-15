//
//  TBackView.h
//  Study_KLine_2
//
//  Created by totrade on 16/1/20.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBackView : UIView

@property (nonatomic, strong)NSArray *dataArr;
@property (nonatomic, strong)NSString *y_Colse;
@property (nonatomic, strong)NSString *y_O;

- (void)startTline;


@end
