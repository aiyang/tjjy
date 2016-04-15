//
//  GuideInterface.h
//  Study_GiideInterface
//
//  Created by totrade on 16/3/6.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

//引导页控件
#import <UIKit/UIKit.h>

@interface GuideInterface : UIView


- (void)setShowPageWithImageArray:(NSArray *)array;

- (void)guideInterfaceButtonTarget:(id)target action:(SEL)action;

- (void)show;
- (void)disMiss;


@end
