//
//  LineSetTingViewController.m
//  CNTJJY
//
//  Created by totrade on 16/1/25.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "LineSetTingViewController.h"
#import "IndSetWidget.h"

//#pragma 用于指标的参数设定
#import "IndsParameters.h"

#import "DatatTansfer.h"


@interface LineSetTingViewController ()

@property (nonatomic, strong)IndSetWidget *indSelWidget;
@property (nonatomic, strong)IndsParameters *indsParameter;
@property (nonatomic, strong)DataManage *dataManage;

@property (nonatomic, strong)NSString *indsName;
@property (nonatomic, assign)NSInteger widgetCount;
@property (nonatomic, strong)NSArray *indPMSArr;


@property (nonatomic, strong)UIScrollView *scrollView;

@end

@implementation LineSetTingViewController

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIView *cleanOffsetView ;
    if (MAINSCREEN_WIDTH > MAINSCREEN_HEIGHT) {
        cleanOffsetView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN_HEIGHT, 1)];
    }else{
        cleanOffsetView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, 1)];
    }
    
    [self.view addSubview:cleanOffsetView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    
    _indsParameter = [[IndsParameters alloc] init];
    
    if (_zhuFuType == 0) {
    }else if (_zhuFuType == 1){
        _indsType = _indsType + 2;
    }
    
    //数据存储所用到的key值,不可写错
    NSArray *inds_PMS = @[@"ma_PMS", @"boll_PMS", @"macd_PMS", @"kdj_PMS", @"rsi_PMS", @"bias_PMS", @"cci_PMS", @"psy_PMS", @"obv_PMS", @"vol_PMS"];
    _indsName = [inds_PMS objectAtIndex:_indsType];
    self.navigationItem.title = [_indsName stringByReplacingOccurrencesOfString:@"_PMS" withString:@""];
    
    //控件显示个数
    NSArray *widgetCountArr = @[@4, @1, @3, @3, @3, @3, @1, @2, @1, @2];
    _widgetCount = [[widgetCountArr objectAtIndex:_indsType] integerValue];
    
    //slider的最大最小值
    NSArray *MaxMinArr = @[@[@1, @1000],
                           @[@1, @120],
                           @[@1, @200],
                           @[@[@1, @90], @[@1, @30], @[@1, @30]],
                           @[@[@1, @120], @[@1, @250], @[@1, @500]],
                           @[@1, @250],
                           @[@1, @100],
                           @[@1, @100],
                           @[@1, @100],
                           @[@1, @500]];
    NSArray *sliderMaxMinArr = [MaxMinArr objectAtIndex:(int)_indsType];
    
    _indPMSArr = [_indsParameter getIndPMSWithType:(int)_indsType];
//    _widgetCount = _indPMSArr.count;
    
    for (NSInteger i = 0; i < _widgetCount; i++) {
        _indSelWidget = [IndSetWidget instanceIndSetWidget];
        
        if (MAINSCREEN_WIDTH>MAINSCREEN_HEIGHT) {
            _indSelWidget.frame = CGRectMake(0, 64 + 100 * i, MAINSCREEN_HEIGHT, 100);
        }
        else{
            _indSelWidget.frame = CGRectMake(0, 64 + 100 * i, MAINSCREEN_WIDTH, 100);
        }
        _indSelWidget.tag = i + 1;
        _indSelWidget.leftButton.tag = i + 1;
        _indSelWidget.rightButton.tag = i + 1;
        _indSelWidget.slider.tag = i + 1;
        
        _indSelWidget.slider.minimumValue = 1;
        
        if (sliderMaxMinArr.count == 2) {
            _indSelWidget.slider.maximumValue = [sliderMaxMinArr[1] integerValue];
        }else{
            _indSelWidget.slider.maximumValue = [[[sliderMaxMinArr objectAtIndex:i] objectAtIndex:1] integerValue];
        }
        _indSelWidget.leftLabel.text = [NSString stringWithFormat:@"移动平均线(1-%.0f):", _indSelWidget.slider.maximumValue];

        _indSelWidget.slider.value = [[_indPMSArr objectAtIndex:i] integerValue];
        _indSelWidget.rightLabel.text = [NSString stringWithFormat:@"%.0f", _indSelWidget.slider.value];
        
        [_indSelWidget leftButtonTarget:self action:@selector(leftAction:)];
        [_indSelWidget rightButtonTarget:self action:@selector(rightAction:)];
        [_indSelWidget sliderTarget:self action:@selector(sliderAction:)];
        [_scrollView addSubview:_indSelWidget];
    }
    
//    _userNameBackView.layer.cornerRadius = 3.0f;
//    _userNameBackView.layer.masksToBounds = YES;
//    _userNameBackView.layer.borderColor = [UIColor colorFromHexCode:@"#F0F2F2"].CGColor;
//    _userNameBackView.layer.borderWidth = 1.0f;
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeSystem];
    if (MAINSCREEN_WIDTH>MAINSCREEN_HEIGHT) {
        clearButton.frame = CGRectMake(10, 64 + _widgetCount * 100 + 20, MAINSCREEN_HEIGHT - 20, 35);
    }else{
        clearButton.frame = CGRectMake(10, 64 + _widgetCount * 100 + 20, MAINSCREEN_WIDTH - 20, 35);

    }
    [clearButton setTitle:@"恢复默认" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(clearButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    clearButton.layer.cornerRadius = 3.0f;
    clearButton.layer.masksToBounds = YES;
    clearButton.backgroundColor = [UIColor grayColor];
    clearButton.tintColor = [UIColor whiteColor];
    [_scrollView addSubview:clearButton];
    
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeSystem];
    okButton.frame = CGRectMake(10, CGRectGetMaxY(clearButton.frame) + 15, 75, 35);
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(okButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    okButton.layer.cornerRadius = 3.0f;
    okButton.layer.masksToBounds = YES;
    okButton.backgroundColor = [UIColor colorFromHexCode:@"#008B2C"];
    okButton.tintColor = [UIColor whiteColor];
    [_scrollView addSubview:okButton];
    
    UIButton *noButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    if (MAINSCREEN_WIDTH>MAINSCREEN_HEIGHT) {
        noButton.frame = CGRectMake(MAINSCREEN_HEIGHT - 10 - 75, CGRectGetMaxY(clearButton.frame) + 15, 75, 35);

    }else{
        noButton.frame = CGRectMake(MAINSCREEN_WIDTH - 10 - 75, CGRectGetMaxY(clearButton.frame) + 15, 75, 35);
    }
    [noButton setTitle:@"取消" forState:UIControlStateNormal];
    [noButton addTarget:self action:@selector(noButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    noButton.layer.cornerRadius = 3.0f;
    noButton.layer.masksToBounds = YES;
    noButton.backgroundColor = [UIColor grayColor];
    noButton.tintColor = [UIColor whiteColor];
    [_scrollView addSubview:noButton];
    
    
    if (MAINSCREEN_WIDTH>MAINSCREEN_HEIGHT) {
        _scrollView.contentSize = CGSizeMake(MAINSCREEN_HEIGHT, CGRectGetMaxY(noButton.frame) + 50);
    }else{
        _scrollView.contentSize = CGSizeMake(MAINSCREEN_WIDTH, CGRectGetMaxY(noButton.frame) + 50);
    }
    
    //导航左侧返回键
    UIButton *leftButton = [UIButton backButtonWithImageName:@"back" target:self action:@selector(backBarAction:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];

}
- (void)backBarAction:(id)barButton
{
    [self pushToTopController];
}




//IndSetWidget子控件action
- (void)leftAction:(UIButton *)button
{
    IndSetWidget *indSelWidget = [self.view viewWithTag:button.tag];
    indSelWidget.slider.value--;//tag值等于0会崩
    indSelWidget.rightLabel.text = [NSString stringWithFormat:@"%.0f", indSelWidget.slider.value];
}

//IndSetWidget子控件action
- (void)rightAction:(UIButton *)button
{
    IndSetWidget *indSelWidget = [self.view viewWithTag:button.tag];
    indSelWidget.slider.value++;
    indSelWidget.rightLabel.text = [NSString stringWithFormat:@"%.0f", indSelWidget.slider.value];
}

//IndSetWidget子控件action
- (void)sliderAction:(UISlider *)slider
{
    IndSetWidget *indSelWidget = [self.view viewWithTag:slider.tag];
    indSelWidget.rightLabel.text = [NSString stringWithFormat:@"%.0f", indSelWidget.slider.value];
}



- (void)okButtonAction:(UIButton *)button
{
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSInteger i = 0; i < _widgetCount; i++) {
        IndSetWidget *indSelWidget = [self.view viewWithTag:i + 1];
        [tempArr addObject:indSelWidget.rightLabel.text];
    }
    [_indsParameter setIndArr:tempArr forKey:_indsName];//保存设置参数
    
    [ShowToast showInBackMessage:@"设置成功"];
    
    [self pushToTopController];
}

- (void)noButtonAction:(UIButton *)button
{
    [self pushToTopController];
}

- (void)clearButtonAction:(UIButton *)button
{
    [DataManage removeUserDefaultsObjectForKey:@"indsDic"];
    _indsParameter = [[IndsParameters alloc] init];
    _indPMSArr = [_indsParameter getIndPMSWithType:(int)_indsType];
    for (NSInteger i = 0; i < _widgetCount; i++) {
        IndSetWidget *indSelWidget = [self.view viewWithTag:i + 1];
        indSelWidget.slider.value = [[_indPMSArr objectAtIndex:i] integerValue];
        indSelWidget.rightLabel.text = [NSString stringWithFormat:@"%.0f", indSelWidget.slider.value];
    }
    
    [DatatTansfer getInitialIndsDataWithDadaArr:_dataArr];//计算指标在获取到数据之后即进行计算

    [ShowToast showInBackMessage:@"恢复成功"];

//    [self pushToTopController];
}



- (void)pushToTopController
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
