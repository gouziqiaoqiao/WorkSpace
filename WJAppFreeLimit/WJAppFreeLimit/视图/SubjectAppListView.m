//
//  SubjectAppListView.m
//  WJAppFreeLimit
//
//  Created by 千锋 on 16/6/14.
//  Copyright (c) 2016年 wangjun. All rights reserved.
//

#import "SubjectAppListView.h"
#import "WJStartView.h"
#import "SubjectModel.h"

@interface SubjectAppListView ()

// 头像
@property (nonatomic, strong) UIImageView *iconImageView;
// 名字
@property (nonatomic, strong) UILabel *nameLabel;
// 评论
@property (nonatomic, strong) UILabel *commentLabel;
// 下载
@property (nonatomic, strong) UILabel *downloadLabel;
// 星级
@property (nonatomic, strong) WJStartView *startView;

@end

// 头像
// 名字
// 评论
// 下载
// 星级

@implementation SubjectAppListView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self creatSubView];
    }
    return self;
}

- (void)layoutSubviews {
    
    [self calculateFrame];
}


#pragma mark - 给子视图赋值
- (void)setAppModel:(SubjectAPPModel *)appModel {
    _appModel = appModel;
    
    // 头像
    [_iconImageView setImageWithURL:[NSURL URLWithString:appModel.iconUrl] placeholderImage:[UIImage imageNamed:@""]];
    // 名字
    _nameLabel.text = appModel.name;
    // 评论
    _commentLabel.attributedText = [self mixImage:[UIImage imageNamed:@"topic_Comment"] text:[NSString stringWithFormat:@" %@", appModel.ratingOverall]];
    // 下载
    _downloadLabel.attributedText = [self mixImage:[UIImage imageNamed:@"topic_Download"] text:[NSString stringWithFormat:@" %@", appModel.downloads]];
    // 星级
    _startView.startValue = appModel.starOverall;
}


#pragma mark - 图文混排
- (NSAttributedString *)mixImage:(UIImage *)image
                            text:(NSString *) text {
    
    // 1.将图片转换成文本附件
    NSTextAttachment *imageToText = [[NSTextAttachment alloc] init];
    imageToText.image = image;
    
    // 2.将图片转换成富文本
    NSAttributedString *imageAttrStr = [NSAttributedString attributedStringWithAttachment:imageToText];
    
    // 3.将文字转换为富文本
    NSAttributedString *textAttrStr = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0], NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    // 4.将文字富文本和图片富文本拼接起来
    NSMutableAttributedString *mAttrStr = [NSMutableAttributedString new];
    [mAttrStr appendAttributedString:imageAttrStr];
    [mAttrStr appendAttributedString:textAttrStr];
   
    // 5.返回
    return mAttrStr;
    
}



#pragma mark - 创建子视图
- (void)creatSubView {
    
    // 头像
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:_iconImageView];
    
    // 名字
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:_nameLabel];
    
    // 评论
    _commentLabel = [[UILabel alloc] init];
    _commentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _commentLabel.font = [UIFont systemFontOfSize:12.0];
    
    [self addSubview:_commentLabel];
    
    // 下载
    _downloadLabel = [[UILabel alloc] init];
    _downloadLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _downloadLabel.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:_downloadLabel];
    
    // 星级
    _startView = [[WJStartView alloc] init];
    _startView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:_startView];
    
}

#pragma mark - 计算子视图的frame

- (void)calculateFrame {

    __weak typeof(self) weakself = self;
    // 头像
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.mas_left);
        make.top.equalTo(weakself.mas_top);
        make.bottom.equalTo(weakself.mas_bottom);
        // 让宽度等于高度
        make.width.equalTo(_iconImageView.mas_height);
    }];

    // 名字
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        // 设置左上右间距
        make.left.equalTo(_iconImageView.mas_right).offset(5);// 有偏移5个像素
        make.top.equalTo(weakself.mas_top);
        make.right.equalTo(weakself.mas_right);
        // 名字的高度是当期视图的高度的1/3
        make.height.equalTo(weakself.mas_height).multipliedBy(1 / 3.0f);
        
    }];

    // 评论
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        // 设置左边距
        make.left.equalTo(_iconImageView.mas_right).offset(5);
        // 高度和nameLabel的高度一致
        make.height.equalTo(_nameLabel.mas_height);
        // Y方向中心等于头像的Y方向中心
        make.centerY.equalTo(_iconImageView.mas_centerY);
        // 宽度等于一个固定值
        CGFloat commentWidth = self.frame.size.width / 3.0f;
        make.width.equalTo(@(commentWidth));
        
    }];

    // 下载
    [_downloadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_commentLabel.mas_right).offset(5);
        make.centerY.equalTo(_iconImageView.mas_centerY);
        make.width.equalTo(_commentLabel); // 这里可以不用把width写出来
        make.height.equalTo(_commentLabel);
    }];
    
    // 星级
    [_startView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_iconImageView.mas_right).offset(5);
        make.right.equalTo(weakself.mas_right).offset(-5);
        make.height.equalTo(_nameLabel);
        make.bottom.equalTo(_iconImageView);
        
    }];
    
}


@end
