//
//  ZuNiViewController.m
//  响应
//
//  Created by open-roc on 2019/8/22.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "ZuNiViewController.h"
#import "MyHeaderView.h"
@interface ZuNiViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) MyHeaderView *headerView;     // 上面蓝色的 view，可以自定义
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) CGFloat headerViewHeight;     // headerView 高度
@property (assign, nonatomic) BOOL hasFinishLayouSubview;
@end

@implementation ZuNiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headerViewHeight = 180;
    [self createView];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    //用一个标识防止不停地调用
    if (!_hasFinishLayouSubview) {
        _hasFinishLayouSubview = YES;
        
        [_tableView layoutIfNeeded];
        [_tableView setContentOffset:CGPointMake(0, -100)];
    }
    
}

#pragma mark - initView
- (void)createView{
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, NAVIGATIONBAR_H, self.view.frame.size.width, self.view.frame.size.height-NAVIGATIONBAR_H);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 40;
    _tableView.sectionHeaderHeight = 20;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.showsVerticalScrollIndicator = false;
    self.automaticallyAdjustsScrollViewInsets = false;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mycell"];
    // 占位用的 view，高度 180
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, self.headerViewHeight)];
    view.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = view;
    [self.view addSubview:self.tableView];
    // 蓝色的 headerView
    _headerView = [[MyHeaderView alloc] init];
    self.headerView.frame = CGRectMake(0, NAVIGATIONBAR_H, self.view.frame.size.width, self.headerViewHeight);
    [self.view addSubview:self.headerView];
}



#pragma mark - 监听 tableView.contentOffset，也可以用 kvo 监听

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGRect frame = self.headerView.frame;
    if (offsetY < 0) {
        frame.size.height = self.headerViewHeight - offsetY;
        frame.origin.y = 0;             // 及时归零
    } else {
        frame.size.height = self.headerViewHeight;
        frame.origin.y = -offsetY;
    }
//    self.headerView.frame = frame;
    self.headerView.frame = CGRectMake(0, frame.origin.y+NAVIGATIONBAR_H, frame.size.width, frame.size.height);
}


// scrollViewWillEndDragging，这个方法内判断一下，contentOffset.y 值，如果超过多少值，那么自动回调一个 block，可实现下拉刷新
//松手时触发
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (-offsetY > 70) {
        
        NSLog(@"11111");
        
    }
    
}

#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indetifier = @"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indetifier];
    cell.textLabel.text = @"Amydom";
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterViewID"];
    if (view == nil) {
        view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"UITableViewHeaderFooterViewID"];
        view.contentView.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.0];;
    }
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
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
