//
//  ViewController.m
//  shuju
//
//  Created by zhuxunyi on 16/8/11.
//  Copyright © 2016年 muyou. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "Case_ListModel.h"
#import "CaseListTableViewCell.h"
#import "XLDataBase.h"
#import <MJRefresh/MJRefresh.h>


#define kurl @"http://mobile.ximalaya.com/m/explore_user_index?device=android&page=0"
static int _page = 0;
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSMutableDictionary *_parameters;
    NSString *_style;// 风格
    int _price;// 价格搜索
    int _mj;// 面积搜索
    int _package;// 套餐搜索
    int _count;// 单页返回的记录数
}
@property (nonatomic, strong) NSMutableDictionary *dic;
@property (nonatomic, strong) NSMutableArray *dataArry;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dataArry = [NSMutableArray array];
    _style = @"style-1";
    _price = 0;
    _package = 0;
    _count = 10;
    NSRange range = NSMakeRange(0, 10);
      [self setuptableView];
    if ([[XLDataBase listWithRange:range] count]) {
        [self.dataArry addObjectsFromArray:[XLDataBase listWithRange:range]];
        NSLog(@"走的数据库");
        [self.tableView reloadData];
    }else {
         [self setupByAfn];
        NSLog(@"网络请求");
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
 self.view.backgroundColor = [UIColor redColor];
  

   }
- (void)setuptableView {
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CaseListTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    
}

- (void)loadNewData {
    _page = 0;
    [self.dataArry removeAllObjects];
    [self setupByAfn];

    
    
}
- (void)loadMoreData {
    _page++;
    NSRange range = NSMakeRange(_page * 10, 10);
    if ([[XLDataBase listWithRange:range] count]) {
        [self.dataArry addObjectsFromArray:[XLDataBase listWithRange:range]];
        NSLog(@"走的数据库  ***");
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    }else {
        [self setupByAfn];
    }
    
}
- (void)setupByAfn {
    if (self.dic == nil) {
        self.dic = [[NSMutableDictionary alloc]init];
        
    }
    [_dic setObject:@"b107d5130286d3322d64d9f417ce5e2c" forKey:@"pwdstr"];
    [_dic setObject:[NSNumber numberWithInt:_count] forKey:@"count"];
    [_dic setObject:[NSNumber numberWithInt:_page] forKey:@"page"];
    [_dic setObject:_style forKey:@"style"];
    [_dic setObject:[NSNumber numberWithInt:_price] forKey:@"price"];
    [_dic setObject:[NSNumber numberWithInt:_mj] forKey:@"mj"];
    [_dic setObject:[NSNumber numberWithInt:_package] forKey:@"package"];

    AFHTTPSessionManager *man = [AFHTTPSessionManager manager];
    [man GET:@"http://api.xrzmall.com/api/case_list.php" parameters:_dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self getFrom:responseObject];
        NSLog(@"网络请求");

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
- (void)getFrom:(NSMutableDictionary *)dic {
    NSArray *arr = dic[@"datas"];
    for (NSDictionary *dicts in arr) {
        Case_ListModel *model = [Case_ListModel mj_objectWithKeyValues:dicts];
        [self.dataArry addObject:model];
        if (![XLDataBase isExistWithId:dicts[@"id"]]) {
            [XLDataBase saveItemDict:dicts];
            NSLog(@"插入成功");
        }
    }
  
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
      [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CaseListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Case_ListModel *modle = [self.dataArry objectAtIndex:indexPath.row];
    cell.model = modle;
    return cell;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 280;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
