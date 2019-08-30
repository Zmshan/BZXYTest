//
//  TPCustomTitleScrollView.m
//  响应
//
//  Created by open-roc on 2018/12/10.
//  Copyright © 2018 kuaixun100. All rights reserved.
//

#import "TPCustomTitleScrollView.h"
#import "Masonry.h"
@interface TPCustomTitleScrollView ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView * titleScrollView;
@property (nonatomic,strong) UIView *contentView ;
@property (nonatomic,strong) UILabel *contentLabel;

@property (nonatomic,strong) UIButton *modelBtn;

@property (nonatomic,strong) UIView *lineView ;
@property (nonatomic,strong) NSMutableArray *getBtnArr;

@end
@implementation TPCustomTitleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleScrollView];
        [self.titleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.bottom.equalTo(self);
        }];
        [self.titleScrollView addSubview:self.contentView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.titleScrollView);
            //因为上面的宽高是相对于contentSize的  所以为0  这里需要设置contentView的宽度约束后  scrollView的contentSize.width就会拉伸
            //        make.height.equalTo(self.scrollView);
            
        }];
    }
    return self;
}


-(void)setTitlesArr:(NSArray *)titlesArr{
    [self.getBtnArr removeAllObjects];
    [self.contentView removeFromSuperview];
    self.contentView = nil;
    [self.titleScrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.titleScrollView);
    }];
    NSArray * btnArr = titlesArr;
    
    __block CGFloat btnSizeW = 0;
    __block CGFloat btnSizWAndJianJu = 20;
    __block CGFloat JianJu = 20;
    __block CGFloat sizeW = self.frame.size.width;
    [btnArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton * sender = [UIButton buttonWithType:UIButtonTypeCustom];
        sender.tag = idx;
        [sender setTitle:obj forState:UIControlStateNormal];
        [sender  addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //        sender.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
        sender.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        sender.backgroundColor = [UIColor blueColor];
        [self.getBtnArr addObject:sender];
        [sender sizeToFit];
        NSLog( @"btnSizeW%f",sender.frame.size.width);
        btnSizWAndJianJu +=sender.frame.size.width+JianJu;
        btnSizeW += sender.frame.size.width;
        
    }];
    
    
    __block UIButton * lastBtn = nil;
    [self.getBtnArr enumerateObjectsUsingBlock:^(id  _Nonnull sender, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        [self.contentView addSubview:sender];
        
        //        如果总按钮宽度+间距 小于当前屏幕的宽
        if (btnSizWAndJianJu<sizeW) {
            //            总屏幕宽- 按钮的宽 = 剩余宽度
            __block CGFloat ShengYuW = sizeW - btnSizeW;
            //这里的间距是平均分的  剩余宽度 /（按钮个数+1）
            JianJu =  ShengYuW/(self.getBtnArr.count+1);
            
            if (idx==0) {
                [sender mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.contentView).mas_offset(JianJu);
                    make.top.equalTo(self.contentView).mas_offset(20);
                    make.bottom.equalTo(self.contentView).mas_offset(-20);
                }];
            }else if (idx==btnArr.count-1){
                [sender mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastBtn.mas_right).mas_offset(JianJu);
                    make.right.equalTo(self.contentView.mas_right).mas_offset(-JianJu);
                    make.top.equalTo(self.contentView).mas_offset(20);
                    make.bottom.equalTo(self.contentView).mas_offset(-20);
                }];
            }else{
                [sender mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastBtn.mas_right).mas_offset(JianJu);
                    make.top.equalTo(self.contentView).mas_offset(20);
                    make.bottom.equalTo(self.contentView).mas_offset(-20);
                }];
            }
            lastBtn = sender;
            
        }else{
            if (idx==0) {
                [sender mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.contentView).mas_offset(JianJu);
                    make.top.equalTo(self.contentView).mas_offset(20);
                    make.bottom.equalTo(self.contentView).mas_offset(-20);
                }];
            }else if (idx==btnArr.count-1){
                [sender mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastBtn.mas_right).mas_offset(JianJu);
                    make.right.equalTo(self.contentView.mas_right).mas_offset(-JianJu);
                    make.top.equalTo(self.contentView).mas_offset(20);
                    make.bottom.equalTo(self.contentView).mas_offset(-20);
                }];
            }else{
                [sender mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastBtn.mas_right).mas_offset(JianJu);
                    make.top.equalTo(self.contentView).mas_offset(20);
                    make.bottom.equalTo(self.contentView).mas_offset(-20);
                }];
            }
            lastBtn = sender;
            
        }
    }];
    
    [self layoutIfNeeded];
    [self setNeedsLayout];
    NSLog(@"contentView%f==%@",self.contentView.frame.size.width,NSStringFromCGRect(self.frame));
    CGRect frame = self.contentView.frame;
    if (self.contentView.frame.size.width<self.frame.size.width) {
        self.contentView.frame = CGRectMake(frame.origin.x, frame.origin.y, self.frame.size.width, frame.size.height);
    }
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.contentView.frame.size.height);
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.frame.size.height);
    }];
    UIButton *senderBtn = [self.getBtnArr firstObject];
    self.lineView.frame = CGRectMake(senderBtn.frame.origin.x, self.contentView.frame.size.height-1, senderBtn.frame.size.width, 1);
    [self.contentView addSubview:self.lineView];
}
/*
- (void)loadTitleBtnAddModel:(NSInteger)modelType{
    
    [self.getBtnArr removeAllObjects];
    [self.contentView removeFromSuperview];
    self.contentView = nil;
    [self.titleScrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.titleScrollView);
    }];
    NSArray * btnArr = nil;
    if (modelType==1) {
        btnArr = @[@"我要显示1",@"我要显示2"];
    }else{
        btnArr = @[@"我要显示1",@"我要显示2",@"我要显示3",@"显示4",@"我要显示5",@"我要显示6",@"我要显示7",@"我要显示8",@"我要显示9"];
    }
    
    
    __block CGFloat btnSizeW = 0;
    __block CGFloat btnSizWAndJianJu = 20;
    __block CGFloat JianJu = 20;
    __block CGFloat sizeW = self.frame.size.width;
    [btnArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton * sender = [UIButton buttonWithType:UIButtonTypeCustom];
        sender.tag = idx;
        [sender setTitle:obj forState:UIControlStateNormal];
        [sender  addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //        sender.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
        sender.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        sender.backgroundColor = [UIColor blueColor];
        [self.getBtnArr addObject:sender];
        [sender sizeToFit];
        NSLog( @"btnSizeW%f",sender.frame.size.width);
        btnSizWAndJianJu +=sender.frame.size.width+JianJu;
        btnSizeW += sender.frame.size.width;
        
    }];
    
    
    __block UIButton * lastBtn = nil;
    [self.getBtnArr enumerateObjectsUsingBlock:^(id  _Nonnull sender, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        [self.contentView addSubview:sender];
        
        //        如果总按钮宽度+间距 小于当前屏幕的宽
        if (btnSizWAndJianJu<sizeW) {
            //            总屏幕宽- 按钮的宽 = 剩余宽度
            __block CGFloat ShengYuW = sizeW - btnSizeW;
            //这里的间距是平均分的  剩余宽度 /（按钮个数+1）
            JianJu =  ShengYuW/(self.getBtnArr.count+1);
            
            if (idx==0) {
                [sender mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.contentView).mas_offset(JianJu);
                    make.top.equalTo(self.contentView).mas_offset(20);
                    make.bottom.equalTo(self.contentView).mas_offset(-20);
                }];
            }else if (idx==btnArr.count-1){
                [sender mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastBtn.mas_right).mas_offset(JianJu);
                    make.right.equalTo(self.contentView.mas_right).mas_offset(-JianJu);
                    make.top.equalTo(self.contentView).mas_offset(20);
                    make.bottom.equalTo(self.contentView).mas_offset(-20);
                }];
            }else{
                [sender mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastBtn.mas_right).mas_offset(JianJu);
                    make.top.equalTo(self.contentView).mas_offset(20);
                    make.bottom.equalTo(self.contentView).mas_offset(-20);
                }];
            }
            lastBtn = sender;
            
        }else{
            if (idx==0) {
                [sender mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.contentView).mas_offset(JianJu);
                    make.top.equalTo(self.contentView).mas_offset(20);
                    make.bottom.equalTo(self.contentView).mas_offset(-20);
                }];
            }else if (idx==btnArr.count-1){
                [sender mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastBtn.mas_right).mas_offset(JianJu);
                    make.right.equalTo(self.contentView.mas_right).mas_offset(-JianJu);
                    make.top.equalTo(self.contentView).mas_offset(20);
                    make.bottom.equalTo(self.contentView).mas_offset(-20);
                }];
            }else{
                [sender mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastBtn.mas_right).mas_offset(JianJu);
                    make.top.equalTo(self.contentView).mas_offset(20);
                    make.bottom.equalTo(self.contentView).mas_offset(-20);
                }];
            }
            lastBtn = sender;
            
        }
    }];
    
    [self layoutIfNeeded];
    NSLog(@"contentView%f",self.contentView.frame.size.width);
    CGRect frame = self.contentView.frame;
    if (self.contentView.frame.size.width<self.frame.size.width) {
        self.contentView.frame = CGRectMake(frame.origin.x, frame.origin.y, self.frame.size.width, frame.size.height);
    }
    
    UIButton *senderBtn = [self.getBtnArr firstObject];
    self.lineView.frame = CGRectMake(senderBtn.frame.origin.x, self.contentView.frame.size.height-1, senderBtn.frame.size.width, 1);
    [self.contentView addSubview:self.lineView];
    
}
*/
#pragma mark - 接口
- (void)titleStatusChangeWithProgress:(CGFloat)progress fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
    if (toIndex > self.getBtnArr.count - 1) return;
    if (fromIndex < 0) return;
    
    // 1.取出源和目标按钮
    UIButton *sourceTitleBtn = self.getBtnArr[fromIndex];
    UIButton *targetTitleBtn = self.getBtnArr[toIndex];
    
    CGRect lineFrame = self.lineView.frame;
    //    // 2.根据进度改变滑块的位置和宽度
    CGFloat moveTotalX = targetTitleBtn.frame.origin.x - sourceTitleBtn.frame.origin.x;
    CGFloat moveX = moveTotalX * progress;
    lineFrame.origin.x = sourceTitleBtn.frame.origin.x + moveX;
    lineFrame.size.width = sourceTitleBtn.frame.size.width + (targetTitleBtn.frame.size.width - sourceTitleBtn.frame.size.width) * progress;
    self.lineView.frame = CGRectMake(lineFrame.origin.x, lineFrame.origin.y, lineFrame.size.width, self.lineView.frame.size.height);
    
    // 3. 处理外界界面左滑右滑标题按钮的选中以及指示器的状态
    if (1.0 != progress) return;
    
    if (fromIndex < toIndex) {
        
        // 让标题判断并滚动到中间
//        [self scrollTitleWithIndex:toIndex];
    } else {
        
        // 右滑
        // 让标题判断并滚动到中间
//        [self scrollTitleWithIndex:toIndex];
        
    }
    
    
}

- (void)titleBtnClick:(UIButton *)sender{
    
    
    [UIView animateWithDuration:.485 animations:^{
        //        UIButton *senderBtn = self.getBtnArr [sender.tag];
        self.lineView.frame = CGRectMake(sender.frame.origin.x, self.contentView.frame.size.height-1, sender.frame.size.width, 1);
        
    }];
    [self scrollTitleWithIndex:sender.tag];
    if (self.scrollPageToIndexBlock) {
        self.scrollPageToIndexBlock(sender.tag);
    }
//    [self scrollPageToIndex:sender.tag];
}
- (void)scrollTitleWithIndex:(NSInteger)index{
    
    // 获取当前选中的标题按钮
    UIButton  *btn = self.getBtnArr[index];
    // 获取当前标题按钮的中心 x 轴
    CGFloat btnCenterX = btn.center.x;
    CGPoint offset = self.titleScrollView.contentOffset;
    // 求将该选中的标题按钮滚动到中间的偏移量
    offset.x = btnCenterX - self.titleScrollView.frame.size.width * 0.5;
    // 左边超出处理
    if (offset.x < 0) offset.x = 0;
    // 右边超出处理
    CGFloat maxTitleOffsetX = self.titleScrollView.contentSize.width - self.titleScrollView.frame.size.width;
    if (offset.x > maxTitleOffsetX ) offset.x = maxTitleOffsetX;
    
    [self.titleScrollView setContentOffset:offset animated:YES];
    
    
}

- (UIScrollView *)titleScrollView{
    
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc]init];
        
        _titleScrollView.delegate = self;
        //    整页滚动
        //        _scrollView.pagingEnabled = YES;
        //    隐藏水平滚动指示条
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        _titleScrollView.backgroundColor = [UIColor greenColor];
    }
    return _titleScrollView;
}
- (UIView *)contentView {
    
    if (!_contentView) {
        
        _contentView =[[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}




- (UIView *)lineView {
    
    if (!_lineView) {
        
        _lineView =[[UIView alloc] init];
        
        _lineView.backgroundColor = [UIColor purpleColor];
    }
    return _lineView;
}
- (NSMutableArray *)getBtnArr{
    if (!_getBtnArr) {
        _getBtnArr = [NSMutableArray array];
    }
    return _getBtnArr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
