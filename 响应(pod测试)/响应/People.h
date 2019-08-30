//
//  People.h
//  响应
//
//  Created by  open-roc on 2017/10/18.
//  Copyright © 2017年 kuaixun100. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface People : NSObject
- (void)run;
- (void)study;



- (People* (^)(void))runBlock;
- (People* (^)(void))studyBlock;

- (People* (^)(NSString * str))runStrBlock;
+ (People* (^)(NSString * str))addRunStrBlock;

@end
