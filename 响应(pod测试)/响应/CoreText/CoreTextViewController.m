//
//  CoreTextViewController.m
//  响应
//
//  Created by open-roc on 2018/9/19.
//  Copyright © 2018年 kuaixun100. All rights reserved.
//

#import "CoreTextViewController.h"
#import "CoreTextView.h"
@interface CoreTextViewController ()

@end

@implementation CoreTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    CoreTextView * view = [[CoreTextView alloc]initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor brownColor];
    [self.view addSubview:view];

    

    

}





@end
