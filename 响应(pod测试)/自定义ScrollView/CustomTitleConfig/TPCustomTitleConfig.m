//
//  TPCustomTitleConfig.m
//  响应
//
//  Created by open-roc on 2018/12/10.
//  Copyright © 2018 kuaixun100. All rights reserved.
//

#import "TPCustomTitleConfig.h"

@implementation TPCustomTitleConfig
+ (instancetype)defaultConfig {
    
    TPCustomTitleConfig *config = [[TPCustomTitleConfig alloc] init];
    
    config.titleFont = [UIFont systemFontOfSize:15];
    config.titleNormalColor = [UIColor whiteColor];
    config.titleSelectColor = [UIColor whiteColor];
    
    config.titleBgNormalColor = [UIColor blueColor];
    config.titleBgSelectColor = [UIColor orangeColor];
    config.titleDefaultMargin = 20;
  
    return config;
    
}
@end
