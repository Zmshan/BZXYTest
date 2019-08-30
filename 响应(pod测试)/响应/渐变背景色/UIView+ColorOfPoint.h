//
//  UIView+ColorOfPoint.h
//  响应
//
//  Created by open-roc on 2019/8/26.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ColorOfPoint)
- (UIColor *) colorOfPoint:(CGPoint)point;
- (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color;
- (void)getRGBColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
