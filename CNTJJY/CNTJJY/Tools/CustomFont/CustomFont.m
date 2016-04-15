//
//  CustomFont.m
//  CNTJJY
//
//  Created by totrade on 16/3/16.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "CustomFont.h"

@implementation CustomFont

+ (UIFont *)diyFont
{
    UIFont *diyFont = [[UIFont alloc] init];
    NSInteger modeWidthInt = MAINSCREEN_WIDTH * MAINSCREEN_HEIGHT;
    switch (modeWidthInt) {
        case 153600://3gs,4(s)
        {
            diyFont = [UIFont systemFontOfSize:9.0f];
        }
        break;
        case 181760://5c,5(s)
        {
            diyFont = [UIFont systemFontOfSize:10.0f];
        }
            break;
        case 250125://6(s)
        {
            diyFont = [UIFont systemFontOfSize:12.0f];
        }
            break;
        case 304704://6(s)+
        {
            diyFont = [UIFont systemFontOfSize:15.0f];
        }
            break;
            
        default:{
            diyFont = [UIFont systemFontOfSize:10.0f];

        }
            break;
    }
    return diyFont;
}

@end
