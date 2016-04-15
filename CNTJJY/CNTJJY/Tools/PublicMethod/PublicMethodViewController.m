//
//  PublicMethodViewController.m
//  CNTJJY
//
//  Created by tianjinjiayin on 16/4/11.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "PublicMethodViewController.h"
#import "UICustomLineLabel.h"

@interface PublicMethodViewController ()

@end

@implementation PublicMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (UICustomLineLabel *)buildCustomLineLabel:(UICustomLineLabel *)lable fatherView:(id)fatherView labletext:(NSString *)labletext{
    lable = [[UICustomLineLabel alloc]init];
    [lable setFont:[UIFont systemFontOfSize:14]];
    lable.backgroundColor=[UIColor colorFromHexCode:@"#242424"];
    lable.textColor=[UIColor colorFromHexCode:@"#949494"];
    lable.translatesAutoresizingMaskIntoConstraints = NO;
    [fatherView addSubview:lable];
    //
    if ([PublicMethodViewController isnull_string:labletext]) {
        lable.text = labletext;
    }
    return lable;
}

+ (UILabel *)buildLable:(UILabel *)lable fatherView:(id)fatherView labletext:(NSString *)labletext{
    lable = [[UILabel alloc]init];
    lable.translatesAutoresizingMaskIntoConstraints = NO;
    lable.textAlignment = NSTextAlignmentLeft;
    [fatherView addSubview:lable];
    //
    if ([PublicMethodViewController isnull_string:labletext]) {
        lable.text = labletext;
    }
    return lable;
}

+ (UIButton *)buildBtn:(UIButton *)btn fatherView:(id)fatherView btntext:(NSString *)btntext{
    btn= [[UIButton alloc]init];
    [btn setFont:[UIFont systemFontOfSize:15]];
    [btn setBackgroundColor:[UIColor colorFromHexCode:@"#242424"]];
    btn.layer.borderColor=[UIColor colorFromHexCode:@"#444444"].CGColor;
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [fatherView addSubview:btn];
    //
    if ([PublicMethodViewController isnull_string:btntext]) {
        [btn setTitle:btntext forState:UIControlStateNormal];
    }
    return btn;
}

+ (UIImageView *)buildImageview:(UIImageView *)imageView fatherView:(id)fatherView imagename:(NSString *)imageName{
    imageView = [[UIImageView alloc]init];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [fatherView addSubview:imageView];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}

/**
 *  判断字符串是否为空
 *
 *  @param str 要判断的字符串
 *
 *  @return 是否为空
 */
+ (BOOL)isnull_string:(NSString *)str{
    if (str != nil && ![str isKindOfClass:[NSNull class]] && ![[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        return YES;
    }
    return NO;
}
@end
