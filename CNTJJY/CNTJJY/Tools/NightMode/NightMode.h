//
//  NightMode.h
//  CNTJJY
//
//  Created by totrade on 16/2/19.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

///由于app中的产品详情界面分夜间模式和日间模式,两种模式下很多控件及线的颜色不一样,故用作统一管理
#import <Foundation/Foundation.h>

@interface NightMode : NSObject

@property (nonatomic, assign)BOOL isNightMode;

@property (nonatomic, strong)UIColor *backGroundColor;

@property (nonatomic, strong)UIColor *tLabelColor;

@property (nonatomic, strong)UIColor *buttonDisSelColor;

@property (nonatomic, strong)UIColor *syNameColor;

@property (nonatomic, strong)UIColor *tLine1Color;
@property (nonatomic, strong)UIColor *tLine2Color;
@property (nonatomic, strong)UIColor *yCloseColor;//详情中昨收和振幅的颜色
@property (nonatomic, strong)UIColor *tkTopViewColor;//K线详情中顶部数据背景色

@property (nonatomic, strong)UIColor *timeSegColor;//K线详情中指标时间

@property (nonatomic, strong)UIColor *timeButtonColor;//分时按钮颜色

@property (nonatomic, strong)UIColor *majorSegColor;//K线详情中主图指标背景色
@property (nonatomic, strong)UIColor *minorSegColor;//K线详情中副图指标背景色
@property (nonatomic, strong)UIColor *divideLineColor;//K线详情中tkTopView分割线颜色
//行情页面设置按钮
@property (nonatomic, strong)UIColor * setButtonColor ;

@property (nonatomic, strong)NSArray *maColorArr;
@property (nonatomic, strong)NSArray *bollColorArr;


@property (nonatomic, strong)NSArray *macdColorArr;
@property (nonatomic, strong)NSArray *kdjColorArr;
@property (nonatomic, strong)NSArray *rsiColorArr;
@property (nonatomic, strong)NSArray *biasColorArr;
@property (nonatomic, strong)UIColor *cciColor;
@property (nonatomic, strong)NSArray *psyColorArr;
@property (nonatomic, strong)NSArray *obvColorArr;
@property (nonatomic, strong)NSArray *volColorArr;

@property (nonatomic, strong)UIColor *hsLineColor;//k线中长按手势的十字线颜色

@property (nonatomic, strong)UIColor *indsSegBtnDidSelColor;//指标选择器被选中的button的颜色



@end
