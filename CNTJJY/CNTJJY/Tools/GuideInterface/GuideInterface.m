//
//  GuideInterface.m
//  Study_GiideInterface
//
//  Created by totrade on 16/3/6.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#define Width [[UIScreen mainScreen] bounds].size.width
#define Heigth [[UIScreen mainScreen] bounds].size.height

#import "GuideInterface.h"
#import "AppDelegate.h"

@interface GuideInterface ()<UIScrollViewDelegate>

@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIButton *button;
@property (nonatomic, assign)NSInteger arrayCount;

@end

@implementation GuideInterface

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        
        
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.pagingEnabled = YES;//按页翻
        _scrollView.bounces = NO;//关闭弹动
        _scrollView.showsVerticalScrollIndicator = NO;//隐藏垂直滚动条
        _scrollView.showsHorizontalScrollIndicator = NO;//隐藏水平滚动条
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        //创建一个UIPageControl对象
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, Heigth - 50, Width, 50)];
        _pageControl.currentPage = 0;
        [self addSubview:_pageControl];
        
        
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button setTitle:@"进入App" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _button.layer.cornerRadius = 3.0f;
        _button.layer.masksToBounds = YES;
        _button.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _button.layer.borderWidth = 1.0f;
        
        
        
        
    }
    return self;
}

- (void)setShowPageWithImageArray:(NSArray *)array
{
    _scrollView.contentSize = CGSizeMake(Width * array.count, Heigth);
    _pageControl.numberOfPages = array.count;
    _arrayCount = array.count;
    
    for (NSInteger i = 0; i < array.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * Width, 0, Width, Heigth)];
//        imageView.tag = i + 10;
        imageView.image = [UIImage imageNamed:[array objectAtIndex:i]];
        [_scrollView addSubview:imageView];
        if (i == array.count - 1) {
            _button.frame = CGRectMake(i * Width + Width / 2 - 100 / 2, Heigth - 100, 100, 50);
            [_scrollView addSubview:_button];

        }
    }
    
}


- (void)show
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.window addSubview:self];
}

//- (void)buttonAction:(UIButton *)button
//{
////    UIImageView *imageView = [self viewWithTag:_arrayCount - 1 + 10];
//    
//
//}

- (void)disMiss
{
//    [UIView animateWithDuration:2 animations:^{
//        _button.frame = CGRectMake(2 * Width + Width / 2 - 100 / 2, Heigth - 100, 100, 25);
//    } completion:^(BOOL finished) {
//
//    }];
    
    [self removeFromSuperview];
}

- (void)guideInterfaceButtonTarget:(id)target action:(SEL)action
{
    [_button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
