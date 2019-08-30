//
//  CJViewController.m
//  响应
//
//  Created by open-roc on 2019/1/10.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "CJViewController.h"
#import "Masonry.h"
@interface CJViewController ()
@property (nonatomic,strong) UIView *bgView ;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UILabel *label1;

@property (nonatomic,strong) UILabel *label2;

@property (nonatomic,strong) UILabel *label3;

@property (nonatomic,strong) UILabel *label4;
@end

@implementation CJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgView];
    
    [self.bgView addSubview:self.label1];
    [self.bgView addSubview:self.label2];
    [self.bgView addSubview:self.label3];
    [self.bgView addSubview:self.label4];
    [self.bgView addSubview:self.lineView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.left.right.equalTo(self.view);
        
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.bgView);
        make.left.equalTo(self.bgView.mas_centerX).offset(100);
        make.width.mas_equalTo(1);
    }];
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.bgView).offset(10);
    }];
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label1.mas_right).offset(20);
         make.centerY.equalTo(self.label1);

    }];
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.label1.mas_bottom).offset(20);
         make.left.equalTo(self.label1.mas_left);
         make.bottom.equalTo(self.bgView.mas_bottom).offset(-20);
    }];
    [_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label2.mas_left);
        make.centerY.equalTo(self.label3);

    }];
    //抗拉伸性 越高越不容易被拉伸
    [_label1 setContentHuggingPriority:UILayoutPriorityRequired
                               forAxis:UILayoutConstraintAxisHorizontal];
    //抗压缩性 越高越不容易被压缩
    [_label1 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    //抗拉伸性 越高越不容易被拉伸
    //抗拉伸性 越高越不容易被拉伸
    [_label2 setContentHuggingPriority:UILayoutPriorityRequired
                                          forAxis:UILayoutConstraintAxisHorizontal];
    //抗压缩性 越高越不容易被压缩
    [_label2 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    //抗拉伸性 越高越不容易被拉伸
    [_label4 setContentHuggingPriority:UILayoutPriorityRequired
                               forAxis:UILayoutConstraintAxisHorizontal];
    //抗压缩性 越高越不容易被压缩
    [_label4 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}
- (UIView *)bgView {
    
    if (!_bgView) {
        
        _bgView =[[UIView alloc] init];
        
        _bgView.backgroundColor = [UIColor greenColor];
//        _bgView.backgroundColor = BottomColor;
    }
    return _bgView;
}
- (UILabel *)label1 {
    
    if (!_label1) {
        _label1 =[[UILabel alloc] init];
        _label1.textColor = [UIColor blackColor];
        _label1.font = [UIFont boldSystemFontOfSize:24];
        _label1.textAlignment = NSTextAlignmentLeft;
//        _label1.numberOfLines = 0;
        _label1.text = @"1500-5000元";
    }
    return _label1;
}
- (UILabel *)label2 {

    if (!_label2) {
        _label2 =[[UILabel alloc] init];
        _label2.textColor = [UIColor blueColor];
        _label2.font = [UIFont boldSystemFontOfSize:13];
        _label2.textAlignment = NSTextAlignmentLeft;
//        _label2.numberOfLines = 0;
        _label2.text = @"70-30天";
    }
    return _label2;
}
- (UILabel *)label3 {
    
    if (!_label3) {
        _label3 =[[UILabel alloc] init];
        _label3.textColor = [UIColor blueColor];
        _label3.font = [UIFont boldSystemFontOfSize:16];
        _label3.textAlignment = NSTextAlignmentLeft;
//        _label3.numberOfLines = 0;
        _label3.text = @"额度范围（元）";
    }
    return _label3;
}
- (UILabel *)label4 {
    
    if (!_label4) {
        _label4 =[[UILabel alloc] init];
        _label4.textColor = [UIColor blueColor];
        _label4.font = [UIFont boldSystemFontOfSize:16];
        _label4.textAlignment = NSTextAlignmentLeft;
//        _label4.numberOfLines = 0;
        _label4.text = @"10分钟放款";
    }
    return _label4;
}

- (UIView *)lineView {
    
    if (!_lineView) {
        
        _lineView =[[UIView alloc] init];
        
        
        _lineView.backgroundColor = [UIColor redColor];
    }
    return _lineView;
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
