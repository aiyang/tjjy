//
//  DiscoverTableViewCell.h
//  CNTJJY
//
//  Created by tianjinjiayin on 16/4/11.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverCellModel.h"

@interface DiscoverTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *iconImgV;
@property (nonatomic,strong) UILabel *mainContentLab;
@property (nonatomic,strong) UILabel *detaileLab;


- (void)buildCell:(DiscoverCellModel *)cellData;
@end
