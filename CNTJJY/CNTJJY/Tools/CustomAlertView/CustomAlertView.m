//
//  CustomAlertView.m
//  Study_Window
//
//  Created by totrade on 15/11/30.
//  Copyright © 2015年 CNPC. All rights reserved.
//

#import "CustomAlertView.h"

#import "AppDelegate.h"

@interface CustomAlertView ()


@property (strong, nonatomic) IBOutlet UIButton *sureButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) IBOutlet UITextField *inputTF;

@end

@implementation CustomAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        [self setXib];
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        
        [self.backView.layer setMasksToBounds:YES];
       // [self.backView.layer setCornerRadius:10.0]; //设置矩圆角半径
//        [self.backView.layer setBorderWidth:0.0];   //边框宽度

        [self.sureButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.sureButton.tag = 10;
        [self.cancelButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.cancelButton.tag = 11;
        [self.deleteButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.deleteButton.tag = 12;
        
        self.inputTF.keyboardType = UIKeyboardTypeDecimalPad;
        [self.inputTF.layer setCornerRadius:0.0f];
        
        [self.sureButton.layer setMasksToBounds:YES];
        //[self.sureButton.layer setCornerRadius:10.0];
        [self.cancelButton.layer setMasksToBounds:YES];
       // [self.cancelButton.layer setCornerRadius:10.0];
        [self.deleteButton.layer setMasksToBounds:YES];
        //[self.deleteButton.layer setCornerRadius:10.0];

        
    }
    return self;
}

- (void)setXib
{
    UIView* nibView =  [[[NSBundle mainBundle] loadNibNamed:@"CustomAlertView" owner:self options:nil] objectAtIndex:0];
    nibView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    nibView.backgroundColor = [UIColor clearColor];
    [self addSubview:nibView];
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}


- (void)clickAction:(UIButton *)button
{
    [self.delegete customAlertViewAtIndex:(button.tag - 10) output:_inputTF.text];
}

- (void)show
{
    AppDelegate *appdeleGate = [UIApplication sharedApplication].delegate;
    _inputTF.text = _wLevel;
    [appdeleGate.window addSubview:self];
}

- (void)disMiss
{
//    [UIView animateWithDuration:1 animations:^{
//        
//    } completion:^(BOOL finished) {
//
//    }];
    
    [self removeFromSuperview];

}



- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
