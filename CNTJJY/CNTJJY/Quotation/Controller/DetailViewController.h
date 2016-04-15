//
//  DetailViewController.h
//  CNTJJY
//
//  Created by totrade on 16/1/18.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#warning 这是该项目最难的界面涉及到分时图,K线图,夜间模式等!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

//前一界面所选产品的名字和代码
@property (nonatomic, strong)NSString *symbolName;
@property (nonatomic, strong)NSString *symbolCode;
@property (nonatomic, strong)NSString *y_Close;
@property (nonatomic, strong)NSString *y_O;

//界面控件
@property (strong, nonatomic) IBOutlet UILabel *symbolNameLB;
@property (strong, nonatomic) IBOutlet UILabel *nwePriceLB;
@property (strong, nonatomic) IBOutlet UILabel *upDownLB;
@property (strong, nonatomic) IBOutlet UILabel *upDownRangeLB;
@property (strong, nonatomic) IBOutlet UILabel *hLB;
@property (strong, nonatomic) IBOutlet UILabel *lLB;
@property (strong, nonatomic) IBOutlet UILabel *yCloseLB;
@property (strong, nonatomic) IBOutlet UILabel *oLB;
@property (strong, nonatomic) IBOutlet UILabel *buyLB;
@property (strong, nonatomic) IBOutlet UILabel *sellLB;
@property (strong, nonatomic) IBOutlet UILabel *swingLB;
@property (strong, nonatomic) IBOutlet UIButton *porLanButton;
@property (strong, nonatomic) IBOutlet UIImageView *upDownIV;






@end
