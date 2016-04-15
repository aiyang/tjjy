//
//  UIButton+ItemButton.h
//  Network_Test0
//
//  Created by totrade on 16/3/3.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

//对button进行的扩展
#import <UIKit/UIKit.h>

@interface UIButton (ItemButton)


+ (instancetype)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

//返回键专用
+ (instancetype)backButtonWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;

//个人中心设置按钮
+ (instancetype)settingButtonWithtitle:(NSString *)title target:(id)target action:(SEL)action;

@end
