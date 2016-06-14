//
//  SubjectModel.h
//  WJAppFreeLimit
//
//  Created by 千锋 on 16/6/14.
//  Copyright (c) 2016年 wangjun. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 外层的
@interface SubjectModel : NSObject<YYModel>

// 应用程序数组
@property (nonatomic, strong) NSArray *applications;
// 日期
@property (nonatomic, copy) NSString *date;
// 描述
@property (nonatomic, copy) NSString *desc;
// 描述图片
@property (nonatomic, copy) NSString *desc_img;
// 大图
@property (nonatomic, copy) NSString *img;
// 标题
@property (nonatomic, copy) NSString *title;


@end


#pragma mark - 内层的applications的
@interface SubjectAPPModel:NSObject<YYModel>
// 应用id
@property (nonatomic, copy) NSString *applicationId;
// 下载数
@property (nonatomic, copy) NSString *downloads;
// 头像
@property (nonatomic, copy) NSString *iconUrl;
// 名字
@property (nonatomic, copy) NSString *name;
// 评价
@property (nonatomic, copy) NSString *ratingOverall;
// 星级
@property (nonatomic, copy) NSString *starOverall;



@end

