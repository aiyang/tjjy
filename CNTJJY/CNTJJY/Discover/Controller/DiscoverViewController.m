//
//  DiscoverViewController.m
//  CNTJJY
//
//  Created by tianjinjiayin on 16/4/11.
//  Copyright © 2016年 CNTJJY. All rights reserved.
//

#define BANNERHEIGHT self.view.frame.size.width*372/1079
#import "DiscoverViewController.h"
#import "DiscoverTableViewCell.h"
#import "DiscoverCellModel.h"
#import "SDCycleScrollView.h"
#import "DiscoverWebViewController.h"
#import "DataManage.h"
#import "GDataXMLNode.h"

@interface DiscoverViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView2 ;
@property (nonatomic ,strong) UIScrollView *mainSV;
@property (nonatomic ,strong) UIView *mainInfoV;
@property(nonatomic,strong)UITableView *discoverTableV;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSMutableArray *imagesArray;
@property(nonatomic,strong)NSMutableArray *imagesUrlArray;
@property(nonatomic,strong)NSMutableArray *imagesTitleArray;

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //    获取cell数据
    [self dataSource];
    //    布局
    [self backView];
    [self buildTB];
    [self verticalLayout];
    //    图片轮播
    [self netImageForBanner];
    
    
    
}

- (void)dataSource{
    
    self.dataArray = [NSMutableArray array];
    self.dataArray=@[@{@"icon":@"caijingrl",@"mainText":@"财经日历",@"detailText":@"最新财经资讯，全面财经信息"},@{@"icon":@"shishixw",@"mainText":@"实时新闻",@"detailText":@"动态要闻第一时间播报"},@{@"icon":@"zhongyingdhs",@"mainText":@"众赢大客户",@"detailText":@"动态要闻第一时间播报"},@{@"icon":@"wangluokt",@"mainText":@"网络课堂",@"detailText":@"全面投资教程体系，短期内便能从中获益"},@{@"icon":@"mingjiajt",@"mainText":@"名家讲坛",@"detailText":@"操盘良师业界权威，特色解读深入浅出"},@{@"icon":@"guolongcjgb",@"mainText":@"国隆财经广播",@"detailText":@"以贵金属视角深度解析全球经济财经大事"},@{@"icon":@"qingjianls",@"mainText":@"青剑论市",@"detailText":@"以贵金属视角深度解析全球经济财经大事"},@{@"icon":@"duokongdj",@"mainText":@"多空对决",@"detailText":@"直观展示多空行情趋势判断，对决比例一目了然"},@{@"icon":@"jiaoyids",@"mainText":@"交易大赛",@"detailText":@"及时追踪高手持仓情况，盈利契机尽在掌握"}];
    
}
- (void)backView{
    UIScrollView *mainSV = [[UIScrollView alloc] init];
    mainSV.translatesAutoresizingMaskIntoConstraints = NO;
    mainSV.delegate = self;
    [self.view addSubview:mainSV];
    self.mainSV = mainSV;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[mainSV]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(mainSV)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[mainSV]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(mainSV)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:mainSV
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:0
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0
                                                           constant:0]];
    
    
    
    
    
    UIView *mainInfoV = [[UIView alloc] init];
    mainInfoV.translatesAutoresizingMaskIntoConstraints = NO;
    [self.mainSV addSubview:mainInfoV];
    self.mainInfoV = mainInfoV;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[mainInfoV]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(mainInfoV)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[mainInfoV]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(mainInfoV)]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:mainInfoV
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:0
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0
                                                           constant:0]];
}


- (void)buildTB{
    
    self.discoverTableV = [[UITableView alloc]init];
    self.discoverTableV.translatesAutoresizingMaskIntoConstraints = NO;
    self.discoverTableV.delegate = self;
    self.discoverTableV.dataSource = self;
    //    self.discoverTableV.separatorColor = [UIColor colorWithHexString:@"#f4f4f4"];
    self.discoverTableV.separatorColor = [UIColor colorFromHexCode:@"#ececec"];
    
    self.discoverTableV.separatorInset = UIEdgeInsetsMake(0,62, 0, 2);        // 设置端距，这里表示separator离左边62像素
    
    self.discoverTableV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.mainInfoV addSubview:self.discoverTableV];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_discoverTableV]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_discoverTableV)]];
    
    
}

- (void)verticalLayout{
    float allHeight=self.dataArray.count*68+7;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[_discoverTableV(%f)]",BANNERHEIGHT,allHeight]
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_discoverTableV)]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_mainInfoV
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:0
                                                             toItem:self.discoverTableV
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
}


- (void)lunboimage{
    
    CGFloat w = self.view.bounds.size.width;
    
    ////    // 本地加载图片的轮播器
    //    self.cycleScrollView2 =[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, BANNERHEIGHT)  imagesGroup:nil];
    ////     情景一：采用本地图片实现
    //    NSArray *images = @[[UIImage imageNamed:@"banner"],
    //                        [UIImage imageNamed:@"banner"]
    //                        ];
    //    self.cycleScrollView2.localizationImagesGroup = images;
    
    // 网络加载图片的轮播器cycleScrollViewWithFrame
    self.cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, BANNERHEIGHT) imageURLStringsGroup:nil];
    self.cycleScrollView2.placeholderImage = [UIImage imageNamed:@""];
    
    //设置网络图片数组
    self.cycleScrollView2.imageURLStringsGroup = self.imagesArray;
    
    self.cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.cycleScrollView2.delegate = self;
    self.cycleScrollView2.dotColor = [UIColor blackColor]; // 自定义分页控件小圆标颜色
    self.cycleScrollView2.placeholderImage = [UIImage imageNamed:@"vip4"];
    
    
    [self.mainSV addSubview:self.cycleScrollView2];
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    DiscoverWebViewController *web = [[DiscoverWebViewController alloc]init];
    
    web.titleStr = self.imagesTitleArray[index];
    web.urlStr = self.imagesUrlArray[index];
    [self.navigationController pushViewController:web animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.discoverTableV reloadData];
}

- (void)netImageForBanner{
    
    [DataManage discoverImageRequest:DISCOVER_BANNER success:^(id responseObject) {
        
        [self getDataFromeXml:responseObject];
        //        图片轮播
        [self lunboimage];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)getDataFromeXml:(NSData *)data{
    
    self.imagesArray = [NSMutableArray array];
    self.imagesUrlArray = [NSMutableArray array];
    self.imagesTitleArray = [NSMutableArray array];
    
    //对象初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:data options:0 error:nil];
    //获取根节点
    GDataXMLElement *rootElement = [doc rootElement];
    //获取其他节点
    NSArray *imageInforArray = [rootElement elementsForName:@"frame"];
    //初始化可变数组，用来显示到textView
    //    self.GDatatext = [[NSMutableString alloc]initWithString:@""];
    for (GDataXMLElement *imageInfor in imageInforArray) {
        //获取节点属性
        NSString *image =[[imageInfor attributeForName:@"lowsrc"] stringValue];
        
        [self.imagesArray addObject:image];
        
        NSString *imageUrl = [[imageInfor attributeForName:@"href"] stringValue];
        [self.imagesUrlArray addObject:imageUrl];
        
        NSString *imageTitle = [[imageInfor attributeForName:@"title"] stringValue];
        [self.imagesTitleArray addObject:imageTitle];
        
    }
}
#pragma mark - Table view data source
//返回分区数(默认为1)
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}
//返回每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

//设置自定义头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view= [[UIView alloc]init];
    view.backgroundColor=[UIColor colorFromHexCode:@"#ececec"];
    
    return view;
    
}
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68;
}
//设置头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    DiscoverTableViewCell *cell = [[DiscoverTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[DiscoverTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSArray *cellData = [DiscoverCellModel modelArrWithDics:(NSMutableArray*)self.dataArray];
    [cell buildCell:cellData[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscoverWebViewController *web = [[DiscoverWebViewController alloc]init];
    
    switch (indexPath.row) {
        case 0:
            web.titleStr = @"财经日历";
            web.urlStr = @"";
            break;
        case 1:
            web.titleStr = @"实时新闻";
            web.urlStr = @"";
            break;
        case 2:
            web.titleStr = @"众赢大客户";
            web.urlStr = @"";
            break;
        case 3:
            web.titleStr = @"网络课程";
            web.urlStr = @"";
            break;
        case 4:
            web.titleStr = @"名家讲坛";
            web.urlStr = @"";
            break;
        case 5:
            web.titleStr = @"国隆财经广播";
            web.urlStr = @"";
            break;
        case 6:
            web.titleStr = @"青剑论市";
            web.urlStr = @"";
            break;
        case 7:
            web.titleStr = @"多空对决";
            web.urlStr = @"";
            break;
        case 8:
            web.titleStr = @"交易大赛";
            web.urlStr = @"";
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:web animated:YES];
    
}


@end
