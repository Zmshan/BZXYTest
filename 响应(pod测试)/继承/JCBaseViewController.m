//
//  JCBaseViewController.m
//  响应
//
//  Created by open-roc on 2018/12/7.
//  Copyright © 2018 kuaixun100. All rights reserved.
//

#import "JCBaseViewController.h"
#import "Masonry.h"
@interface JCBaseViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView * titleScrollView;
@property (nonatomic,strong) UIView *contentView ;
 @property (nonatomic,strong) UILabel *contentLabel;

@property (nonatomic,strong) UIButton *modelBtn;

@property (nonatomic,strong) UIView *lineView ;
@property (nonatomic,strong) NSMutableArray *getBtnArr;




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

@implementation JCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.titleScrollView];
    
    
    [self testBtn1];
    [self testBtn2];
    
    [self.titleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
    [self.titleScrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.titleScrollView);
        //因为上面的宽高是相对于contentSize的  所以为0  这里需要设置contentView的宽度约束后  scrollView的contentSize.width就会拉伸
//        make.height.equalTo(self.scrollView);
        
    }];

    
//    [self.contentView addSubview:self.contentLabel];
//    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).mas_offset(20);
//        make.top.equalTo(self.contentView).mas_offset(20);
//        make.bottom.equalTo(self.contentView).mas_offset(-20);
//    }];

}


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
    __block CGFloat sizeW = self.view.frame.size.width;
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
    
    [self.view layoutIfNeeded];
    NSLog(@"contentView%f",self.contentView.frame.size.width);
//    CGRect frame = self.contentView.frame;
//    if (self.contentView.frame.size.width<self.view.frame.size.width) {
//        self.contentView.frame = CGRectMake(frame.origin.x, frame.origin.y, self.view.frame.size.width, frame.size.height);
//    }
    
    UIButton *senderBtn = [self.getBtnArr firstObject];
    self.lineView.frame = CGRectMake(senderBtn.frame.origin.x, self.contentView.frame.size.height-1, senderBtn.frame.size.width, 1);
    [self.contentView addSubview:self.lineView];
    
}


- (void)testBtn1{
    
    UIButton *exemptionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    exemptionBtn.frame = CGRectMake(100, 500, 100, 50);
    exemptionBtn.layer.masksToBounds = YES;
    exemptionBtn.layer.cornerRadius = 4;
    exemptionBtn.backgroundColor = [UIColor yellowColor];
    [exemptionBtn setTintColor:[UIColor whiteColor]];
    [exemptionBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [exemptionBtn setTitle:@"model1" forState:UIControlStateNormal];
    [exemptionBtn  addTarget:self action:@selector(modelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exemptionBtn];
}
- (void)testBtn2{
    
    UIButton *exemptionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    exemptionBtn.frame = CGRectMake(250, 500, 100, 50);
    exemptionBtn.layer.masksToBounds = YES;
    exemptionBtn.layer.cornerRadius = 4;
    exemptionBtn.backgroundColor = [UIColor yellowColor];
    [exemptionBtn setTintColor:[UIColor whiteColor]];
    [exemptionBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [exemptionBtn setTitle:@"model2" forState:UIControlStateNormal];
    [exemptionBtn  addTarget:self action:@selector(model2BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exemptionBtn];
}
- (void)modelBtnClicked:(UIButton *)sender{
    NSLog(@"modelBtn1");
    [self loadTitleBtnAddModel:1];
    [self loadViewsBtnAddModel:1];
}
- (void)model2BtnClicked:(UIButton *)sender{
    NSLog(@"modelBtn2");
    [self loadTitleBtnAddModel:2];
    [self loadViewsBtnAddModel:2];
}

#pragma mark - 接口
- (void)setTitleStatusChangeWithProgress:(CGFloat)progress fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
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
        [self scrollTitleWithIndex:toIndex];
    } else {
        
        // 右滑
        // 让标题判断并滚动到中间
        [self scrollTitleWithIndex:toIndex];
        
    }
    
    
}

- (void)titleBtnClick:(UIButton *)sender{
    
    
    [UIView animateWithDuration:.485 animations:^{
//        UIButton *senderBtn = self.getBtnArr [sender.tag];
        self.lineView.frame = CGRectMake(sender.frame.origin.x, self.contentView.frame.size.height-1, sender.frame.size.width, 1);
        
    }];
    [self scrollTitleWithIndex:sender.tag];
    [self scrollPageToIndex:sender.tag];
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
    
    [self setTitleStatusChangeWithProgress:progress fromIndex:sourceIndex toIndex:targetIndex];
    
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

- (UILabel *)contentLabel {

   
    if (!_contentLabel) {
        _contentLabel =[[UILabel alloc] init];
        _contentLabel.textColor = [UIColor brownColor];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = @"我是小标签";
        _contentLabel.backgroundColor =  [UIColor cyanColor];
    }
    return _contentLabel;
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



//*****************************************ViewScroll****************

- (void)loadViewsBtnAddModel:(NSInteger)modelType{
    [self.view addSubview:self.addViewScrollView];
    [self.addViewScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleScrollView.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
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
    
    
    __block CGFloat viewSizeW = self.view.frame.size.width;
    __block CGFloat viewSizWAndJianJu = 20;
    __block CGFloat JianJu = 0;
    __block CGFloat sizeW = self.view.frame.size.width;
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
    
    
    __block UIView * lastBtn = nil;
    [self.viewsArr enumerateObjectsUsingBlock:^(id  _Nonnull sender, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        [self.addViewContentView addSubview:sender];
        //        如果总按钮宽度+间距 小于当前屏幕的宽
        
            if (idx==0) {
                [sender mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.addViewContentView).mas_offset(JianJu);
                    make.top.equalTo(self.addViewContentView).mas_offset(top);
                    make.bottom.equalTo(self.addViewContentView).mas_offset(-bottom);
                    make.width.mas_equalTo(sizeW);
                    make.height.mas_equalTo(100);
                }];
            }else if (idx==btnArr.count-1){
                [sender mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastBtn.mas_right).mas_offset(JianJu);
                    make.right.equalTo(self.addViewContentView.mas_right).mas_offset(-JianJu);
                    make.top.equalTo(self.addViewContentView).mas_offset(top);
                    make.bottom.equalTo(self.addViewContentView).mas_offset(-bottom);
                    make.width.mas_equalTo(sizeW);
                    make.height.mas_equalTo(100);
                }];
            }else{
                [sender mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastBtn.mas_right).mas_offset(JianJu);
                    make.top.equalTo(self.addViewContentView).mas_offset(top);
                    make.bottom.equalTo(self.addViewContentView).mas_offset(-bottom);
                    make.width.mas_equalTo(sizeW);
                    make.height.mas_equalTo(100);
                }];
            }
            lastBtn = sender;
        
    }];
    
    [self.view layoutIfNeeded];
    NSLog(@"addViewContentView%f",self.addViewContentView.frame.size.width);
    CGRect frame = self.addViewContentView.frame;
    if (self.addViewContentView.frame.size.width<self.view.frame.size.width) {
        self.addViewContentView.frame = CGRectMake(frame.origin.x, frame.origin.y, self.view.frame.size.width, frame.size.height);
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
