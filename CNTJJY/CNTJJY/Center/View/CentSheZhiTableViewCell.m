//
//  CentSheZhiTableViewCell.m
//  CNTJJY
//
//  Created by iOS on 16/4/12.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "CentSheZhiTableViewCell.h"

@implementation CentSheZhiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        NSLog(@"self ====== %f",self.frame.size.width);
        //_leftBtn.frame = CGRectMake(200, 7, 48/30.0*30, 30);
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"leftArrow.png"] forState:UIControlStateNormal];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"leftArrowDid"] forState:UIControlStateHighlighted];
        [self addSubview:_leftBtn];
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        NSLog(@"self ====== %f",self.frame.size.height);
        //_rightBtn.frame = CGRectMake(200 + _leftBtn.frame.size.width, 7, 48/30.0*30, 30);
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"rightArrow.png"] forState:UIControlStateNormal];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"rightArrowDid"] forState:UIControlStateHighlighted];
        [self addSubview:_rightBtn];
        
        
    }
    return self ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    _rightBtn.frame = CGRectMake(self.frame.size.width - 48 - 10, self.frame.size.height/2 - 15 , 48, 30);
    
    _leftBtn.frame = CGRectMake(_rightBtn.frame.origin.x - _rightBtn.frame.size.width , _rightBtn.frame.origin.y , _rightBtn.frame.size.width , _rightBtn.frame.size.height ) ;
    
    // Configure the view for the selected state
}

@end
