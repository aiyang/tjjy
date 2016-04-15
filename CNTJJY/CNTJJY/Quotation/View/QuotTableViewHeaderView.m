//
//  QuotTableViewHeaderView.m
//  CNTJJY
//
//  Created by totrade on 16/1/16.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "QuotTableViewHeaderView.h"

@implementation QuotTableViewHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setXib];
        
    }
    return self;
}

- (void)setXib
{
    UIView *containerView = [[[UINib nibWithNibName:@"QuotTableViewHeaderView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
    containerView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    [self.contentView addSubview:containerView];//我觉的这种添加方法才是真的是对的吧!!!
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
