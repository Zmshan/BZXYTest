//
//  UIViewController+Test.h
//  响应
//
//  Created by open-roc on 2018/12/7.
//  Copyright © 2018 kuaixun100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Test)
@property (nonatomic, retain) NSString *url;
- (void)testLog;
@end

NS_ASSUME_NONNULL_END
