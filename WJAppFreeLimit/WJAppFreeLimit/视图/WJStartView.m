//
//  WJStartView.m
//  WJAppFreeLimit
//
//  Created by 千锋 on 16/6/13.
//  Copyright (c) 2016年 wangjun. All rights reserved.
//

#import "WJStartView.h"

@interface WJStartView ()

@property (nonatomic, strong) UIImageView *backgroundView;

@property (nonatomic, strong) UIImageView *foregroundView;

@end

@implementation WJStartView


#pragma mark - 初始化
- (instancetype)init {
    if (self = [super init]) {
        
        [self creatSubView];
        
    }
    return self;
}



// 通过storyBoard或者xib去创建视图的时候,会调用这个方法
// 在这个方法中可以拿到当前视图的frame
- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self creatSubView];
        
    }
    return self;
}

- (void)creatSubView {
    
    // 实例化子视图
    //NSLog(@"%@",NSStringFromCGRect(self.frame));
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"StarsBackground"]];
    [self addSubview:self.backgroundView];
    
    self.foregroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"StarsForeground.png"]];
    [self addSubview:self.foregroundView];
    
    
    // 设置显示模式是将突破的左边显示全
    [self.foregroundView setContentMode:UIViewContentModeLeft];
    // 允许裁剪,改变frame
    self.foregroundView.clipsToBounds = YES;
}


//  从外部给startValue赋值,然后根据startValue的值去设置foregroundView的宽度
- (void)setStartValue:(NSString *)startValue {
    
    // 获取原来位置的信息
    CGRect rect = self.backgroundView.frame;
    CGFloat realWidth = rect.size.width * (startValue.floatValue / 5.0f);
    
    // 更新frame
    self.foregroundView.frame = CGRectMake(rect.origin.x, rect.origin.y, realWidth, rect.size.height);

}

@end
