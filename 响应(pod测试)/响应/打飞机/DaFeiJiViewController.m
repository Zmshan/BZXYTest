//
//  DaFeiJiViewController.m
//  响应
//
//  Created by open-roc on 2019/7/26.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "DaFeiJiViewController.h"
#import "Masonry.h"
@interface DaFeiJiViewController ()
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UILabel *contentLabel1;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSTimer *fjTimer;
@property (nonatomic,strong) NSTimer *zdTimer;
@property (nonatomic,assign) CGFloat sc;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) UIBarButtonItem *rightItem;
@property (nonatomic,strong) UIBarButtonItem *rightModelItem;

@property (nonatomic,strong) NSMutableArray *feiJArrarr;
@property (nonatomic,assign) CGFloat FJ_Y;
@property (nonatomic,assign) NSInteger loadCount;
@property (nonatomic,assign) NSInteger index;

@property (nonatomic,assign) NSInteger score;

@property (nonatomic,strong) UIView *tapFeiJi ;
@property (nonatomic,strong) UIView *ziDanView;

@property (nonatomic,strong) NSMutableArray *zdArrarr;
@property (nonatomic,assign) CGFloat ZD_Y;
@property (nonatomic,assign) CGPoint fj_point;
@end

@implementation DaFeiJiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
    
    [self.view addSubview:self.tapFeiJi];
    self.tapFeiJi.hidden = YES;
    CGRect frame =self.view.frame;
    self.tapFeiJi.frame = CGRectMake(frame.size.width/2, frame.size.height-100, 30, 30);
    
    
    self.contentLabel.text = [NSString stringWithFormat:@"得分%ld",(long)_score];
    self.view.userInteractionEnabled = NO;
   
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self removeTimer];
    [self removeFjTimer];
}


- (void)rightBtn:(UIBarButtonItem *)item{
    if ([item.title isEqualToString:@"开始"]) {
        [_rightItem setTitle:@"暂停"];

        _sc = 0.25;
        [self loadTime];
        [self createFjTime];
        self.view.userInteractionEnabled = YES;
    }else if ([item.title isEqualToString:@"暂停"]){
        [_rightItem setTitle:@"继续"];
        self.view.userInteractionEnabled = NO;
        [self pauseFjTimer];
        [self pauseTimer];
    }else if ([item.title isEqualToString:@"继续"]){
        [_rightItem setTitle:@"暂停"];
        self.view.userInteractionEnabled = YES;
        [self continueFjTimer];
        [self continueTimer];
    }
    else if ([item.title isEqualToString:@"模式"]){
        [_rightModelItem setTitle:@"模式1"];
       
    }else if ([item.title isEqualToString:@"模式1"]){
        [_rightModelItem setTitle:@"模式2"];
        
    }else if ([item.title isEqualToString:@"模式2"]){
        [_rightModelItem setTitle:@"飞机"];
        
        _count = 6;
        _index = 1;
        _sc = 0.1;
        
//        [self createFjTime];
//        [self loadTime];
//        [self loadModel3];
    }else if ([item.title isEqualToString:@"飞机"]){
        [_rightModelItem setTitle:@"模式"];
       
    }
    
    
    
    
}

- (void)createFjTime{

    if (!_fjTimer) {
        _fjTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(createFj) userInfo:nil repeats:YES];
        _zdTimer = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(createZD) userInfo:nil repeats:YES];
    }else{
        [self continueFjTimer];
        [self continueZdTimer];
    }
}
- (void)createFj{
    
    NSInteger WIdth = self.view.frame.size.width;
    NSInteger Height = self.view.frame.size.height;
    CGFloat R = arc4random()%255;
    CGFloat G = arc4random()%255;
    CGFloat B = arc4random()%255;
    CGFloat X = arc4random()%WIdth;
    //        CGFloat Y = arc4random()%Height/2+64;
    CGFloat Y = arc4random()%20;
    CGFloat arcW = arc4random()%20+10;
    arcW = 20;
    if (X>(WIdth-arcW)) {
        X = arc4random()%(long)X;
    }
    UILabel *label = [self contentLabel1];
    label.backgroundColor = [UIColor colorWithRed:R/255 green:G/255 blue:B/255 alpha:1];
    label.frame = CGRectMake(X, 64, arcW, arcW);
    label.layer.cornerRadius = arcW/2;
    label.layer.masksToBounds = YES;
    [self.view addSubview:label];
    label.hidden = YES;
    [self.feiJArrarr addObject:label];
    
   
   
    
}
//暂停定时器(只是暂停,并没有销毁timer)
-(void)pauseFjTimer{
    [self.fjTimer setFireDate:[NSDate distantFuture]];
    [self pauseZdTimer];
}
//继续计时
-(void)continueFjTimer{
    [self.fjTimer setFireDate:[NSDate distantPast]];
    [self continueZdTimer];
}
- (void)removeFjTimer

{
    if (self.fjTimer) {
        [self.fjTimer invalidate];
        self.fjTimer =nil;
    }
    [self removeZdTimer];
}


- (void)createZD{
    self.tapFeiJi.hidden = NO;
    UIView *zd = [self ziDanView];
    [self.view addSubview:zd];
    zd.frame = CGRectMake(self.tapFeiJi.frame.origin.x+self.tapFeiJi.frame.size.width/2-5, self.tapFeiJi.frame.origin.y, 10, 10);
    NSLog(@"zd.frameA%@",NSStringFromCGRect(zd.frame));
    [self.zdArrarr addObject:zd];
}
//暂停定时器(只是暂停,并没有销毁timer)
-(void)pauseZdTimer{
    [self.zdTimer setFireDate:[NSDate distantFuture]];
}
//继续计时
-(void)continueZdTimer{
    [self.zdTimer setFireDate:[NSDate distantPast]];
}
- (void)removeZdTimer

{
    if (self.zdTimer) {
        [self.zdTimer invalidate];
        self.zdTimer =nil;
    }
    
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
    
    if ([_rightModelItem.title isEqualToString:@"模式"]) {
//        [self loadModel0];
    }else if ([_rightModelItem.title isEqualToString:@"模式1"]){
//        [self loadModel1];
    }else if ([_rightModelItem.title isEqualToString:@"模式2"]){
//        [self loadModel2];
    }else if ([_rightModelItem.title isEqualToString:@"飞机"]){
        [self loadModel3];
    }
}

- (void)loadModel0{
    for (int i=0; i<_count; i++) {
        UILabel *label = [self contentLabel1];
        [self.view addSubview:label];
        NSInteger WIdth = self.view.frame.size.width;
        NSInteger Height = self.view.frame.size.height;
        CGFloat R = arc4random()%255;
        CGFloat G = arc4random()%255;
        CGFloat B = arc4random()%255;
        CGFloat X = arc4random()%WIdth;
        CGFloat Y = arc4random()%Height/2+64;
        CGFloat arcW = arc4random()%30+10;
        
        label.backgroundColor = [UIColor colorWithRed:R/255 green:G/255 blue:B/255 alpha:1];
        label.frame = CGRectMake(X, 64, arcW, 10);
        
        [UIView animateWithDuration:1 animations:^{
            CGFloat X1 = arc4random()%(long)X;
            label.frame = CGRectMake(X1, Y, arcW, 10);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 animations:^{
                label.frame = CGRectMake(X, Height, arcW, 10);
                
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
            }];
        }];
    }
    self.navigationItem.title = [NSString stringWithFormat:@"当前数量（%ld）", (long)_count];
    _count++;
}

- (void)loadModel1{
    
    for (int i=0; i<_count; i++) {
        UILabel *label = [self contentLabel1];
        [self.view addSubview:label];
        NSInteger WIdth = self.view.frame.size.width;
        NSInteger Height = self.view.frame.size.height;
        CGFloat R = arc4random()%255;
        CGFloat G = arc4random()%255;
        CGFloat B = arc4random()%255;
        CGFloat X = arc4random()%WIdth;
        CGFloat Y = arc4random()%Height/2+64;
        CGFloat arcW = arc4random()%30+10;
        
        label.backgroundColor = [UIColor colorWithRed:R/255 green:G/255 blue:B/255 alpha:1];
        label.frame = CGRectMake(X, 64, arcW, arcW);
        label.layer.cornerRadius = arcW/2;
        label.layer.masksToBounds = YES;
        CGFloat Y1 = arc4random()%Height;
        [UIView animateWithDuration:1 animations:^{
            label.frame = CGRectMake(X, Y1, arcW, arcW);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 animations:^{
                label.frame = CGRectMake(X, Y1-arcW, arcW, arcW);
                
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
            }];
        }];
    }
    self.navigationItem.title = [NSString stringWithFormat:@"当前数量（%ld）", (long)_count];
    _count++;
    
}

- (void)loadModel2{
    
    for (int i=0; i<_count; i++) {
        UILabel *label = [self contentLabel1];
        [self.view addSubview:label];
        NSInteger WIdth = self.view.frame.size.width;
        NSInteger Height = self.view.frame.size.height;
        CGFloat R = arc4random()%255;
        CGFloat G = arc4random()%255;
        CGFloat B = arc4random()%255;
        CGFloat X = arc4random()%WIdth;
        CGFloat Y = arc4random()%Height/2+64;
        CGFloat arcW = arc4random()%30+10;
        arcW = 20;
        label.backgroundColor = [UIColor colorWithRed:R/255 green:G/255 blue:B/255 alpha:1];
        label.frame = CGRectMake(i*arcW, 64+i*arcW, arcW, arcW);
        label.layer.cornerRadius = arcW/2;
        label.layer.masksToBounds = YES;
//        CGFloat Y1 = arc4random()%Height;
        [UIView animateWithDuration:1 animations:^{
            label.frame = CGRectMake(i*arcW*2, 64+i*arcW, arcW, arcW);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 animations:^{

                label.frame = CGRectMake(i*arcW*1, 64+i*arcW, arcW, arcW);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:1 animations:^{
                    
                    label.frame = CGRectMake(i*arcW*2, 64+i*arcW, arcW, arcW);
                } completion:^(BOOL finished) {
                    [label removeFromSuperview];
                    if ((i+1)==_count) {
                        _count++;
                        self.navigationItem.title = [NSString stringWithFormat:@"当前数量（%ld）", (long)_count];
                        [self loadModel2];
                    }
                }];
            }];
        }];
        
    }
    

}
- (void)loadModel3{
    NSLog(@"loadModel3%@",[NSThread mainThread]);

    _loadCount++;

    _FJ_Y= _FJ_Y +5;
    NSArray *arr  =self.feiJArrarr;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        
            NSInteger WIdth = self.view.frame.size.width;
            NSInteger Height = self.view.frame.size.height;
            //            CGFloat R = arc4random()%255;
            //            CGFloat G = arc4random()%255;
            //            CGFloat B = arc4random()%255;
//            CGFloat X = arc4random()%WIdth;
            //        CGFloat Y = arc4random()%Height/2+64;
//            CGFloat Y = arc4random()%20;
            CGFloat arcW = arc4random()%20+10;
            UILabel *label = obj;
            label.hidden = NO;
            arcW = 20;
            label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y+5, arcW, arcW);
            label.layer.cornerRadius = arcW/2;
            label.layer.masksToBounds = YES;
            
            if (label.frame.origin.y>=Height) {
                [self.feiJArrarr removeObject:obj];
//                label.frame = CGRectMake(label.frame.origin.x, 64, arcW, arcW);
                _FJ_Y=0;
                _index= 0;

        }
     
    }];
    
//    _ZD_Y--;
    NSArray *zdArr  =self.zdArrarr;
//    [zdArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        UIView *zd = obj;
//        //        NSLog(@"zd.frame.origin.x=%f zd.frame.origin.y%f",zd.frame.origin.x,zd.frame.origin.y);
//        zd.frame = CGRectMake(zd.frame.origin.x, (zd.frame.origin.y-6), 10, 10);
//        NSLog(@"zd.frameB%@",NSStringFromCGRect(zd.frame));
//        if (zd.frame.origin.y<=0) {
//            [self.zdArrarr removeObject:obj];
//        }
//    }];
//    [zdArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        UIView *zd = obj;
//        //        NSLog(@"zd.frame.origin.x=%f zd.frame.origin.y%f",zd.frame.origin.x,zd.frame.origin.y);
//        zd.frame = CGRectMake(zd.frame.origin.x, (zd.frame.origin.y-6), 10, 10);
//        NSLog(@"zd.frameB%@",NSStringFromCGRect(zd.frame));
//        if (zd.frame.origin.y<=0) {
//            [self.zdArrarr removeObject:obj];
//        }
//    }];
    [zdArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *zd = obj;
        //        NSLog(@"zd.frame.origin.x=%f zd.frame.origin.y%f",zd.frame.origin.x,zd.frame.origin.y);
        zd.frame = CGRectMake(zd.frame.origin.x, (zd.frame.origin.y-6), 10, 10);
        NSLog(@"zd.frameB%@",NSStringFromCGRect(zd.frame));
        
        
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull fjObj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            
            UILabel *label = fjObj;
            BOOL isMutul =CGRectIntersectsRect(zd.frame,label.frame);
            if (isMutul) {
                label.hidden = YES;
                zd.hidden = YES;
                _score = _score+10;
                self.contentLabel.text = [NSString stringWithFormat:@"得分%ld",(long)_score];
                [self.feiJArrarr removeObject:fjObj];
                [self.zdArrarr removeObject:obj];
            }
            
        }];
        if (zd.frame.origin.y<=0) {
            [self.zdArrarr removeObject:obj];
        }
    }];
    
    /*
    CGFloat count = arc4random()%10;
    for (int i=0; i<count; i++) {
        NSInteger WIdth = self.view.frame.size.width;
        NSInteger Height = self.view.frame.size.height;
        CGFloat R = arc4random()%255;
        CGFloat G = arc4random()%255;
        CGFloat B = arc4random()%255;
        CGFloat X = arc4random()%WIdth;
        CGFloat Y = arc4random()%Height/2+64;
        CGFloat arcW = arc4random()%20+10;
        
        if (X>(WIdth-arcW)) {
            X = arc4random()%(long)X;
        }
        UILabel *label = [self contentLabel1];
        [self.view addSubview:label];
        label.backgroundColor = [UIColor colorWithRed:R/255 green:G/255 blue:B/255 alpha:1];
        label.frame = CGRectMake(X, 64+_FJ_Y, arcW, arcW);
        label.layer.cornerRadius = arcW/2;
        label.layer.masksToBounds = YES;
        
        if (label.frame.origin.y>=Height) {
            [label removeFromSuperview];
        }
//        [UIView animateWithDuration:1 animations:^{
//            label.frame = CGRectMake(X, 64+Height/3, arcW, arcW);
//        } completion:^(BOOL finished) {
//
//            [UIView animateWithDuration:1 animations:^{
//                label.frame = CGRectMake(X, 64+Height/2, arcW, arcW);
//            } completion:^(BOOL finished) {
//
//            }];
//            [UIView animateWithDuration:1 animations:^{
//                label.frame = CGRectMake(X, 64+Height/1, arcW, arcW);
//            } completion:^(BOOL finished) {
//
//            }];
//        }];
     }
   */
    
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

- (UIView *)tapFeiJi {

    if (!_tapFeiJi) {
        _tapFeiJi =[[UIView alloc] init];
        _tapFeiJi.layer.cornerRadius = 5;
        _tapFeiJi.layer.masksToBounds = YES;
        _tapFeiJi.backgroundColor = [UIColor redColor];
    }
    return _tapFeiJi;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.view]; 
    self.tapFeiJi.frame = CGRectMake(point.x, point.y, 30, 30);
    _fj_point = point;
   
}

- (UIView *)ziDanView {
        _ziDanView =[[UIView alloc] init];
        _ziDanView.layer.cornerRadius = 2;
        _ziDanView.layer.masksToBounds = YES;
        _ziDanView.backgroundColor = [UIColor redColor];
    return _ziDanView;
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
