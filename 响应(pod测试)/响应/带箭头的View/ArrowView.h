//
//  ArrowView.h
//  响应
//
//  Created by open-roc on 2019/6/3.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ArrowViewType)   {
    //    试题类型
    ArrowTypeTypeTop = 1,               // 上
    ArrowTypeBottom = 2,                // 下
    ArrowTypeLeft = 3,                  // 左
    ArrowTypeRight = 4,                 // 右
    ArrowTypeSanJiao = 5,               // 三角形
    ArrowTypeYuanJiaoArc = 6,           // 圆角
    ArrowTypeCustomBottom = 7,          // 下

} ;
typedef NS_ENUM(NSInteger, ArrowViewDirectionType)   { //箭头方向
    //    试题类型
    ArrowViewDirectionTypeLeftTop,               // 左上
    ArrowViewDirectionTypeLeftCenter,            // 左中
    ArrowViewDirectionTypeLeftBottom,            // 左下
    ArrowViewDirectionTypeBottomLeft,            // 下左
    ArrowViewDirectionTypeBottomCenter,          // 下中
    ArrowViewDirectionTypeBottomRight,           // 下右
    ArrowViewDirectionTypeRightTop,              // 右上
    ArrowViewDirectionTypeRightCenter,           // 右中
    ArrowViewDirectionTypeRightBottom,           // 右下
    ArrowViewDirectionTypeTopLeft,               // 上左
    ArrowViewDirectionTypeTopCenter,             // 上中
    ArrowViewDirectionTypeTopRight,              // 上右
} ;


NS_ASSUME_NONNULL_BEGIN

@interface ArrowView : UIView
- (void)changeBackColor:(UIColor *)color;
@property (assign,nonatomic) ArrowViewType  arrowType;
@property (assign,nonatomic) ArrowViewDirectionType  arrowDirectionType;

- (void)configurationRadiusLeftTop:(CGFloat)leftTop andLeftBootom:(CGFloat)leftBootom andRightTop:(CGFloat)rightTop andRightBootom:(CGFloat)rightBootom;
- (void)arrowNeedsDisplay;
@end

NS_ASSUME_NONNULL_END
