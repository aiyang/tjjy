//
//  WarningReq_DownObj.h
//  CNTJJY
//
//  Created by totrade on 16/2/26.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "BasicObject.h"

@interface WarningReq_DownObj : BasicObject


//"id": "5",
//"userid": "03DCAC9198FB4304A21F39D3AF157541",
//"marketCode": "makretCode00",
//"productCode": "productCode001",
//"warningLevel": "30.0000",
//"FixedLevel": "20.0000",
//"createtime": "1455876023",
//"updatetime": "1455876023",//修改时间
//"issend": "1",//0代表关闭,1代表不发送
//"isdelete": "0",
//"TryTimes": "0",
//"cInfo": "cInfo001"




//@property (nonatomic, strong)NSString *id;
@property (nonatomic, strong)NSString *theId;
@property (nonatomic, strong)NSString *userid;
@property (nonatomic, strong)NSString *marketCode;
@property (nonatomic, strong)NSString *productCode;
@property (nonatomic, strong)NSString *warningLevel;
@property (nonatomic, strong)NSString *FixedLevel;
@property (nonatomic, strong)NSString *createtime;
@property (nonatomic, strong)NSString *updatetime;
@property (nonatomic, strong)NSString *issend;
@property (nonatomic, strong)NSString *isdelete;
@property (nonatomic, strong)NSString *TryTimes;
@property (nonatomic, strong)NSString *cInfo;


@end
