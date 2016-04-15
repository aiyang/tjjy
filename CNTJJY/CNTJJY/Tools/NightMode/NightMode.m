//
//  NightMode.m
//  CNTJJY
//
//  Created by totrade on 16/2/19.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "NightMode.h"

#import "DataManage.h"
#import "TimeTools.h"

@interface NightMode ()

@end

@implementation NightMode

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSNumber *number = [DataManage readUserDefaultsObjectforKey:@"nightMode"];
        BOOL isSystemNightMode = [TimeTools JudgeisSystemNightMode];
        //用户切换夜间模式,其优先级大于系统预设
        if ([number isEqual: @0]) {
            _isNightMode = [number boolValue];
        }else if ([number isEqual:@1]){
            _isNightMode = [number boolValue];
        }else{
            _isNightMode = isSystemNightMode;
        }
        
    }
    return self;
}

- (UIColor *)backGroundColor
{
    if (_isNightMode) {//夜间模式
        _backGroundColor = [UIColor colorFromHexCode:@"#242329"];
    }else{
        _backGroundColor = [UIColor whiteColor];
    }
    return _backGroundColor;
}

- (UIColor *)tLabelColor
{
    if (_isNightMode) {//夜间模式
        _tLabelColor = [UIColor colorWithWhite:0.5 alpha:1];
    }else{
        _tLabelColor = [UIColor colorWithWhite:0.4 alpha:1];
    }
    return _tLabelColor;
}

- (UIColor *)buttonDisSelColor
{
    if (_isNightMode) {
        _buttonDisSelColor = [UIColor colorFromHexCode:@"#fe6101"];
    }else{
        _buttonDisSelColor = [UIColor colorFromHexCode:@"#fe6101"];
    }
    return _buttonDisSelColor;
}

- (UIColor *)tLine1Color
{
    if (_isNightMode) {
        _tLine1Color = [UIColor colorFromHexCode:@"#f5f400"];
    }else{
        _tLine1Color = [UIColor colorFromHexCode:@"#e09348"];
    }
    return _tLine1Color;
}

- (UIColor *)tLine2Color
{
    if (_isNightMode) {
        _tLine2Color = [UIColor colorFromHexCode:@"#77aaaa"];//[UIColor whiteColor];
    }else{
        _tLine2Color = [UIColor colorFromHexCode:@"#77aaaa"];//[UIColor blackColor];
    }
    return _tLine2Color;
}


- (UIColor *)syNameColor
{
    if (_isNightMode) {
        _syNameColor = [UIColor whiteColor];
    }else{
        _syNameColor = [UIColor blackColor];
    }
    return _syNameColor;
}

- (UIColor *)yCloseColor
{
    if (_isNightMode) {
        _yCloseColor = [UIColor whiteColor];
    }else{
        _yCloseColor = [UIColor grayColor];
    }
    return _yCloseColor;
}

- (UIColor *)tkTopViewColor
{
    if (_isNightMode) {
        _tkTopViewColor = [UIColor colorFromHexCode:@"#242424"];
    }else{
        _tkTopViewColor = [UIColor whiteColor];
    }
    return _tkTopViewColor;
}

// XCIndsSegControl color
- (UIColor *)timeSegColor
{
    if (_isNightMode) {
        _timeSegColor = [UIColor colorWithWhite:0.2 alpha:1];
    }else{
        _timeSegColor = [UIColor colorFromHexCode:@"#f1f1f1"];
    }
    return _timeSegColor;
}


- (UIColor *)timeButtonColor{
    if (_isNightMode) {
        _timeButtonColor = [UIColor lightGrayColor];
    }
    else{
        _timeButtonColor = [UIColor blackColor];
    }
    return _timeButtonColor ;
}

- (UIColor *)majorSegColor
{
    if (_isNightMode) {
        _majorSegColor = [UIColor blackColor];
    }else{
        _majorSegColor = [UIColor whiteColor];
    }
    return _majorSegColor;
}

// time  color
- (UIColor *)minorSegColor
{
    if (_isNightMode) {
        _minorSegColor = [UIColor blackColor];
    }else{
        _minorSegColor = [UIColor colorFromHexCode:@"#e0e0e0"];
    }
    return _minorSegColor;
}

- (UIColor *)indsSegBtnDidSelColor
{
    if (_isNightMode) {
       // _indsSegBtnDidSelColor = [UIColor whiteColor];
        _indsSegBtnDidSelColor = [UIColor colorFromHexCode:@"#fe6100"];
    }else{
       // _indsSegBtnDidSelColor = [UIColor blackColor];
        _indsSegBtnDidSelColor = [UIColor colorFromHexCode:@"#fe6100"];
    }
    return _indsSegBtnDidSelColor;
}



- (UIColor *)divideLineColor
{
    if (_isNightMode) {
        _divideLineColor = [UIColor colorFromHexCode:@"#242424"];
    }else{
        _divideLineColor = [UIColor lightGrayColor];
    }
    return _divideLineColor;
}

- (NSArray *)maColorArr
{
    if (_isNightMode) {
        _maColorArr = @[[UIColor colorFromHexCode:@"#77aaaa"], [UIColor yellowColor], [UIColor magentaColor], [UIColor brownColor]];
    }else{
        _maColorArr = @[[UIColor colorFromHexCode:@"#77aaaa"], [UIColor yellowColor], [UIColor magentaColor], [UIColor brownColor]];
    }
    return _maColorArr;
}

- (NSArray *)bollColorArr
{
    if (_isNightMode) {
        _bollColorArr = @[[UIColor yellowColor], [UIColor whiteColor], [UIColor magentaColor]];
    }else{
        _bollColorArr = @[[UIColor brownColor], [UIColor lightGrayColor], [UIColor magentaColor]];
    }
    return _bollColorArr;
}

- (NSArray *)macdColorArr
{
    if (_isNightMode) {
        _macdColorArr = @[[UIColor magentaColor], [UIColor cyanColor]];
    }else{
        _macdColorArr = @[[UIColor magentaColor], [UIColor cyanColor]];
    }
    return _macdColorArr;
}

- (NSArray *)kdjColorArr
{
    if (_isNightMode) {
        _kdjColorArr = @[[UIColor cyanColor], [UIColor magentaColor], [UIColor brownColor]];
    }else{
        _kdjColorArr = @[[UIColor cyanColor], [UIColor magentaColor], [UIColor brownColor]];
}
    return _kdjColorArr;
}

- (NSArray *)rsiColorArr
{
    if (_isNightMode) {
        _rsiColorArr = @[[UIColor cyanColor], [UIColor magentaColor], [UIColor brownColor]];
    }else{
        _rsiColorArr = @[[UIColor cyanColor], [UIColor magentaColor], [UIColor brownColor]];
    }
    return _kdjColorArr;
}

- (NSArray *)biasColorArr
{
    if (_isNightMode) {
        _biasColorArr = @[[UIColor cyanColor], [UIColor magentaColor], [UIColor brownColor]];
    }else{
        _biasColorArr = @[[UIColor cyanColor], [UIColor magentaColor], [UIColor brownColor]];
    }
    return _biasColorArr;
}

- (UIColor *)cciColor
{
    if (_isNightMode) {
        _cciColor = [UIColor cyanColor];
    }else{
        _cciColor = [UIColor cyanColor];
    }
    return _cciColor;
}

- (NSArray *)psyColorArr
{
    if (_isNightMode) {
        _psyColorArr = @[[UIColor cyanColor], [UIColor magentaColor]];
    }else{
        _psyColorArr = @[[UIColor cyanColor], [UIColor magentaColor]];
    }
    return _psyColorArr;
}

- (NSArray *)obvColorArr
{
    if (_isNightMode) {
        _obvColorArr = @[[UIColor cyanColor], [UIColor magentaColor]];
    }else{
        _obvColorArr = @[[UIColor cyanColor], [UIColor magentaColor]];
    }
    return _obvColorArr;
}

- (NSArray *)volColorArr
{
    if (_isNightMode) {
        _volColorArr = @[[UIColor cyanColor], [UIColor magentaColor]];
    }else{
        _volColorArr = @[[UIColor cyanColor], [UIColor magentaColor]];
    }
    return _obvColorArr;
}

- (UIColor *)hsLineColor
{
    if (_isNightMode) {
        _hsLineColor = [UIColor whiteColor];
    }else{
        _hsLineColor = [UIColor grayColor];
    }
    return _hsLineColor;
}

-(UIColor *)setButtonColor{
    if (_isNightMode) {
        _setButtonColor = [UIColor blackColor];
    }
    else{
        _setButtonColor = [UIColor colorWithWhite:0.7f alpha:1.0f] ;
    }
    return _setButtonColor ;
}


@end
