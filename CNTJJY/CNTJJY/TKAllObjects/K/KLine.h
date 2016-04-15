//
//  KLine.h
//  Study_KLine_2
//
//  Created by totrade on 16/1/19.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//


//我感觉这个类纯粹是用来画图的,即各种图表:分时图,K线主图,K线副图,但是一定有一个View是用来承载这个View的,这个View除了加载本类还有其他的一些东西,例如x,y轴的显示,长按十字线等
#import <UIKit/UIKit.h>

typedef enum {
    theMajor = 0,
    theMinor,
}BackPic;

typedef enum {
    TheMA = 0,
    TheBOLL
}THEMajorLine;

typedef NS_ENUM(NSInteger, THEMinorLine){
    TheMACD = 0,
    TheKDJ,
    TheRSI,
    TheBIAS,
    TheCCI,
    ThePSY,
    TheObv,
    TheVol
};


typedef void(^PassIndValue)(id value);

@interface KLine : UIView

@property (nonatomic, copy)PassIndValue passIndValue;

- (void)setWithDataArr:(NSArray *)dataArr
               backPic:(BackPic)backPic
                cWidth:(CGFloat)cWidth
                cCount:(NSInteger)cCount
                   loc:(NSInteger)location
             majorLine:(THEMajorLine)theMajarline
             minorLine:(THEMinorLine)theMinorline;



@end
