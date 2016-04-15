//
//  DiscoverWebViewController.m
//  CNTJJY
//
//  Created by tianjinjiayin on 16/4/12.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "DiscoverWebViewController.h"

@interface DiscoverWebViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *discoverWebV;

@end

@implementation DiscoverWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.titleStr;
    self.discoverWebV = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.discoverWebV.delegate = self;
    [self.view addSubview:self.discoverWebV];
    self.urlStr = @"http://192.168.200.14/1/";
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.discoverWebV loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return true;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
}

@end
