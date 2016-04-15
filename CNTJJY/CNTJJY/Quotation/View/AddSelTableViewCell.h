//
//  AddSelTableViewCell.h
//  CNTJJY
//
//  Created by totrade on 16/1/16.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleExchangeAllSymbolsInstantData_DownObj.h"


@interface AddSelTableViewCell : UITableViewCell

@property (nonatomic, strong)SingleExchangeAllSymbolsInstantData_DownObj *single_DownObj;

@property (nonatomic, strong)NSString *exch_name ;

@property (strong, nonatomic) IBOutlet UILabel *nameLB;

@property (strong, nonatomic) IBOutlet UIImageView *imageIV;
@property (strong, nonatomic) IBOutlet UILabel *addReduceLB;

@end
