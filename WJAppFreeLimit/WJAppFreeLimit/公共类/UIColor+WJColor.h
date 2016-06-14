//
//  UIColor+WJColor.h
//  WJFreeLimitApp
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 wangjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(WJColor)

+ (UIColor *)colorWithR:(CGFloat) R
                      g:(CGFloat) G
                      b:(CGFloat) B;

+ (UIColor *)colorWithR:(CGFloat) R
                      g:(CGFloat) G
                      b:(CGFloat) B
                      a:(CGFloat) alpha;


@end
