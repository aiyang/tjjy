//
//  XCTimeSegControl.m
//  TsetUIObj
//
//  Created by totrade on 16/3/9.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#define TagAdd 1000

#define WIDTH (self.bounds.size.width)
#define HEIGHT (self.bounds.size.height)


#import "XCTimeSegControl.h"
#import "NightMode.h"

static NSArray *timeArr;

@interface XCTimeSegControl ()

@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)NSMutableArray *buttonArray;
@property (nonatomic, strong)UIView *bottomLineView;

@property (nonatomic, assign)CGFloat btnWidth;
@property (nonatomic, assign)CGFloat btnHeight;

@property (nonatomic, strong)UIButton *tempBtn;

@property (nonatomic, strong)NightMode *nightMode;

@end

@implementation XCTimeSegControl

//非外部传值可写在initWithCoder或awakeFromNib
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
   self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"initWithCoder");
        
//        self.backgroundColor = 
//        行情图表包括：分时、5分钟、15分钟、30分钟、60分钟、240分钟、日线、周线、月线、年线等
        timeArr = @[@"分时", @"5", @"15", @"30", @"60", @"日", @"周", @"月"];
        
        _nightMode = [[NightMode alloc] init];
        
        self.backgroundColor = _nightMode.minorSegColor;
        
        _buttonArray = [NSMutableArray array];
        
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.userInteractionEnabled = YES;
        //        _scrollView.bounces = NO;
        //        _scrollView.showsHorizontalScrollIndicator = NO;
        
        for (NSInteger i = 0; i < timeArr.count; i ++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            //            btn.frame = CGRectMake(i*_btnWidth, .0f, _btnWidth, 50);
            [btn setTitleColor:_nightMode.timeButtonColor forState:UIControlStateNormal];
            [btn setTitleColor:_nightMode.buttonDisSelColor forState:UIControlStateSelected];//被选择的颜色
            [btn setTitle:[timeArr objectAtIndex:i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn addTarget:self action:@selector(segmentedControlChange:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = TagAdd+i;
            if (i == 0) {
                btn.selected = YES;
            }
            [_scrollView addSubview:btn];
            [_buttonArray addObject:btn];
        }
    
        
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor colorFromHexCode:@"#fe6100"];
        [_scrollView addSubview:_bottomLineView];
        
        [self addSubview:_scrollView];
        
    }
    return self;
    
}

//非外部传值可写在initWithCoder或awakeFromNib
- (void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"awakeFromNib");
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [self setAll];
    if (_tempBtn != nil) {
        [self scrollWith:_tempBtn];
    }
    

}


- (void)segmentedControlChange:(UIButton *)button
{
    _tempBtn = button;
    [self scrollWith:button];
    [self.delegate indexButton:self index:button.tag - TagAdd];

}


- (void)scrollWith:(UIButton *)button
{
    //确保同时只选择一个
    button.selected = YES;
    for (UIButton *subBtn in _buttonArray) {
        if (subBtn != button) {
            subBtn.selected = NO;
        }
    }
    
    CGPoint pt = CGPointZero;
    BOOL canScrolle = NO;
    NSInteger buttonTag = button.tag - TagAdd;
    
    if (WIDTH > HEIGHT) {//横屏时
        
        if (buttonTag >= 4 && buttonTag < (_buttonArray.count - 4)) {
            pt.x = _btnWidth * (buttonTag - 1);
            canScrolle = YES;
        }else if (buttonTag >= (_buttonArray.count - 4)){
            pt.x = _scrollView.contentSize.width - WIDTH;
            canScrolle = YES;
        }else{
            canScrolle = YES;
        }
        
        
        if (canScrolle) {
            [UIView animateWithDuration:0.3 animations:^{
                _scrollView.contentOffset = pt;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.bottomLineView.frame = CGRectMake(button.frame.origin.x, button.frame.size.height - 2.0f, _btnWidth, 2.0f);
                }];
            }];
        }
        
    }else if(WIDTH < HEIGHT){
        
        if (buttonTag >= 4 && buttonTag < (_buttonArray.count - 4)) {
            pt.y = _btnHeight * (buttonTag - 1);
            canScrolle = YES;
        }else if (buttonTag >= (_buttonArray.count - 4)){
            pt.y = _scrollView.contentSize.height - HEIGHT;
            canScrolle = YES;
        }else{
            canScrolle = YES;
            
        }
        
        
        if (canScrolle) {
            [UIView animateWithDuration:0.3 animations:^{
                _scrollView.contentOffset = pt;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.bottomLineView.frame = CGRectMake(0, button.frame.origin.y, 2.0f, button.frame.size.height);
                }];
            }];
        }
        
        
    }
}


- (void)setAll
{
    CGRect rect = self.bounds;
    rect.origin.x = 0.0f;
    rect.origin.y = 0.0f;
    [_scrollView setFrame:rect];
    
    for (NSInteger i = 0; i < timeArr.count; i ++) {
        UIButton *btn = [self viewWithTag:i + TagAdd];
        if (WIDTH > HEIGHT) {//横屏时
            _btnWidth = WIDTH / 6;
            _btnHeight = HEIGHT;
            _scrollView.contentSize = CGSizeMake(timeArr.count * _btnWidth, HEIGHT);
            btn.frame = CGRectMake(i * _btnWidth, 0.0f, _btnWidth, _btnHeight);
            
            
        }else if(WIDTH < HEIGHT){
            
            
            _btnWidth = WIDTH;
            _btnHeight = HEIGHT / 6;
            _scrollView.contentSize = CGSizeMake(WIDTH , timeArr.count * _btnHeight);
            btn.frame = CGRectMake(0, i * _btnHeight, _btnWidth, _btnHeight);
            
        }
    }
    
    for (UIButton *subBtn in _buttonArray) {
        if (subBtn.selected) {
            if (WIDTH > HEIGHT) {//横屏时
                     [_bottomLineView setFrame:CGRectMake(subBtn.frame.origin.x, subBtn.frame.size.height - 2.0f, _btnWidth, 2.0f)];
            }else if(WIDTH < HEIGHT){
                  [_bottomLineView setFrame:CGRectMake(0, subBtn.frame.origin.y, 2.0f, _btnHeight)];
            }
       
        }
    }
    
}




- (void)setSomeValue:(NSString *)string
{
//    _string = string;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
