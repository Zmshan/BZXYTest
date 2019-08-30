//
//  ReboundViewController.m
//  响应
//
//  Created by open-roc on 2019/7/31.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "ReboundViewController.h"
#import "Masonry.h"
typedef void(^XBTBlock)(void);
//XBTBlock block;

@interface ReboundViewController ()
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UILabel *contentLabel1;
@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,assign) CGFloat sc;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) UIBarButtonItem *rightItem;
@property (nonatomic,strong) UIBarButtonItem *rightModelItem;

@property (nonatomic,strong) NSMutableArray *feiJArrarr;
@property (nonatomic,assign) CGFloat FJ_Y;
@property (nonatomic,assign) NSInteger loadCount;
@property (nonatomic,assign) NSInteger index;

@property (nonatomic,assign) NSInteger score;

@property (nonatomic,strong) UIView *tapHuaKuai ;
@property (nonatomic,strong) UIView *ziDanView;

@property (nonatomic,strong) NSMutableArray *zdArrarr;
@property (nonatomic,assign) CGFloat ZD_Y;
@property (nonatomic,assign) CGPoint fj_point;
@property (nonatomic,copy) XBTBlock block;
@end

@implementation ReboundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * str1 = @"我是一个字符串";
    NSLog(@"str1%p--str1%p--",str1,&str1);
    NSString *str2 = str1;
    NSLog(@"str2%p--str2%p--",str2,&str2);
    
    NSString *str3 = [str2 mutableCopy];
    
    NSLog(@"str3%p--str3%p--",str3,&str3);
    
    void (^aaaa)(void) = ^{
        self.FJ_Y = 1111;
    };
    aaaa();
    
    UILabel *la = [[UILabel alloc]init];
    
    __weak UILabel *weakSelf = la;
    __weak typeof (self)weak = self;
    self.block = ^{
        weak.FJ_Y = 1;
        weak.loadCount = 1;
        weak.index = 1;
        weak.score = 1;
        weak.FJ_Y = 1;
        NSLog(@"======= %@",weakSelf.text);
        void (^aaaa)(void) = ^{
            weak.FJ_Y = 1111;
        };
        aaaa();
    };
    self.block();
    
    [self.view addSubview:self.contentLabel];
    self.navigationItem.title = [NSString stringWithFormat:@"当前数量（%ld）", (long)_count];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"开始" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtn:)];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"模式" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtn:)];
    self.navigationItem.rightBarButtonItems = @[item,item1];
    _rightItem = item;
    _rightModelItem = item1;
    _sc = 2;
    
    
    [self.view addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.right.mas_equalTo(-20);
    }];
    
    [self.view addSubview:self.tapHuaKuai];
    self.tapHuaKuai.hidden = YES;
    CGRect frame =self.view.frame;
    self.tapHuaKuai.frame = CGRectMake(frame.size.width/2, frame.size.height-100, 50, 30);
    
    
    self.contentLabel.text = [NSString stringWithFormat:@"得分%ld",(long)_score];
    self.view.userInteractionEnabled = NO;
    [self createZD];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self removeTimer];
    
}

- (void)rightBtn:(UIBarButtonItem *)item{
    if ([item.title isEqualToString:@"开始"]) {
        [_rightItem setTitle:@"暂停"];
        
        _sc = 0.1;
        [self loadTime];
        
        self.view.userInteractionEnabled = YES;
    }else if ([item.title isEqualToString:@"暂停"]){
        [_rightItem setTitle:@"继续"];
        self.view.userInteractionEnabled = NO;
        
        [self pauseTimer];
    }else if ([item.title isEqualToString:@"继续"]){
        [_rightItem setTitle:@"暂停"];
        self.view.userInteractionEnabled = YES;
        [self continueTimer];
    }
    
    
    
    
    
}



- (void)createZD{
    self.tapHuaKuai.hidden = NO;
    UIView *zd = [self ziDanView];
    [self.view addSubview:zd];
    NSInteger WIdth = self.view.frame.size.width;
    CGFloat X = arc4random()%WIdth;
    zd.frame = CGRectMake(X, 64, 20, 20);
    NSLog(@"zd.frameA%@",NSStringFromCGRect(zd.frame));
    [self.zdArrarr addObject:zd];
}

- (void)loadTime{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_sc target:self selector:@selector(aaaaa) userInfo:nil repeats:YES];
        _count = 6;
    }else{
        [self continueTimer];
    }
}
//暂停定时器(只是暂停,并没有销毁timer)
-(void)pauseTimer{
    [self.timer setFireDate:[NSDate distantFuture]];
}
//继续计时
-(void)continueTimer{
    [self.timer setFireDate:[NSDate distantPast]];
}
- (void)removeTimer

{
    if (self.timer) {
        [self.timer invalidate];
        self.timer =nil;
    }
    
}

- (void)aaaaa{
    
    [self loadModel3];
}


- (void)loadModel3{
    NSLog(@"loadModel3%@",[NSThread mainThread]);
    
    _loadCount++;
    _FJ_Y= _FJ_Y +5;

    UIView *zd = _ziDanView;
    NSInteger WIdth = self.view.frame.size.width;
    NSInteger Height = self.view.frame.size.height;
    CGFloat arcW = arc4random()%20+10;
    arcW = 20;
    zd.frame = CGRectMake(zd.frame.origin.x, zd.frame.origin.y+20, arcW, arcW);
    
    BOOL isMutul =CGRectIntersectsRect(zd.frame,self.tapHuaKuai.frame);
    if (isMutul) {
        CGFloat X = arc4random()%WIdth;
        _score = _score+10;
        self.contentLabel.text = [NSString stringWithFormat:@"得分%ld",(long)_score];
        zd.frame = CGRectMake(X, (zd.frame.origin.y-150), arcW, arcW);
    }
    if (zd.frame.origin.y>=Height) {
        [self showAler];
        [self pauseTimer];
        [zd removeFromSuperview];
    }
    
    

    
    self.navigationItem.title = [NSString stringWithFormat:@"打飞机"];
}


- (UILabel *)contentLabel {
    
    if (!_contentLabel) {
        _contentLabel =[[UILabel alloc] init];
        _contentLabel.textColor = [UIColor redColor];
        _contentLabel.backgroundColor = [UIColor blueColor];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UILabel *)contentLabel1 {
    _contentLabel1 =[[UILabel alloc] init];
    _contentLabel1.textColor = [UIColor redColor];
    _contentLabel1.backgroundColor = [UIColor blueColor];
    _contentLabel1.font = [UIFont systemFontOfSize:14];
    _contentLabel1.textAlignment = NSTextAlignmentCenter;
    _contentLabel1.numberOfLines = 0;
    
    return _contentLabel1;
}

- (NSMutableArray *)feiJArrarr{
    
    if (!_feiJArrarr) {
        _feiJArrarr = [NSMutableArray array];
    }
    return _feiJArrarr;
}
- (NSMutableArray *)zdArrarr{
    
    if (!_zdArrarr) {
        _zdArrarr = [NSMutableArray array];
    }
    return _zdArrarr;
}

- (UIView *)tapHuaKuai {
    
    if (!_tapHuaKuai) {
        _tapHuaKuai =[[UIView alloc] init];
        _tapHuaKuai.layer.cornerRadius = 5;
        _tapHuaKuai.layer.masksToBounds = YES;
        _tapHuaKuai.backgroundColor = [UIColor redColor];
    }
    return _tapHuaKuai;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"点击了屏幕");
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.view];
    self.tapHuaKuai.frame = CGRectMake(point.x, point.y, 50, 30);
    _fj_point = point;
    
}

- (UIView *)ziDanView {
    _ziDanView =[[UIView alloc] init];
    _ziDanView.layer.cornerRadius = 2;
    _ziDanView.layer.masksToBounds = YES;
    _ziDanView.backgroundColor = [UIColor redColor];
    return _ziDanView;
}
- (void)showAler{
    UIAlertController *aler = [UIAlertController alertControllerWithTitle:@"提示" message:@"游戏结束" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
    UIAlertAction * yes = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self createZD];
    }];
//    [aler addAction:cancel];
    [aler addAction:yes];
    [self presentViewController:aler animated:YES completion:^{
        
    }];
}


- (void)dealloc{
    NSLog(@"释放我");
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
