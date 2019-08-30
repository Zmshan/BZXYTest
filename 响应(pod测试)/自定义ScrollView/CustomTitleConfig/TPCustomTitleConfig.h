//
//  TPCustomTitleConfig.h
//  响应
//
//  Created by open-roc on 2018/12/10.
//  Copyright © 2018 kuaixun100. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface TPCustomTitleConfig : NSObject

@property (nonatomic,strong) UIFont  *titleFont;
@property (nonatomic,strong) UIColor  *titleNormalColor;
@property (nonatomic,strong) UIColor  *titleSelectColor;
@property (nonatomic,assign) CGFloat titleDefaultMargin;

@property (nonatomic,strong) UIColor  *titleBgNormalColor;
@property (nonatomic,strong) UIColor  *titleBgSelectColor;

@property (nonatomic,assign) CGFloat btnSizeW;
@property (nonatomic,assign) CGFloat btnSizWAndJianJu;
@property (nonatomic,assign) CGFloat sizeW;


@end

NS_ASSUME_NONNULL_END
