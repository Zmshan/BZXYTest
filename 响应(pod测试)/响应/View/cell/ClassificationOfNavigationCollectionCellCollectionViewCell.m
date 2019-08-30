//
//  ClassificationOfNavigationCollectionCellCollectionViewCell.m
//  响应
//
//  Created by  open-roc on 2018/3/1.
//  Copyright © 2018年 kuaixun100. All rights reserved.
//

#import "ClassificationOfNavigationCollectionCellCollectionViewCell.h"
#import "Masonry.h"
#define WEAKSELF(weakSelf) __weak __typeof(&*self)weakSelf = self
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SIZEWIDTH_X(w,SCREEN_WIDTH)  ((w*1.104)/ (414/SCREEN_WIDTH))


@implementation ClassificationOfNavigationCollectionCellCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.titleLab];
        [self addSubview:self.grayView];
        
        [self layoutHomePageUI];
        
        
    }
    return self;
}
- (void)layoutHomePageUI{
    
    WEAKSELF(weakSelf);
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.mas_top).offset(SIZEWIDTH_X(0, SCREEN_WIDTH));
        make.left.equalTo(weakSelf.mas_left).offset(SIZEWIDTH_X(28, SCREEN_WIDTH));
        make.right.equalTo(weakSelf.mas_right).offset(SIZEWIDTH_X(0, SCREEN_WIDTH));
        make.bottom.equalTo(weakSelf.mas_bottom).offset(SIZEWIDTH_X(0, SCREEN_WIDTH));
    }];
    
   
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(0);
        make.left.equalTo(weakSelf.mas_left).offset(0);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(0);
        
        
    }];
}
-(void)setIndexCellRow:(NSInteger)indexCellRow{
    WEAKSELF(weakSelf);
    if (indexCellRow%3==1) {
        [self.grayView mas_updateConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(weakSelf.mas_left).offset(SIZEWIDTH_X(28, SCREEN_WIDTH));
       
        }];
    }else{
        [self.grayView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(weakSelf.mas_left).offset(0);
            
        }];
    }
}
- (UILabel *)titleLab{
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = [UIFont systemFontOfSize:SIZEWIDTH_X(14, SCREEN_WIDTH)];
        _titleLab.textColor = [UIColor lightGrayColor];
        _titleLab.textAlignment = NSTextAlignmentLeft;
//        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}
- (UIView *)grayView{
    
    if (!_grayView) {
        _grayView = [[UIView alloc]init];
        _grayView.backgroundColor = [UIColor lightGrayColor];
    }
    return _grayView;
}

@end
