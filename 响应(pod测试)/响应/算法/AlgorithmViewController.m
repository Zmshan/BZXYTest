//
//  AlgorithmViewController.m
//  响应
//
//  Created by open-roc on 2019/6/28.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "AlgorithmViewController.h"

@interface AlgorithmViewController ()

@end

@implementation AlgorithmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    https://www.jianshu.com/p/384b0ff5dd69
    
    NSArray *arr = @[@(0),@(15),@(1),@(8),@(7),@(6),@(8),@(12),@(24),@(6),@(8),@(12),@(24)];
    NSMutableArray *muarr = [NSMutableArray array];
    [muarr setArray:arr];
    [muarr enumerateObjectsUsingBlock:^(id  _Nonnull objA, NSUInteger idxA, BOOL * _Nonnull stop) {
        
        [muarr enumerateObjectsUsingBlock:^(id  _Nonnull objB, NSUInteger idxB, BOOL * _Nonnull stop) {
            
            if (muarr.count>(idxB+1)) {
                if ([objB integerValue]>[muarr[idxB+1] integerValue]) {
                    [muarr exchangeObjectAtIndex:idxB+1 withObjectAtIndex:idxB];
                }
                
            }
            
        }];
        
        
//        0
//        0 15 1 8 7
//        15
//        0 1 15 8 7
//        15
//        0 1 8 15 7
//        7
//        0 1 8  7 15
    }];
    NSLog(@"arrarrarr%@",muarr);
    [self maoPao];
    
    for (int i = 0; i<arr.count; i++) {
        
    }
    
}

- (void)maoPao{

    __block NSInteger count =  0;
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    //这部分为需要统计时间的代码
    NSArray *arr = @[@(0),@(15),@(1),@(8),@(7),@(6),@(8),@(12),@(24),@(6),@(8),@(12),@(24)];
    //    NSInteger index = 10;
    NSMutableArray * muArr = [NSMutableArray arrayWithArray:arr];
    [muArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx0, BOOL * _Nonnull stop) {
        
        //        [muArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx1, BOOL * _Nonnull stop) {
        //            if ([muArr[idx0]integerValue]>[muArr[idx1]integerValue]) {
        //
        ////                [muArr exchangeObjectAtIndex:idx0 withObjectAtIndex:idx1];//升序
        ////                NSLog(@"执行次数1 %ld",(long)count++);
        //            }else{
        //
        ////                [muArr exchangeObjectAtIndex:idx0 withObjectAtIndex:idx1];//降序
        //
        //
        //            }
        //
        //        }];
        
        //        优化后 次数降低了。耗时变长了。计算多了
        [muArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx1, BOOL * _Nonnull stop) {
            if (idx1+1<muArr.count) {
                if ( [muArr[idx1]integerValue]>[muArr[idx1 +1]integerValue]) {
                    
                    [muArr exchangeObjectAtIndex:idx1+1 withObjectAtIndex:idx1];//升序
                    NSLog(@"优化执行次数1升序 %ld",(long)count++);
                }else{
                    
                    //                      [muArr exchangeObjectAtIndex:idx1+1 withObjectAtIndex:idx1];;//降序
                    //                    NSLog(@"优化执行次数1降序 %ld",(long)count++);
                    
                }
            }
            
            
        }];
        
    }];
    CFAbsoluteTime endTime = (CFAbsoluteTimeGetCurrent() - startTime);
    NSLog(@"方法耗时1: %f ms", endTime * 1000.0);
    
    
    count = 0;
    CFAbsoluteTime startTime2 = CFAbsoluteTimeGetCurrent();
    //这部分为需要统计时间的代码
    for (int i = 0; i < muArr.count; i++) {
        for (int j = 0; j < muArr.count - 1 - i; j++) {
            if ([muArr[j] intValue] < [muArr[j + 1] intValue]) {
                
                int tmp = [muArr[j] intValue];
                muArr[j] = muArr[j + 1];
                muArr[j + 1] = [NSNumber numberWithInt:tmp];
                NSLog(@"执行次数2 %ld",(long)count++);
                
                //              结果和上面四行一样
                //                [muArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];//升序
            }
        }
    }
    
    NSLog(@"冒泡排序后结果：%@", muArr);
    CFAbsoluteTime endTime2 = (CFAbsoluteTimeGetCurrent() - startTime2);
    NSLog(@"方法耗时2: %f ms", endTime2 * 1000.0);
    
    //冒泡排序
    int a [13] = {0,15,1,8,7,6,8,12,24,6,8,12,24};
    BOOL exchanged = YES;
    //i:整体遍历的次数
    //j:当前遍历的位置
    for (int i = 0 ; i<12&&exchanged; i++) {
        exchanged = NO;
        
        
        for (int j = 0 ; j<(12-i); j++)
        {
            NSLog(@"执行次数3 %ld",(long)count++);
            NSLog(@"---%d---%d",i,j);
            int b = a[j];
            int c = a[j+1];
            if (b>c) {
                a[j] = c;
                a[j+1] = b;
                exchanged = YES;
                
            }
        }
        
    }
    for (int i = 0 ; i< 13;i++ ) {
        NSLog(@"for is end :%d",a[i]);
    }
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
