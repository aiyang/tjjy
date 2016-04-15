//
//  TLine.m
//  Study_KLine_2
//
//  Created by totrade on 16/1/19.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//
#import "UIColor+AddColor.h"
#import "NightMode.h"

#import "TLine.h"

@interface TLine ()

@property (nonatomic, strong)NSArray *array;
@property (nonatomic, strong)NSArray *array2;//存储另一条线数据
@property (nonatomic, strong)NSArray *tbackView_Arr;//用于画背景线的数组
@property (nonatomic, strong)NightMode *nightMode;

@end


@implementation TLine

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _nightMode = [[NightMode alloc] init];
        self.backgroundColor = _nightMode.backGroundColor;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    _array = [_tTline_Arr objectAtIndex:0];
    _array2 = [_tTline_Arr objectAtIndex:3];
    
//    NSLog(@"难道rect是0???%@", NSStringFromCGRect(rect));
    [self drawBackLine];
    [self drawTline];
    [self drawTLine2];//画另一条线
}

#pragma 画背景线
- (void)drawBackLine
{
    //背景线,框框里面,横9(边框两根),竖5(边框两根)
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5f);
//    CGContextSetRGBStrokeColor(context, 0.5f, 0.5f, 0.5f, 1.0f);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);

    //画横线
    //横线X轴
    CGFloat x1 = 0.0f;
    CGFloat x2 = self.frame.size.width;
    //横线Y轴
    CGFloat y = 0.0f;
    CGFloat distancex = self.frame.size.height / 10;//常量,即线与线之间的距离
    
    CGFloat dashArray[] = {3, 2};
    CGContextSetLineDash(context, 0, dashArray, 2);//画虚线
    
    for (NSInteger i = 0; i < 11; i++) {
        CGPoint point1 = CGPointMake(x1, y);
        CGPoint point2 = CGPointMake(x2, y);
        const CGPoint points[] = {point1, point2};
        CGContextStrokeLineSegments(context, points, 2);
        y += distancex;
    }
    
    //画竖线
    //竖线X轴
    CGFloat x = 0.0f;
    CGFloat distancey = self.frame.size.width / 6;
    //竖线Y轴
    CGFloat y1 = 0.0f;
    CGFloat y2 = self.frame.size.height;
    for (NSInteger i = 0; i < 7; i++) {
        CGPoint point1 = CGPointMake(x, y1);
        CGPoint point2 = CGPointMake(x, y2);
        const CGPoint points[] = {point1, point2};
        CGContextStrokeLineSegments(context, points, 2);
        x += distancey;
    }
    
    CGContextSetLineDash(context, 0, dashArray, 0);//防止被虚线

    
  
    
}

- (void)drawTline
{
//    NSLog(@"怎么可能画出来呢?%@", _tTline_Arr);
    
    CGContextRef context = UIGraphicsGetCurrentContext();//获取当前图形上下文
    CGContextSetShouldAntialias(context, YES);//设置图形上下文的抗锯齿开启或关闭
    
    CGContextSetLineCap(context, kCGLineCapRound);
    // 线段拐角出设置的三种类型
    // CGLineJoin. kCGLineJoinMiter(直角), kCGLineJoinRound(圆角), kCGLineJoinBevel(平角)
    CGContextSetLineJoin(context, kCGLineJoinRound);
    //设置笔画颜色
//    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1.0);
    CGContextSetStrokeColorWithColor(context, _nightMode.tLine1Color.CGColor);

//    //设置线宽
//    CGContextSetLineWidth(context, 1.0f);
//    CGContextMoveToPoint(context, 0, self.frame.size.height);//设置起点,开始画线
//    
//    NSLog(@"%@", _tTline_Arr);
//    
//    for (NSInteger i = 0; i < _tTline_Arr.count; i++) {
//        CGPoint point = CGPointFromString([_tTline_Arr objectAtIndex:i]);
//        CGContextAddLineToPoint(context, point.x, point.y);
//    }
//    CGContextStrokePath(context);//使用当前 CGContextRef设置的线宽绘制路径
    //设置线宽
    CGContextSetLineWidth(context, 0.5f);
    if (_array.count != 0) {
        
        CGPoint startPoint = CGPointFromString([_array objectAtIndex:0]);
        CGContextMoveToPoint(context, startPoint.x, startPoint.y);//设置起点,开始画线
        
        for (NSInteger i = 1; i < _array.count; i++) {
            CGPoint point = CGPointFromString([_array objectAtIndex:i]);
            CGContextAddLineToPoint(context, point.x, point.y);
        }
        CGContextStrokePath(context);//使用当前 CGContextRef设置的线宽绘制路径
    }
    
  
    

}

- (void)drawTLine2
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();//获取当前图形上下文
    CGContextSetShouldAntialias(context, YES);//设置图形上下文的抗锯齿开启或关闭
    
    CGContextSetLineCap(context, kCGLineCapRound);
    // 线段拐角出设置的三种类型
    CGContextSetLineJoin(context, kCGLineJoinRound);
    //设置笔画颜色

    CGContextSetStrokeColorWithColor(context, _nightMode.tLine2Color.CGColor);

    //设置线宽
    CGContextSetLineWidth(context, 0.5f);
    if (_array2.count != 0) {
        
        CGPoint startPoint = CGPointFromString([_array2 objectAtIndex:0]);
        CGContextMoveToPoint(context, startPoint.x, startPoint.y);//设置起点,开始画线
        
        for (NSInteger i = 1; i < _array2.count; i++) {
            CGPoint point = CGPointFromString([_array2 objectAtIndex:i]);
            CGContextAddLineToPoint(context, point.x, point.y);
        }
        CGContextStrokePath(context);//使用当前 CGContextRef设置的线宽绘制路径
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
