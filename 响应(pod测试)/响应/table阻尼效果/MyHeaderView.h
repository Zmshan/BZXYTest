//
//  MyHeaderView.h
//  响应
//
//  Created by open-roc on 2019/8/22.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, HeadDrawType)   {
    
    DrawTypeA = 0,               // A
    DrawTypeB = 1,               // B
    DrawTypeC = 2,               // C
    DrawTypeD = 3,               // D
    
} ;
NS_ASSUME_NONNULL_BEGIN

@interface MyHeaderView : UIView

@property (strong, nonatomic) UIImageView *imageV;          // 随便放一个 imageView
@property (assign, nonatomic) CGFloat headerViewHeight;     // headerView 高度
@property (assign, nonatomic) CGFloat screenWidth;
@property (assign, nonatomic) HeadDrawType drawType;
@end

NS_ASSUME_NONNULL_END
