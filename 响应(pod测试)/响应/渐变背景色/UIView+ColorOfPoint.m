//
//  UIView+ColorOfPoint.m
//  响应
//
//  Created by open-roc on 2019/8/26.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "UIView+ColorOfPoint.h"
#import <QuartzCore/QuartzCore.h>
@implementation UIView (ColorOfPoint)

#pragma mark === 获取当前像素颜色 ====
- (UIColor *) colorOfPoint:(CGPoint)point
{
    unsigned char pixel[4] = {0};
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    //NSLog(@"pixel: %d %d %d %d", pixel[0], pixel[1], pixel[2], pixel[3]);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}
#pragma mark === 转RGB1 ====
- (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 kCGImageAlphaNoneSkipLast);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component] / 255.0f;
    }
}

//-(RGBValue)readRGBForUIColor:(UIColor*)color{
//    
//    const CGFloat *components = CGColorGetComponents(color.CGColor);
//    Byte b = components[2] * 255;
//    Byte g = components[1] * 255;
//    Byte r = components[0] * 255;
//    
//    RGBValue rgb;
//    rgb.blue = b;
//    rgb.green = g;
//    rgb.red = r;
//    
//    NSLog(@"red:%x\ngreen:%x\nblue:%x",r,g,b);
//    return rgb;
//}

#pragma mark === 转RGB2 ====
- (void)getRGBColor:(UIColor *)color{
//    CGFloat* colors = CGColorGetComponents([UIColor redColor].CGColor);
  
    UIColor *gcolor = color;
    const CGFloat *components = CGColorGetComponents(gcolor.CGColor);
    NSLog(@"Red: %f", components[0]);
    NSLog(@"Green: %f", components[1]);
    NSLog(@"Blue: %f", components[2]);
}

#pragma mark === 转RGB3 ====
- (void)getRGB_Color:(UIColor *)uiColor{
    CGFloat R, G, B;
    
    CGColorRef color = [uiColor CGColor];
    int numComponents = CGColorGetNumberOfComponents(color);
    if (numComponents == 4)
    {
        const CGFloat *components = CGColorGetComponents(color);
        R = components[0];
        G = components[1];
        B = components[2];
    }
}
@end
