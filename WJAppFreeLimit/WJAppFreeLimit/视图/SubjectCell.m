//
//  SubjectCell.m
//  WJAppFreeLimit
//
//  Created by 千锋 on 16/6/14.
//  Copyright (c) 2016年 wangjun. All rights reserved.
//

#import "SubjectCell.h"
#import "SubjectModel.h"
#import "SubjectAppListView.h"



@interface SubjectCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;

@property (weak, nonatomic) IBOutlet UIView *appListView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UITextView *descTextView;
@end


@implementation SubjectCell

#pragma mark - 设置子视图
- (void)setModel:(SubjectModel *)model {
    _model = model;
    
    // 名字
    _nameLabel.text = model.title;
    // 图片
    [_pictureImageView setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@""]];
    
    
    // 描述图片
    [_iconImageView setImageWithURL:[NSURL URLWithString:model.desc_img] placeholderImage:[UIImage imageNamed:@""]];
    // 描述文字
    _descTextView.text = model.desc;
    
    //
    [self addAppList];
    
}




- (void)awakeFromNib {
    // app列表
    SubjectAppListView *appView = [[SubjectAppListView alloc] initWithFrame:CGRectMake(0, 0, self.appListView.frame.size.width, 40)];
    [self.appListView addSubview:appView];
    
    
}

#pragma mark - 添加applist内容
- (void)addAppList {
    
    // 清除applistView原来的视图
    if (self.appListView.subviews.count > 0) {
        // 让数组中的数组元素都去执行指定的方法
        // self.appListView.subviews中视图中都执行这个removeFromSuperview的方法
        [self.appListView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    CGFloat Width = self.appListView.frame.size.width;
    CGFloat Height = self.appListView.frame.size.height / 4.0f;
    CGFloat X = 0;
    __block CGFloat Y;
    
    [self.model.applications enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        // 计算Y
        Y = idx * (Height + 8);
        
        SubjectAppListView *appView = [[SubjectAppListView alloc] initWithFrame:CGRectMake(X, Y, Width, Height)];
        
        [self.appListView addSubview:appView];
        
        // 给模型赋值就会设置子视图的属性
        appView.appModel = obj;
        
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
