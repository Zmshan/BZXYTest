//
//  TPScrollViewController.m
//  响应
//
//  Created by open-roc on 2018/12/10.
//  Copyright © 2018 kuaixun100. All rights reserved.
//

#import "TPScrollViewController.h"
#import "TPCustomTitleScrollView.h"
#import "TPCustomAddViewScrollView.h"
#import "Masonry.h"
@interface TPScrollViewController ()

@end

@implementation TPScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self testBtn1];
    [self testBtn2];
    
    
    
    NSArray *titleBtnArr = @[@"我要显示1",@"我要显示2",@"我要显示3",@"显示4",@"我要显示5",@"我要显示6",@"我要显示7",@"我要显示8",@"我要显示9"];
    
    TPCustomTitleScrollView * titleScroll = [[TPCustomTitleScrollView alloc]init];
    //        titleScroll.frame =CGRectMake(0, 100, self.view.frame.size.width, 100);
    titleScroll.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:titleScroll];
    [titleScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(100);
    }];
    [self.view layoutIfNeeded];
    titleScroll.titlesArr = titleBtnArr;
    
    
    
    
    TPCustomAddViewScrollView * addViewScroll = [[TPCustomAddViewScrollView alloc]init];

    [self.view addSubview:addViewScroll];
    [addViewScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(titleScroll.mas_bottom).offset(10);
    }];
    [self.view layoutIfNeeded];
    NSMutableArray *arr = [NSMutableArray array];
    [titleBtnArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIView * view = [[UIView alloc]init];
        CGFloat rgb = arc4random()%225;
        view.backgroundColor = [UIColor colorWithRed:rgb/255 green:rgb/255 blue:rgb/255 alpha:1];
        view.tag = idx;
        [view sizeToFit];
        NSLog( @"view%f",view.frame.size.width);
        [arr addObject:view];
    }];
    addViewScroll.addViewsArr = arr;
    
    

    titleScroll.scrollPageToIndexBlock = ^(NSInteger index) {
        [addViewScroll scrollPageToIndex:index];
    };
    
    addViewScroll.changeWithProgressBlock = ^(CGFloat progress, NSInteger sourceIndex, NSInteger targetIndex) {
        [titleScroll titleStatusChangeWithProgress:progress fromIndex:sourceIndex toIndex:targetIndex];
    };
    
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
