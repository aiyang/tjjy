//
//  CentSetMode.h
//  CNTJJY
//
//  Created by totrade on 16/3/9.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

///用于个人中心相关的设置,并将用户的设置保存于本地
#import <Foundation/Foundation.h>


@interface CentSetMode : NSObject

@property (nonatomic, strong)NSString *refreshSeconds;///刷新频率设置
@property (nonatomic, assign)BOOL isNightMode;///是否为夜间模式
@property (nonatomic, assign)BOOL isPush;///是否开始推送

- (void)recover;//恢复默认
- (void)clean;//清除缓存
+(CGFloat)cacheSize ;

@end
