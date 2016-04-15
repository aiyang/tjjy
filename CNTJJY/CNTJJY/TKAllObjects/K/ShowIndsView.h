//
//  ShowIndsView.h
//  CNTJJY
//
//  Created by totrade on 16/2/20.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ShowIndType){
    indMACD = 0,
    indKDJ,
    indRSI,
    indBIAS,
    indCCI,
    indPSY,
    indOBV,
    indVOL
};


//用于副图显示指标的
@interface ShowIndsView : UIView

- (void)setAllValuesWithArray:(NSArray *)array index:(NSInteger)index type:(ShowIndType)type;

@end
