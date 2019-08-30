//
//  ZCAGradientLayerViewController.m
//  响应
//
//  Created by open-roc on 2019/8/8.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "ZCAGradientLayerViewController.h"
#import "UIView+ColorOfPoint.h"//view取色
#import "UIImageView+ColorOfPoint.h"//image取色
#import "Masonry.h"
@interface ZCAGradientLayerViewController ()

@property(copy) NSArray *colors;  //渐变颜色的数组
@property(copy) NSArray *locations; //渐变颜色的区间分布，
//locations的数组长度和color一致，一般不用设置，默认是nil，会平均分布。
//[NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],
//                          [NSNumber numberWithFloat:0.3],
//                         [NSNumber numberWithFloat:0.8],
//                         [NSNumber numberWithFloat:1.0],
//                        nil];
@property CGPoint startPoint; //映射locations中第一个位置，
//用单位向量表示，比如（0，0）表示从左上角开始变化。默认值是(0.5,0.0)。
@property CGPoint endPoint; //映射locations中最后一个位置
//,用单位向量表示，比如（1，1）表示到右下角变化结束。默认值是(0.5,1.0)。


@property (nonatomic,strong) UIBarButtonItem *rightItem;

@property (nonatomic,strong) UIView *chageViewColor ;
@property (nonatomic,strong) UILabel *changeColorLabel;


@property (nonatomic,strong) UIImageView *bgImage;

@property (nonatomic ,assign) NSInteger  loadType;//0:view 1:image

@end

@implementation ZCAGradientLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"背景渐变" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtn:)];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"图片" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtn:)];
    self.navigationItem.rightBarButtonItems = @[item,item1];
    
    
    
    
    [self loadCAGradientLayer];
    
    
    
    
    [self.view addSubview:self.bgImage];
    self.bgImage.hidden = YES;
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.view addSubview:self.chageViewColor];
    [self.chageViewColor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(100);
    }];
    
    [self.view addSubview:self.changeColorLabel];
    [self.changeColorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.chageViewColor.mas_top).offset(-10);
        make.centerX.equalTo(self.chageViewColor);
    }];

    
    
    
}




- (void)rightBtn:(UIBarButtonItem *)item{
    
    if ([item.title isEqualToString:@"背景渐变"]) {
        self.loadType = 0;
        self.bgImage.hidden = YES;
    }else{
        self.loadType = 1;
        self.bgImage.hidden = NO;
    }
}
#pragma mark === 渐变色 ====
- (void)loadCAGradientLayer{
    //渐变色
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:gradientLayer];
    
    CGFloat R = arc4random()%255;
    CGFloat G = arc4random()%255;
    CGFloat B = arc4random()%255;
    
    UIColor *lightColor = [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:1.0];
    
    UIColor *whiteColor = [UIColor colorWithRed:255.0 / 255.0 green:250.0 / 255.0 blue:250.0 / 255.0 alpha:1.0];
    //可以设置多个colors,
    gradientLayer.colors = @[(__bridge id)lightColor.CGColor,(__bridge id)whiteColor.CGColor];
    //45度变色(由lightColor－>white)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.view];
    
    
    if (self.loadType==0) {
        self.chageViewColor.backgroundColor = [self.view colorOfPoint:point];
        
        CGFloat components[3];
        [self.view getRGBComponents:components forColor:[self.view colorOfPoint:point]];
        NSLog(@"components%f %f %f", components[0], components[1], components[2]);
        
        NSLog(@"red:%f\ngreen:%f\nblue:%f",components[0] * 255,components[1] * 255,components[2] * 255);
        self.changeColorLabel.text = [NSString stringWithFormat:@"red:%f\ngreen:%f\nblue:%f",components[0] * 255,components[1] * 255,components[2] * 255];
    }else{
        self.chageViewColor.backgroundColor = [self.bgImage colorOfPoint:point];
        
        CGFloat components[3];
        [self.bgImage getRGBComponents:components forColor:[self.bgImage colorOfPoint:point]];
        NSLog(@"components%f %f %f", components[0], components[1], components[2]);
        
        NSLog(@"red:%f\ngreen:%f\nblue:%f",components[0] * 255,components[1] * 255,components[2] * 255);
        self.changeColorLabel.text = [NSString stringWithFormat:@"red:%f\ngreen:%f\nblue:%f",components[0] * 255,components[1] * 255,components[2] * 255];
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.view];
    
    if (self.loadType==0) {
        self.chageViewColor.backgroundColor = [self.view colorOfPoint:point];
        
        CGFloat components[3];
        [self.view getRGBComponents:components forColor:[self.view colorOfPoint:point]];
        NSLog(@"components%f %f %f", components[0], components[1], components[2]);
        
        NSLog(@"red:%f\ngreen:%f\nblue:%f",components[0] * 255,components[1] * 255,components[2] * 255);
        self.changeColorLabel.text = [NSString stringWithFormat:@"red:%f\ngreen:%f\nblue:%f",components[0] * 255,components[1] * 255,components[2] * 255];
    }else{

        self.chageViewColor.backgroundColor = [self.bgImage colorOfPoint:point];
        
        CGFloat components[3];
        [self.bgImage getRGBComponents:components forColor:[self.bgImage colorOfPoint:point]];
        NSLog(@"components%f %f %f", components[0], components[1], components[2]);
        
        NSLog(@"red:%f\ngreen:%f\nblue:%f",components[0] * 255,components[1] * 255,components[2] * 255);
        self.changeColorLabel.text = [NSString stringWithFormat:@"red:%f\ngreen:%f\nblue:%f",components[0] * 255,components[1] * 255,components[2] * 255];
    }
}


- (UIView *)chageViewColor {

    if (!_chageViewColor) {
        
        _chageViewColor =[[UIView alloc] init];
        _chageViewColor.layer.cornerRadius =50;
        _chageViewColor.layer.masksToBounds = YES;
        _chageViewColor.backgroundColor = [UIColor lightTextColor];
    }
    return _chageViewColor;
}

- (UILabel *)changeColorLabel {

    if (!_changeColorLabel) {
        _changeColorLabel =[[UILabel alloc] init];
        _changeColorLabel.textColor = [UIColor blackColor];
        _changeColorLabel.font = [UIFont systemFontOfSize:SIZEWIDTH_X(14, SCREEN_WIDTH)];
        _changeColorLabel.textAlignment = NSTextAlignmentCenter;
        _changeColorLabel.numberOfLines = 0;
   
    }
    return _changeColorLabel;
}



- (UIImageView *)bgImage {

    if (!_bgImage) {
        _bgImage =[[UIImageView alloc] init];
        _bgImage.image = [UIImage imageNamed:@"山水.jpg"];
    }
    return _bgImage;
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
