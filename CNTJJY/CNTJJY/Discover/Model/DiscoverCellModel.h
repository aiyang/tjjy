//
//  DiscoverCellModel.h
//  CNTJJY
//
//  Created by tianjinjiayin on 16/4/11.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicObject.h"

@interface DiscoverCellModel : BasicObject

@property (nonatomic,strong) NSString *icon;//图标
@property (nonatomic,strong) NSString *mainText;//主题
@property (nonatomic,strong) NSString *detailText;//小标题
@end
