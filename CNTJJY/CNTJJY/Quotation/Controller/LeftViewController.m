//
//  LeftViewController.m
//  CNTJJY
//
//  Created by tianjinjiayin on 16/4/8.
//  Copyright © 1016年 CNTJJY. All rights reserved.
//

#define BTNWITH (self.view.frame.size.width*0.816-45)/3
#define BTNHIGH (self.view.frame.size.width*0.816-45)/3*0.34
#define LABWITH (self.view.frame.size.width*0.816-20)

#define BTNWITHH (self.view.frame.size.height*0.816-45)/3
#define BTNHIGHH (self.view.frame.size.height*0.816-45)/3*0.34
#define LABWITHH (self.view.frame.size.height*0.816-20)

#import "LeftViewController.h"
#import "PublicMethodViewController.h"
#import "UICustomLineLabel.h"

@interface LeftViewController ()

@end

@implementation LeftViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorFromHexCode:@"#242424"];
    [self buildUI];

}


-(void)buildUI{
    
    //      0        1         2             3          4         5         6
    //    @[@"天矿所", @"津贵所", @"齐鲁商品", @"上海金", @"纸黄金", @"国际外汇", @"国际黄金"]
    //                TMRE     TJPME    QILUCE      SGE       PGOLD     MT4         WGJS
    
    
    self.zhjBtn = [self setBtn:self.zhjBtn Text:@"纸黄金"];
    self.zhjBtn.tag=4;
    
    self.shjBtn = [self setBtn:self.shjBtn Text:@"上海金"];
    self.shjBtn.tag=3;
    
    self.tksBtn = [self setBtn:self.tksBtn Text:@"天矿所"];
    self.tksBtn.tag=0;
    
    self.jgsBtn = [self setBtn:self.jgsBtn Text:@"津贵所"];
    self.jgsBtn.tag=1;

    self.qlspBtn = [self setBtn:self.qlspBtn Text:@"齐鲁商品"];
    self.qlspBtn.tag=2;
    
    self.gjwhBtn = [self setBtn:self.gjwhBtn Text:@"国际外汇"];
    self.gjwhBtn.tag=5;
    
    self.gjhjBtn = [self setBtn:self.gjhjBtn Text:@"国际黄金"];
    self.gjhjBtn.tag=6;
    
    self.gnhqLab=[PublicMethodViewController buildCustomLineLabel:self.gnhqLab fatherView:self.view labletext:@"国内行情"];
    self.gnhqLab.lineType = LineTypeDown;
    self.gnhqLab.lineColor = [UIColor blackColor];
    
    self.gjhjLab=[PublicMethodViewController buildCustomLineLabel:self.gjhjLab fatherView:self.view labletext:@"国际行情"];
    self.gjhjLab.lineType = LineTypeDown;
    self.gjhjLab.lineColor = [UIColor blackColor];
    
    
    
    
    if (self.view.frame.size.width>self.view.frame.size.height) {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-10-[_zhjBtn(%f)]-10-[_shjBtn(%f)]-10-[_tksBtn(%f)]",BTNWITHH,BTNWITHH,BTNWITHH]
                                                                          options:0
                                                                          metrics:nil
                                                                            views:NSDictionaryOfVariableBindings(_zhjBtn,_shjBtn,_tksBtn)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-10-[_jgsBtn(%f)]-10-[_qlspBtn(%f)]",BTNWITHH,BTNWITHH]
                                                                          options:0
                                                                          metrics:nil
                                                                            views:NSDictionaryOfVariableBindings(_jgsBtn,_qlspBtn)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-10-[_gjwhBtn(%f)]-10-[_gjhjBtn(%f)]",BTNWITHH,BTNWITHH]
                                                                          options:0
                                                                          metrics:nil
                                                                            views:NSDictionaryOfVariableBindings(_gjwhBtn,_gjhjBtn)]];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-10-[_gjwhBtn(%f)]-10-[_gjhjBtn(%f)]",BTNWITHH,BTNWITHH]
                                                                          options:0
                                                                          metrics:nil
                                                                            views:NSDictionaryOfVariableBindings(_gjwhBtn,_gjhjBtn)]];
        
        
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-10-[_gnhqLab(%f)]",LABWITHH]
                                                                          options:0
                                                                          metrics:nil
                                                                            views:NSDictionaryOfVariableBindings(_gnhqLab)]];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-10-[_gjhjLab(%f)]",LABWITHH]
                                                                          options:0
                                                                          metrics:nil
                                                                            views:NSDictionaryOfVariableBindings(_gjhjLab)]];
        
        
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-50-[_gnhqLab(50)]-15-[_zhjBtn(%f)]-10-[_jgsBtn(%f)]-10-[_gjhjLab(50)]-15-[_gjwhBtn(%f)]",BTNHIGHH,BTNHIGHH,BTNHIGHH]
                                                                          options:0
                                                                          metrics:nil
                                                                            views:NSDictionaryOfVariableBindings(_gnhqLab,_zhjBtn,_jgsBtn,_gjhjLab,_gjwhBtn)]];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-115-[_shjBtn(%f)]-10-[_qlspBtn(%f)]-75-[_gjhjBtn(%f)]",BTNHIGHH,BTNHIGHH,BTNHIGHH]
                                                                          options:0
                                                                          metrics:nil
                                                                            views:NSDictionaryOfVariableBindings(_shjBtn,_qlspBtn,_gjhjBtn)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-115-[_tksBtn(%f)]",BTNHIGHH]
                                                                          options:0
                                                                          metrics:nil
                                                                            views:NSDictionaryOfVariableBindings(_tksBtn)]];
    }else{
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-10-[_zhjBtn(%f)]-10-[_shjBtn(%f)]-10-[_tksBtn(%f)]",BTNWITH,BTNWITH,BTNWITH]
                                                                          options:0
                                                                          metrics:nil
                                                                            views:NSDictionaryOfVariableBindings(_zhjBtn,_shjBtn,_tksBtn)]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-10-[_jgsBtn(%f)]-10-[_qlspBtn(%f)]",BTNWITH,BTNWITH]
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_jgsBtn,_qlspBtn)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-10-[_gjwhBtn(%f)]-10-[_gjhjBtn(%f)]",BTNWITH,BTNWITH]
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_gjwhBtn,_gjhjBtn)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-10-[_gjwhBtn(%f)]-10-[_gjhjBtn(%f)]",BTNWITH,BTNWITH]
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_gjwhBtn,_gjhjBtn)]];
    
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-10-[_gnhqLab(%f)]",LABWITH]
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_gnhqLab)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-10-[_gjhjLab(%f)]",LABWITH]
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_gjhjLab)]];
    
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-50-[_gnhqLab(50)]-15-[_zhjBtn(%f)]-10-[_jgsBtn(%f)]-10-[_gjhjLab(50)]-15-[_gjwhBtn(%f)]",BTNHIGH,BTNHIGH,BTNHIGH]
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_gnhqLab,_zhjBtn,_jgsBtn,_gjhjLab,_gjwhBtn)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-115-[_shjBtn(%f)]-10-[_qlspBtn(%f)]-75-[_gjhjBtn(%f)]",BTNHIGH,BTNHIGH,BTNHIGH]
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_shjBtn,_qlspBtn,_gjhjBtn)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-115-[_tksBtn(%f)]",BTNHIGH]
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_tksBtn)]];
    }
}

- (UIButton *)setBtn:(UIButton *)btn Text:(NSString *)text{
    btn=[PublicMethodViewController buildBtn:btn fatherView:self.view btntext:text];
    btn.layer.cornerRadius=2;
    btn.layer.borderWidth=1.5;
    [btn addTarget:self action:@selector(btnTag:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
-(void)btnTag:(UIButton *)btn{
//    self.btnTagBlock((int)btn.tag);
    NSMutableDictionary *tagDic=[[NSMutableDictionary alloc]init];
    [tagDic setValue:[NSString stringWithFormat:@"%d",(int)btn.tag] forKey:@"btnTag"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"btnTag" object:nil userInfo:tagDic];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"--->>>leftView will appear");
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"--->>>leftView did appear");
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"--->>>leftView will disappear");
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"--->>>leftView did disappear");
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"left view rotate");
}

@end
