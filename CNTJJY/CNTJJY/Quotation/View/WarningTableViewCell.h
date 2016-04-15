//
//  WarningTableViewCell.h
//  CNTJJY
//
//  Created by totrade on 16/1/28.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WarningReq_DownObj.h"

//typedef void(^CellRefresh)(void);

@interface WarningTableViewCell : UITableViewCell

@property (nonatomic, strong)WarningReq_DownObj *req_DownObj;

@property (strong, nonatomic) IBOutlet UILabel *wLevelLB;
@property (strong, nonatomic) IBOutlet UILabel *modifyTimeLB;
@property (strong, nonatomic) IBOutlet UISwitch *theSwitch;


@property (nonatomic, strong)NSString *yClose;//用于比较以显示红绿色

//@property (nonatomic, copy)CellRefresh cell_Refresh;



@end
