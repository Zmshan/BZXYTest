//
//  CustomeUISlider.m
//  响应
//
//  Created by open-roc on 2019/4/18.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "CustomeUISlider.h"
#import "CustomView.h"
#import "Masonry.h"
@interface CustomeUISlider ()

@property (nonatomic, strong) CustomView *indexDetailView;
@property (nonatomic,strong) UILabel *minValue;
@property (nonatomic,strong) UILabel *maxValue;
@property (nonatomic,strong) UILabel *topLabel;
@property (nonatomic,strong) NSMutableArray *averageArray;
@property (nonatomic,strong) NSArray *nodesArray;
@end
@implementation CustomeUISlider

- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
//        _indexDetailView = [[CustomView alloc] init];
//        _indexDetailView.textColor = [UIColor redColor];
//        _indexDetailView.backgroundColor = [UIColor clearColor];
//        [self addSubview:_indexDetailView];
//        [_indexDetailView addSubview:self.topLabel];
//        [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.indexDetailView);
//        }];
         [self addSubview:self.topLabel];
         [self addSubview:self.minValue];
         [self addSubview:self.maxValue];

        
        [self.minValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self.mas_top).offset(-12);
        }];
        [self.maxValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.top.equalTo(self.mas_top).offset(-12);
        }];
//
    }
    return self;
}
- (CGRect)minimumValueImageRectForBounds:(CGRect)bounds{
    CGRect minimum = [super minimumValueImageRectForBounds:CGRectMake(0, 0, bounds.size.width, 3)];
    return minimum;
}
- (CGRect)maximumValueImageRectForBounds:(CGRect)bounds{
    CGRect maximum = [super maximumValueImageRectForBounds:CGRectMake(0, 0, bounds.size.width, 3)];
    return maximum;
}
/// 设置thumb（滑块）尺寸
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value{
    
    CGFloat WH = 16;
    CGFloat margin = WH *.5f - 21 *.5f + 2;
    /// 滑块的滑动区域宽度
    CGFloat maxWidth = CGRectGetWidth(rect) + 2 * margin;
    /// 每次偏移量
    CGFloat offset = (maxWidth - WH)/(self.maximumValue - self.minimumValue);
    
    CGFloat H = WH;
    CGFloat Y = (bounds.size.height - H ) *.5f;
    CGFloat W = H;
    CGFloat X = CGRectGetMinX(rect) - margin + offset *(value-self.minimumValue);
    CGRect r =  CGRectMake(X, Y, W, H);
    
    [self topLabelCoordinatesHidden_X:X maxWidth:maxWidth];
    _topLabel.frame = CGRectMake(X-1, self.maxValue.frame.origin.y, W, H);
    _topLabel.text = [NSString stringWithFormat:@"%2.f",[self sliderValue:value nodesArray:_nodesArray]];
    
    return r;
}
#pragma mark === 获取最小和最大值 ====
- (void)minValue:(NSInteger)minValue maxValue:(NSInteger)maxValue{
    _minValue.text  = [NSString stringWithFormat:@"%ld",(long)minValue];
    _maxValue.text  = [NSString stringWithFormat:@"%ld",(long)maxValue];
}
#pragma mark === 节点数组 ====
- (void)nodesArray:(NSArray*)nodesArray{
    _nodesArray =nodesArray;
    NSInteger minValue =[[nodesArray firstObject] floatValue];
    NSInteger maxValue =[[nodesArray lastObject] floatValue];
    [self minValue:minValue maxValue:maxValue];
    [nodesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.averageArray addObject:@{@"startingPoint":@(idx),@"endPoint":@(idx+1)}];
    }];
}
#pragma mark === 获取当前节点 ====
- (CGFloat)sliderValue:(float)value nodesArray:(NSArray*)nodesArray{
    if (nodesArray.count==0) {
        return 0;
    }
    
    NSInteger index = ceilf(value);
    index = index-1;
    if (index<=0) {//防止数组越界
        index = 0;
    }
    CGFloat  currentNode =  [nodesArray[index] floatValue];
//    [self topLabelSliderValueHiddenNodesArray:nodesArray currentNode:currentNode];
    return currentNode;
}
#pragma mark === 根据坐标判断是否隐藏标签 ====
- (void)topLabelCoordinatesHidden_X:(CGFloat)X maxWidth:(CGFloat)maxWidth{
    if (X<16||X>maxWidth-20) {
        _topLabel.hidden = YES;
    }else{
        _topLabel.hidden = NO;
    }
}
#pragma mark === 根据坐标判断是否隐藏标签 ====
- (void)topLabelSliderValueHiddenNodesArray:(NSArray*)nodesArray currentNode:(CGFloat)currentNode{
    NSInteger minValue =[[nodesArray firstObject] floatValue];
    NSInteger maxValue =[[nodesArray lastObject] floatValue];
    if (minValue==currentNode||currentNode==maxValue) {
        _topLabel.hidden = YES;
    }else{
        _topLabel.hidden = NO;
    }
}
- (UILabel *)topLabel {

    if (!_topLabel) {
        _topLabel =[[UILabel alloc] init];
        _topLabel.textColor = [UIColor greenColor];
        _topLabel.font = [UIFont systemFontOfSize:14];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.backgroundColor = [UIColor clearColor];
//        _topLabel.numberOfLines = 0;
    }
    return _topLabel;
}

- (UILabel *)minValue {

    if (!_minValue) {
        _minValue =[[UILabel alloc] init];
        _minValue.textColor = [UIColor grayColor];
        _minValue.font = [UIFont systemFontOfSize:14];
        _minValue.textAlignment = NSTextAlignmentLeft;
    }
    return _minValue;
}
- (UILabel *)maxValue {
    
    if (!_maxValue) {
        _maxValue =[[UILabel alloc] init];
        _maxValue.textColor = [UIColor grayColor];
        _maxValue.font = [UIFont systemFontOfSize:14];
        _maxValue.textAlignment = NSTextAlignmentRight;
    }
    return _maxValue;
}
- (NSMutableArray *)averageArray{
    
    if (!_averageArray) {
        _averageArray = [NSMutableArray array];
    }
    return _averageArray;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
