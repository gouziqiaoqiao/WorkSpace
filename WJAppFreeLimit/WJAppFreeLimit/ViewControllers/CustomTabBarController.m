//
//  CustomTabBarController.m
//  WJFreeLimitApp
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 wangjun. All rights reserved.
//

#import "CustomTabBarController.h"
#import "LimitFreeViewController.h"
#import "FreeViewController.h"
#import "ReductionViewController.h"
#import "SubjectViewController.h"
#import "HotListViewController.h"
#import "CustomNavgationController.h"


@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 创建视图控制器
    [self creatControllers];
    // 设置界面
    [self creatUI];
    
}

#pragma mark - 创建界面
- (void)creatUI {
    
    // 设置tabBar的背景
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_bg"]];
    
    // 设置navgationBar上的颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:60 / 255.0f green:130 / 255.0f blue:199 / 255.0f alpha:1.0]}];

    // 设置tabBar上的文字选中颜色
    [self.tabBar setTintColor:[UIColor colorWithRed:60 / 255.0f green:130 / 255.0f blue:199 / 255.0f alpha:1.0]];

}


#pragma mark - 创建视图控制器
- (void)creatControllers {

    // 1.拿到plist文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Controllers.plist" ofType:nil];
    
    // 2.拿到数组
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:path];
    
    // 3.遍历数组(通过枚举的方式进行遍历数组)
    [plistArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        
        NSString *className = obj[@"className"];
        NSString *imageName = obj[@"imageName"];
        NSString *title = obj[@"title"];
        
        // 将类名转换为类,runTime的方法
        Class wjClass = NSClassFromString(className);
        // 创建视图控制器对象
        UIViewController *controller = [[wjClass alloc] init];
        // 设置tabBatItem的属性
        controller.title = title;
        controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        controller.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_press",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        
        // 添加到tabBarController中
        CustomNavgationController *nav = [[CustomNavgationController alloc] initWithRootViewController:controller];
        [self addChildViewController:nav];
        
    }];
    
    
    
}




@end
