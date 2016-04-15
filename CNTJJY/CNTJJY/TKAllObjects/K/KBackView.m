//
//  KBackView.m
//  Study_KLine_2
//
//  Created by totrade on 16/1/20.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//
#define HH self.frame.size.height
#define WW self.frame.size.width

#define LeftX 5.0f
#define MM (WW - 10.0f)


#import "UIColor+AddColor.h"



#import "KBackView.h"
#import "KLine.h"
#import "SingleSymbolHistoryData_DownObj.h"
#import "DatatTansfer.h"
#import "LineSetTingViewController.h"
#import "CustomNavigationController.h"

#import "NightMode.h"

#import "TimeTools.h"

#import "ShowDohlcView.h"
#import "ShowIndsView.h"

#import "XCIndsSegControl.h"




@interface KBackView ()<XCIndsSegControlDelegate>

@property (nonatomic, strong)NightMode *nightMode;

@property (nonatomic, strong)XCIndsSegControl *topIndsSegControl;//主图选择器
@property (nonatomic, strong)XCIndsSegControl *bottomIndsSegControl;//副图选择器

@property(nonatomic, strong)KLine *kLine;
@property (nonatomic, strong)KLine *minorLine;

@property (nonatomic, assign)NSInteger longPressCount;

@property (nonatomic, strong)NSArray *someArr;//用于存储十字线相关数据及主图底部显示的时间
@property (nonatomic, strong)NSArray *dateArr;//用于存储底部时间的
//十字线
@property (nonatomic, strong)UIView *s_line;
@property (nonatomic, strong)UIView *h_line;
@property (nonatomic, strong)NSArray *judgeArr;
@property (nonatomic, strong)ShowDohlcView *dohlcView;
@property (nonatomic, strong)NSArray *candleArr;



//拖拽
@property (nonatomic, assign)CGFloat panX;

@property (nonatomic, assign)CGFloat cWidth;//实际蜡烛图的宽度应该为影线的1/2加cWidth?
@property (nonatomic, assign)NSInteger cCount;//蜡烛图的个数
@property (nonatomic, assign)NSInteger location;//用于DataTansfer中取数组的位置//默认为0

//缩放
@property (nonatomic, assign)CGFloat pinX;

//副图参数显示
@property (nonatomic, strong)ShowIndsView *indsView;
@property (nonatomic, assign)NSInteger indsType;
@property (nonatomic, strong)NSArray *minorArr;


@end

#warning 目前界面的显示层次应该是这样的,在viewController上有一个View,在view上创建一个KBackView,即该类,backView对象里有_majorBox和_minorBox,这两个box是用于存放绘图后的KLine类的子对象,对就是这样.也就是说目前有4层View

@implementation KBackView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        _nightMode = [[NightMode alloc] init];
        self.backgroundColor = _nightMode.backGroundColor;
        
        _cCount = 30;
        _longPressCount = 0;
        _location = 0;
        
        for (NSInteger i = 0; i < 5; i++) {
            UILabel *majorDateLabel = [[UILabel alloc] init];
            majorDateLabel.tag = i+ 100;
            majorDateLabel.font = [UIFont systemFontOfSize:7];
            majorDateLabel.textColor = _nightMode.tLabelColor;
            [self addSubview:majorDateLabel];
        }
        
        
    }
    return self;
}

//由于K线图分两部分,即主图和副图,所以应该创建两个View对应两个图

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self startKline];
    
   
}


//创建K线视图,即开始画K线,该方法中需要将原始数据整理成可显示数据
- (void)startKline
{
    if (self.dataArr.count != 0) {
        
        //计算蜡烛图的宽度与个数
        [self calculateCWidthCCount];
        
        //加载主视图
        [self loadMajorView];
        
        //主图
        [_kLine setFrame:CGRectMake(LeftX, 30, MM, (HH - 60) * 3 / 5)];
        [_kLine setWithDataArr:_dataArr
                       backPic:theMajor
                        cWidth:_cWidth
                        cCount:_cCount
                           loc:_location
                     majorLine:_majorIndex
                     minorLine:_minorIndex];
        [_kLine setNeedsDisplay];
        
        //获取长按需要显示的所有数据
        [self getLongPressData];
        
        //为时间label赋值
        [self setDateLabelValue];
        
        //加载副视图
        [self loadMinorView];
        
        //副图
        [_minorLine setFrame:CGRectMake(LeftX, 30 + (HH - 60)* 3 / 5 + 20+30, MM, (HH - 60) * 2 / 5 - 20)];
        [_minorLine setWithDataArr:_dataArr
                           backPic:theMinor
                            cWidth:_cWidth
                            cCount:_cCount
                               loc:_location
                         majorLine:_majorIndex
                         minorLine:_minorIndex];
        [_minorLine setNeedsDisplay];
    }
    
    //加载十字架相关视图
    [self loadCorssView];
    
    //加载副图指标显示视图
    [self loadMinorIndsView];
    
    //加载指标选择器
    [self loadIndsSeg];
    
}

- (void)calculateCWidthCCount
{
    if ((_location + _cCount - 1) > _dataArr.count) {
        _location = 0;
    }

    //*-*-*-*-*-*-*-*-*-*-*-*-*-
    
    if (_cCount >= _dataArr.count) {
        _cCount = _dataArr.count;
    }else{
        _cCount = 30 ;
    }
    
    //*-*-*-*-*-*-*-*-*-*-*-*-*-*-
    
    _cWidth = ((MM - LeftEdge * 2) / (CGFloat)_cCount) - YWIDTH - SPACE;

    
    if (_cWidth < 2.0f) {
        _cWidth = 2.0f;
        //(_cWidth + YWIDTH + SPACE)为一个蜡烛图组件的宽度
        _cCount = (MM - LeftEdge * 2) / (_cWidth + YWIDTH + SPACE);
    }
    
    
    


    
    
}

- (void)getLongPressData
{
    _someArr = [DatatTansfer getUI_Press_WithW:MM h:((HH - 60) * 3 / 5) kW:_cWidth loc:_location cCount:_cCount maOrBoll:_majorIndex];
    _judgeArr = [_someArr objectAtIndex:0];
    _dateArr = [TimeTools getNewDateArrWithDateArr:[_someArr objectAtIndex:1] count:5];
    _candleArr = [_someArr objectAtIndex:2];
}

//加载主视图
- (void)loadMajorView
{
    if (!_kLine) {
        _kLine = [[KLine alloc] init];
        _kLine.layer.cornerRadius = 1.0f;
        _kLine.layer.masksToBounds = YES;
        _kLine.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _kLine.layer.borderWidth = 1.0f;
        //捏合
        UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinAction:)];
        [_kLine addGestureRecognizer:pin];
        //长按
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        [_kLine addGestureRecognizer:longPress];
        //拖拽
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [_kLine addGestureRecognizer:pan];
        [self addSubview:_kLine];
    }
}

//加载副视图
- (void)loadMinorView
{
    //副图
    if (!_minorLine) {
        _minorLine = [[KLine alloc] init];
        _minorLine.layer.cornerRadius = 1.0f;
        _minorLine.layer.masksToBounds = YES;
        _minorLine.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _minorLine.layer.borderWidth = 1.0f;
        [self addSubview:_minorLine];
    }
}

- (void)setDateLabelValue
{
    //为时间label赋值
    CGFloat x = 5.0;//横线X轴
    CGFloat y = 30 + ((HH - 60) * 3 / 5);//横线Y轴
    CGFloat distancex = MM / 4;//常量,即线与线之间的距离
    for (NSInteger i = 0; i < 5; i++) {
        UILabel *majorDateLabel = (UILabel *)[self viewWithTag:i + 100];
        [majorDateLabel setFrame:CGRectMake(x - 45 / 2, y, 45, 20)];
        if (i == 0) {
            [majorDateLabel setFrame:CGRectMake(x, y, 45, 20)];
        }else if (i == 4){
            [majorDateLabel setFrame:CGRectMake(x - 45, y, 45, 20)];
        }
        majorDateLabel.text = _dateArr[i];
        x += distancex;
    }
}

//加载十字架相关视图
- (void)loadCorssView
{
    if (!_dohlcView) {//与十字线一起显示的那个方块
        _dohlcView = [[ShowDohlcView alloc] init];
    }
    [_kLine addSubview:_dohlcView];
    [_dohlcView setHidden:YES];
    
    if (!_s_line) {
        _s_line = [[UIView alloc] init];
        _s_line.backgroundColor = _nightMode.hsLineColor;
    }
    [self addSubview:_s_line];
    
    if (!_h_line) {
        _h_line = [[UIView alloc] init];
        _h_line.backgroundColor = _nightMode.hsLineColor;
    }
    [_kLine addSubview:_h_line];
}

- (void)loadMinorIndsView
{
    //副图顶部数据显示
    if (!_indsView) {
        _indsView = [[ShowIndsView alloc] init];
    }
    [_minorLine addSubview:_indsView];
    [_indsView setHidden:YES];
    
    [_indsView setFrame:CGRectMake(50 + LeftX - LeftX, 0, MM - 50, 10)];
    __block ShowIndsView *blockindsView = _indsView;//感觉这个写的不对,少个weak
    __block NSArray *tempArr = [NSArray array];
    NSInteger tempIndsType = _indsType;
    _minorLine.passIndValue = ^(id value){
        _minorArr = value;
        tempArr = value;
        [blockindsView setAllValuesWithArray:tempArr index:0 type:tempIndsType];
    };
    
}


//捏合
- (void)pinAction:(UIPinchGestureRecognizer *)pin
{
    
    if (pin.scale < _pinX) {//缩小
        _cCount += 1;
        if (_cCount <= _dataArr.count && _location >= 1) {
            if (_cWidth != 2.0) {
                _location--;
            }
        }
    }else if (pin.scale > _pinX){//放大
        _cCount -= 1;
        if (_cCount < 5) {//放大最大为_cCount = 5;
            _cCount = 5;
        }
    }

    _pinX = pin.scale;
    [self startKline];
    
}

//长按
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress
{
    
    CGPoint point = [longPress locationInView:self];
    
    [_s_line setHidden:NO];
    [_h_line setHidden:NO];
    [_dohlcView setHidden:NO];
    [_indsView setHidden:NO];
    
    for (NSInteger i = 0; i < _judgeArr.count; i++) {
        CGFloat the_x = [[_judgeArr[i] objectAtIndex:0] floatValue];
        CGFloat the_y = [[_judgeArr[i] objectAtIndex:1] floatValue];
        
         NSLog(@"the_y:%f", the_y);
        
        if (point.x < the_x + _cWidth / 2 && point.x > the_x - _cWidth / 2) {
            [_s_line setFrame:CGRectMake(the_x + LeftX, 30, 1.0f, HH - 60)];
            [_h_line setFrame:CGRectMake(0, the_y, MM, 1.0f)];
            
            //十字架赋值
            [_dohlcView setAllLabelValueWithDateArr:_someArr candleArr:_candleArr index:i];
            //副图赋值
            [_indsView setAllValuesWithArray:_minorArr index:i type:_indsType];
        }
        
    }
    
    
    //显示日期开高低收的view的位置
    if (point.x <= MM / 2) {
        [_dohlcView setFrame:CGRectMake(MM - 55, 0, 55, 55)];
    }else if (point.x > MM / 2){
        [_dohlcView setFrame:CGRectMake(0, 0, 55, 55)];
    }
    
    if (longPress.state == UIGestureRecognizerStateEnded) {
        [_s_line setHidden:YES];
        [_h_line setHidden:YES];
        [_dohlcView setHidden:YES];
        [_indsView setHidden:YES];
        
    }
}

//拖拽
- (void)panAction:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:_kLine];
    
    //计算界面容纳蜡烛图的个数
    NSInteger candleCount = (MM - LeftEdge * 2) / (_cWidth + YWIDTH + SPACE);//_kLine_Width /
    
    //计算_location最大的点
    NSInteger maxLocation = _dataArr.count - candleCount;
    if (maxLocation < 0) {
        maxLocation = 0;
    }
    
    if (point.x > _panX) {//往右拖拽,右移
    
        _location++ ;       //这个不太好判断
        //
      //  NSLog(@"--------%d",_location);
        if (_location > maxLocation) {
            _location = maxLocation;
        }
    }else if (point.x == _panX){//不动
        
    }else if (point.x < _panX){//往左拖拽,左移
        _location--;
        if (_location < 0) {
            _location = 0;
        }
        
    }
    _panX = point.x;//计算完_location后在赋值,可以用于记录上一次point.x的数据
    
    
    [self startKline];
}




//加载指标选择控件
- (void)loadIndsSeg
{
    if (!_topIndsSegControl) {
        _topIndsSegControl = [[XCIndsSegControl alloc] initWithType:1 delegate:self];
        [self addSubview:_topIndsSegControl];
    }
    [_topIndsSegControl setFrame:CGRectMake(0, 0, WW, 30)];
    
    if (!_bottomIndsSegControl) {
        _bottomIndsSegControl = [[XCIndsSegControl alloc] initWithType:2 delegate:self];
        [self addSubview:_bottomIndsSegControl];
    }
    [_bottomIndsSegControl setFrame:CGRectMake(0, HH - 30-((HH - 60) * 2 / 5 - 20), WW, 30)];
}


//指标切换及其设置按钮
- (void)indexButton:(id)tkindex index:(NSInteger)index isSet:(BOOL)isSet
{
    
    if (!isSet) {
        if (tkindex == _topIndsSegControl) {
            _majorIndex = index;
        }else if (tkindex == _bottomIndsSegControl){
            _minorIndex = index;
            _indsType = index;
        }
        [self startKline];
    }else{
        LineSetTingViewController *lineSettingVC = [[LineSetTingViewController alloc] init];
        if (tkindex == _topIndsSegControl) {
            lineSettingVC.zhuFuType = 0;
        }else if (tkindex == _bottomIndsSegControl){
            lineSettingVC.zhuFuType = 1;
        }
        lineSettingVC.indsType = index;
        lineSettingVC.dataArr = _dataArr;
        CustomNavigationController *lineSettingNC = [[CustomNavigationController alloc] initWithRootViewController:lineSettingVC];
        [self.target presentViewController:lineSettingNC animated:YES completion:^{
            
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
