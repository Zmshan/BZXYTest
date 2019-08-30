//
//  BaseViewController.m
//  响应
//
//  Created by open-roc on 2018/12/7.
//  Copyright © 2018 kuaixun100. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewController+Test.h"
@interface BaseViewController ()
- (void)testUI;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testLog];
    self.url = @"123456";
}

- (void)test{
    
}
- (void)testUI{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
