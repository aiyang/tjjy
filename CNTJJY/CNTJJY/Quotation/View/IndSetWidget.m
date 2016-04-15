//
//  IndSetWidget.m
//  CNTJJY
//
//  Created by totrade on 16/1/27.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "IndSetWidget.h"

@implementation IndSetWidget

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
//        NSLog(@"111");
//        self.backgroundColor = [UIColor redColor];
        
    }
    return self;
}

- (void)layoutSubviews
{
//    NSLog(@"222");
    if (MAINSCREEN_WIDTH>MAINSCREEN_HEIGHT) {
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, MAINSCREEN_HEIGHT, 100)];
    }
    else{
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, MAINSCREEN_WIDTH, 100)];
    }
    
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
//    NSLog(@"333");
//    self.leftButton.backgroundColor = [UIColor blackColor];
//    _leftButton addTarget: action:<#(nonnull SEL)#> forControlEvents:<#(UIControlEvents)#>
//    self.slider.minimumValue = 2;
//    self.slider.maximumValue = 250;
    
//    @property(nullable, nonatomic,strong) UIColor *minimumTrackTintColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
//    @property(nullable, nonatomic,strong) UIColor *maximumTrackTintColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
//    @property(nullable, nonatomic,strong) UIColor *thumbTintColor
    
    _slider.minimumTrackTintColor = [UIColor orangeColor];
    _slider.maximumTrackTintColor = [UIColor grayColor];
    _slider.thumbTintColor = [UIColor grayColor];
    
    [_leftButton setImage:[UIImage imageNamed:@"leftArrowDid"] forState:UIControlStateHighlighted];
    [_rightButton setImage:[UIImage imageNamed:@"rightArrowDid"] forState:UIControlStateHighlighted];
}



+(IndSetWidget *)instanceIndSetWidget
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"IndSetWidget" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}


- (void)leftButtonTarget:(id)target action:(SEL)action
{
    [_leftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}
- (void)rightButtonTarget:(id)target action:(SEL)action
{
    [_rightButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}
- (void)sliderTarget:(id)target action:(SEL)action
{
    [_slider addTarget:target action:action forControlEvents:UIControlEventValueChanged];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
