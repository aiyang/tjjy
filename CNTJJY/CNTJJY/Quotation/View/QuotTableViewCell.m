//
//  QuotTableViewCell.m
//  CNTJJY
//
//  Created by totrade on 16/1/15.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "QuotTableViewCell.h"


#import "SingleExchangeAllSymbolsInstantData_DownObj.h"
#import "SomeSymbolsInstantData_DownObj.h"
#import "DataManage.h"
#import "AddSelfSelect.h"

#import "CustomFont.h"//根据屏幕尺寸获取font


@interface QuotTableViewCell ()

@property (nonatomic, strong)SingleExchangeAllSymbolsInstantData_DownObj *single_DownObj;
@property (nonatomic, strong)SomeSymbolsInstantData_DownObj *some_DownObj;
//@property (nonatomic, strong)DataManage *dataManage;

@property (nonatomic, strong)AddSelfSelect *addSelSelect;

@end


@implementation QuotTableViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
    
    
    self.nameLB.textColor = [UIColor colorFromHexCode:@"#2f2f2f"];
    
//    @property (strong, nonatomic) IBOutlet UILabel *nameLB;
//    @property (strong, nonatomic) IBOutlet UILabel *buyLB;
//    @property (strong, nonatomic) IBOutlet UILabel *sellLB;
//    @property (strong, nonatomic) IBOutlet UILabel *upDownLB;
//    @property (strong, nonatomic) IBOutlet UILabel *upDownRangeLB;
    UIFont *diyFont = [CustomFont diyFont];
//    self.nameLB.font = diyFont;
    self.buyLB.font = diyFont;
    self.sellLB.font = diyFont;
    self.upDownLB.font = diyFont;
    self.upDownRangeLB.font = diyFont;
    
    
 

}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.dataManage = [DataManage shareInstance];
       _addSelSelect = [[AddSelfSelect alloc] init];
    
    
    if ([self.get_DownObj isKindOfClass:[SingleExchangeAllSymbolsInstantData_DownObj class]]) {
        
        self.single_DownObj = _get_DownObj;
        self.nameLB.text = self.single_DownObj.name;
        self.buyLB.text = self.single_DownObj.buy;
        self.sellLB.text = self.single_DownObj.sell;
        self.upDownLB.text = self.single_DownObj.upDown;
        self.upDownRangeLB.text = self.single_DownObj.upDownRange;
        self.code = self.single_DownObj.code;
        self.y_Close = self.single_DownObj.yclose;
        
      
        
        
    }else if([self.get_DownObj isKindOfClass:[SomeSymbolsInstantData_DownObj class]]){
#warning 走这个方法,可以显示名字肯定是不对的!!!
        self.some_DownObj = _get_DownObj;
        
     NSString *qlName = [[_addSelSelect.addSelDic objectForKey:@"ql"] objectForKey:self.some_DownObj.code];
     NSString *htName = [[_addSelSelect.addSelDic objectForKey:@"ht"] objectForKey:self.some_DownObj.code];
//        NSLog(@"双双双%@---%@---%@", htName, qlName, self.some_DownObj.code);
        
        if (qlName.length == 0) {
            self.nameLB.text = htName;
        }else if (qlName.length != 0){
            self.nameLB.text = qlName;
        }
        self.buyLB.text = self.some_DownObj.buy;
        self.sellLB.text = self.some_DownObj.sell;
        self.upDownLB.text = self.some_DownObj.upDown;
        self.upDownRangeLB.text = self.some_DownObj.upDownRange;
        self.code = self.some_DownObj.code;
        self.y_Close = self.some_DownObj.yclose;
    }
    

    
    if ([self.upDownLB.text floatValue] > 0) {
        [self changeRed];
    }else if ([self.upDownLB.text floatValue] == 0){
        self.upDownLB.textColor = [UIColor blackColor];
        self.upDownRangeLB.textColor = [UIColor blackColor];
    }else{
        [self changeGreen];
    }
    
 
    
    
    
    
    if ([_y_Close floatValue] >= [_buyLB.text floatValue]) {
        _buyLB.textColor = [UIColor colorFromHexCode:@"#11b736"];
    }else if ([_y_Close floatValue] == [_buyLB.text floatValue]) {
        _buyLB.textColor = [UIColor blackColor];
    }else{
        _buyLB.textColor = [UIColor colorFromHexCode:@"#ff0202"];
    }
    
    if ([_y_Close floatValue] >= [_sellLB.text floatValue]) {
        _sellLB.textColor = [UIColor colorFromHexCode:@"#11b736"];
    }else if ([_y_Close floatValue] == [_sellLB.text floatValue]) {
        _sellLB.textColor = [UIColor blackColor];
    }else{
        _sellLB.textColor = [UIColor colorFromHexCode:@"#ff0202"];
    }
    

    
}

- (void)changeRed
{
//    self.nameLB.textColor = [UIColor redColor];
//    self.buyLB.textColor = [UIColor colorFromHexCode:@"#ff0202"];
//    self.sellLB.textColor = [UIColor colorFromHexCode:@"#ff0202"];
    self.upDownLB.textColor = [UIColor colorFromHexCode:@"#ff0202"];
    self.upDownRangeLB.textColor = [UIColor colorFromHexCode:@"#ff0202"];
}

- (void)changeGreen
{
//    self.nameLB.textColor = [UIColor greenColor];
//    self.buyLB.textColor = [UIColor colorFromHexCode:@"#11b736"];
//    self.sellLB.textColor = [UIColor colorFromHexCode:@"#11b736"];
    self.upDownLB.textColor = [UIColor colorFromHexCode:@"#11b736"];
    self.upDownRangeLB.textColor = [UIColor colorFromHexCode:@"#11b736"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
