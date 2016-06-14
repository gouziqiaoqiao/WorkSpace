//
//  SearchViewController.m
//  WJAppFreeLimit
//
//  Created by 千锋 on 16/6/14.
//  Copyright (c) 2016年 wangjun. All rights reserved.
//

#import "SearchViewController.h"
#import "AppListCell.h"
#import "AppListModel.h"


@interface SearchViewController ()<UITableViewDelegate, UITableViewDataSource>
// 数据源数组
@property (nonatomic, strong) NSMutableArray *dataArray;

// tableView
@property (nonatomic, strong) UITableView *searchTableView;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestDataWithPage:1 search:self.searchText cateId:nil];
}

#pragma mark - 懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

#pragma mark - 创建界面
- (void)creatUI {
    // 1.tableView
    self.searchTableView = [UITableView new];
    [self.view addSubview:self.searchTableView];

    //
    self.searchTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 添加约束
    __weak typeof (self) weakself = self;
    [self.searchTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakself.view);
    }];
    
    // 添加刷新控件
    [self addMJResfresh];
    
    // 设置代理
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    
    // 注册cell
    [self.searchTableView registerNib:[UINib nibWithNibName:@"AppListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    // 2.设置title
    self.title = @"搜索结果";
    
    // 3.设置返回按钮
    [self addNavigationItemWithTiltle:@"返回" isBack:YES isRight:NO target:self action:@selector(backLastView)];
    
}

#pragma mark - delegate协议
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //return 146;
    // 算出cell的高度比(在6上是146)
    CGFloat scale = 146 / 667.0f;
    
    // 根据不同的屏幕尺寸设置cell的高度
    return scale *self.view.frame.size.height;
    
}

#pragma mark - dataSource协议
// 设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

// TableViewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 创建cell
    AppListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // 刷新数据
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}


#pragma mark - 获取数据
- (void)requestDataWithPage:(NSInteger) page
                     search:(NSString *) search
                     cateId:(NSString *) cateId {
    NSDictionary *dict = @{@"page":[NSNumber numberWithInteger:page], @"number":@20,@"search":self.searchText};
    [self.requestManager GET:self.requestUrl parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        // 1.将获取到字典数组
        NSArray *dictArray = responseObject[@"applications"];
        
        // 2.将字典数组转换为模型数组
        NSArray *modelArray = [NSArray yy_modelArrayWithClass:[AppListModel class] json:dictArray];
        
        // 3.将模型数组中的数据放到数据源数组中
        [self.dataArray addObjectsFromArray:modelArray];
        
        // 4.刷新界面
        [self.searchTableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
    }];
}


#pragma mark - 添加刷新控件
- (void)addMJResfresh {
    
    // 下拉
    self.searchTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self.searchTableView.mj_header endRefreshing];
        [self requestDataWithPage:1 search:self.searchText cateId:@""];
    }];
    
    // 上拉
    self.searchTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
         [self.searchTableView.mj_footer endRefreshing];
        
        NSInteger page = self.dataArray.count / 20 + 1;
        [self requestDataWithPage:page search:self.searchText cateId:@""];
    }];
}


@end
