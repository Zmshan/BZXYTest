//
//  MyHeaderView.m
//  响应
//
//  Created by open-roc on 2019/8/22.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "MyHeaderView.h"


@implementation MyHeaderView


- (UIImageView *)imageV {
    if (_imageV == nil) {
        _imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_head"]];
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
        _imageV.userInteractionEnabled = true;
        [_imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapAction:)]];
    }
    return _imageV;
}

- (void)imageViewTapAction:(id)sender {
    NSLog(@"imageView tap");
    
    if (self.drawType==DrawTypeA) {
        self.drawType=DrawTypeB;
    }else if (self.drawType==DrawTypeB) {
        self.drawType=DrawTypeC;
    }else if (self.drawType==DrawTypeC) {
        self.drawType=DrawTypeD;
    }else if (self.drawType==DrawTypeD) {
        self.drawType=DrawTypeA;
    }
    [self setNeedsDisplay];     // 重绘
}

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.headerViewHeight = 180;
        self.screenWidth = [UIScreen mainScreen].bounds.size.width;
        [self addSubview:self.imageV];
    }
    return self;
}

// 更改 frame 会触发 layoutSubviews
// 触发 layoutSubviews 后，这个 view 里面的控件想怎么变（旋转，位移，缩放），全部这个方法里面就好了
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // imageV 是 60 * 60 的
    CGFloat y = 60 + (self.frame.size.height - self.headerViewHeight) * 0.6;
    self.imageV.frame = CGRectMake((self.screenWidth - 60) * 0.5, y, 60, 60);
    
    [self setNeedsDisplay];     // 重绘
}

// 绘制曲线
- (void)drawRect:(CGRect)rect {
    if (self.drawType==DrawTypeA) {
        [self xgA:rect];
    }else if (self.drawType==DrawTypeB) {
        [self xgB:rect];
    }else if (self.drawType==DrawTypeC) {
        [self xgC:rect];
    }else if (self.drawType==DrawTypeD) {
        [self xgD:rect];
    }
 
}
- (void)xgA:(CGRect)rect{
    //获取上下文
    //CGContextRef 用来保存图形信息.输出目标
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置颜色
    CGContextSetRGBFillColor(context, 0.00392, 0.54117, 0.85098, 1.0);
    
    CGFloat h1 = self.headerViewHeight;
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    //    起点
    CGContextMoveToPoint(context, w, h1);
    //画线
    CGContextAddLineToPoint(context, w, 0);
    CGContextAddLineToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 0, h1);
    CGContextAddQuadCurveToPoint(context, w * 0.5, h + (h - h1) * 0.6, w, h1);
    //闭合
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathFill);
    
}
- (void)xgB:(CGRect)rect{
    //获取上下文
    //CGContextRef 用来保存图形信息.输出目标
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置颜色
    CGContextSetRGBFillColor(context, 0.00392, 0.54117, 0.85098, 1.0);
    
    CGFloat h1 = self.headerViewHeight;
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    //起点
    CGContextMoveToPoint(context, w, 0);
    //画线
    CGContextAddLineToPoint(context, w, h1);
    CGContextAddLineToPoint(context, 0, h1);
    CGContextAddLineToPoint(context, 0, 0);
    CGContextAddQuadCurveToPoint(context, w * 0.5 , h + (h - h1) * 0.6, w, 0);
    //闭合
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathFill);
}

- (void)xgC:(CGRect)rect{
    //获取上下文
    //CGContextRef 用来保存图形信息.输出目标
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置颜色
    CGContextSetRGBFillColor(context, 0.00392, 0.54117, 0.85098, 1.0);
    
    CGFloat h1 = self.headerViewHeight;
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    //    起点
    CGContextMoveToPoint(context, w, h1);
    
   
    //画线
//    CGContextAddLineToPoint(context, w, h1*0.2);
//    CGContextAddQuadCurveToPoint(context, w * 0.5, 10, 0, h1*0.2);
    CGContextAddLineToPoint(context, w, h1*0.9);
    CGContextAddQuadCurveToPoint(context, w * 0.5, 10, 0, h1*0.9);
    CGContextAddLineToPoint(context, 0, h1);
    CGContextAddQuadCurveToPoint(context, w * 0.5, h + (h - h1) * 0.6, w, h1);
    //闭合
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathFill);
    
}


- (void)xgD:(CGRect)rect{
    //获取上下文
    //CGContextRef 用来保存图形信息.输出目标
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置颜色
    CGContextSetRGBFillColor(context, 0.00392, 0.54117, 0.85098, 1.0);
    
    CGFloat h1 = self.headerViewHeight;
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    
    //下拉间距 (h - h1)
    CGFloat spacing_Y= (h - h1);
    //修改左右点便移量
    CGFloat XYof = spacing_Y * 0.6;//可修改数字0-1查看效果
    
    CGFloat numerical = 1;//可修改数字0-1查看效果
    //底部偏移
    CGFloat bottom_spacing_Y = spacing_Y * numerical;
    
    //起点
    CGContextMoveToPoint(context, w, h1+bottom_spacing_Y);
    //画线
    CGContextAddLineToPoint(context, w,  XYof);
    CGContextAddQuadCurveToPoint(context, w * 0.5, 0, 0, XYof);
    CGContextAddLineToPoint(context, 0, h1 + bottom_spacing_Y);
    CGContextAddLineToPoint(context, w, h1 + bottom_spacing_Y);
    //闭合
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathFill);
    
}


// 这个 view 里面有多少个被点击的控件，把他的 frame 告诉 pointInside 就可以了
//这个函数会被 hitTest 调用，返回 false 表示点击的不是自己，返回 true 表示点击的是自己
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    // 判断点击的点，在不在圆内
    CGPoint center = self.imageV.center;
    CGFloat r = self.imageV.frame.size.width * 0.5;
    CGFloat newR = sqrt((center.x - point.x) * (center.x - point.x) + (center.y - point.y) * (center.y - point.y));
    
    // 浮点数比较不推荐用等号，虽然 ios 底层已经处理了这种情况
    if (newR > r) {
        return false;
    } else {
        return true;
    }
}
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event;   hitTest 主要用来做事件分发的，可以实现不规则点击，它在整个 view 结构上是递归的


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
