//
//  TPCustomTitleScrollView.h
//  响应
//
//  Created by open-roc on 2018/12/10.
//  Copyright © 2018 kuaixun100. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPCustomTitleScrollView : UIView
@property (nonatomic,copy) NSArray *titlesArr;
@property (nonatomic,copy) void (^scrollPageToIndexBlock)(NSInteger index);
- (void)titleStatusChangeWithProgress:(CGFloat)progress fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
@end

NS_ASSUME_NONNULL_END
