//
//  WarningTableViewCell.m
//  CNTJJY
//
//  Created by totrade on 16/1/28.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "WarningTableViewCell.h"

#import "CipherManage.h"
#import "TimeTools.h"

@interface WarningTableViewCell ()


@end

@implementation WarningTableViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    
//    CGAffineTransformMakeScale 这是什么属性?
    _theSwitch.transform = CGAffineTransformMakeScale(0.9, 0.9);
    

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    

//    _wLevelLB.text = _req_DownObj.warningLevel;
    _wLevelLB.text = [TimeTools cutZero:_req_DownObj.warningLevel];
    if ([_req_DownObj.warningLevel floatValue] >= [_yClose floatValue]) {
        _wLevelLB.textColor = [UIColor redColor];
    }else{
        _wLevelLB.textColor = [UIColor greenColor];
    }

    
//    self.modifyTimeLB.text = [NSString stringWithFormat:@"%@--%@", _req_DownObj.updatetime, _req_DownObj.theId];
    self.modifyTimeLB.text = [TimeTools getWarnDateStringFromTimeInterval:_req_DownObj.updatetime];
    self.theSwitch.on = [_req_DownObj.issend boolValue];
    
    
}

//
- (IBAction)theSwitchAction:(UISwitch *)sender {
    if (sender.on == 0) {
        [self handleWarningChaWithIssendValue:@"0"];
    }else if(sender.on == 1){
        [self handleWarningChaWithIssendValue:@"1"];
    }
}


- (void)handleWarningChaWithIssendValue:(NSString *)issendValue
{

    NSString *cinfo = [NSString string];
    if (_req_DownObj.cInfo.length == 0) {
        cinfo = @"";
    }else{
        cinfo = _req_DownObj.cInfo;
    }
    
    //code="action=cha&id=8&mCode=makretCode002&pCode=productCode001&wLevel=1&cInfo=cInfo001";
#warning issend选择开启或关闭推送时,action应该填写什么字段
    NSDictionary *issend = @{@"action":@"cha",
                          @"id":_req_DownObj.theId,
                          @"mCode":_req_DownObj.marketCode,
                          @"pCode":_req_DownObj.productCode,
                          @"wLevel":_req_DownObj.warningLevel,
                          @"FixedLevel":_req_DownObj.FixedLevel,//修改时不用修改固定值的
                          @"createtime":_req_DownObj.createtime,
                          @"updatetime":_req_DownObj.updatetime,
                          @"cinfo":cinfo,
                          @"issend":issendValue};
    
    
    NSDictionary *enIssend = [CipherManage requestDicToPostBodyWithDic:issend];
    
    
    [DataManage quotationWarningWithPostBody:enIssend success:^(id responseObject) {
        NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
        NSLog(@"行情预警接口---issend:%@", dic);
        
//        _cell_Refresh();//用于修改开关后,重新获取并刷新数据,万一修改失败了呢?

    } failure:^(NSError *error) {
        
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    //设定view选中状态
    // Configure the view for the selected state
    
}

@end
