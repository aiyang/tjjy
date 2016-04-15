//
//  AddWarningView.m
//  CNTJJY
//
//  Created by totrade on 16/1/28.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "AddWarningView.h"
#import "TimeTools.h"


@interface AddWarningView ()



@end

@implementation AddWarningView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //这种方法
        [self setXib];
        
        
        
        
    }
    return self;
}



//感觉这种方法更好
- (void)setXib
{
    UIView *containerView = [[[UINib nibWithNibName:@"AddWarningView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
    containerView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    containerView.backgroundColor = [UIColor blackColor];
    [self addSubview:containerView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    _priceLB.text = _some_DownObj.c;
//    _upDownLB.text = _some_DownObj.upDown;
//    _upDownRangeLB.text = _some_DownObj.upDownRange;
    
//    if ([_some_DownObj.c floatValue] > [_some_DownObj.yclose floatValue]) {
//        [self changeRed];
//    }else{
//        [self changeGreen];
//    }
//
//    
    
}

- (void)changeGreen
{
    self.priceLB.textColor = [UIColor greenColor];
    self.upDownLB.textColor = [UIColor greenColor];
    self.upDownRangeLB.textColor = [UIColor greenColor];
    
}

- (void)changeRed
{
    self.priceLB.textColor = [UIColor redColor];
    self.upDownLB.textColor = [UIColor redColor];
    self.upDownRangeLB.textColor = [UIColor redColor];
}




//
//+(AddWarningView *)instanceAddWarningView
//{
//    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"AddWarningView" owner:nil options:nil];
//    return [nibView objectAtIndex:0];
//    
//}

//有空研究下这两种方法在类中创建和在autoLayout中创建以及是设置view的class还是设置FilesOwner以及同时设置的的区别,还有直接拖拽成属性的区别

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
