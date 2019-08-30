//
//  CustomView.m
//  响应
//
//  Created by open-roc on 2019/4/18.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _drawColor = [UIColor lightGrayColor];
        _indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.height)];
        _indexLabel.textColor = [UIColor whiteColor];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        _indexLabel.font = [UIFont boldSystemFontOfSize:18];
        _indexLabel.text = @"aaa";
        [self addSubview:_indexLabel];
        
    }
    return self;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    _indexLabel.textColor = textColor;
}

- (void)drawRect:(CGRect)rect
{
    [self drawInContext:UIGraphicsGetCurrentContext()];
}

- (void)drawInContext:(CGContextRef)context
{
//    CGContextSetLineWidth(context, 2.0);
//    CGContextSetFillColorWithColor(context,_drawColor.CGColor);
//    [self getDrawPath:context];
//    CGContextFillPath(context);
}

- (void)getDrawPath:(CGContextRef)context
{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat xOffset = self.bounds.size.width * 1/4;
    CGFloat yOffset = self.bounds.size.height * 1/4;
    CGFloat radius = sqrt(pow(xOffset, 2) + pow(yOffset, 2));
    
    //Draw triangle
    CGContextMoveToPoint(context, width - xOffset, height * 0.5 - yOffset);
    CGContextAddLineToPoint(context,width, height * 0.5);
    CGContextAddLineToPoint(context,width - xOffset, height * 0.5 + yOffset);
    
    //Draw semicircle
    CGContextAddArcToPoint(context, width * 0.5, height, width * 0.5 - xOffset, height * 0.5 + yOffset, radius);
    CGContextAddArcToPoint(context, 0, height * 0.5, width * 0.5 - xOffset, height * 0.5 - yOffset, radius);
    CGContextAddArcToPoint(context, width * 0.5, 0, width * 0.5 + xOffset, height * 0.5 - yOffset, radius);
    CGContextClosePath(context);
}


@end
