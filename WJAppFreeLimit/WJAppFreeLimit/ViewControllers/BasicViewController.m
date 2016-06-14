//
//  BasicViewController.m
//  WJFreeLimitApp
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 wangjun. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController ()

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建界面
    [self creatUI];

}

#pragma mark - 返回上一页
- (void)backLastView {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 创建界面
- (void)creatUI {

}

#pragma mark - 实例化manager-懒加载
- (AFHTTPSessionManager *)requestManager {
    if (!_requestManager) {
        _requestManager = [AFHTTPSessionManager manager];
        
        // 设置JSON数据序列化，将JSON数据转换为字典或者数组
        _requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
        // 在序列化器中追加一个类型，text/html这个类型是不支持的，text/json, application/json
        _requestManager.responseSerializer.acceptableContentTypes = [_requestManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
    }
    return _requestManager;
}



#pragma mark - 添加navigationItem
- (void)addNavigationItemWithTiltle:(NSString *)title isBack:(BOOL)isBack isRight:(BOOL)isRight target:(id)target action:(SEL)action {
    
    // 通过自定制按钮去创建UIBarButtonItem
    UIButton *button = [[UIButton alloc] init];
    
    // 设置文字颜色
//    [button setTitleColor:[UIColor colorWithRed:61 / 255.0f green:40 / 255.0f blue:60 / 255.0f alpha:1.0] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithR:61 g:40 b:60 a:1.0] forState:UIControlStateNormal];
    
    // 设置字体大小
    button.titleLabel.font = [UIFont systemFontOfSize:12.0];
    
    // 根据是否是返回按钮而设置不同的大小和背景图片
    if (isBack) {
        button.frame = CGRectMake(0, 0, 63, 30);
        [button setBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal];
    }
    else {
        button.frame = CGRectMake(0, 0, 44, 30);
        [button setBackgroundImage:[UIImage imageNamed:@"buttonbar_action"] forState:UIControlStateNormal];
    }
    
    // 设置文字
    [button setTitle:title forState:UIControlStateNormal];
    
    // 给按钮添加点击事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    // 根据按钮创建UIBarButtonItem
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];

    // 显示在navigation上去
    if (isRight) {
        self.navigationItem.rightBarButtonItem = item;
    }
    else {
        self.navigationItem.leftBarButtonItem = item;
    }
    
}

@end
