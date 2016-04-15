//
//  UIButton+ItemButton.m
//  Network_Test0
//
//  Created by totrade on 16/3/3.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "UIButton+ItemButton.h"

@implementation UIButton (ItemButton)


+ (instancetype)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 40, 25);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    
//    button.imageEdgeInsets = UIEdgeInsetsMake(6.0f, 0, - 6.0f, 0);这里设置这个对barButton不好用

    button.layer.cornerRadius = 3.0f;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = [UIColor grayColor].CGColor;
    button.layer.borderWidth = 0.5f;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (instancetype)backButtonWithImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    
    //    button.imageEdgeInsets = UIEdgeInsetsMake(6.0f, 0, - 6.0f, 0);这里设置这个对barButton不好用
    
//    button.layer.cornerRadius = 3.0f;
//    button.layer.masksToBounds = YES;
//    button.layer.borderColor = [UIColor grayColor].CGColor;
//    button.layer.borderWidth = 0.5f;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (instancetype)settingButtonWithtitle:(NSString *)title target:(id)target action:(SEL)action
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
   // button.frame = CGRectMake(0, 0, 60, 25);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    imageView.image = [UIImage imageNamed:@"chilun2"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 35, 25)];
    label.textColor = [UIColor whiteColor];
    label.text = title;
    
    [button addSubview:imageView];
    [button addSubview:label];
    
    return button;
}









@end
