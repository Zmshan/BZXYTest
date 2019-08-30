//
//  TPCustomAddViewScrollView.m
//  响应
//
//  Created by open-roc on 2018/12/10.
//  Copyright © 2018 kuaixun100. All rights reserved.
//

#import "TPCustomAddViewScrollView.h"
#import "Masonry.h"
@interface TPCustomAddViewScrollView ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *addViewScrollView;
@property (nonatomic,strong) UIView *addViewContentView;

@property (nonatomic,strong) NSMutableArray *viewsArr;
/** 保存当前 scrollView 的 X 轴偏移量 */
@property(nonatomic, assign) CGFloat startOffsetX;
/** 保存当前选中的标题按钮索引 */
@property(nonatomic, assign) NSInteger selectTitleIndex;
/** 是否是点击了标题按钮 */
@property(nonatomic, assign) BOOL isClickTitleBtn;
@end
@implementation TPCustomAddViewScrollView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self addSubview:self.addViewScrollView];
        [self.addViewScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.bottom.equalTo(self);
        }];
        [self.addViewScrollView addSubview:self.addViewContentView];
        [self.addViewContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.addViewScrollView);
            //因为上面的宽高是相对于contentSize的  所以为0  这里需要设置contentView的宽度约束后  scrollView的contentSize.width就会拉伸
            //        make.height.equalTo(self.scrollView);
            
        }];
    }
    return self;
}





//*****************************************ViewScroll****************

- (void)setAddViewsArr:(NSArray *)addViewsArr{
    [self addSubview:self.addViewScrollView];
    
    [self.viewsArr removeAllObjects];
    [self.addViewContentView removeFromSuperview];
    self.addViewContentView = nil;
    [self.addViewScrollView addSubview:self.addViewContentView];
    [self.addViewContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.addViewScrollView);
    }];
    NSArray * viewArr = addViewsArr;
   
    __block CGFloat viewSizeW = self.frame.size.width;
    __block CGFloat viewSizWAndJianJu = 20;
    __block CGFloat JianJu = 0;
    __block CGFloat sizeW = self.frame.size.width;
    __block CGFloat top = 0;
    __block CGFloat bottom = 0;
    [viewArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
//        UIView * view = [[UIView alloc]init];
//        CGFloat rgb = arc4random()%225;
//        view.backgroundColor = [UIColor colorWithRed:rgb/255 green:rgb/255 blue:rgb/255 alpha:1];
//
        UIView *view =  obj;
        view.tag = idx;
        [view sizeToFit];
        NSLog( @"view%f",view.frame.size.width);
        viewSizWAndJianJu +=view.frame.size.width+JianJu;
        viewSizeW += view.frame.size.width;
        [self.viewsArr addObject:view];
    }];
    
    
    __block UIView * lastView = nil;
    [self.viewsArr enumerateObjectsUsingBlock:^(id  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        [self.addViewContentView addSubview:view];
        //        如果总按钮宽度+间距 小于当前屏幕的宽
        
        if (idx==0) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.addViewContentView).mas_offset(JianJu);
                make.top.equalTo(self.addViewContentView).mas_offset(top);
                make.bottom.equalTo(self.addViewContentView).mas_offset(-bottom);
                make.width.mas_equalTo(sizeW);
                make.height.mas_equalTo(100);
            }];
        }else if (idx==viewArr.count-1){
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastView.mas_right).mas_offset(JianJu);
                make.right.equalTo(self.addViewContentView.mas_right).mas_offset(-JianJu);
                make.top.equalTo(self.addViewContentView).mas_offset(top);
                make.bottom.equalTo(self.addViewContentView).mas_offset(-bottom);
                make.width.mas_equalTo(sizeW);
                make.height.mas_equalTo(100);
            }];
        }else{
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastView.mas_right).mas_offset(JianJu);
                make.top.equalTo(self.addViewContentView).mas_offset(top);
                make.bottom.equalTo(self.addViewContentView).mas_offset(-bottom);
                make.width.mas_equalTo(sizeW);
                make.height.mas_equalTo(100);
            }];
        }
        lastView = view;
        
    }];
    
    [self layoutIfNeeded];
    [self setNeedsLayout];
    NSLog(@"addViewContentView%f",self.addViewContentView.frame.size.width);
    CGRect frame = self.addViewContentView.frame;
    if (self.addViewContentView.frame.size.width<self.frame.size.width) {
        self.addViewContentView.frame = CGRectMake(frame.origin.x, frame.origin.y, self.frame.size.width, frame.size.height);
    }
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.addViewContentView.frame.size.height);
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.frame.size.height);
    }];
    
    
}


/*
- (void)loadViewsBtnAddModel:(NSInteger)modelType{
    [self addSubview:self.addViewScrollView];
    
    [self.viewsArr removeAllObjects];
    [self.addViewContentView removeFromSuperview];
    self.addViewContentView = nil;
    [self.addViewScrollView addSubview:self.addViewContentView];
    [self.addViewContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.addViewScrollView);
    }];
    NSArray * btnArr = nil;
    if (modelType==1) {
        btnArr = @[@"我要显示1",@"我要显示2"];
    }else{
        btnArr = @[@"我要显示1",@"我要显示2",@"我要显示3",@"显示4",@"我要显示5",@"我要显示6",@"我要显示7",@"我要显示8",@"我要显示9"];
    }
    
    
    __block CGFloat viewSizeW = self.frame.size.width;
    __block CGFloat viewSizWAndJianJu = 20;
    __block CGFloat JianJu = 0;
    __block CGFloat sizeW = self.frame.size.width;
    __block CGFloat top = 0;
    __block CGFloat bottom = 0;
    [btnArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIView * view = [[UIView alloc]init];
        CGFloat rgb = arc4random()%225;
        view.backgroundColor = [UIColor colorWithRed:rgb/255 green:rgb/255 blue:rgb/255 alpha:1];
        
        view.tag = idx;
        [view sizeToFit];
        NSLog( @"view%f",view.frame.size.width);
        viewSizWAndJianJu +=view.frame.size.width+JianJu;
        viewSizeW += view.frame.size.width;
        [self.viewsArr addObject:view];
    }];
    
    
    __block UIView * lastView = nil;
    [self.viewsArr enumerateObjectsUsingBlock:^(id  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        [self.addViewContentView addSubview:view];
        //        如果总按钮宽度+间距 小于当前屏幕的宽
        
        if (idx==0) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.addViewContentView).mas_offset(JianJu);
                make.top.equalTo(self.addViewContentView).mas_offset(top);
                make.bottom.equalTo(self.addViewContentView).mas_offset(-bottom);
                make.width.mas_equalTo(sizeW);
                make.height.mas_equalTo(100);
            }];
        }else if (idx==btnArr.count-1){
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastView.mas_right).mas_offset(JianJu);
                make.right.equalTo(self.addViewContentView.mas_right).mas_offset(-JianJu);
                make.top.equalTo(self.addViewContentView).mas_offset(top);
                make.bottom.equalTo(self.addViewContentView).mas_offset(-bottom);
                make.width.mas_equalTo(sizeW);
                make.height.mas_equalTo(100);
            }];
        }else{
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastView.mas_right).mas_offset(JianJu);
                make.top.equalTo(self.addViewContentView).mas_offset(top);
                make.bottom.equalTo(self.addViewContentView).mas_offset(-bottom);
                make.width.mas_equalTo(sizeW);
                make.height.mas_equalTo(100);
            }];
        }
        lastView = view;
        
    }];
    
    [self layoutIfNeeded];
    NSLog(@"addViewContentView%f",self.addViewContentView.frame.size.width);
    CGRect frame = self.addViewContentView.frame;
    if (self.addViewContentView.frame.size.width<self.frame.size.width) {
        self.addViewContentView.frame = CGRectMake(frame.origin.x, frame.origin.y, self.frame.size.width, frame.size.height);
    }
    
    
    
    
}
*/
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.addViewScrollView!=scrollView) {
        return;
    }
    // 将是否点击标题设置为 NO，取消对拖拽页面产生的影响
    self.isClickTitleBtn = NO;
    // 保存当前 scrollView 的 X 轴偏移量
    self.startOffsetX = scrollView.contentOffset.x;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.addViewScrollView!=scrollView||self.isClickTitleBtn) {
        return;
    }
  
    // 1.定义获取需要的数据
    CGFloat progress = 0;
    NSInteger sourceIndex = 0;
    NSInteger targetIndex = 0;
    
    // 2.判断是左滑还是右滑
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat scrollViewW = scrollView.bounds.size.width;
    
    if (currentOffsetX > self.startOffsetX) { // 左滑
        // 1.计算progress
        progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW);
        
        // 2.计算sourceIndex
        sourceIndex = (NSInteger)currentOffsetX / scrollViewW;
        
        // 3.计算targetIndex
        targetIndex = sourceIndex + 1;
        if (targetIndex >= self.viewsArr.count) {
            targetIndex = self.viewsArr.count - 1;
        }
        
        // 4.如果完全划过去
        if (currentOffsetX - self.startOffsetX == scrollViewW) {
            progress = 1;
            targetIndex = sourceIndex;
            sourceIndex -= 1;
        } else if (progress == 0) {  // 快速左滑产生的 BUG
            progress = 1;
            targetIndex = sourceIndex;
            sourceIndex -= 1;
        }
        
        
    } else { // 右滑
        if (currentOffsetX < 0) {
            return;
        }
        // 1.计算progress
        progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW));
        
        // 2.计算targetIndex
        targetIndex = (NSInteger)currentOffsetX / scrollViewW;
        
        // 3.计算sourceIndex
        sourceIndex = targetIndex + 1;
        if (sourceIndex >= self.viewsArr.count) {
            sourceIndex = self.viewsArr.count - 1;
        }
   
        
    }
    if (self.changeWithProgressBlock) {
        self.changeWithProgressBlock(progress, sourceIndex, targetIndex);
    }
    
}


- (void)scrollPageToIndex:(NSInteger)index{
    self.isClickTitleBtn = YES;
    // 保存当前选中的按钮索引
    self.selectTitleIndex = index;
    // 滚动到指定的view
    CGPoint offset = self.addViewScrollView.contentOffset;
    offset.x = index * self.addViewScrollView.frame.size.width;
    [self.addViewScrollView setContentOffset:offset animated:YES];
}

- (UIScrollView *)addViewScrollView{
    
    if (!_addViewScrollView) {
        _addViewScrollView = [[UIScrollView alloc]init];
        
        _addViewScrollView.delegate = self;
        //    整页滚动
        _addViewScrollView.pagingEnabled = YES;
        //    隐藏水平滚动指示条
        _addViewScrollView.showsHorizontalScrollIndicator = NO;
        _addViewScrollView.backgroundColor = [UIColor blackColor];
    }
    return _addViewScrollView;
}
- (UIView *)addViewContentView {
    
    if (!_addViewContentView) {
        
        _addViewContentView =[[UIView alloc] init];
        _addViewContentView.backgroundColor = [UIColor whiteColor];
    }
    return _addViewContentView;
}


- (NSMutableArray *)viewsArr{
    if (!_viewsArr) {
        _viewsArr = [NSMutableArray array];
    }
    return _viewsArr;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
