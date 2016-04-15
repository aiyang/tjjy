//
//  TBackView.m
//  Study_KLine_2
//
//  Created by totrade on 16/1/20.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "UIColor+AddColor.h"


#define HH self.frame.size.height
#define WW self.frame.size.width

#import "TBackView.h"

#import "DatatTansfer.h"

#import "TLine.h"

#import "NightMode.h"


@interface TBackView ()

@property (nonatomic, strong)TLine *tline;

@property (nonatomic, strong)NightMode *nightMode;


@end

@implementation TBackView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _nightMode = [[NightMode alloc] init];
        self.backgroundColor = _nightMode.backGroundColor;
        
        
        for (NSInteger i = 0; i < 11; i++) {
            UILabel *leftlabel = [[UILabel alloc] init];
            leftlabel.tag = i+ 100;
            leftlabel.font = [UIFont systemFontOfSize:10];
            leftlabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:leftlabel];
            UILabel *rightlabel = [[UILabel alloc] init];
            rightlabel.tag = i+ 200;
            rightlabel.font = [UIFont systemFontOfSize:10];
            if (i < 5) {
                leftlabel.textColor = [UIColor redColor];
                rightlabel.textColor = [UIColor redColor];
            }else if (i == 5){
                leftlabel.textColor = _nightMode.tLabelColor;
                rightlabel.textColor = _nightMode.tLabelColor;
            }else if (i > 5){
                leftlabel.textColor = [UIColor greenColor];
                rightlabel.textColor = [UIColor greenColor];
            }

            [self addSubview:rightlabel];
        }
        
        for (NSInteger i = 0; i < 7; i++) {
            UILabel *bottomLabel = [[UILabel alloc] init];
            bottomLabel.tag = i+ 300;
            bottomLabel.font = [UIFont systemFontOfSize:10];
            bottomLabel.textColor = _nightMode.tLabelColor;
            

            [self addSubview:bottomLabel];
        }
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [self startTline];
    
      NSLog(@"---- %f",self.frame.size.height);
}



- (void)startTline
{
    if (!_tline) {
//        [self.tline removeFromSuperview];
         self.tline = [[TLine alloc] init];
        _tline.layer.cornerRadius = 1.0f;
        _tline.layer.masksToBounds = YES;
        _tline.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _tline.layer.borderWidth = 1.0f;
           [self addSubview:_tline];
    }
    [self.tline setFrame:CGRectMake(35, 10, WW - 70, HH - 30)];

    
    NSArray *bottomArr = @[@"06:00", @"10:00", @"14:00", @"18:00", @"22:00", @"02:00", @"06:00"];
    CGFloat x = 0.0f;
    CGFloat distancey = (self.frame.size.width - 70) / 6;
    for (NSInteger i = 0; i < 7; i++) {
        UILabel *bottomLabel = (UILabel *)[self viewWithTag:i + 300];
        [bottomLabel setFrame:CGRectMake(x + 15, HH - 20, 40, 20)];
        bottomLabel.text = [bottomArr objectAtIndex:i];
        x += distancey;
    }
   
    
    if (_y_Colse.length != 0) {
        if ([_y_Colse floatValue] <= 0) {
            self.tline.tTline_Arr = [DatatTansfer handleTLineDataWith:_dataArr With_W:WW - 70 with_H:HH - 30 yClose:_y_O];
        }else{
            self.tline.tTline_Arr = [DatatTansfer handleTLineDataWith:_dataArr With_W:WW - 70 with_H:HH - 30 yClose:_y_Colse];
        }
    }
    
    
    CGFloat y = 0.0f;
    CGFloat distancex = (HH - 30) / 10;//常量,即线与线之间的距离
    for (NSInteger i = 0; i < 11; i++) {
        UILabel *leftlabel = (UILabel *)[self viewWithTag:i + 100];
        [leftlabel setFrame:CGRectMake(0, y, 35, 20)];
        
        
        UILabel *rightlabel = (UILabel *)[self viewWithTag:i + 200];
        [rightlabel setFrame:CGRectMake(WW - 35, y, 35, 20)];
        
        NSArray *leftArr = [_tline.tTline_Arr objectAtIndex:1];
        NSArray *rightArr = [_tline.tTline_Arr objectAtIndex:2];
        
        if (leftArr.count != 0) {
            
            leftlabel.text = [NSString stringWithFormat:@"%@", [leftArr objectAtIndex:i]];
            if (leftlabel.text.length > 5) {
                for (NSInteger i = 0; i < 11; i++) {
                    UILabel *leftlabel = (UILabel *)[self viewWithTag:i + 100];
                    leftlabel.font = [UIFont systemFontOfSize:8.0f];
             }
            }
            
            if (leftlabel.text.length > 7) {
                for (NSInteger i = 0; i < 11; i++) {
                    UILabel *leftlabel = (UILabel *)[self viewWithTag:i + 100];
                    leftlabel.font = [UIFont systemFontOfSize:7.0f];
                }
            }
            
//            leftlabel.text = [NSString stringWithFormat:@"%.2f%%", [[leftArr objectAtIndex:i] floatValue]];
            leftlabel.text = [leftlabel.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
            
         
            rightlabel.text = [NSString stringWithFormat:@"%.2f%%", [[rightArr objectAtIndex:i] floatValue]];
            rightlabel.text = [rightlabel.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
   
        }
        
        
        y += distancex;
    }
    
    [self.tline setNeedsDisplay];

    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
