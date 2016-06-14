//
//  FreeViewController.m
//  WJFreeLimitApp
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 wangjun. All rights reserved.
//

#import "FreeViewController.h"

@interface FreeViewController ()

@end

@implementation FreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)init {
    if (self = [super init]) {
        self.requestUrl = kFreeUrl;
    }
    return self;
}

@end
