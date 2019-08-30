//
//  ZPersonModel.h
//  响应
//
//  Created by open-roc on 2019/8/9.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZPersonModel : NSObject

@property (nonatomic ,assign) NSInteger  user_id;
@property (nonatomic ,copy) NSString  *user_name;
@property (nonatomic ,assign) NSInteger  user_age;

 
@end

NS_ASSUME_NONNULL_END
