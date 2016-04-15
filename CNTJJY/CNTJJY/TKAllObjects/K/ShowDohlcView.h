//
//  ShowDohlcView.h
//  CNTJJY
//
//  Created by totrade on 16/2/20.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import <UIKit/UIKit.h>

//用于长按手势后出现的显示日期开高低收的View
@interface ShowDohlcView : UIView

- (void)setAllLabelValueWithDateArr:(NSArray *)dateArr candleArr:(NSArray *)candleArr index:(NSInteger)index;

@end
