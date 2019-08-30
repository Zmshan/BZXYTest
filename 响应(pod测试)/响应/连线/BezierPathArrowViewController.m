//
//  BezierPathArrowViewController.m
//  响应
//
//  Created by open-roc on 2019/8/14.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "BezierPathArrowViewController.h"
#import "Arrow.h"
#import "MyTestView.h"
@interface BezierPathArrowViewController ()

@end

@implementation BezierPathArrowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    Arrow *v= [[Arrow alloc]initWithFrame:self.view.bounds];
//    [self.view addSubview:v];
    
    MyTestView *v= [[MyTestView alloc]init];
    v.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100);
    [self.view addSubview:v];
    
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
