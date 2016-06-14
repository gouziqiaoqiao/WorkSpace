//
//  UIColor+WJColor.m
//  WJFreeLimitApp
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 wangjun. All rights reserved.
//

#import "UIColor+WJColor.h"

@implementation UIColor(WJColor)


+ (UIColor *)colorWithR:(CGFloat) R
                      g:(CGFloat) G
                      b:(CGFloat) B {

    return [UIColor colorWithRed:R / 255.0f green:G / 255.0f blue:B / 255.0f alpha:1.0];

}


+ (UIColor *)colorWithR:(CGFloat) R
                      g:(CGFloat) G
                      b:(CGFloat) B
                      a:(CGFloat) alpha {
    
    return [UIColor colorWithRed:R / 255.0f green:G / 255.0f blue:B / 255.0f alpha:alpha];
}

@end
