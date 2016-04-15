//
//  TestWebViewController.h
//  CNTJJY
//
//  Created by totrade on 16/2/29.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestWebViewController : UIViewController

@property (nonatomic, strong)NSString *theTitle;
@property (nonatomic, strong)NSString *path;

- (void)testWebViewLoaded;

@end
