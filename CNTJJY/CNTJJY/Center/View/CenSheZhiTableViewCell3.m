//
//  CenSheZhiTableViewCell3.m
//  CNTJJY
//
//  Created by iOS on 16/4/12.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "CenSheZhiTableViewCell3.h"

@implementation CenSheZhiTableViewCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        _cacheLabel = [[UILabel alloc]init];
        [self addSubview:_cacheLabel];
    }
    return self ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    _cacheLabel.font = [UIFont boldSystemFontOfSize:14.0];
    CGFloat width = [self contentHeight:_cacheLabel.text];
    _cacheLabel.frame = CGRectMake(self.frame.size.width - 30 - width-5, self.frame.size.height/2 - 15, width+5, 30) ;
    // Configure the view for the selected state
}
-(CGFloat)contentHeight:(NSString *)content
{
    CGRect rect=[content boundingRectWithSize:CGSizeMake(200, 1) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    return rect.size.width;
}

@end
