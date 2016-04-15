//
//  XCIndsSegControl.h
//  TsetUIObj
//
//  Created by totrade on 16/3/7.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

///产品详情界面的指标选择控件
#import <UIKit/UIKit.h>

@protocol XCIndsSegControlDelegate <NSObject>

///代理:选中某一周期,参数tkindex:代表该类创建的一个对象,isSet:选中的是否为设置按钮
- (void)indexButton:(id)tkindex index:(NSInteger)index isSet:(BOOL)isSet;

@end

@interface XCIndsSegControl : UIView

@property (nonatomic, assign)id<XCIndsSegControlDelegate>delegate;

- (instancetype)initWithType:(NSInteger)type delegate:(id)delegate;

@end
