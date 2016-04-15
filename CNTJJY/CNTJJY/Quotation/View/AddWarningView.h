//
//  AddWarningView.h
//  CNTJJY
//
//  Created by totrade on 16/1/28.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SomeSymbolsInstantData_DownObj.h"


@interface AddWarningView : UIView

@property (nonatomic, strong)SomeSymbolsInstantData_DownObj *some_DownObj;

@property (strong, nonatomic) IBOutlet UILabel *nameLB;
@property (strong, nonatomic) IBOutlet UILabel *priceLB;
@property (strong, nonatomic) IBOutlet UILabel *upDownLB;
@property (strong, nonatomic) IBOutlet UILabel *upDownRangeLB;

@end
