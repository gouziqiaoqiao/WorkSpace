//
//  CategoryViewController.h
//  WJFreeLimitApp
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 wangjun. All rights reserved.
//

#import "BasicViewController.h"

@interface CategoryViewController : BasicViewController


// 使用block做反向传值:在下一级界面声明和调用block,在上一级界面实现block
@property (nonatomic, copy) void (^sendValue)(NSString *cateId);

@end
