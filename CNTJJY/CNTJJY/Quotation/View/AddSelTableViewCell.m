//
//  AddSelTableViewCell.m
//  CNTJJY
//
//  Created by totrade on 16/1/16.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "AddSelTableViewCell.h"
#import "DataManage.h"
#import "AddSelfSelect.h"

@interface AddSelTableViewCell ()

@property (nonatomic, strong)AddSelfSelect *addSelfSeclect;

@end

@implementation AddSelTableViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code

}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    DataManage *dataManage = [DataManage shareInstance];
        _addSelfSeclect = [[AddSelfSelect alloc] init];

    if ([[[_addSelfSeclect.addSelDic objectForKey:@"ql"] allKeys] containsObject:_single_DownObj.code]
        || [[[_addSelfSeclect.addSelDic objectForKey:@"ht"] allKeys] containsObject:_single_DownObj.code]) {
        

        self.imageIV.image = [UIImage imageNamed:@"reduce_Img"];
        self.addReduceLB.text = @"删自选";
        
    }else{

        self.imageIV.image = [UIImage imageNamed:@"add_Img"];
        self.addReduceLB.text = @"加自选";
        
    }
    
    NSLog(@"self.single_DownObj.name:%@", self.single_DownObj.name);
    
    self.nameLB.text = self.single_DownObj.name;

    
}

-(SingleExchangeAllSymbolsInstantData_DownObj *)single_DownObj{
    if (!_single_DownObj) {
        _single_DownObj = [[SingleExchangeAllSymbolsInstantData_DownObj alloc]init];
    }
    return _single_DownObj ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
