//
//  ShowToast.m
//  CNTJJY
//
//  Created by totrade on 16/2/26.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "ShowToast.h"

@implementation ShowToast

+(void)showMessage:(NSString *)message
{
    //    if (message.length == 0) {
    //        message = @"数据获取异常";
    //    }
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(290, 9000)];
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    
    label.numberOfLines = 0;
    
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    showview.frame = CGRectMake((window.frame.size.width - LabelSize.width - 20)/2, window.frame.size.height - 370, LabelSize.width+20, LabelSize.height+10);
    //    [UIView animateWithDuration:1.5 animations:^{
    //        showview.alpha = 0;
    //    } completion:^(BOOL finished) {
    //        [showview removeFromSuperview];
    //    }];
    [UIView animateWithDuration:2 delay:1 options:0 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}


+(void)showInBackMessage:(NSString *)message
{
    //    if (message.length == 0) {
    //        message = @"数据获取异常";
    //    }
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor lightGrayColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(290, 9000)];
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    
    label.numberOfLines = 0;
    
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    showview.frame = CGRectMake((window.frame.size.width - LabelSize.width - 20)/2, window.frame.size.height - 370, LabelSize.width+20, LabelSize.height+10);
    //    [UIView animateWithDuration:1.5 animations:^{
    //        showview.alpha = 0;
    //    } completion:^(BOOL finished) {
    //        [showview removeFromSuperview];
    //    }];
    [UIView animateWithDuration:1 delay:1 options:0 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}



@end
