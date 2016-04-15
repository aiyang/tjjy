//
//  KLine.m
//  Study_KLine_2
//
//  Created by totrade on 16/1/19.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//
#import "UIColor+AddColor.h"

#define HH self.frame.size.height
#define WW self.frame.size.width



#import "KLine.h"
#import "DatatTansfer.h"

#import "NightMode.h"

@interface KLine ()

@property (nonatomic, strong)NightMode *nightMode;



@property (nonatomic, strong)NSArray *dataArr;
@property (nonatomic, assign)CGFloat cWidth;//实际蜡烛图的宽度应该为影线的1/2加cWidth
@property (nonatomic, assign)BackPic backPic;
@property (nonatomic, assign)NSInteger cCount;//蜡烛图的个数
@property (nonatomic, assign)THEMajorLine theMajorline;
@property (nonatomic, assign)THEMinorLine theMinorline;
@property (nonatomic, assign)NSInteger location;

@property (nonatomic, strong)NSArray *candleMa_Arr;
@property (nonatomic, strong)NSArray *candleBoll_Arr;
@property (nonatomic, strong)NSArray *macd_Arr;
@property (nonatomic, strong)NSArray *kdj_Arr;
@property (nonatomic, strong)NSArray *rsi_Arr;
@property (nonatomic, strong)NSArray *bias_Arr;
@property (nonatomic, strong)NSArray *cci_Arr;
@property (nonatomic, strong)NSArray *psy_Arr;
@property (nonatomic, strong)NSArray *obv_Arr;
@property (nonatomic, strong)NSArray *vol_Arr;

@property (nonatomic, strong)NSArray *majorMaxMinArr;
@property (nonatomic, strong)NSArray *minorMaxMinArr;

@end

@implementation KLine



- (instancetype)initWithFrame:(CGRect)frame
{
    NSLog(@"111");
    self = [super initWithFrame:frame];
    if (self) {
        
        _nightMode = [[NightMode alloc] init];
        self.backgroundColor = _nightMode.backGroundColor;
        
        _backPic = theMinor;//默认为主图
        
        //主图左侧数据显示label
        for (NSInteger i = 0; i < 5; i++) {
            UILabel *majorLeftLabel = [[UILabel alloc] init];
            majorLeftLabel.tag = i+ 100;
            majorLeftLabel.font = [UIFont systemFontOfSize:9];
            majorLeftLabel.textColor = _nightMode.tLabelColor;
            [self addSubview:majorLeftLabel];
        }
        
        //副图左侧数据显示label
        for (NSInteger i = 0; i < 3; i++) {
            UILabel *minorLeftLabel = [[UILabel alloc] init];
            minorLeftLabel.tag = i+ 300;
            minorLeftLabel.font = [UIFont systemFontOfSize:9];
            minorLeftLabel.textColor = _nightMode.tLabelColor;
            [self addSubview:minorLeftLabel];
            
        }
    }
    return self;
}



//画图是在这里画
- (void)drawRect:(CGRect)rect
{
    
    switch (_backPic) {
        case theMajor:{//画主图
        
            [self drawMajorLine];
                [self drawMajorBackLine];//画主图背景线
        }
            break;
            
        case theMinor:{//画副图
          
            [self drawMinorLine];
              [self drawMinorBackLine];//画副图背景线
        }
            break;
            
        default:
            break;
    }
    
    
    
}





//画主图线
- (void)drawMajorLine
{
    switch (_theMajorline) {
        case TheMA:{
            NSArray *sum_candleMa_Arr = [DatatTansfer getUI_CandleMa_WithW:WW h:HH kW:_cWidth loc:_location cCount:_cCount];
            _candleMa_Arr = [sum_candleMa_Arr objectAtIndex:0];
            _majorMaxMinArr = [sum_candleMa_Arr objectAtIndex:1];
            [self drawMALine];
        }
            break;
            
        case TheBOLL:{
            NSArray *sum_candleBoll_Arr = [DatatTansfer getUI_CandleBoll_WithW:WW h:HH kW:_cWidth loc:_location cCount:_cCount];
            _candleBoll_Arr = [sum_candleBoll_Arr objectAtIndex:0];
            _majorMaxMinArr = [sum_candleBoll_Arr objectAtIndex:1];
            [self drawBollLine];
        }
            break;
            
            
        default:
            break;
    }
}




//画副图线
- (void)drawMinorLine
{
    
    switch (_theMinorline) {
        case TheMACD:{
            NSArray *sum__macd_Arr = [DatatTansfer getUI_Macd_WithW:WW h:HH kW:_cWidth loc:_location cCount:_cCount];
            _macd_Arr = [sum__macd_Arr objectAtIndex:0];
            _minorMaxMinArr = [sum__macd_Arr objectAtIndex:1];
            [self drawMACDLine];
            _passIndValue([sum__macd_Arr objectAtIndex:2]);
        }
            break;
            
        case TheKDJ:{
            NSArray *sum_kdj_Arr = [DatatTansfer getUI_Kdj_WithW:WW h:HH kW:_cWidth loc:_location cCount:_cCount];
            _kdj_Arr = [sum_kdj_Arr objectAtIndex:0];
            _minorMaxMinArr = [sum_kdj_Arr objectAtIndex:1];
            _passIndValue([sum_kdj_Arr objectAtIndex:2]);
            [self drawKDJLine];
        }
            break;
            
        case TheRSI:{
            NSArray *sum_rsi_Arr = [DatatTansfer getUI_Rsi_WithW:WW h:HH kW:_cWidth loc:_location cCount:_cCount];
            _rsi_Arr = [sum_rsi_Arr objectAtIndex:0];
            _minorMaxMinArr = [sum_rsi_Arr objectAtIndex:1];
            _passIndValue([sum_rsi_Arr objectAtIndex:2]);
            [self drawRSILine];//rsi算法有问题!!!
        }
            break;
            
        case TheBIAS:{
            NSArray *sum_bias_Arr = [DatatTansfer getUI_Bias_WithW:WW h:HH kW:_cWidth loc:_location cCount:_cCount];
            _bias_Arr = [sum_bias_Arr objectAtIndex:0];
            _minorMaxMinArr = [sum_bias_Arr objectAtIndex:1];
            _passIndValue([sum_bias_Arr objectAtIndex:2]);
            [self drawBIASLine];
        }
            break;
            
        case TheCCI:{
            
            NSArray *sum_cci_Arr = [DatatTansfer getUI_Cci_WithW:WW h:HH kW:_cWidth loc:_location cCount:_cCount];
            _cci_Arr = [sum_cci_Arr objectAtIndex:0];
            _minorMaxMinArr = [sum_cci_Arr objectAtIndex:1];
            _passIndValue([sum_cci_Arr objectAtIndex:2]);
            [self drawCCiLine];
        }
            break;
            
        case ThePSY:{
            NSArray *sum_psy_Arr = [DatatTansfer getUI_Psy_WithW:WW h:HH kW:_cWidth loc:_location cCount:_cCount];
            _psy_Arr = [sum_psy_Arr objectAtIndex:0];
            _minorMaxMinArr = [sum_psy_Arr objectAtIndex:1];
            _passIndValue([sum_psy_Arr objectAtIndex:2]);
            [self drawPSYLine];
        }
            break;
            
        case TheObv:{
            NSArray *sum_obv_Arr = [DatatTansfer getUI_Obv_WithW:WW h:HH kW:_cWidth loc:_location cCount:_cCount];
            _obv_Arr = [sum_obv_Arr objectAtIndex:0];
            _minorMaxMinArr = [sum_obv_Arr objectAtIndex:1];
            _passIndValue([sum_obv_Arr objectAtIndex:2]);
            [self drawOBVLine];
        }
            break;
            
        case TheVol:{
            NSArray *sum_vol_Arr = [DatatTansfer getUI_Vol_WithW:WW h:HH kW:_cWidth loc:_location cCount:_cCount];
            _vol_Arr = [sum_vol_Arr objectAtIndex:0];
            _minorMaxMinArr = [sum_vol_Arr objectAtIndex:1];
            _passIndValue([sum_vol_Arr objectAtIndex:2]);
            [self drawVOLLine];
        }
            break;
            
        default:
            break;
    }
    
    
}

- (void)drawMALine
{
    //画K线
    [self drawKLineWithArr:_candleMa_Arr];
    
    //画MA5均线
    [self draw_Line_WithArray:_candleMa_Arr index:4 sColor:[_nightMode.maColorArr objectAtIndex:0]];
    //画MA10均线
    [self draw_Line_WithArray:_candleMa_Arr index:5 sColor:[_nightMode.maColorArr objectAtIndex:1]];
    //画MA20均线
    [self draw_Line_WithArray:_candleMa_Arr index:6 sColor:[_nightMode.maColorArr objectAtIndex:2]];
    //画MA60均线
    [self draw_Line_WithArray:_candleMa_Arr index:7 sColor:[_nightMode.maColorArr objectAtIndex:3]];
    
}

- (void)drawBollLine
{
    //画K线
    [self drawKLineWithArr:_candleBoll_Arr];
    //画布林上
    [self draw_Line_WithArray:_candleBoll_Arr index:4 sColor:[_nightMode.bollColorArr objectAtIndex:0]];
    //画布林中
    [self draw_Line_WithArray:_candleBoll_Arr index:5 sColor:[_nightMode.bollColorArr objectAtIndex:1]];
    //画布林下
    [self draw_Line_WithArray:_candleBoll_Arr index:6 sColor:[_nightMode.bollColorArr objectAtIndex:2]];
    
}

- (void)drawMACDLine
{
    NSMutableArray *macdArr = [NSMutableArray array];
    for (NSInteger i = 0; i < _macd_Arr.count; i++) {
        NSArray *smallArr = [_macd_Arr objectAtIndex:i];
        [macdArr addObject:@[smallArr[2], smallArr[3]]];
    }
    [self drawMacdWithMacdArr:macdArr];
    [self draw_Line_WithArray:_macd_Arr index:0 sColor:[_nightMode.macdColorArr objectAtIndex:0]];
    [self draw_Line_WithArray:_macd_Arr index:1 sColor:[_nightMode.macdColorArr objectAtIndex:1]];
    
}

- (void)drawMacdWithMacdArr:(NSArray *)macdArr
{
    for (NSInteger i = 0; i < macdArr.count; i++) {
        NSArray *tempArr = macdArr[i];
        CGPoint macd = CGPointFromString(tempArr[0]);
        CGPoint lingPoint = CGPointFromString(tempArr[1]);
        if (lingPoint.y < macd.y) {//原点之下
            [self drawSingleMacdWithMacd:macd lingPoint:lingPoint sColor:[UIColor greenColor] sPoint:lingPoint];
        }else if (lingPoint.y == macd.y){//等于原点
            [self drawSingleMacdWithMacd:macd lingPoint:lingPoint sColor:[UIColor whiteColor] sPoint:macd];
        }else if (lingPoint.y > macd.y){//原点之上
            [self drawSingleMacdWithMacd:macd lingPoint:lingPoint sColor:[UIColor redColor] sPoint:macd];
        }
    }
    
}



- (void)drawSingleMacdWithMacd:(CGPoint)macd lingPoint:(CGPoint)ling sColor:(UIColor*)sColor sPoint:(CGPoint)sPoint
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    CGContextSetLineWidth(context, _cWidth);
    
    //画线段
    CGPoint H = macd;
    CGPoint L = ling;
    const CGPoint points[] = {H, L};
    //线段
    CGContextSetStrokeColorWithColor(context, sColor.CGColor);//线框颜色
    CGContextStrokeLineSegments(context, points, 2);//绘制线段
    
}

- (void)drawKDJLine
{
    [self draw_Line_WithArray:_kdj_Arr index:0 sColor:[_nightMode.kdjColorArr objectAtIndex:0]];
    [self draw_Line_WithArray:_kdj_Arr index:1 sColor:[_nightMode.kdjColorArr objectAtIndex:1]];
    [self draw_Line_WithArray:_kdj_Arr index:2 sColor:[_nightMode.kdjColorArr objectAtIndex:2]];
    
}

- (void)drawRSILine
{
    
    [self draw_Line_WithArray:_rsi_Arr index:0 sColor:[_nightMode.rsiColorArr objectAtIndex:0]];
    [self draw_Line_WithArray:_rsi_Arr index:1 sColor:[_nightMode.rsiColorArr objectAtIndex:1]];
    [self draw_Line_WithArray:_rsi_Arr index:2 sColor:[_nightMode.rsiColorArr objectAtIndex:2]];
    
}

- (void)drawBIASLine
{
    [self draw_Line_WithArray:_bias_Arr index:0 sColor:[_nightMode.biasColorArr objectAtIndex:0]];
    [self draw_Line_WithArray:_bias_Arr index:1 sColor:[_nightMode.biasColorArr objectAtIndex:1]];
    [self draw_Line_WithArray:_bias_Arr index:2 sColor:[_nightMode.biasColorArr objectAtIndex:2]];
}

- (void)drawCCiLine
{
    [self draw_Line_WithArray:_cci_Arr index:0 sColor:_nightMode.cciColor];
    
}

- (void)drawPSYLine
{
    
    [self draw_Line_WithArray:_psy_Arr index:0 sColor:[_nightMode.psyColorArr objectAtIndex:0]];
    [self draw_Line_WithArray:_psy_Arr index:1 sColor:[_nightMode.psyColorArr objectAtIndex:1]];
}

- (void)drawOBVLine
{
    
    [self draw_Line_WithArray:_obv_Arr index:0 sColor:[_nightMode.obvColorArr objectAtIndex:0]];
    [self draw_Line_WithArray:_obv_Arr index:1 sColor:[_nightMode.obvColorArr objectAtIndex:1]];
}

- (void)drawVOLLine
{
    //画成交量
    for (NSInteger i = 0; i < _vol_Arr.count; i++) {
        NSArray *tempArr = _vol_Arr[i];
        CGPoint vol = CGPointFromString(tempArr[0]);
        CGPoint lingPoint = CGPointFromString(tempArr[1]);
        [self drawSingleMacdWithMacd:vol lingPoint:lingPoint sColor:[UIColor redColor] sPoint:vol];
    }

    //画两条线
    [self draw_Line_WithArray:_vol_Arr index:2 sColor:[_nightMode.volColorArr objectAtIndex:0]];
    [self draw_Line_WithArray:_vol_Arr index:3 sColor:[_nightMode.volColorArr objectAtIndex:1]];
}

//画K线,这里不是统称,就是蜡烛图
- (void)drawKLineWithArr:(NSArray *)theArr
{
    //画蜡烛图
    for (NSArray *arr in theArr) {//arr中,第一个为high,第二个为low,第三个为open,第四个为close
        
        //画蜡烛(由于要判断,所以才取出来)
        CGPoint O = CGPointFromString(arr[0]);
        CGPoint C = CGPointFromString(arr[3]);
        
        //NSLog(@"打印所有收盘价:%f", C.y);
        
#warning 既然分两种画法,那么还不如实心的线也用这种方法好了,无非改变里面的填充颜色罢了
        if (O.y > C.y) {//收盘价大于开盘价,红色空心//但是对于y轴来说,上面小,下面大与真实值正好相反
            //画蜡烛图
            [self drawCandleWithArray:arr k_Y:C.y sColor:[UIColor redColor] fColor:[UIColor redColor]];//_nightMode.backGroundColor
        }else if (O.y == C.y){//开盘价等于收盘价
            [self drawCandleWithArray:arr k_Y:C.y sColor:[UIColor lightGrayColor] fColor:[UIColor whiteColor]];
        }else if (O.y < C.y){//收盘价小于开盘价,绿色,实心
            [self drawCandleWithArray:arr k_Y:O.y sColor:[UIColor greenColor] fColor:[UIColor greenColor]];
        }
    }
}

//candle,绘制蜡烛图
- (void)drawCandleWithArray:(NSArray *)array k_Y:(CGFloat)k_y sColor:(UIColor *)sColor fColor:(UIColor *)fColor
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, YWIDTH);//线宽,上下影线的宽度
    //画线段
    CGPoint H = CGPointFromString(array[1]);
    CGPoint L = CGPointFromString(array[2]);
    const CGPoint points[] = {H, L};
    //线段
    CGContextSetStrokeColorWithColor(context, sColor.CGColor);//线框颜色//有这方法早说呀,擦,还用啥RGB
    CGContextStrokeLineSegments(context, points, 2);//绘制线段
    
    //画蜡烛
    CGPoint O = CGPointFromString(array[0]);
    CGPoint C = CGPointFromString(array[3]);
    //        //矩形，并填弃颜色
    CGContextSetStrokeColorWithColor(context, sColor.CGColor);//线框颜色
    CGContextSetFillColorWithColor(context, fColor.CGColor);//填充颜色
    //此处Y轴应该取开收中大的进行绘图
    
    CGContextAddRect(context,CGRectMake(O.x, k_y, _cWidth, fabs(O.y - C.y)));//画方框
    
    CGContextDrawPath(context, kCGPathFillStroke);//绘制矩形路径
    
    
}



//#warning 归纳起来,一共就只有三种画线方式,蜡烛图,线,线段//candle,line,lineSeg
- (void)draw_Line_WithArray:(NSArray *)array index:(NSInteger)index sColor:(UIColor *)sColor
{
    CGContextRef context = UIGraphicsGetCurrentContext();//获取当前图形上下文
    //设置笔画颜色
    CGContextSetStrokeColorWithColor(context, sColor.CGColor);
    //设置线宽
    CGContextSetLineWidth(context, 1.0f);
    //取_kLine_Arr中的均线第一个点作为起点
    CGPoint startPoint = CGPointFromString([array[0] objectAtIndex:index]);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);//设置起点,开始画线
    
    
    for (NSInteger i = 1; i < array.count; i++) {//第一个点作为起点被取走,所以i = 1
        NSArray *arr = array[i];
        CGPoint point = CGPointFromString(arr[index]);
        if (point.y != CGFLOAT_MAX) {
            CGContextAddLineToPoint(context, point.x, point.y);
        }
        
    }
    CGContextStrokePath(context);//使用当前 CGContextRef设置的线宽绘制路径
}



- (void)drawMajorBackLine
{
    //背景线,框框里面
    //主图:横5(包括边框两根),竖5(包括边框两根)
    //副图:横3(包括边框两根),竖5(包括边框两根)
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.25f);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    
    //画横线
    //横线X轴
    CGFloat x1 = 0.0f;
    CGFloat x2 = self.frame.size.width;
    //横线Y轴
    CGFloat y = 0.0f;
    CGFloat distancex = self.frame.size.height / 4;//常量,即线与线之间的距离
    
    CGFloat dashArray[] = {3, 2};
    CGContextSetLineDash(context, 0, dashArray, 2);//画虚线
    
    CGFloat maxF = [_majorMaxMinArr[0] floatValue];
    CGFloat theGap = [_majorMaxMinArr[1] floatValue] / 4;
    
    
    
    
    for (NSInteger i = 0; i < 5; i++) {
        CGContextMoveToPoint(context, x1, y);//开始画线, x，y 为开始点的坐标
        CGContextAddLineToPoint(context, x2, y);//画直线, x，y 为线条结束点的坐标
        CGContextStrokePath(context);//开始画线
        
        //为majorLeftLabel赋值
        UILabel *leftlabel = (UILabel *)[self viewWithTag:i + 100];
        [leftlabel setFrame:CGRectMake(0, y, 75, 20)];
        if (i == 4) {
            [leftlabel setFrame:CGRectMake(0, y - 15, 75, 20)];
        }
        
        leftlabel.text = [NSString stringWithFormat:@"%.2f", maxF - theGap * i];
        
        y += distancex;//从上往下画
    }
    
    //            CGContextStrokeLineSegments/CGContextStrokePath//都可以用于画线段
    
    //画竖线
    //竖线X轴
    CGFloat x = 0.0f;
    CGFloat distancey = self.frame.size.width / 4;
    //竖线Y轴
    CGFloat y1 = 0.0f;
    CGFloat y2 = self.frame.size.height;
    
    for (NSInteger i = 0; i < 5; i++) {
        CGPoint point1 = CGPointMake(x, y1);
        CGPoint point2 = CGPointMake(x, y2);
        const CGPoint points[] = {point1, point2};
        CGContextStrokeLineSegments(context, points, 2);
        x += distancey;
    }
    
    CGContextSetLineDash(context, 0, dashArray, 0);//防止被虚线
}

- (void)drawMinorBackLine
{
    
    //背景线,框框里面
    //主图:横5(包括边框两根),竖5(包括边框两根)
    //副图:横3(包括边框两根),竖5(包括边框两根)
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.25f);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    //画横线
    //横线X轴
    CGFloat x1 = 0.0f;
    CGFloat x2 = self.frame.size.width;
    //横线Y轴
    CGFloat y = 0.0f;
    CGFloat distancex = self.frame.size.height / 2;//常量,即线与线之间的距离
    
    for (NSInteger i = 0; i < 3; i++) {
        CGPoint point1 = CGPointMake(x1, y);
        CGPoint point2 = CGPointMake(x2, y);
        const CGPoint points[] = {point1, point2};
        CGContextStrokeLineSegments(context, points, 2);
        
        //为majorLeftLabel赋值
        if (i == 0) {
            UILabel *leftlabel = (UILabel *)[self viewWithTag:i + 300];
            [leftlabel setFrame:CGRectMake(0, y, 75, 20)];
            leftlabel.text = [NSString stringWithFormat:@"%.2f", [_minorMaxMinArr[0] floatValue]];
        }else if (i == 2){
            UILabel *leftlabel = (UILabel *)[self viewWithTag:i + 300];
            [leftlabel setFrame:CGRectMake(0, y - 15, 75, 20)];
            
            leftlabel.text = [NSString stringWithFormat:@"%.2f", [_minorMaxMinArr[1] floatValue]];
            
        }
        
        
        y += distancex;
    }
    
    //画竖线
    //竖线X轴
    CGFloat x = 0.0f;
    CGFloat distancey = self.frame.size.width / 4;
    //竖线Y轴
    CGFloat y1 = 0.0f;
    CGFloat y2 = self.frame.size.height;
    for (NSInteger i = 0; i < 5; i++) {
        CGPoint point1 = CGPointMake(x, y1);
        CGPoint point2 = CGPointMake(x, y2);
        const CGPoint points[] = {point1, point2};
        CGContextStrokeLineSegments(context, points, 2);
        x += distancey;
    }
}

- (void)setWithDataArr:(NSArray *)dataArr
               backPic:(BackPic)backPic
                cWidth:(CGFloat)cWidth
                cCount:(NSInteger)cCount
                   loc:(NSInteger)location
             majorLine:(THEMajorLine)theMajarline
             minorLine:(THEMinorLine)theMinorline
{
    _dataArr = dataArr;
    _backPic = backPic;
    _cWidth = cWidth;
    _cCount = cCount;
    _location = location;
    _theMajorline = theMajarline;
    _theMinorline = theMinorline;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
