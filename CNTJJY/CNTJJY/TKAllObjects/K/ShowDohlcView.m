//
//  ShowDohlcView.m
//  CNTJJY
//
//  Created by totrade on 16/2/20.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height

#define LeftLBWidth 15.0f

#define FONT 6

#import "ShowDohlcView.h"
#import "TimeTools.h"

@interface ShowDohlcView ()

@property (nonatomic, strong)UILabel *dateLeftLB;
@property (nonatomic, strong)UILabel *oLeftLB;
@property (nonatomic, strong)UILabel *hLeftLB;
@property (nonatomic, strong)UILabel *lLeftLB;
@property (nonatomic, strong)UILabel *cLeftLB;


@property (nonatomic, strong)UILabel *dateLB;
@property (nonatomic, strong)UILabel *oLB;
@property (nonatomic, strong)UILabel *hLB;
@property (nonatomic, strong)UILabel *lLB;
@property (nonatomic, strong)UILabel *cLB;



@end

@implementation ShowDohlcView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        self.backgroundColor = [UIColor cyanColor];
    
        _dateLeftLB = [[UILabel alloc] init];
        _dateLeftLB.text = @"日期:";
        _dateLeftLB.backgroundColor = [UIColor clearColor];
        _dateLeftLB.font = [UIFont systemFontOfSize:FONT];
        [self addSubview:_dateLeftLB];
        _dateLB = [[UILabel alloc] init];
        _dateLB.backgroundColor = [UIColor clearColor];
        _dateLB.font = [UIFont systemFontOfSize:FONT];
        [self addSubview:_dateLB];
        
        _oLeftLB = [[UILabel alloc] init];
        _oLeftLB.text = @"开盘:";
        _oLeftLB.backgroundColor = [UIColor clearColor];
        _oLeftLB.font = [UIFont systemFontOfSize:FONT];
        [self addSubview:_oLeftLB];
        _oLB = [[UILabel alloc] init];
        _oLB.backgroundColor = [UIColor clearColor];
        _oLB.font = [UIFont systemFontOfSize:FONT];
        [self addSubview:_oLB];
        
        _hLeftLB = [[UILabel alloc] init];
        _hLeftLB.text = @"最高:";
        _hLeftLB.backgroundColor = [UIColor clearColor];
        _hLeftLB.font = [UIFont systemFontOfSize:FONT];
        [self addSubview:_hLeftLB];
        _hLB = [[UILabel alloc] init];
        _hLB.backgroundColor = [UIColor clearColor];
        _hLB.font = [UIFont systemFontOfSize:FONT];
        [self addSubview:_hLB];
        
        _lLeftLB = [[UILabel alloc] init];
        _lLeftLB.text = @"最低:";
        _lLeftLB.backgroundColor = [UIColor clearColor];
        _lLeftLB.font = [UIFont systemFontOfSize:FONT];
        [self addSubview:_lLeftLB];
        _lLB = [[UILabel alloc] init];
        _lLB.backgroundColor = [UIColor clearColor];
        _lLB.font = [UIFont systemFontOfSize:FONT];
        [self addSubview:_lLB];
        
        _cLeftLB = [[UILabel alloc] init];
        _cLeftLB.text = @"收盘:";
        _cLeftLB.backgroundColor = [UIColor clearColor];
        _cLeftLB.font = [UIFont systemFontOfSize:FONT];
        [self addSubview:_cLeftLB];
        _cLB = [[UILabel alloc] init];
        _cLB.backgroundColor = [UIColor clearColor];
        _cLB.font = [UIFont systemFontOfSize:FONT];
        [self addSubview:_cLB];
        
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    frame = frame;
    
    [_dateLeftLB setFrame:CGRectMake(0, 0 * HEIGHT / 5, LeftLBWidth, HEIGHT / 5)];
    [_dateLB setFrame:CGRectMake(LeftLBWidth, 0 * HEIGHT / 5, WIDTH - LeftLBWidth, HEIGHT / 5)];
    [_oLeftLB setFrame:CGRectMake(0, 1 * HEIGHT / 5, LeftLBWidth, HEIGHT / 5)];
    [_oLB setFrame:CGRectMake(LeftLBWidth, 1 * HEIGHT / 5, WIDTH - LeftLBWidth, HEIGHT / 5)];
    [_hLeftLB setFrame:CGRectMake(0, 2 * HEIGHT / 5, LeftLBWidth, HEIGHT / 5)];
    [_hLB setFrame:CGRectMake(LeftLBWidth, 2 * HEIGHT / 5, WIDTH - LeftLBWidth, HEIGHT / 5)];
    [_lLeftLB setFrame:CGRectMake(0, 3 * HEIGHT / 5, LeftLBWidth, HEIGHT / 5)];
    [_lLB setFrame:CGRectMake(LeftLBWidth, 3 * HEIGHT / 5, WIDTH - LeftLBWidth, HEIGHT / 5)];
    [_cLeftLB setFrame:CGRectMake(0, 4 * HEIGHT / 5, LeftLBWidth, HEIGHT / 5)];
    [_cLB setFrame:CGRectMake(LeftLBWidth, 4 * HEIGHT / 5, WIDTH - LeftLBWidth, HEIGHT / 5)];

}

- (void)setAllLabelValueWithDateArr:(NSArray *)dateArr candleArr:(NSArray *)candleArr index:(NSInteger)index
{
    NSString *intervalString = [[[dateArr objectAtIndex:1] objectAtIndex:0] objectAtIndex:index];
    CGFloat oF = [[[candleArr objectAtIndex:0] objectAtIndex:index] floatValue];
    CGFloat hF = [[[candleArr objectAtIndex:1] objectAtIndex:index] floatValue];
    CGFloat lF = [[[candleArr objectAtIndex:2] objectAtIndex:index] floatValue];
    CGFloat cF = [[[candleArr objectAtIndex:3] objectAtIndex:index] floatValue];
    //十字架赋值
    _dateLB.text = [TimeTools getDateStringFromTimeInterval:intervalString];;
    _oLB.text = [NSString stringWithFormat:@"%.2f", oF];
    _hLB.text = [NSString stringWithFormat:@"%.2f", hF];
    _lLB.text = [NSString stringWithFormat:@"%.2f", lF];
    _cLB.text = [NSString stringWithFormat:@"%.2f", cF];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
