//
//  TestOCViewController.m
//  响应
//
//  Created by open-roc on 2019/8/23.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "TestOCViewController.h"
#import "响应-Swift.h"//import "工程名-Swift.h"
@interface TestOCViewController ()

@end

@implementation TestOCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    来源参考 ：
//    https://blog.csdn.net/zlj_jeck/article/details/51503937
//    https://www.jianshu.com/p/03496798a373
    
    TestSwiftViewController *test = [[TestSwiftViewController alloc] init];
    
    test.view.frame = self.view.bounds;
    [self.view addSubview:test.view];
    [self addChildViewController:test];
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
