//
//  PublicMethodViewController.h
//  CNTJJY
//
//  Created by tianjinjiayin on 16/4/11.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICustomLineLabel.h"

@interface PublicMethodViewController : UIViewController
+ (UICustomLineLabel *)buildCustomLineLabel:(UICustomLineLabel *)lable fatherView:(id)fatherView labletext:(NSString *)labletext;

+ (UILabel *)buildLable:(UILabel *)lable fatherView:(id)fatherView labletext:(NSString *)labletext;

+ (UIButton *)buildBtn:(UIButton *)btn fatherView:(id)fatherView btntext:(NSString *)btntext;

+ (UIImageView *)buildImageview:(UIImageView *)imageView fatherView:(id)fatherView imagename:(NSString *)imageName;
/**
 *  判断字符串是否为空
 *
 *  @param str 要判断的字符串
 *
 *  @return 是否为空
 */
+ (BOOL)isnull_string:(NSString *)str;
@end
