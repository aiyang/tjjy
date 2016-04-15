//
//  LineSetTingViewController.h
//  CNTJJY
//
//  Created by totrade on 16/1/25.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

typedef NS_ENUM(NSInteger, IndsType){
    theMA = 0,
    theBOLL,
    theMACD,
    theKDJ,
    theRSI,
    theBIAS,
    theCCI
};

#import <UIKit/UIKit.h>

@interface LineSetTingViewController : UIViewController

@property (nonatomic, assign)NSInteger zhuFuType;
@property (nonatomic, assign)IndsType indsType;

@property (nonatomic, strong)NSArray *dataArr;


@end
