//
//  AppListCell.m
//  WJFreeLimitApp
//
//  Created by 千锋 on 16/6/13.
//  Copyright (c) 2016年 wangjun. All rights reserved.
//

#import "AppListCell.h"
#import <UIImageView+AFNetworking.h>
#import "AppListModel.h"
#import "WJStartView.h"


@interface AppListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *dataLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet WJStartView *StartView;

@end



@implementation AppListCell

// 给子控件赋值
- (void)setModel:(AppListModel *)model {
    _model = model;
    
    // 头像
    [self.iconImageView setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:[UIImage imageNamed:@""]];
    
    // 名字
    self.nameLabel.text = model.name;
    
    // 日期
    self.dataLabel.text = model.releaseDate;
    
    // 价格
    //self.priceLabel.text = model.lastPrice;
    
    /** 使用富文本
     参数1:一般的字符串
     参数2:属性
    */
    // NSStrikethroughStyleAttributeName删除线,NSStrikethroughColorAttributeName:删除线颜色
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",model.lastPrice] attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle), NSStrikethroughColorAttributeName:[UIColor redColor]}];
    // 在label上显示富文本
    self.priceLabel.attributedText = attrStr;
    
    
    // 类型
    self.typeLabel.text = model.categoryName;
    
    // 数量等
    self.countLabel.text = [NSString stringWithFormat:@"分享:%@  收藏:%@  下载:%@",model.shares, model.favorites, model.downloads];
    
    // 星级
    self.StartView.startValue = model.startCurrent;
    
}


// 通过xib的方式,创建cell,当cell将要显示出来的时候,会自动调用这个方法
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    // 切圆角
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = 10;
    
    // 使用自己的字体,来设置nameLabel
    /**
     *  @param NSString 字体名
     *  @return 字体大小
     */
    //self.nameLabel.font = [UIFont fontWithName:@"HYZhuanShuF" size:17.0];
   // NSLog(@"%@",[UIFont familyNames]);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
