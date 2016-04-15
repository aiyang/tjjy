//
//  XCTimeSegControl.h
//  TsetUIObj
//
//  Created by totrade on 16/3/9.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

///产品详情界面的时间周期选择控件
#import <UIKit/UIKit.h>

@protocol XCTimeSegControlDelegate <NSObject>

///代理:选中某一周期,参数tkindex:代表该类创建的一个对象
- (void)indexButton:(id)tkindex index:(NSInteger)index;

@end

@interface XCTimeSegControl : UIView

@property (nonatomic, assign)id<XCTimeSegControlDelegate>delegate;

@end
