//
//  XCIndsSegControl.m
//  TsetUIObj
//
//  Created by totrade on 16/3/7.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#define bottomLineHeight 2.0f

#define WIDTH (self.bounds.size.width)
#define HEIGHT (self.bounds.size.height)

#define SEG_WIDTH (self.bounds.size.width - 30)

#define TagAdd 1000


#import "XCIndsSegControl.h"
#import "NightMode.h"

static NSArray *majorArr;
static NSArray *minorArr;

@interface XCIndsSegControl ()


@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)NSMutableArray *buttonArray;
@property (nonatomic, strong)UIView *bottomLineView;
@property (nonatomic, assign)CGFloat btnWidth;

@property (nonatomic, strong)NSArray *tempArray;

@property (nonatomic, strong)UIButton *tempBtn;//临时存储已选定的按钮

@property (nonatomic, strong)UIButton *setButton;//设置按钮

@property (nonatomic, strong)NightMode *nightMode;

@end


@implementation XCIndsSegControl


- (instancetype)initWithType:(NSInteger)type delegate:(id)delegate
{
    self = [super init];
    if (self) {
        
        _nightMode = [[NightMode alloc] init];
        
//        self.backgroundColor = [UIColor clearColor];
        
        _delegate = delegate;
        
        majorArr = @[@"MA", @"BOLL"];
        minorArr = @[@"MACD", @"KDJ", @"RSI", @"BIAS", @"CCI", @"PSY", @"OBV", @"VOL"];
        _buttonArray = [NSMutableArray array];
        
        if (type == 1) {
            _tempArray = majorArr;
           // self.backgroundColor = _nightMode.majorSegColor;
            self.backgroundColor = _nightMode.timeSegColor;
        }else{
            _tempArray = minorArr;
           // self.backgroundColor = _nightMode.minorSegColor;
            self.backgroundColor = _nightMode.timeSegColor;
        }
        
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.userInteractionEnabled = YES;
        //        _scrollView.bounces = NO;
        //        _scrollView.showsHorizontalScrollIndicator = NO;
        
        for (NSInteger i = 0; i < _tempArray.count; i ++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btn setTitleColor:_nightMode.indsSegBtnDidSelColor forState:UIControlStateSelected];//被选择的颜色
            [btn setTitle:[_tempArray objectAtIndex:i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];

            [btn addTarget:self action:@selector(segmentedControlChange:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = TagAdd+i;
            if (i == 0) {
                btn.selected = YES;
            }
            [_scrollView addSubview:btn];
            [_buttonArray addObject:btn];
        }
        
        _setButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_setButton setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
        [_setButton addTarget:self action:@selector(setButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_setButton setTintColor:[UIColor whiteColor]];
        _setButton.backgroundColor = _nightMode.setButtonColor;
        _setButton.tag = 999 + TagAdd;
        [self addSubview:_setButton];
        
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor colorFromHexCode:@"#fe6100"];
        [_scrollView addSubview:_bottomLineView];
        
        [self addSubview:_scrollView];
        
    }
    return self;
}




- (void)segmentedControlChange:(UIButton *)button
{
    _tempBtn = button;
    [self scrollWith:button];
    [self.delegate indexButton:self index:button.tag - TagAdd isSet:NO];
}

- (void)setButtonAction:(UIButton *)button
{
    if (_tempBtn == nil) {
        [self.delegate indexButton:self index:0 isSet:YES];
    }else{
         [self.delegate indexButton:self index:_tempBtn.tag - TagAdd isSet:YES];
    }
   
}


- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];

    [self setAll];
    if (_tempBtn != nil) {
        [self scrollWith:_tempBtn];
    }

}



- (void)setAll
{
    
    CGRect rect = self.bounds;
    rect.size.width = SEG_WIDTH;
    
    if (_tempArray.count != 2) {
        _btnWidth = SEG_WIDTH / 5;
    }else{
        _btnWidth = SEG_WIDTH / 2;
    }
    
    [_scrollView setFrame:rect];
    _scrollView.contentSize = CGSizeMake(_tempArray.count * _btnWidth, self.frame.size.height);
    [_setButton setFrame:CGRectMake(SEG_WIDTH, 0, self.frame.size.height, self.frame.size.height)];
    
    for (NSInteger i = 0; i < _tempArray.count; i++) {
        UIButton *btn = [self viewWithTag:TagAdd + i];
        btn.frame = CGRectMake(i * _btnWidth, .0f, _btnWidth, self.frame.size.height);
    }
    
    for (UIButton *subBtn in _buttonArray) {
        if (subBtn.selected) {
            [_bottomLineView setFrame:CGRectMake(subBtn.frame.origin.x, subBtn.frame.size.height - bottomLineHeight, _btnWidth, bottomLineHeight)];
        }
    }
    
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
    
    if (_buttonArray.count == 2) {
        canScrolle = YES;
    }else{
        if (buttonTag >= 3 && buttonTag < (_buttonArray.count - 3)) {
            pt.x = _btnWidth * (buttonTag - 1);
            canScrolle = YES;
        }else if (buttonTag >= (_buttonArray.count - 3)){
            pt.x = _scrollView.contentSize.width - SEG_WIDTH;
            canScrolle = YES;
        }else{
            canScrolle = YES;
        }
    }
    
    if (canScrolle) {
        [UIView animateWithDuration:0.3 animations:^{
            _scrollView.contentOffset = pt;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0 animations:^{
                _bottomLineView.frame = CGRectMake(button.frame.origin.x, button.frame.size.height - bottomLineHeight, _btnWidth, bottomLineHeight);
            }];
        }];
    }
    
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
