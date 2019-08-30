//
//  CFJCBaseViewController.m
//  响应
//
//  Created by open-roc on 2018/12/7.
//  Copyright © 2018 kuaixun100. All rights reserved.
//

#import "CFJCBaseViewController.h"
#import "TPCustomTitleScrollView.h"
#import "TPCustomAddViewScrollView.h"
#import "Masonry.h"

@interface CFJCBaseViewController ()

@end

@implementation CFJCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self test];
    [self testBtn1];
    [self testBtn2];
    

//    TPCustomTitleScrollView * titleScroll = [[TPCustomTitleScrollView alloc]init];
//    titleScroll.titlesArr = @[@"我要显示1",@"我要显示2",@"我要显示3",@"显示4",@"我要显示5",@"我要显示6",@"我要显示7",@"我要显示8",@"我要显示9"];
    
//    [self.view addSubview:titleScroll];
    
    
    
//    TPCustomAddViewScrollView * addViewScroll = [[TPCustomAddViewScrollView alloc]init];
//    [self.view addSubview:addViewScroll];
}
- (void)testBtn1{
    
    UIButton *exemptionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    exemptionBtn.frame = CGRectMake(100, 500, 100, 50);
    exemptionBtn.layer.masksToBounds = YES;
    exemptionBtn.layer.cornerRadius = 4;
    exemptionBtn.backgroundColor = [UIColor yellowColor];
    [exemptionBtn setTintColor:[UIColor whiteColor]];
    [exemptionBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [exemptionBtn setTitle:@"model1" forState:UIControlStateNormal];
    [exemptionBtn  addTarget:self action:@selector(modelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exemptionBtn];
}
- (void)testBtn2{
    
    UIButton *exemptionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    exemptionBtn.frame = CGRectMake(250, 500, 100, 50);
    exemptionBtn.layer.masksToBounds = YES;
    exemptionBtn.layer.cornerRadius = 4;
    exemptionBtn.backgroundColor = [UIColor yellowColor];
    [exemptionBtn setTintColor:[UIColor whiteColor]];
    [exemptionBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [exemptionBtn setTitle:@"model2" forState:UIControlStateNormal];
    [exemptionBtn  addTarget:self action:@selector(model2BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exemptionBtn];
}

- (void)modelBtnClicked:(UIButton *)sender{
    NSLog(@"modelBtn1");
//    [self loadTitleBtnAddModel:1];
//    [self loadViewsBtnAddModel:1];
}
- (void)model2BtnClicked:(UIButton *)sender{
    NSLog(@"modelBtn2");
//    [self loadTitleBtnAddModel:2];
//    [self loadViewsBtnAddModel:2];
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
