//
//  CoreTextView.m
//  响应
//
//  Created by open-roc on 2018/9/19.
//  Copyright © 2018年 kuaixun100. All rights reserved.
//

#import "CoreTextView.h"
#import <CoreText/CoreText.h>


@interface CoreTextView()
@property (nonatomic,assign) CGRect imageRect;
@end

@implementation CoreTextView
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    //        [self baseCoreTextUsingMethod];
    
    
    
    

    //1.获取当前设备上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //2.翻转坐标系(coreText坐标系是以左下角为坐标原点，UIKit以左上角为坐标原点)
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    //3.设置绘制区域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(20, 50, self.bounds.size.width - 40, self.bounds.size.height - 100));
    //2.创建需要绘制的文字
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"\tWhen I will learn CoreText, i think it will hard for me.But it is easy.\n\tIn fact,if you bengin learn, you can know that every thing is easy when you start.you just need some knowlages\n\tIn fact,if you bengin learn, you can know that every thing is easy when you start.you just need some knowlages\n\tIn fact,if you bengin learn, you can know that every thing is easy when you start.you just need some knowlages\n\tIn fact,if you bengin learn, you can know that every thing is easy when you start.you just need some knowlages\n\tIn fact,if you bengin learn, you can know that every thing is easy when you start.you just need some knowlages\n\tIn fact,if you bengin learn, you can know that every thing is easy when you start.you just need some knowlages\n\tIn fact,if you bengin learn, you can know that every thing is easy when you start.you just need some knowlages\n\tIn fact,if you bengin learn, you can know that every thing is easy when you start.you just need some knowlagesif you bengin learn, you can know that every thing is easy when you start.you just need some knowlagesif you bengin learn, you can know that every thing is easy when you start.you just need some knowlagesif you bengin learn, you can know that every thing is easy when you start.you just need some knowlagesif you bengin learn, you can know that every thing is easy when you start.you just need some knowlagesif you bengin learn, you can know that every thing is easy when you start.you just need some knowlagesif you bengin learn, you can know that every thing is easy when you start.you just need some knowlages"];
    
    //5.设置CTFrame
    CTFramesetterRef ctFrameSetting = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFrameSetting, CFRangeMake(0, [attString length]), path, NULL);
    //6.在CTFrame中绘制文本关联到上下文
    CTFrameDraw(ctFrame, context);
    //7.释放变量
//    CFRelease(path);
//    CFRelease(ctFrameSetting);
//    CFRelease(ctFrame);
    
    
    
//        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
    
    
    //将图片绘制到上下文中
        CGContextDrawImage(context, CGRectMake(37, 274, 100, 100), [UIImage imageNamed:@"0"].CGImage);
        CGContextRestoreGState(context);
//      CGContextRestoreGState(context);
    //    if (self.data) {
    //        CTFrameDraw(self.data.ctFrame, context);
    //        for (CoreTextImageData *imageData in self.data.imageArray) {
    //            //将图片绘制到上下文中
    //            CGContextDrawImage(context, imageData.imagePosition, [UIImage imageNamed:imageData.name].CGImage);
    //        }
    //    }
    
    //    [self frame:frame];
 
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(ctx);
//    //翻转起来---上下颠倒
//    CGContextTranslateCTM(ctx, 0.0, self.bounds.size.height);
//    CGContextScaleCTM(ctx, 1.0, -1.0);
//
//    ////假设想在10,30,80,80的地方绘制,颠倒过来后的Rect应该是 10, self.bounds.size.height - 110, 80, 80
//    CGRect imageRect = CGRectMake(10, self.bounds.size.height - 174, 80, 80);
//    CGContextDrawImage(ctx, imageRect, [UIImage imageNamed:@"0"].CGImage);
//    CGContextRestoreGState(ctx);
//
//    //字体在iOS7中被废除了,移入CoreText框架中,以后再详细讨论.
//    [@"这是一个飞船" drawAtPoint:CGPointMake(10, 120) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blackColor]}];
}
//- (void)setData:(CoreTextData *)data {
//    if (_data != data) {
//        _data = data;
//    }
//    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, self.data.height);
//}

#pragma mark - 空白占位符及代理设置
- (NSMutableAttributedString *)CTRunDelegate{
    
    //CTRunDelegateCallBacks:用于保存指针的结构体，由CTRun delegate进行回调
    CTRunDelegateCallbacks callbacks;
    //为callbacks开辟内存空间
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = heightCallBack;
    callbacks.getDescent = descentCallBack;
    callbacks.getWidth = widthCallBack;
    //图片信息字典
    NSDictionary *imgInfoDic = @{@"width":@320,@"height":@230};
    //创建CTRunDelegate的代理
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge void*)imgInfoDic);
    //使用oxFFFC作为空白占位符
    unichar objectReplacementChar = 0xFFFC;
    NSString *content = [NSString stringWithCharacters:&objectReplacementChar length:1];
    NSMutableAttributedString *space = [[NSMutableAttributedString alloc] initWithString:content];
    //设置代理
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)space, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    return space;
}
#pragma mark - CTRunDelegateCallbacks Method
//此处使用的字典结构来存储数值
static CGFloat heightCallBack(void *ref) {
    return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"height"] floatValue];
}
static CGFloat descentCallBack (void *ref) {
    return 0;
}
static CGFloat widthCallBack (void *ref) {
    return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"width"] floatValue];
}

- (CGRect)frame:(CTFrameRef)ctframe{
    //获取CTLine数组
    NSArray *lines = (NSArray *)CTFrameGetLines(ctframe);
    NSInteger lineCount = lines.count;
    CGPoint lineOrigins[lineCount];
    CTFrameGetLineOrigins(ctframe, CFRangeMake(0, 0), lineOrigins);
    //遍历每一个CTline
    for (NSInteger i = 0; i < lineCount; i ++) {
        CTLineRef line = (__bridge CTLineRef)lines[i];
        NSArray *runObjArray = (NSArray *)CTLineGetGlyphRuns(line);
        //遍历每个CTLine中的CTRun找到空白字符的delegate
        for (id runObj in runObjArray) {
            CTRunRef run = (__bridge CTRunRef)runObj;
            NSDictionary *runAttributes = (NSDictionary *)CTRunGetAttributes(run);
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[runAttributes valueForKey:(id)kCTRunDelegateAttributeName];
            if (delegate == nil) {
                continue;
            }
            NSDictionary *metaDic = CTRunDelegateGetRefCon(delegate);
            if (![metaDic isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            //找到代理后开始计算空白字符的位置
            CGRect runBounds;
            CGFloat ascent;
            CGFloat descent;
            
            runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
            runBounds.size.height = ascent + descent;
            //计算在行当中的x偏移量
            CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            runBounds.origin.x = lineOrigins[i].x + xOffset;
            runBounds.origin.y = lineOrigins[i].y - descent;
            //获得ctframe的绘制区域
            CGPathRef pathRef = CTFrameGetPath(ctframe);
            //计算此绘制区域的范围
            CGRect colRect = CGPathGetBoundingBox(pathRef);
            //计算在此区域中空白字符的位置
            CGRect delegateBounds= CGRectOffset(runBounds, colRect.origin.x, colRect.origin.y);
            //记录空白字符位置
            _imageRect = delegateBounds;
            //返回空白字符位置
            return delegateBounds;
        }
    }
    //若没有找到对应的代理则返回空位置
    return CGRectZero;
}
#pragma mark - CoreText基础用法
/**
 *  基础的coreText用法
 */
- (void)baseCoreTextUsingMethod {
    //1.获取当前设备上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //2.翻转坐标系(coreText坐标系是以左下角为坐标原点，UIKit以左上角为坐标原点)
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    //3.设置绘制区域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(10, 20, self.bounds.size.width - 20, self.bounds.size.height - 40));
    //4.设置文本内容
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"Hello world"];
    //5.设置CTFrame
    CTFramesetterRef ctFrameSetting = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFrameSetting, CFRangeMake(0, [attString length]), path, NULL);
    //6.在CTFrame中绘制文本关联到上下文
    CTFrameDraw(ctFrame, context);
    //7.释放变量
    CFRelease(path);
    CFRelease(ctFrameSetting);
    CFRelease(ctFrame);
    
}

@end
