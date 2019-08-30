//
//  ArrowView.m
//  响应
//
//  Created by open-roc on 2019/6/3.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "ArrowView.h"
@interface ArrowView()

@property (copy,nonatomic)id context;
@property (strong,nonatomic)UIColor *color;
@property (assign,nonatomic)CGFloat leftTopRadius;//左上
@property (assign,nonatomic)CGFloat rightTopRadius;//右上
@property (assign,nonatomic)CGFloat leftBottomRadius;//左下
@property (assign,nonatomic)CGFloat rightBootomRadius;//右下
@end

@implementation ArrowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.color = [UIColor whiteColor];
        self.leftTopRadius = 0;
        self.rightTopRadius = 0;
        self.leftBottomRadius = 0;
        self.rightBootomRadius = 0;
    }
    return self;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.color = [UIColor whiteColor];
        self.leftTopRadius = 0;
        self.rightTopRadius = 0;
        self.leftBottomRadius = 0;
        self.rightBootomRadius = 0;
    }
    return self;
    
}


- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    switch (_arrowType) {
        case ArrowTypeTypeTop:
            [self topArrowView:rect];
            break;
        case ArrowTypeBottom:
            [self bottomArrowView:rect];
            break;
        case ArrowTypeLeft:
            [self leftArrowView:rect];
            break;
        case ArrowTypeRight:
            [self rightArrowView:rect];
            break;
            
        case ArrowTypeSanJiao:
            [self sanJiaoTuXing:rect];
            break;
        case ArrowTypeYuanJiaoArc:
            [self addArc:rect];
            break;
        case ArrowTypeCustomBottom:
//            [self customArrowView:rect];
            [self arrowView:rect];
            break;
        default:
            break;
    }
    NSLog(@"正在drawRect...");
}


-(void)arrowView:(CGRect)rect{
    //获取当前图形,视图推入堆栈的图形,相当于你所要绘制图形的图纸
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] set];
    //创建一个新的空图形路径
    CGContextBeginPath(ctx);
    NSLog(@"开始绘制...");
    
    //起始位置坐标
    CGFloat origin_x = 0.0;
    CGFloat origin_y = 0.0; //frame.origin.y + 10;
    //第一条线的位置坐标
    CGFloat line_1_x = 0.0;
    CGFloat line_1_y = 0.0;
    //第二条线的位置坐标
    CGFloat line_2_x = 0.0;
    CGFloat line_2_y = 0.0;
    //第三条线的位置坐标
    CGFloat line_3_x = 0.0;
    CGFloat line_3_y = 0.0;
    //第四条线的位置坐标
    CGFloat line_4_x = 0.0;
    CGFloat line_4_y = 0.0;
    //第五条线的位置坐标
    CGFloat line_5_x = 0.0;
    CGFloat line_5_y = 0.0;
    //第六条线的位置坐标
    CGFloat line_6_x = 0.0;
    CGFloat line_6_y = 0.0;
    
    CGFloat line_7_x = 0.0;
    CGFloat line_7_y = 0.0;
    
   
    
    if (_arrowDirectionType==ArrowViewDirectionTypeLeftTop) {// 左上
        origin_x = rect.origin.x+10;
        origin_y = rect.origin.y;
        
        line_1_x = origin_x;
        line_1_y = rect.origin.y+20;
        
        line_2_x = rect.origin.x;
        line_2_y = line_1_y+5;
        
        line_3_x = rect.origin.x+10;
        line_3_y = line_2_y+5;
        
        line_4_x = rect.origin.x+10;
        line_4_y = rect.size.height;
        
        line_5_x = rect.size.width;
        line_5_y = rect.size.height;
        
        line_6_x = rect.size.width;
        line_6_y = rect.origin.y;
        
        line_7_x = origin_x;
        line_7_y = origin_y;
        
        CGContextMoveToPoint(ctx, origin_x, origin_y);
        
        CGContextAddArcToPoint(ctx, line_1_x, line_1_y, line_2_x, line_2_y, 0);//小上角
        CGContextAddArcToPoint(ctx, line_2_x, line_2_y, line_3_x, line_3_y, 0);//小三角
        CGContextAddArcToPoint(ctx, line_3_x, line_3_y, line_4_x, line_4_y, 0);//小三角
        CGContextAddArcToPoint(ctx, line_4_x, line_4_y, line_5_x, line_5_y, self.leftBottomRadius);//左下角
        CGContextAddArcToPoint(ctx, line_5_x, line_5_y, line_6_x, line_6_y, self.rightBootomRadius);//右下角
        CGContextAddArcToPoint(ctx, line_6_x, line_6_y, line_7_x, line_7_y, self.rightTopRadius);//右上角
        CGContextAddArcToPoint(ctx, line_7_x, line_7_y, line_1_x, line_1_y, self.leftTopRadius);//左上角
    }else if (_arrowDirectionType==ArrowViewDirectionTypeLeftCenter){// 左中
        origin_x = rect.origin.x+10;
        origin_y = rect.origin.y;
        
        line_1_x = origin_x;
        line_1_y = rect.size.height/2-5;
        
        line_2_x = rect.origin.x;
        line_2_y = line_1_y+5;
        
        line_3_x = rect.origin.x+10;
        line_3_y = line_2_y+5;
        
        line_4_x = rect.origin.x+10;
        line_4_y = rect.size.height;
        
        line_5_x = rect.size.width;
        line_5_y = rect.size.height;
        
        line_6_x = rect.size.width;
        line_6_y = rect.origin.y;
        
        line_7_x = origin_x;
        line_7_y = origin_y;
        
        CGContextMoveToPoint(ctx, origin_x, origin_y);
        
        CGContextAddArcToPoint(ctx, line_1_x, line_1_y, line_2_x, line_2_y, 0);//小上角
        CGContextAddArcToPoint(ctx, line_2_x, line_2_y, line_3_x, line_3_y, 0);//小三角
        CGContextAddArcToPoint(ctx, line_3_x, line_3_y, line_4_x, line_4_y, 0);//小三角
        CGContextAddArcToPoint(ctx, line_4_x, line_4_y, line_5_x, line_5_y, self.leftBottomRadius);//左下角
        CGContextAddArcToPoint(ctx, line_5_x, line_5_y, line_6_x, line_6_y, self.rightBootomRadius);//右下角
        CGContextAddArcToPoint(ctx, line_6_x, line_6_y, line_7_x, line_7_y, self.rightTopRadius);//右上角
        CGContextAddArcToPoint(ctx, line_7_x, line_7_y, line_1_x, line_1_y, self.leftTopRadius);//左上角
    }else if (_arrowDirectionType==ArrowViewDirectionTypeLeftBottom) {// 左下
        origin_x = rect.origin.x+10;
        origin_y = rect.origin.y;
        
        line_1_x = origin_x;
        line_1_y = rect.size.height-40;
        
        line_2_x = rect.origin.x;
        line_2_y = line_1_y+5;
        
        line_3_x = rect.origin.x+10;
        line_3_y = line_2_y+5;
        
        line_4_x = rect.origin.x+10;
        line_4_y = rect.size.height;
        
        line_5_x = rect.size.width;
        line_5_y = rect.size.height;
        
        line_6_x = rect.size.width;
        line_6_y = rect.origin.y;
        
        line_7_x = origin_x;
        line_7_y = origin_y;
        
        CGContextMoveToPoint(ctx, origin_x, origin_y);
        
        CGContextAddArcToPoint(ctx, line_1_x, line_1_y, line_2_x, line_2_y, 0);//小上角
        CGContextAddArcToPoint(ctx, line_2_x, line_2_y, line_3_x, line_3_y, 0);//小三角
        CGContextAddArcToPoint(ctx, line_3_x, line_3_y, line_4_x, line_4_y, 0);//小三角
        CGContextAddArcToPoint(ctx, line_4_x, line_4_y, line_5_x, line_5_y, self.leftBottomRadius);//左下角
        CGContextAddArcToPoint(ctx, line_5_x, line_5_y, line_6_x, line_6_y, self.rightBootomRadius);//右下角
        CGContextAddArcToPoint(ctx, line_6_x, line_6_y, line_7_x, line_7_y, self.rightTopRadius);//右上角
        CGContextAddArcToPoint(ctx, line_7_x, line_7_y, line_1_x, line_1_y, self.leftTopRadius);//左上角
    }else if (_arrowDirectionType==ArrowViewDirectionTypeBottomLeft){// 下左
        //起始位置坐标
        origin_x = rect.origin.x;
        origin_y = rect.origin.y; //frame.origin.y + 10;
        //第一条线的位置坐标
        line_1_x = origin_x;
        line_1_y = rect.size.height-10;
        //第二条线的位置坐标
        line_2_x = rect.origin.x+20;
        line_2_y = line_1_y;
        //第三条线的位置坐标
        line_3_x = line_2_x + 5;
        line_3_y = rect.size.height;
        //第四条线的位置坐标
        line_4_x = line_3_x+5;
        line_4_y = line_2_y;
        //第五条线的位置坐标
        line_5_x = rect.size.width;
        line_5_y = line_4_y;
        //第六条线的位置坐标
        line_6_x = rect.size.width;
        line_6_y = rect.origin.y;
        
        line_7_x = origin_x;
        line_7_y = origin_y;
        CGContextMoveToPoint(ctx, origin_x, origin_y);
        
        CGContextAddArcToPoint(ctx, line_1_x, line_1_y, line_2_x, line_2_y, self.leftBottomRadius);//左下角
        CGContextAddArcToPoint(ctx, line_2_x, line_2_y, line_3_x, line_3_y, 0);//小三角
        CGContextAddArcToPoint(ctx, line_3_x, line_3_y, line_4_x, line_4_y, 0);//小三角
        CGContextAddArcToPoint(ctx, line_4_x, line_4_y, line_5_x, line_5_y, 0);//小三角
        CGContextAddArcToPoint(ctx, line_5_x, line_5_y, line_6_x, line_6_y, self.rightBootomRadius);//右下角
        CGContextAddArcToPoint(ctx, line_6_x, line_6_y, line_7_x, line_7_y, self.rightTopRadius);//右上角
        CGContextAddArcToPoint(ctx, line_7_x, line_7_y, line_1_x, line_1_y, self.leftTopRadius);//左上角
    }else if (_arrowDirectionType==ArrowViewDirectionTypeBottomCenter) {// 下中
        
        //起始位置坐标
        origin_x = rect.origin.x;
        origin_y = rect.origin.y; //frame.origin.y + 10;
        //第一条线的位置坐标
        line_1_x = origin_x;
        line_1_y = rect.size.height-10;
        //第二条线的位置坐标
        line_2_x = rect.size.width/2-5;
        line_2_y = line_1_y;
        //第三条线的位置坐标
        line_3_x = line_2_x + 5;
        line_3_y = rect.size.height;
        //第四条线的位置坐标
        line_4_x = line_3_x+5;
        line_4_y = line_2_y;
        //第五条线的位置坐标
        line_5_x = rect.size.width;
        line_5_y = line_4_y;
        //第六条线的位置坐标
        line_6_x = rect.size.width;
        line_6_y = rect.origin.y;
        
        line_7_x = origin_x;
        line_7_y = origin_y;
        CGContextMoveToPoint(ctx, origin_x, origin_y);
        
        CGContextAddArcToPoint(ctx, line_1_x, line_1_y, line_2_x, line_2_y, self.leftBottomRadius);//左下角
        CGContextAddArcToPoint(ctx, line_2_x, line_2_y, line_3_x, line_3_y, 0);//小三角
        CGContextAddArcToPoint(ctx, line_3_x, line_3_y, line_4_x, line_4_y, 0);//小三角
        CGContextAddArcToPoint(ctx, line_4_x, line_4_y, line_5_x, line_5_y, 0);//小三角
        CGContextAddArcToPoint(ctx, line_5_x, line_5_y, line_6_x, line_6_y, self.rightBootomRadius);//右下角
        CGContextAddArcToPoint(ctx, line_6_x, line_6_y, line_7_x, line_7_y, self.rightTopRadius);//右上角
        CGContextAddArcToPoint(ctx, line_7_x, line_7_y, line_1_x, line_1_y, self.leftTopRadius);//左上角
    }else if (_arrowDirectionType==ArrowViewDirectionTypeBottomRight){// 下右
        //起始位置坐标
        origin_x = rect.origin.x;
        origin_y = rect.origin.y; //frame.origin.y + 10;
        //第一条线的位置坐标
        line_1_x = origin_x;
        line_1_y = rect.size.height-10;
        //第二条线的位置坐标
        line_2_x = rect.size.width-40;
        line_2_y = line_1_y;
        //第三条线的位置坐标
        line_3_x = line_2_x + 5;
        line_3_y = rect.size.height;
        //第四条线的位置坐标
        line_4_x = line_3_x+5;
        line_4_y = line_2_y;
        //第五条线的位置坐标
        line_5_x = rect.size.width;
        line_5_y = line_4_y;
        //第六条线的位置坐标
        line_6_x = rect.size.width;
        line_6_y = rect.origin.y;
        
        line_7_x = origin_x;
        line_7_y = origin_y;
        CGContextMoveToPoint(ctx, origin_x, origin_y);
        
        CGContextAddArcToPoint(ctx, line_1_x, line_1_y, line_2_x, line_2_y, self.leftBottomRadius);//左下角
        CGContextAddArcToPoint(ctx, line_2_x, line_2_y, line_3_x, line_3_y, 0);//小三角
        CGContextAddArcToPoint(ctx, line_3_x, line_3_y, line_4_x, line_4_y, 0);//小三角
        CGContextAddArcToPoint(ctx, line_4_x, line_4_y, line_5_x, line_5_y, 0);//小三角
        CGContextAddArcToPoint(ctx, line_5_x, line_5_y, line_6_x, line_6_y, self.rightBootomRadius);//右下角
        CGContextAddArcToPoint(ctx, line_6_x, line_6_y, line_7_x, line_7_y, self.rightTopRadius);//右上角
        CGContextAddArcToPoint(ctx, line_7_x, line_7_y, line_1_x, line_1_y, self.leftTopRadius);//左上角
    }else if (_arrowDirectionType==ArrowViewDirectionTypeRightTop) {// 右上
        
    }else if (_arrowDirectionType==ArrowViewDirectionTypeRightCenter){// 右中
        
    }else if (_arrowDirectionType==ArrowViewDirectionTypeRightBottom) {// 右下
        
    }else if (_arrowDirectionType==ArrowViewDirectionTypeTopLeft){// 上左
        
    }else if (_arrowDirectionType==ArrowViewDirectionTypeTopCenter) {// 上中
        
    }else if (_arrowDirectionType==ArrowViewDirectionTypeTopRight){// 上右
        
    }
    
    
    
    
    
    
    CGContextClosePath(ctx);
    
    //设置填充颜色
    CGContextSetFillColorWithColor(ctx, self.color.CGColor);
    CGContextFillPath(ctx);
}


-(void)topArrowView:(CGRect)rect{
    //获取当前图形,视图推入堆栈的图形,相当于你所要绘制图形的图纸
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] set];
    //创建一个新的空图形路径
    CGContextBeginPath(ctx);
    NSLog(@"开始绘制...");
    
    //起始位置坐标
    CGFloat origin_x = rect.origin.x;
    CGFloat origin_y = 10; //frame.origin.y + 10;
    //第一条线的位置坐标
    CGFloat line_1_x = rect.size.width /2-5;
    CGFloat line_1_y = origin_y;
    //第二条线的位置坐标
    CGFloat line_2_x = line_1_x + 5;
    CGFloat line_2_y = rect.origin.y;
    //第三条线的位置坐标
    CGFloat line_3_x = line_2_x + 5;
    CGFloat line_3_y = line_1_y;
    //第四条线的位置坐标
    CGFloat line_4_x = rect.size.width;
    CGFloat line_4_y = line_1_y;
    //第五条线的位置坐标
    CGFloat line_5_x = rect.size.width;
    CGFloat line_5_y = rect.size.height;
    //第六条线的位置坐标
    CGFloat line_6_x = origin_x;
    CGFloat line_6_y = rect.size.height;
    
    CGContextMoveToPoint(ctx, origin_x, origin_y);
    
    CGContextAddLineToPoint(ctx, line_1_x, line_1_y);
    CGContextAddLineToPoint(ctx, line_2_x, line_2_y);
    CGContextAddLineToPoint(ctx, line_3_x, line_3_y);
    CGContextAddLineToPoint(ctx, line_4_x, line_4_y);
    
    //    CGContextAddArcToPoint(ctx, line_5_x, line_5_y, line_5_x, 100, 10);
    //    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextAddLineToPoint(ctx, line_5_x, line_5_y);
    CGContextAddLineToPoint(ctx, line_6_x, line_6_y);
    //
    CGContextClosePath(ctx);
    
    //设置填充颜色
    CGContextSetFillColorWithColor(ctx, self.color.CGColor);
    CGContextFillPath(ctx);
}
-(void)bottomArrowView:(CGRect)rect{
    //获取当前图形,视图推入堆栈的图形,相当于你所要绘制图形的图纸
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] set];
    //创建一个新的空图形路径
    CGContextBeginPath(ctx);
    NSLog(@"开始绘制...");
    
    //起始位置坐标
    CGFloat origin_x = rect.origin.x;
    CGFloat origin_y = rect.size.height-10; //frame.origin.y + 10;
    //第一条线的位置坐标
    CGFloat line_1_x = rect.size.width /2-5;
    CGFloat line_1_y = origin_y;
    //第二条线的位置坐标
    CGFloat line_2_x = line_1_x + 5;
    CGFloat line_2_y = origin_y+10;
    //第三条线的位置坐标
    CGFloat line_3_x = line_2_x + 5;
    CGFloat line_3_y = line_1_y;
    //第四条线的位置坐标
    CGFloat line_4_x = rect.size.width;
    CGFloat line_4_y = line_1_y;
    //第五条线的位置坐标
    CGFloat line_5_x = rect.size.width;
    CGFloat line_5_y = rect.origin.y;
    //第六条线的位置坐标
    CGFloat line_6_x = origin_x;
    CGFloat line_6_y = -rect.size.height;
    
    CGContextMoveToPoint(ctx, origin_x, origin_y);
    
    CGContextAddLineToPoint(ctx, line_1_x, line_1_y);
    CGContextAddLineToPoint(ctx, line_2_x, line_2_y);
    CGContextAddLineToPoint(ctx, line_3_x, line_3_y);
    CGContextAddLineToPoint(ctx, line_4_x, line_4_y);
 
    CGContextAddLineToPoint(ctx, line_5_x, line_5_y);
    CGContextAddLineToPoint(ctx, line_6_x, line_6_y);
    //
    CGContextClosePath(ctx);
    
    //设置填充颜色
    CGContextSetFillColorWithColor(ctx, self.color.CGColor);
    CGContextFillPath(ctx);
}

-(void)customArrowView:(CGRect)rect{
    //获取当前图形,视图推入堆栈的图形,相当于你所要绘制图形的图纸
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] set];
    //创建一个新的空图形路径
    CGContextBeginPath(ctx);
    NSLog(@"开始绘制...");
    
    //起始位置坐标
    CGFloat origin_x = rect.origin.x;
    CGFloat origin_y = rect.origin.y; //frame.origin.y + 10;
    //第一条线的位置坐标
    CGFloat line_1_x = origin_x;
    CGFloat line_1_y = rect.size.height-10;
    //第二条线的位置坐标
    CGFloat line_2_x = rect.size.width/2-5;
    CGFloat line_2_y = line_1_y;
    //第三条线的位置坐标
    CGFloat line_3_x = line_2_x + 5;
    CGFloat line_3_y = rect.size.height;
    //第四条线的位置坐标
    CGFloat line_4_x = line_3_x+5;
    CGFloat line_4_y = line_2_y;
    //第五条线的位置坐标
    CGFloat line_5_x = rect.size.width;
    CGFloat line_5_y = line_4_y;
    //第六条线的位置坐标
    CGFloat line_6_x = rect.size.width;
    CGFloat line_6_y = rect.origin.y;
    
    CGFloat line_7_x = origin_x;
    CGFloat line_7_y = origin_y;
    
    CGContextMoveToPoint(ctx, origin_x, origin_y);
    
//    CGContextAddLineToPoint(ctx, line_1_x, line_1_y);
//    CGContextAddLineToPoint(ctx, line_2_x, line_2_y);
//    CGContextAddLineToPoint(ctx, line_3_x, line_3_y);
//    CGContextAddLineToPoint(ctx, line_4_x, line_4_y);
//    CGContextAddLineToPoint(ctx, line_5_x, line_5_y);
//    CGContextAddLineToPoint(ctx, line_6_x, line_6_y);
//    CGContextAddLineToPoint(ctx, line_7_x, line_7_y);
    
    
    CGContextAddArcToPoint(ctx, line_1_x, line_1_y, line_2_x, line_2_y, self.leftBottomRadius);//左下角
    CGContextAddArcToPoint(ctx, line_2_x, line_2_y, line_3_x, line_3_y, 0);//小三角
    CGContextAddArcToPoint(ctx, line_3_x, line_3_y, line_4_x, line_4_y, 0);//小三角
    CGContextAddArcToPoint(ctx, line_4_x, line_4_y, line_5_x, line_5_y, 0);//小三角
    CGContextAddArcToPoint(ctx, line_5_x, line_5_y, line_6_x, line_6_y, self.rightBootomRadius);//右下角
    CGContextAddArcToPoint(ctx, line_6_x, line_6_y, line_7_x, line_7_y, self.rightTopRadius);//右上角
    CGContextAddArcToPoint(ctx, line_7_x, line_7_y, line_1_x, line_1_y, self.leftTopRadius);//左上角


    CGContextClosePath(ctx);
    
    //设置填充颜色
    CGContextSetFillColorWithColor(ctx, self.color.CGColor);
    CGContextFillPath(ctx);
}



-(void)leftArrowView:(CGRect)rect{
    //获取当前图形,视图推入堆栈的图形,相当于你所要绘制图形的图纸
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] set];
    //创建一个新的空图形路径
    CGContextBeginPath(ctx);
    NSLog(@"开始绘制...");
    
    //起始位置坐标
    CGFloat origin_x = rect.origin.x+10;
    CGFloat origin_y = rect.origin.y; //frame.origin.y + 10;
    //第一条线的位置坐标
    CGFloat line_1_x = origin_x;
    CGFloat line_1_y = rect.size.height/2-5;
    //第二条线的位置坐标
    CGFloat line_2_x = rect.origin.x;
    CGFloat line_2_y = line_1_y+5;
    //第三条线的位置坐标
    CGFloat line_3_x = line_1_x;
    CGFloat line_3_y = line_2_y+5;
    //第四条线的位置坐标
    CGFloat line_4_x = line_3_x;
    CGFloat line_4_y = rect.size.height;
    //第五条线的位置坐标
    CGFloat line_5_x = rect.size.width;
    CGFloat line_5_y = rect.size.height;
    //第六条线的位置坐标
    CGFloat line_6_x = rect.size.width;
    CGFloat line_6_y = origin_y;
    
    CGContextMoveToPoint(ctx, origin_x, origin_y);
    CGContextAddLineToPoint(ctx, line_1_x, line_1_y);
    CGContextAddLineToPoint(ctx, line_2_x, line_2_y);
    CGContextAddLineToPoint(ctx, line_3_x, line_3_y);
    CGContextAddLineToPoint(ctx, line_4_x, line_4_y);
    CGContextAddLineToPoint(ctx, line_5_x, line_5_y);
    CGContextAddLineToPoint(ctx, line_6_x, line_6_y);
    //
    CGContextClosePath(ctx);
    
    //设置填充颜色
    CGContextSetFillColorWithColor(ctx, self.color.CGColor);
    CGContextFillPath(ctx);
}
-(void)rightArrowView:(CGRect)rect{
    //获取当前图形,视图推入堆栈的图形,相当于你所要绘制图形的图纸
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] set];
    //创建一个新的空图形路径
    CGContextBeginPath(ctx);
    NSLog(@"开始绘制...");
    
    //起始位置坐标
    CGFloat origin_x = rect.size.width-10;
    CGFloat origin_y = rect.origin.y; //frame.origin.y + 10;
    //第一条线的位置坐标
    CGFloat line_1_x = origin_x;
    CGFloat line_1_y = rect.size.height/2-5;
    //第二条线的位置坐标
    CGFloat line_2_x = rect.size.width;
    CGFloat line_2_y = line_1_y+5;
    //第三条线的位置坐标
    CGFloat line_3_x = line_1_x;
    CGFloat line_3_y = line_2_y+5;
    //第四条线的位置坐标
    CGFloat line_4_x = line_3_x;
    CGFloat line_4_y = rect.size.height;
    //第五条线的位置坐标
    CGFloat line_5_x = rect.origin.x;
    CGFloat line_5_y = rect.size.height;
    //第六条线的位置坐标
    CGFloat line_6_x = rect.origin.x;
    CGFloat line_6_y = origin_y;
    
    CGContextMoveToPoint(ctx, origin_x, origin_y);
    
    CGContextAddLineToPoint(ctx, line_1_x, line_1_y);
    CGContextAddLineToPoint(ctx, line_2_x, line_2_y);
    CGContextAddLineToPoint(ctx, line_3_x, line_3_y);
    CGContextAddLineToPoint(ctx, line_4_x, line_4_y);
    
    CGContextAddLineToPoint(ctx, line_5_x, line_5_y);
    CGContextAddLineToPoint(ctx, line_6_x, line_6_y);
    //
    CGContextClosePath(ctx);
    
    //设置填充颜色
    CGContextSetFillColorWithColor(ctx, self.color.CGColor);
    CGContextFillPath(ctx);
}

- (void)sanJiaoTuXing:(CGRect)rect{
    {
        //获取当前图形,视图推入堆栈的图形,相当于你所要绘制图形的图纸
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        [[UIColor whiteColor] set];
        //创建一个新的空图形路径
        CGContextBeginPath(ctx);
        NSLog(@"开始绘制...");
        
        //起始位置坐标
        CGFloat origin_x = rect.size.width/2;
        CGFloat origin_y = rect.origin.y; //frame.origin.y + 10;
        //第一条线的位置坐标
        CGFloat line_1_x = rect.origin.x;
        CGFloat line_1_y = rect.size.height;
        //第二条线的位置坐标
        CGFloat line_2_x = rect.size.width;
        CGFloat line_2_y = rect.size.height;
        //第三条线的位置坐标
        CGFloat line_3_x = origin_x;
        CGFloat line_3_y = origin_y;
       
        
        CGContextMoveToPoint(ctx, origin_x, origin_y);
        
        CGContextAddLineToPoint(ctx, line_1_x, line_1_y);
        CGContextAddLineToPoint(ctx, line_2_x, line_2_y);
        CGContextAddLineToPoint(ctx, line_3_x, line_3_y);
       
        CGContextClosePath(ctx);
        
        //设置填充颜色
        CGContextSetFillColorWithColor(ctx, self.color.CGColor);
        CGContextFillPath(ctx);
    }
}

- (void)addArc:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //创建一个新的空图形路径
//    CGContextBeginPath(ctx);
    NSLog(@"开始绘制...");
    
    //起始位置坐标
//    CGFloat origin_x = rect.size.width-10;
//    CGFloat origin_y = rect.origin.y; //frame.origin.y + 10;
//    //第一条线的位置坐标
//    CGFloat line_1_x = origin_x;
//    CGFloat line_1_y = rect.size.height/2-5;
//    //第二条线的位置坐标
//    CGFloat line_2_x = rect.size.width;
//    CGFloat line_2_y = line_1_y+5;
//    //第三条线的位置坐标
//    CGFloat line_3_x = line_1_x;
//    CGFloat line_3_y = line_2_y+5;
//    //第四条线的位置坐标
//    CGFloat line_4_x = line_3_x;
//    CGFloat line_4_y = rect.size.height;
//    //第五条线的位置坐标
//    CGFloat line_5_x = rect.origin.x;
//    CGFloat line_5_y = rect.size.height;
//    //第六条线的位置坐标
//    CGFloat line_6_x = rect.origin.x;
//    CGFloat line_6_y = origin_y;
//
//    CGContextMoveToPoint(ctx, origin_x, origin_y);
//
//    CGContextAddLineToPoint(ctx, line_1_x, line_1_y);
//    CGContextAddLineToPoint(ctx, line_2_x, line_2_y);
//    CGContextAddLineToPoint(ctx, line_3_x, line_3_y);
//    CGContextAddLineToPoint(ctx, line_4_x, line_4_y);
//
//    CGContextAddLineToPoint(ctx, line_5_x, line_5_y);
//    CGContextAddLineToPoint(ctx, line_6_x, line_6_y);
//    //
//    CGContextClosePath(ctx);
    float fw = 180;
    float fh = 280;
    CGContextMoveToPoint(ctx, fw, fh-20);  // 开始坐标右边开始
    CGContextAddArcToPoint(ctx, fw, fh, fw-20, fh, 10);  // 右下角角度
    CGContextAddArcToPoint(ctx, 120, fh, 120, fh-20, 10); // 左下角角度
    CGContextAddArcToPoint(ctx, 120, 250, fw-20, 250, 10); // 左上角
    CGContextAddArcToPoint(ctx, fw, 250, fw, fh-20, 10); // 右上角
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke); //根据坐标绘制路径
    CGContextSetFillColorWithColor(ctx, self.color.CGColor);
    CGContextFillPath(ctx);
}

#pragma mark === 设置圆角 ====
- (void)configurationRadiusLeftTop:(CGFloat)leftTop andLeftBootom:(CGFloat)leftBootom andRightTop:(CGFloat)rightTop andRightBootom:(CGFloat)rightBootom  {
    self.leftTopRadius = leftTop;
    self.leftBottomRadius = leftBootom;
    self.rightTopRadius = rightTop;
    self.rightBootomRadius = rightBootom;
}
- (void)changeBackColor:(UIColor *)color{
    _color = color;
}
- (void)arrowNeedsDisplay{
    [self setNeedsDisplay];
}
- (void)setArrowType:(ArrowViewType)arrowType{
    _arrowType = arrowType;
}
#pragma mark === 箭头方向 ====
- (void)setArrowDirectionType:(ArrowViewDirectionType)arrowDirectionType{
    _arrowDirectionType = arrowDirectionType;
}
@end
