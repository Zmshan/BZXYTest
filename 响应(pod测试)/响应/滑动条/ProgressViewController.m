//
//  ProgressViewController.m
//  响应
//
//  Created by open-roc on 2019/4/16.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "ProgressViewController.h"
#import "Masonry.h"
#import "ConvertImageTool.h"

#import "CustomeUISlider.h"
@interface ProgressViewController ()
@property (strong, nonatomic) CustomeUISlider *durationSlider;//时间滑动条
@property (nonatomic,strong) NSMutableArray *nodesArray;
@property (nonatomic,strong) NSMutableArray *averageArray;
@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self durationSlidersetting];
    
    //生成图片Image（封装好（背景颜色、图片大小、字体大小、颜色等），一行代码解决绘制图片头像）
   
}
#pragma mark === 进度条 ====
-(void)durationSlidersetting
{
    self.durationSlider = [[CustomeUISlider alloc] init];
    self.durationSlider.minimumValue = 0.0f;
    self.durationSlider.maximumValue = 1.0f;
    self.durationSlider.value = 0.0f;
    self.durationSlider.continuous = NO;
//    [self.durationSlider setMaximumTrackImage:[UIImage imageNamed:@"全屏未播放"]forState:UIControlStateNormal];
    //[self.durationSlider setMinimumTrackImage:[UIImage imageNamed:@"全屏已播放"]forState:UIControlStateNormal];
//    [self.durationSlider setThumbImage:[UIImage imageNamed:@"player-slider-handle"]forState:UIControlStateNormal];
    
    [self.durationSlider setMinimumTrackTintColor:[UIColor greenColor]];
//    [self.durationSlider setThumbTintColor:[UIColor blueColor]];
    [self.durationSlider setMaximumTrackTintColor:[UIColor grayColor]];
    
    
    UIImage *image = [ConvertImageTool imageWithFrame:CGRectMake(0, 0, 16, 16) BackGroundColor:[UIColor greenColor] Text:@"" TextColor:[UIColor whiteColor] TextFontOfSize:0];
    
    [self.durationSlider setThumbImage:image forState:UIControlStateNormal];
   
    //    滑动改变
    [self.durationSlider addTarget:self action:@selector(durationSliderMoving:) forControlEvents:UIControlEventValueChanged];
    [self.durationSlider addTarget:self action:@selector(durationSliderEnded:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    [self.durationSlider addTarget:self action:@selector(durationSliderBeganDown:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.durationSlider];
    [self.durationSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_centerY);
        make.left.equalTo(self.view.mas_left).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.height.mas_equalTo(20);
    }];
    [self.nodesArray setArray: @[@"1",@"3",@"5",@"7",@"9",@"11",@"13"]];
    self.durationSlider.maximumValue = self.nodesArray.count;
    [self.durationSlider nodesArray:self.nodesArray];
    [self.nodesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.averageArray addObject:@{@"startingPoint":@(idx),@"endPoint":@(idx+1)}];
    }];
}

- (void)durationSliderMoving:(UISlider *)slider
{
    
    NSLog(@"sliderslider--%@",slider);
    
}


#pragma mark === 获取开始拖动事件 ====
- (void)durationSliderBeganDown:(UISlider *)slider{
   
    NSLog(@"sliderslider获取开始拖动事件--%@",slider);
}


#pragma mark === 获取停止拖动事件 ====
#pragma mark === 滑动条事件 ====
- (void)durationSliderEnded:(UISlider *)slider
{
    
    NSLog(@"sliderslider获取停止拖动事件--%@",slider);

}


- (NSMutableArray *)nodesArray{

    if (!_nodesArray) {
        _nodesArray = [NSMutableArray array];
    }
    return _nodesArray;
}
- (NSMutableArray *)averageArray{
    
    if (!_averageArray) {
        _averageArray = [NSMutableArray array];
    }
    return _averageArray;
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
