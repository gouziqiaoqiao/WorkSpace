//
//  SettingsViewController.m
//  WJFreeLimitApp
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 wangjun. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 创建界面
- (void)creatUI {
    
    self.title = @"设置";
    [self addNavigationItemWithTiltle:@"返回" isBack:YES isRight:NO target:self action:@selector(backLastView)];
}

#pragma mark - 按钮点击
- (void)backLastView {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
