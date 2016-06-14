//
//  SubjectViewController.m
//  WJFreeLimitApp
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 wangjun. All rights reserved.
//

#import "SubjectViewController.h"
#import "SubjectModel.h"
#import "SubjectCell.h"

@interface SubjectViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *subjectTableView;

// 数据源数组
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestDataWithPage:1];
}

#pragma mark - 懒加载
- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;

}

- (instancetype)init {
    if (self = [super init]) {
        self.requestUrl = kSubjectUrl;
    }
    return self;
}

#pragma mark - 获取数据
// page 分页
// number 数量
- (void)requestDataWithPage:(NSInteger) page {
    
    [self.requestManager GET:self.requestUrl parameters:@{@"page":[NSNumber numberWithInteger:page], @"number":@5} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"请求成功%@",responseObject);
        // 将数组转换为模型数组
        NSArray *modelArray = [NSArray yy_modelArrayWithClass:[SubjectModel class] json:responseObject];
        
        // 判断是否是刷新
        if ([self.subjectTableView.mj_header isRefreshing]) {
            [self.dataArray removeAllObjects];
        }
        
        // 停止刷新
        [self.subjectTableView.mj_header endRefreshing];
        [self.subjectTableView.mj_footer endRefreshing];
        
        // 将数据源放到数据源数组中
        [self.dataArray addObjectsFromArray:modelArray];
        
        // 刷新
        [self.subjectTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"请求失败%@",error);
        
        
    }];
}

#pragma mark - 创建界面
- (void)creatUI {
    
    // 1.创建tableView
    self.subjectTableView = [[UITableView alloc] init];
    self.subjectTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.subjectTableView];
    
    __weak typeof(self) weakself = self;
    [self.subjectTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(weakself.view);
    }];
    
    
    // 添加刷新控件
    [self addMJResfresh];
    
    // 设置代理
    self.subjectTableView.delegate = self;
    self.subjectTableView.dataSource = self;
    
    
    // 设置行高
    self.subjectTableView.rowHeight = 250;
    
    // 注册cell
    [self.subjectTableView registerNib:[UINib nibWithNibName:@"SubjectCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

#pragma mark - 实现协议方法dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 创建cell
    SubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // 刷新数据
    cell.model = self.dataArray[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 返回cell
    return cell;
    
}


#pragma mark - 添加刷新控件
- (void)addMJResfresh {

    // 下拉
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh:)];
    // 设置文字
    [header setTitle:@"下拉加载数据" forState:MJRefreshStateIdle];
    [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    
    self.subjectTableView.mj_header = header;
    
    // 上拉
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(addMore:)];
    
    // 设置文字
    [footer setTitle:@"开始刷新" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"已经没有数据" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor blueColor];
    self.subjectTableView.mj_footer = footer;
    
}

#pragma mark - 下拉刷新
- (void)refresh:(MJRefreshGifHeader *)header {
    //[self.subjectTableView.mj_header endRefreshing];
    
    [self requestDataWithPage:1];
    
}
#pragma mark - 上拉加载更多
- (void)addMore:(MJRefreshBackGifFooter *)footer {
    //[self.subjectTableView.mj_footer endRefreshing];
    
    [self requestDataWithPage:self.dataArray.count / 5 + 1];
}


@end
