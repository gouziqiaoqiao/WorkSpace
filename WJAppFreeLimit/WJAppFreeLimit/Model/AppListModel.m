//
//  AppListModel.m
//  WJFreeLimitApp
//
//  Created by 千锋 on 16/6/13.
//  Copyright (c) 2016年 wangjun. All rights reserved.
//

#import "AppListModel.h"

@implementation AppListModel


// 重写description
- (NSString *)description {
    return _descrip;
}


// 定制属性的映射
+ (NSDictionary *)modelCustomPropertMapper {
    // 让属性descrip和字典的键description对应
    return @{@"descrip":@"description"};
}
@end
