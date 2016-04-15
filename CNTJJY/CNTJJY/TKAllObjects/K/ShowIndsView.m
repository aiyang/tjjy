//
//  ShowIndsView.m
//  CNTJJY
//
//  Created by totrade on 16/2/20.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//


#define FONT 7.5f

#import "ShowIndsView.h"
#import "IndsParameters.h"

@interface ShowIndsView ()

@property (nonatomic, strong)UILabel *sumLB;

@property (nonatomic, strong)IndsParameters *indsParameter;
@property (nonatomic, strong)NSArray *indPMSArr;

@end

@implementation ShowIndsView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _indsParameter = [[IndsParameters alloc] init];

        
        _sumLB = [[UILabel alloc] init];
        _sumLB.backgroundColor = [UIColor clearColor];
        _sumLB.font = [UIFont systemFontOfSize:FONT];
        [self addSubview:_sumLB];
        
        
    }
    return self;
}


- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [_sumLB setFrame:self.bounds];
    
    
}


- (void)setAllValuesWithArray:(NSArray *)array index:(NSInteger)index type:(ShowIndType)type
{
   _indPMSArr = [_indsParameter getIndPMSWithType:(int)type + 2];//0和1存的是主图指标
    
    
    NSString *indParameterStr = [NSString string];
    NSString *firstStr = [NSString string];
    NSString *secondStr = [NSString string];
    NSString *thirdStr = [NSString string];
    
    
    CGFloat float1, float2, float3;
    if (array.count == 3 || array.count == 4) {
        if ([[array objectAtIndex:0] count] > index) {
            float1 = [[[array objectAtIndex:0] objectAtIndex:index] floatValue];
            firstStr = [NSString stringWithFormat:@"%.2f", float1];
        }else{
            firstStr = @"---";
        }
        if ([[array objectAtIndex:1] count] > index) {
            float2 = [[[array objectAtIndex:1] objectAtIndex:index] floatValue];
            secondStr = [NSString stringWithFormat:@"%.2f", float2];
        }else{
            secondStr = @"---";
        }
        if ([[array objectAtIndex:2] count] > index) {
            float3 = [[[array objectAtIndex:2] objectAtIndex:index] floatValue];
            thirdStr = [NSString stringWithFormat:@"%.2f", float3];
        }else{
            thirdStr = @"---";
        }
    }else if (array.count == 2){
        if ([[array objectAtIndex:0] count] > index) {
            float1 = [[[array objectAtIndex:0] objectAtIndex:index] floatValue];
            firstStr = [NSString stringWithFormat:@"%.2f", float1];
        }else{
            firstStr = @"---";
        }
        if ([[array objectAtIndex:1] count] > index) {
            float2 = [[[array objectAtIndex:1] objectAtIndex:index] floatValue];
            secondStr = [NSString stringWithFormat:@"%.2f", float2];
        }else{
            secondStr = @"---";
        }
        thirdStr = @"---";
    }else if (array.count == 1){
        if ([[array objectAtIndex:0] count] > index) {
            float1 = [[[array objectAtIndex:0] objectAtIndex:index] floatValue];
            firstStr = [NSString stringWithFormat:@"%.2f", float1];
            
        }else{
            firstStr = @"---";
        }
        secondStr = @"---";
        thirdStr = @"---";
    }
    
    
    switch (type) {
        case indMACD:
        {
            indParameterStr = [NSString stringWithFormat:@"(%@,%@,%@)", _indPMSArr[0], _indPMSArr[1], _indPMSArr[2]];
            firstStr = [NSString stringWithFormat:@"%@:%@", @"DEA", firstStr];
            secondStr = [NSString stringWithFormat:@"%@:%@", @"DIF", secondStr];
            thirdStr = [NSString stringWithFormat:@"%@:%@", @"MACD", thirdStr];
        }
            break;
            
        case indKDJ:
        {
            indParameterStr = [NSString stringWithFormat:@"(%@,%@,%@)", _indPMSArr[0], _indPMSArr[1], _indPMSArr[2]];
            firstStr = [NSString stringWithFormat:@"%@:%@", @"K", firstStr];
            secondStr = [NSString stringWithFormat:@"%@:%@", @"D", secondStr];
            thirdStr = [NSString stringWithFormat:@"%@:%@", @"J", thirdStr];
        }
            break;
            
        case indRSI:
        {
            indParameterStr = [NSString stringWithFormat:@"(%@,%@,%@)", _indPMSArr[0], _indPMSArr[1], _indPMSArr[2]];
            firstStr = [NSString stringWithFormat:@"%@:%@", @"RSI1", firstStr];
            secondStr = [NSString stringWithFormat:@"%@:%@", @"RSI2", secondStr];
            thirdStr = [NSString stringWithFormat:@"%@:%@", @"RSI3", thirdStr];
        }
            break;
            
        case indBIAS:
        {
            indParameterStr = [NSString stringWithFormat:@"(%@,%@,%@)", _indPMSArr[0], _indPMSArr[1], _indPMSArr[2]];
            firstStr = [NSString stringWithFormat:@"%@:%@", @"BIAS1", firstStr];
            secondStr = [NSString stringWithFormat:@"%@:%@", @"BIAS1", secondStr];
            thirdStr = [NSString stringWithFormat:@"%@:%@", @"BIAS1", thirdStr];
        }
            break;
            
        case indCCI:
        {
            indParameterStr = [NSString stringWithFormat:@"(%@)", _indPMSArr[0]];
            firstStr = [NSString stringWithFormat:@"%@:%@", @"CCI", firstStr];
            secondStr = @"---";
            thirdStr = @"---";
        }
            break;
            
        case indPSY:
        {
            indParameterStr = [NSString stringWithFormat:@"(%@,%@)", _indPMSArr[0], _indPMSArr[1]];
            firstStr = [NSString stringWithFormat:@"%@:%@", @"PSY", firstStr];
            secondStr = [NSString stringWithFormat:@"%@:%@", @"PSYMA", secondStr];
            thirdStr = @"---";
        }
            break;
            
        case indOBV:
        {
            indParameterStr = [NSString stringWithFormat:@"(%@)", _indPMSArr[0]];
            firstStr = [NSString stringWithFormat:@"%@:%@", @"OBV", firstStr];
            secondStr = [NSString stringWithFormat:@"%@:%@", @"MAOBV", secondStr];
            thirdStr = @"---";
        }
            break;
            
        case indVOL:
        {
            indParameterStr = [NSString stringWithFormat:@"(%@,%@)", _indPMSArr[0], _indPMSArr[1]];
            firstStr = [NSString stringWithFormat:@"%@:%@", @"VOL", firstStr];
            secondStr = [NSString stringWithFormat:@"%@:%@", @"MAVOL1", secondStr];
            thirdStr = [NSString stringWithFormat:@"%@:%@", @"MAVOL2", thirdStr];
        }
            break;
            
            
            
        default:
        {
            indParameterStr = nil;
            firstStr = nil;
            secondStr = nil;
            thirdStr = nil;
        }
            break;
    }
    
    if (type == indCCI) {
        secondStr = @"";
        thirdStr = @"";
    }
    if (type == indPSY) {
        thirdStr = @"";
    }
    
    
    
    //使用富文本
    indParameterStr = [NSString stringWithFormat:@"%@  ", indParameterStr];
    NSMutableAttributedString *indParameterString = [[NSMutableAttributedString alloc] initWithString:indParameterStr];
    NSRange range0 = NSMakeRange(0, indParameterString.length);
    [indParameterString addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"#234878"] range:range0];
    
    firstStr = [NSString stringWithFormat:@"%@  ", firstStr];
    NSMutableAttributedString *firstString = [[NSMutableAttributedString alloc] initWithString:firstStr];
    NSRange range1 = NSMakeRange(0, firstString.length);
    [firstString addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"#10f1c4"] range:range1];
    
    secondStr = [NSString stringWithFormat:@"%@  ", secondStr];
    NSMutableAttributedString *secondString = [[NSMutableAttributedString alloc] initWithString:secondStr];
    NSRange range2 = NSMakeRange(0, secondString.length);
    [secondString addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"#fd4d91"] range:range2];
    
    NSMutableAttributedString *thirdString = [[NSMutableAttributedString alloc] initWithString:thirdStr];
    NSRange range3 = NSMakeRange(0, thirdString.length);
    [thirdString addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"#ce950b"] range:range3];
    
    
    NSMutableAttributedString *sumString = [[NSMutableAttributedString alloc] init];
    [sumString appendAttributedString:indParameterString];
    [sumString appendAttributedString:firstString];
    [sumString appendAttributedString:secondString];
    [sumString appendAttributedString:thirdString];
    
    [_sumLB setAttributedText:sumString];
    
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
