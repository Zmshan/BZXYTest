//
//  ConvertImageTool.m
//  响应
//
//  Created by open-roc on 2019/4/18.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "ConvertImageTool.h"

@implementation ConvertImageTool

+ (UIImage *)imageWithFrame:(CGRect)frame BackGroundColor:(UIColor *)backGroundColor Text:(NSString *)text TextColor:(UIColor *)textColor TextFontOfSize:(CGFloat)size{
    //初始化并绘制UI
    ConvertImageView *view = [[ConvertImageView alloc] initWithFrame:frame BackGroundColor:backGroundColor Text:text TextColor:textColor TextFontOfSize:size];
    
    //转化成image
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tImage;
}
@end
