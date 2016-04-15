//
//  IndSetWidget.h
//  CNTJJY
//
//  Created by totrade on 16/1/27.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndSetWidget : UIView


@property (strong, nonatomic) IBOutlet UILabel *leftLabel;
@property (strong, nonatomic) IBOutlet UILabel *rightLabel;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UISlider *slider;

+(IndSetWidget *)instanceIndSetWidget;

- (void)leftButtonTarget:(id)target action:(SEL)action;
- (void)rightButtonTarget:(id)target action:(SEL)action;
- (void)sliderTarget:(id)target action:(SEL)action;

@end
