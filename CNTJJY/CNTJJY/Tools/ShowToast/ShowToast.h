//
//  ShowToast.h
//  CNTJJY
//
//  Created by totrade on 16/2/26.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

//类似于安卓的toast提示控件
#import <Foundation/Foundation.h>

@interface ShowToast : NSObject

+(void)showMessage:(NSString *)message;

//在黑色背景下调用
+(void)showInBackMessage:(NSString *)message;

@end
