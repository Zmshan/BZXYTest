//
//  tableVCViewController.m
//  响应
//
//  Created by open-roc on 2018/9/19.
//  Copyright © 2018年 kuaixun100. All rights reserved.
//

#import "tableVCViewController.h"
#import "TCTableViewCell.h"
#import "Masonry.h"
@interface tableVCViewController ()<UITableViewDelegate,UITableViewDataSource >
@property (nonatomic, strong)UITableView *jcTableView;
@end

@implementation tableVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.jcTableView];
    [self.jcTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


#pragma mark numberOfSectionsInTableView:
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark tableView:numberOfRowsInSection:
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return 0.000001;
//}


#pragma mark tableView:cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jcTableViewCell" forIndexPath:indexPath];
    if (indexPath.row==0) {
        cell.contentLabel.text = @"wlkjdkjsdbkfbakjbshkfbjhabsjkbfkjabj";
        return cell;
    }else{
        NSString * str =@"wlkjdkjsdbkfbakjbshkfbjhabsjkbfkjabjfbawlkjdkjsdbkfbakjbshkfbjhabsjkbfkjabjfbaskjbfjbakbsfvabvbabvbajwlkjdkjsdbkfbakjbshkfbjhabsjkbfkjabjfbaskj\t\tb";
//        cell.contentLabel.text = @"wlkjdkjsdbkfbakjbshkfbjhabsjkbfkjabjfbaskjbfjbakbsfvabvbabvbaj";
//        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//        // 对齐方式
//        style.alignment = NSTextAlignmentLeft;
//        // 首行缩进
//        style.firstLineHeadIndent = 0.0f;
//        // 头部缩进
//        style.headIndent =  0.0f;
//        // 尾部缩进
//        style.tailIndent = -14.0f*5;
//        NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:str attributes:@{ NSParagraphStyleAttributeName : style}];
//        cell.contentLabel.attributedText = str;
        cell.contentLabel.numberOfLines = 0;
        cell.contentLabel.text = str;
        cell.contentLabel.backgroundColor = [UIColor redColor];
        
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  UITableViewAutomaticDimension;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (UITableView *)jcTableView{
    
    
    if (!_jcTableView) {
        _jcTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _jcTableView.backgroundColor = [UIColor clearColor];
        //        _jcTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        iOS11TabViewEstimated(_jcTableView)
        _jcTableView.delegate =self;
        _jcTableView.dataSource = self;
        _jcTableView.rowHeight = 44;
        _jcTableView.estimatedRowHeight = 44;
        [_jcTableView registerClass:[TCTableViewCell class] forCellReuseIdentifier:@"jcTableViewCell"];
        
        _jcTableView.scrollEnabled = NO;
        _jcTableView.bounces = NO;
    }
    return _jcTableView;
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
