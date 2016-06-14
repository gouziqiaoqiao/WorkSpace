//
//  SubjectModel.m
//  WJAppFreeLimit
//
//  Created by 千锋 on 16/6/14.
//  Copyright (c) 2016年 wangjun. All rights reserved.
//

#import "SubjectModel.h"


@implementation SubjectModel

// 将当前模型中指定的属性(必须是容器)元素转为指定的类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    // 将applications属性的数组元素转为SubjectAPPModel类型
    return @{@"applications":[SubjectAPPModel class]};

}

@end


@implementation SubjectAPPModel



@end