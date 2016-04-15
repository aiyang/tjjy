//
//  DiscoverTableViewCell.m
//  CNTJJY
//
//  Created by tianjinjiayin on 16/4/11.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "DiscoverTableViewCell.h"
#import "PublicMethodViewController.h"

@implementation DiscoverTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)buildCell:(DiscoverCellModel *)cellData{
    self.iconImgV = [PublicMethodViewController buildImageview:self.iconImgV fatherView:self imagename:cellData.icon];
    
    self.mainContentLab = [PublicMethodViewController buildLable:self.mainContentLab fatherView:self labletext:cellData.mainText];
    
    self.detaileLab = [PublicMethodViewController buildLable:self.detaileLab fatherView:self labletext:cellData.detailText];
    self.detaileLab.font = [UIFont systemFontOfSize:13];
    self.detaileLab.textColor = [UIColor colorFromHexCode:@"#949494"];
    
 
    
    
    
    if (self.frame.size.width == 320) {
        self.mainContentLab.font = [UIFont systemFontOfSize:15];
        self.detaileLab.font = [UIFont systemFontOfSize:11];
    }
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-12-[_iconImgV(44)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_iconImgV)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-14-[_iconImgV(44)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_iconImgV)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-65-[_mainContentLab(%f)]",self.frame.size.width-50]
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_mainContentLab)]];

    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-65-[_detaileLab(%f)]",self.frame.size.width-40]
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_detaileLab)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-14-[_mainContentLab(25)]-0-[_detaileLab(22)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_mainContentLab,_detaileLab)]];

}

@end
