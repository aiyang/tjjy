//
//  TimeTools.h
//  CNTJJY
//
//  Created by totrade on 16/1/29.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeTools : NSObject

//获取当前时间
+ (NSString *)getNowTime;

//从当前时间到早上6点,一共多少分钟就请求多少个数
+ (NSString *)getTLineRequestCount;
//计算分时图开始与结束时间,用于网络请求的上行参数
+ (NSArray *)getTLineStartStop;

//判断系统是否处于夜间模式
+ (BOOL)JudgeisSystemNightMode;

//将原有时间数组等分成count个并作返回,dateArr中为时间戳字符串,下行数据中已经有时间大小顺序,即第一个是最新时间,最后一个为最旧时间
//返回时第一个是最旧的,便于赋值显示
+ (NSArray *)getNewDateArrWithDateArr:(NSArray *)dateArr count:(NSInteger)count;

//将时间戳转换成时间字符串@"yyyy/MM/dd"
+ (NSString *)getDateStringFromTimeInterval:(NSString *)interval;

//将时间戳转换成时间字符串@"yyyy/MM/dd"
+ (NSString *)getWarnDateStringFromTimeInterval:(NSString *)interval;

//去除小数点后多余的零
+ (NSString *)cutZero:(NSString *)stringFloat;

@end
