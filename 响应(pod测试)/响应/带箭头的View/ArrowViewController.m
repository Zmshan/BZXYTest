//
//  ArrowViewController.m
//  响应
//
//  Created by open-roc on 2019/6/3.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "ArrowViewController.h"
#import "ArrowView.h"
#import "Masonry.h"
@interface ArrowViewController ()
@property (nonatomic,strong) UILabel *contentLabel;
@end

@implementation ArrowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ArrowView *view = [[ArrowView alloc] initWithFrame:CGRectMake(100, 100, 200, 80)];
    [view setBackgroundColor:[UIColor orangeColor]];
//    view.backgroundColor = [UIColor blueColor];
//    view.layer.masksToBounds = YES;
//    view.layer.cornerRadius = 6;

    [self.view addSubview:view];
    view.arrowDirectionType = ArrowViewDirectionTypeBottomRight;
    view.arrowType = ArrowTypeCustomBottom;
    [view configurationRadiusLeftTop:10 andLeftBootom:20 andRightTop:5 andRightBootom:10];
    [view changeBackColor:[UIColor blueColor]];
    
    [self load];
    [view addSubview:self.contentLabel];
    self.contentLabel.text = @"赵钱孙李周吴郑王赵钱孙李周吴郑王";
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(view);
    }];
    
    
  
//    self.block = ^{
//         self.contentLabel.text = @"赵钱孙李周吴郑王赵钱孙李周吴郑王";
//    };
//    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerHandler:) userInfo:nil repeats:YES];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//    });
    
   
}
- (void)timerHandler:(NSTimer *)time{
    NSLog(@"time");
}
- (void)load{
    UIImageView *testView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 200, 200)];
    testView.backgroundColor = [UIColor yellowColor];
    // 开启上下文
    UIGraphicsBeginImageContext(testView.frame.size);
    // 开始绘制
    [testView.image drawInRect:CGRectMake(0, 0, testView.frame.size.width, testView.frame.size.height)];
    // 获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置边框宽度
    CGContextSetLineWidth(context, 3);
    // 设置边框颜色
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    // A:(20,20)   B:(120,20)  C:(120,100)
    CGContextMoveToPoint(context, 20, 20);
    
    //以下三行是辅助线  可以注释掉
    CGContextAddLineToPoint(context, 120, 20);
    CGContextAddLineToPoint(context, 120, 100);
    CGContextMoveToPoint(context, 20, 20);
    
    CGContextAddArcToPoint(context, 120, 20, 120, 100, 50);
    CGContextDrawPath(context, kCGPathFillStroke);
    testView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.view addSubview:testView];
    
    
    
    
    
}

- (UILabel *)contentLabel {


    if (!_contentLabel) {
        _contentLabel =[[UILabel alloc] init];
        _contentLabel.textColor = [UIColor redColor];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 0;
  
    }
    return _contentLabel;
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
