//
//  Arrow.m
//  响应
//
//  Created by open-roc on 2019/8/14.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "Arrow.h"
#import "UIBezierPath+dqd_arrowhead.h"
@implementation Arrow
{
    CGPoint startPoint;
    CGPoint endPoint;
    CGFloat tailWidth;
    CGFloat headWidth;
    CGFloat headLength;
    UIBezierPath *path;
    
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setMultipleTouchEnabled:NO];
        [self setBackgroundColor:[UIColor whiteColor]];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [[UIColor redColor] setStroke];
    tailWidth = 4;
    headWidth = 8;
    headLength = 8;
    path = [UIBezierPath dqd_bezierPathWithArrowFromPoint:(CGPoint)startPoint
                                                  toPoint:(CGPoint)endPoint
                                                tailWidth:(CGFloat)tailWidth
                                                headWidth:(CGFloat)headWidth
                                               headLength:(CGFloat)headLength];
    [path setLineWidth:2.0];
    
    [path stroke];
    
}
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    UITouch* touchPoint = [touches anyObject];
    startPoint = [touchPoint locationInView:self];
    endPoint = [touchPoint locationInView:self];
    
    
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    endPoint=[touch locationInView:self];
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    endPoint = [touch locationInView:self];
    [self setNeedsDisplay];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
