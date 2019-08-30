//
//  PGroupSectionCollectionReusableView.m
//  TPZLK
//
//  Created by  open-roc on 17/6/19.
//  Copyright © 2017年 kuaixun100. All rights reserved.
//

#import "PGroupSectionCollectionReusableView.h"
#import "Masonry.h"
#define WEAKSELF(weakSelf) __weak __typeof(&*self)weakSelf = self
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SIZEWIDTH_X(w,SCREEN_WIDTH)  ((w*1.104)/ (414/SCREEN_WIDTH))
@implementation PGroupSectionCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        WEAKSELF(weakSelf);
        
        //    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //    make.left.mas_equalTo(weakSelf.leftImage.mas_right).offset(SIZEWIDTH_X(6, SCREEN_WIDTH));
        //        make.centerY.equalTo(weakSelf.leftImage.mas_centerY);
        //    }];
        //
        //    [self.clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.right.mas_equalTo(weakSelf.mas_right).offset(SIZEWIDTH_X(-16, SCREEN_WIDTH));
        //        make.centerY.equalTo(weakSelf.mas_centerY).offset(SIZEWIDTH_X(6, SCREEN_WIDTH));
        //    }];
        //
        //    [self addSubview:self.mallHeadView];
        //    [ self.mallHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        //        make.edges.equalTo(weakSelf);
        //
        //    }];
        [self addSubview:self.topBtn];
//        self.topBtn.hidden = YES;
        [self.topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).offset(0);
            make.left.equalTo(weakSelf.mas_left).offset(SIZEWIDTH_X(24, SCREEN_WIDTH));
//            make.right.equalTo(weakSelf.mas_right).offset(0);
            make.bottom.equalTo(weakSelf.mas_bottom).offset(0);
            
            
        }];
        [self addSubview:self.grayView];
        [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).offset(0);
            make.left.equalTo(weakSelf.mas_left).offset(0);
            make.height.mas_equalTo(1);
            make.bottom.equalTo(weakSelf.mas_bottom).offset(0);
            
            
        }];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    self.titleLabel.font = [UIFont systemFontOfSize:SIZEWIDTH_X(16, SCREEN_WIDTH)];
//     self.backgroundColor = [UIColor redColor];
    
 
//    self.titleLabel.font = [UIFont boldSystemFontOfSize:SIZEWIDTH_X(16, SCREEN_WIDTH)];
//    self.clickBtn.titleLabel.font =[UIFont systemFontOfSize:SIZEWIDTH_X(14, SCREEN_WIDTH)];
//
}
//- (void)setShwoOrHeid:(NSString *)shwoOrHeid
//{
//    _shwoOrHeid = shwoOrHeid;
//    if ([shwoOrHeid isEqualToString:@"0"]) {
//            self.topBtn.hidden =YES;
//    }
//   else{
//          self.topBtn.hidden =NO;
//    
//    }
//
//}


- (UIButton *)topBtn{
    if (!_topBtn) {
        
        _topBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _topBtn.backgroundColor = [UIColor whiteColor];
        
        [_topBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_topBtn setTitle:@"换一组" forState:UIControlStateNormal];
        _topBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
       
    }
    return _topBtn;
}
- (UIView *)grayView{
    
    if (!_grayView) {
        _grayView = [[UIView alloc]init];
        _grayView.backgroundColor = [UIColor lightGrayColor];
    }
    return _grayView;
}

@end
