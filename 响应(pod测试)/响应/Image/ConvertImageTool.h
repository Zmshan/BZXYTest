//
//  ConvertImageTool.h
//  响应
//
//  Created by open-roc on 2019/4/18.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConvertImageView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ConvertImageTool : NSObject

+ (UIImage*)imageWithFrame:(CGRect)frame BackGroundColor:(UIColor*)backGroundColor Text:(NSString*)text TextColor:(UIColor*)textColor TextFontOfSize:(CGFloat)size;
@end

NS_ASSUME_NONNULL_END
