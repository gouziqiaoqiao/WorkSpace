//
//  AppListViewController.m
//  WJFreeLimitApp
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 wangjun. All rights reserved.
//

#import "AppListViewController.h"
#import "SettingsViewController.h"
#import "CategoryViewController.h"
#import "SearchViewController.h"
#import "AppListModel.h"
#import "AppListCell.h"




@interface AppListViewController () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

// 表格视图
@property (nonatomic, strong) UITableView *appTableView;

// 数据源数组
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation AppListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestDataWithPage:1 search:@"" cateId:@"1"];
}

#pragma mark - 懒加载
- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}



#pragma mark - 数据请求
- (void)requestDataWithPage:(NSInteger) page
                     search:(NSString *) search
                     cateId:(NSString *) cateId {
    
    // 请求数据
    NSDictionary *dict = @{@"page":[NSNumber numberWithInteger:page], @"number":@20, @"search":search};
    if (self.cateId.length > 0) {
        dict = @{@"page":[NSNumber numberWithInteger:page], @"number":@20, @"search":search, @"cate_id":self.cateId};
    }
    
    [self.requestManager GET:self.requestUrl parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        // 请求成功的block
        //NSLog(@"请求成功%@",responseObject);
        // 获取字典数组
        NSArray *plistArray = responseObject[@"applications"];
        
        // 将字典数组转换为模型数组
        /**
         *  @param Class 模型的类型
         *  @return 需要转换的数组
         */
        NSArray *appArray = [NSArray yy_modelArrayWithClass:[AppListModel class] json:plistArray];
        
        
        if ([self.appTableView.mj_header isRefreshing]) {
            // 删除之前的数据
            [self.dataArray removeAllObjects];
        }
        
        
        // 将模型放到数据源数组中
        [self.dataArray addObjectsFromArray:appArray];
        
        [self.appTableView.mj_header endRefreshing];
        [self.appTableView.mj_footer endRefreshing];
        
        // 刷新界面
        [self.appTableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 请求失败的block
        NSLog(@"error:%@",error);
        
    }];
    
}



#pragma mark - 创建界面
- (void)creatUI {
    
    // 1.设置navigationBarItem
    // 分类
    [self addNavigationItemWithTiltle:@"分类" isBack:NO isRight:NO target:self action:@selector(category:)];

    // 设置
    [self addNavigationItemWithTiltle:@"设置" isBack:NO isRight:YES target:self action:@selector(settings:)];
    
    // 2.创建tableView
    self.appTableView = [[UITableView alloc] init];
    
    self.appTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.appTableView];
    
    // 添加约束
    __weak typeof (self) weakself = self;
    [self.appTableView mas_makeConstraints:^(MASConstraintMaker *make) {
      
        // 同时添加上下左右的边距
        make.edges.equalTo(weakself.view);
    
    }];

    // 添加刷新控件
    [self addMJResfresh];
    
    // 添加代理
    self.appTableView.delegate = self;
    self.appTableView.dataSource = self;
    
    // 设置cell的高度
    self.appTableView.rowHeight = 140;
    
    // 注册cell
    [self.appTableView registerNib:[UINib nibWithNibName:@"AppListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    
    // 3.添加搜索框
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    searchBar.showsCancelButton = YES;
    
    searchBar.placeholder = @"百万应用等你来搜哟";
    
    searchBar.delegate = self;
    self.appTableView.tableHeaderView = searchBar;
}

#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 去复用池中查看是否有可以复用的cell,如果有直接返回,如果没有就创建一个新的返回
    AppListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // 更新数据
    cell.model = self.dataArray[indexPath.row];
    
    // 返回
    return cell;
}



#pragma mark - 添加刷新控件
- (void)addMJResfresh {
    
    // 下拉
    self.appTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        //[self.appTableView.mj_header endRefreshing];
        
        
        // 重新刷新数据
        [self requestDataWithPage:1 search:@"" cateId:@""];
        
    }];

    // 上拉
    self.appTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        //[self.appTableView.mj_footer endRefreshing];
        NSInteger page = self.dataArray.count / 20 + 1;
        
        [self requestDataWithPage:page search:@"" cateId:@""];
    }];

}



#pragma mark - UISearchBarDelegate
// 点击取消按钮的会调用的方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {

    // 收起键盘
    [searchBar resignFirstResponder];
    
    searchBar.text = nil;
}
// 点击搜索按钮会调用的方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    // 收起键盘
    [searchBar resignFirstResponder];
    
    // 进入搜索页
    SearchViewController *search = [[SearchViewController alloc] init];
    
    search.searchText = searchBar.text;
    search.requestUrl = self.requestUrl;
    
    search.hidesBottomBarWhenPushed = YES;
    
    // 跳转
    [self.navigationController pushViewController:search animated:YES];
    
    
}


#pragma mark - 按钮点击
// 点击分类
- (void)category:(UIButton *)button {
    
    CategoryViewController *category = [[CategoryViewController alloc] init];
    
    // 现实下一级界面的block
    category.sendValue = ^(NSString *cateId) {
        
        self.cateId = cateId;
        [self.appTableView.mj_header beginRefreshing];
        
        
    };
    
    category.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:category animated:YES];
    
    
}

// 点击设置
- (void)settings:(UIButton *)button {

    SettingsViewController *settings = [[SettingsViewController alloc] init];
    
    settings.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:settings animated:YES];
}



@end
