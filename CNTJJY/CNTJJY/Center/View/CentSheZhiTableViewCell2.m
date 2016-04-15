//
//  CentSheZhiTableViewCell2.m
//  CNTJJY
//
//  Created by iOS on 16/4/12.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "CentSheZhiTableViewCell2.h"

@implementation CentSheZhiTableViewCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _centSetMode = [[CentSetMode alloc] init];
        _kaiGuan = [[UISwitch alloc]init];
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithWhite:0.93f alpha:1.0f];;
        [self addSubview:_lineView];

        [self addSubview:_kaiGuan];
    }
    return self ;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    _lineView.frame = CGRectMake(10, self.frame.size.height-1, self.frame.size.width - 10, 1) ;
    _kaiGuan.frame = CGRectMake(self.frame.size.width- 60 , self.frame.size.height/2 - 15 , 50, 30);
    // Configure the view for the selected state
}

@end
