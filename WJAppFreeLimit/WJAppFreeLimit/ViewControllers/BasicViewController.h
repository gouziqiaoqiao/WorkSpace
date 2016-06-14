//
//  BasicViewController.h
//  WJFreeLimitApp
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 wangjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicViewController : UIViewController

// 请求路径
@property (nonatomic, strong) NSString *requestUrl;

// 网络请求管理者
@property (nonatomic, strong) AFHTTPSessionManager *requestManager;


// 添加navigationItem
- (void)addNavigationItemWithTiltle:(NSString *)title
                             isBack:(BOOL) isBack
                            isRight:(BOOL) isRight
                             target:(id) target
                             action:(SEL) action;

// 创建界面
- (void)creatUI;


// 返回上一页
- (void)backLastView;

@end
