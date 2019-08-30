//
//  LoginViewController.m
//  响应
//
//  Created by open-roc on 2019/7/24.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "LoginViewController.h"
#import "CritterView.h"
#import "Masonry.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property (nonatomic ,assign) CGRect  buttonFrame;
@property (nonatomic ,assign) CGFloat buttonHeight;
@property (nonatomic ,assign) CGFloat buttonHorizontalMargin;
@property (nonatomic ,assign) CGFloat buttonImageDimension;
@property (nonatomic ,assign) CGFloat buttonVerticalMargin;
@property (nonatomic ,assign) CGFloat buttonWidth;
@property (nonatomic ,assign) CGFloat critterViewDimension;
@property (nonatomic ,assign) CGRect  critterViewFrame;
@property (nonatomic ,assign) CGFloat critterViewTopMargin;
@property (nonatomic ,assign) CGFloat textFieldHeight;
@property (nonatomic ,assign) CGFloat textFieldHorizontalMargin;
@property (nonatomic ,assign) CGFloat textFieldSpacing;
@property (nonatomic ,assign) CGFloat textFieldTopMargin;
@property (nonatomic ,assign) CGFloat textFieldWidth;

@property (nonatomic,strong) UIView *alertView ;
@property (nonatomic,strong) UIView *alertView1 ;
@property (nonatomic,strong) UIView *alertView2 ;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _buttonImageDimension = 18;
    _critterViewDimension = 160;
    _critterViewTopMargin = 70;
    _textFieldHeight = 37;
    _textFieldHorizontalMargin = 16.5;
    _textFieldSpacing = 22;
    _textFieldTopMargin = 38.8;
    _textFieldWidth = 206;
    _buttonHeight = _textFieldHeight;
    _buttonVerticalMargin = (_buttonHeight - _buttonImageDimension) / 2;
    _buttonWidth = (_textFieldHorizontalMargin / 2) + _buttonImageDimension;
    _buttonFrame = CGRectMake(0, 0, _buttonWidth, _buttonHeight);
    _buttonHorizontalMargin = _textFieldHorizontalMargin / 2;
    _critterViewFrame = CGRectMake(0, 0, _critterViewDimension, _critterViewDimension);
   
    
    [self.view addSubview:self.alertView];
    _alertView.frame = CGRectMake(100, 100, 200, 200);
    
    [self.alertView addSubview:self.alertView1];
    _alertView1.frame = CGRectMake(10, 10, 150, 150);
    
    [self.alertView1 addSubview:self.alertView2];
    _alertView2.frame = CGRectMake(10, 10, 100, 100);
//    _alertView1.bounds = CGRectMake(10, 0, 150, 150);
    
    //设置约束
    [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(100);
        make.height.mas_equalTo(100);
        
        
    }];

    [_alertView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_alertView);
        //        make.width.mas_equalTo(topView);
        //        make.height.mas_equalTo(topView.mas_height).multipliedBy(0.5);
        //设置宽高比例为7：1
        make.width.mas_equalTo(_alertView1.mas_height).multipliedBy(16);
//        make.width.mas_equalTo(_alertView.mas_width).multipliedBy(7);
//        make.height.mas_equalTo(_alertView.mas_height).multipliedBy(16);
        make.center.mas_equalTo(_alertView);
        //设置优先级
        make.width.height.mas_equalTo(_alertView).priorityLow();
        make.width.height.lessThanOrEqualTo(_alertView);
    }];
    
    
    
    
}
- (UIView *)alertView {
    
    if (!_alertView) {
        _alertView =[[UIView alloc] init];
        _alertView.backgroundColor = [UIColor blackColor];
    }
    return _alertView;
}

- (UIView *)alertView1 {
    
    if (!_alertView1) {
        _alertView1 =[[UIView alloc] init];
        _alertView1.backgroundColor = [UIColor blueColor];
    }
    return _alertView1;
}
- (UIView *)alertView2 {
    
    if (!_alertView2) {
        _alertView2 =[[UIView alloc] init];
        _alertView2.backgroundColor = [UIColor redColor];
    }
    return _alertView2;
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
