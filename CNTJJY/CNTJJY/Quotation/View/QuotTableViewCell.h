//
//  QuotTableViewCell.h
//  CNTJJY
//
//  Created by totrade on 16/1/15.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuotTableViewCell : UITableViewCell

@property (nonatomic, strong)id get_DownObj;

@property (strong, nonatomic) IBOutlet UILabel *nameLB;
@property (strong, nonatomic) IBOutlet UILabel *buyLB;
@property (strong, nonatomic) IBOutlet UILabel *sellLB;
@property (strong, nonatomic) IBOutlet UILabel *upDownLB;
@property (strong, nonatomic) IBOutlet UILabel *upDownRangeLB;
@property (nonatomic, strong)NSString *code;

@property (nonatomic, strong)NSString *y_Close;

@end
