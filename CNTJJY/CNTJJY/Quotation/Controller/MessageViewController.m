//
//  MessageViewController.m
//  CNTJJY
//
//  Created by totrade on 16/3/2.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#import "MessageViewController.h"
#import "DataManage.h"
#import "CipherManage.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"消息";
   
    //获取版本号测试
//    NSString *url = @"http://www.cntjjy.com/p/appDataInterface.php";
//    NSDictionary *postBody = @{@"action":@"getAppVer"};
//    NSDictionary *enPostBody = [CipherManage requestDicToPostBodyWithDic:postBody];
//    [DataManage tempWithPostRequest:url PostBody:enPostBody success:^(id responseObject) {
//        NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
//        NSLog(@"获取版本号---del:%@", [dic objectForKey:@"result"]);
//    } failure:^(NSError *error) {
//        
//    }];
    
    
//    /p/appDataInterface.php
//    insertFid
//    insertUID
//    首次开启应用:insertFid:id:唯一标志码 ver:操作系统识别
//    点击登录:insertUID:uid:用户uid id:唯一标识码
//    fid
    
  //返回结果
//    result=insertSuccess
//    result=insertFail
//    result=updateSuccess
//    result=updateFail
    
//    //首次开启应用
//        NSString *url = @"http://www.cntjjy.com/p/appDataInterface.php";
//        NSDictionary *postBody = @{@"action":@"insertFid",
//                                   @"fid":@"575448B7-F044-4F15-88B2-B0E9D8B399AD",
//                                   @"ver":@"iOS"};
//        NSDictionary *enPostBody = [CipherManage requestDicToPostBodyWithDic:postBody];
//        [DataManage tempWithPostRequest:url PostBody:enPostBody success:^(id responseObject) {
//            NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
//            NSLog(@"首次开启应用---del:%@", [dic objectForKey:@"result"]);
//        } failure:^(NSError *error) {
//            
//        }];
//    
//    //用户每次登录成功并获取用户信息之后
//    NSString *url = @"http://www.cntjjy.com/p/appDataInterface.php";
//    NSDictionary *postBody = @{@"action":@"insertUID",
//                               @"uid":@"03DCAC9198FB4304A21F39D3AF157541",
//                               @"fid":@"575448B7-F044-4F15-88B2-B0E9D8B399AD"};
//    NSDictionary *enPostBody = [CipherManage requestDicToPostBodyWithDic:postBody];
//    [DataManage tempWithPostRequest:url PostBody:enPostBody success:^(id responseObject) {
//        NSDictionary *dic = [CipherManage responseDataToDictionaryWithData:responseObject];
//        NSLog(@"用户每次登录成功并获取用户信息之后:%@", [dic objectForKey:@"result"]);
//    } failure:^(NSError *error) {
//        
//    }];
    
#warning http://103.25.42.173:802/codeclass.aspx//获取商品信息配置
    
    //    [DataManage tempWithGetRequest:@"http://103.25.42.173:802/codeclass.aspx" success:^(id responseObject) {
    //
    //        NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
    //
    //        NSLog(@"%@", array);
    //
    //    } failure:^(NSError *error) {
    //        
    //    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
