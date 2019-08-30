//
//  ZDatePickerViewViewController.h
//  响应
//
//  Created by open-roc on 2019/5/7.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDatePickerViewViewController : UIViewController
@property (nonatomic,copy) void (^dateBlock)(NSString *beginDate,NSString *endDate);
@property (nonatomic,copy) NSString *beginDate;
@property (nonatomic,copy) NSString *endDate;
- (void)beginDate:(NSString *)beginDat endDate:(NSString *)endDate;
@end

NS_ASSUME_NONNULL_END
