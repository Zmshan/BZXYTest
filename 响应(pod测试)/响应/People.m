//
//  People.m
//  响应
//
//  Created by  open-roc on 2017/10/18.
//  Copyright © 2017年 kuaixun100. All rights reserved.
//

#import "People.h"

@implementation People
- (void)run{
    NSLog(@"run");
}
- (void)study {
    NSLog(@"study");
}


- (People* (^)(void))runBlock {
    People* (^block)(void) = ^() {
        NSLog(@"runBlock");
        return self;
    };
    return block;
}
- (People* (^)(void))studyBlock {
    People* (^block)(void) = ^()  {
        NSLog(@"studyBlock");
        return self;
    };
    return block;
}

- (People* (^)(NSString * str))runStrBlock{
    People* (^block)(NSString * ss) = ^(NSString * ss)  {
        NSLog(@"%@",ss);
        return self;
    };
    return block;
}

+(People* (^)(NSString * str))addRunStrBlock{
    People* (^block)(NSString * ss) = ^(NSString * ss)  {
        NSLog(@"%@",ss);
        return self;
    };
    return block;
}

@end
