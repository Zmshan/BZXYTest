//
//  TCTableViewCell.m
//  响应
//
//  Created by open-roc on 2018/9/19.
//  Copyright © 2018年 kuaixun100. All rights reserved.
//

#import "TCTableViewCell.h"
#import "Masonry.h"

@implementation TCTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.jcBtn];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-30);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        [self.jcBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.bottom.equalTo(self.contentLabel.mas_bottom).offset(5);
        }];
        
        
        
        
    }
    return self;
}

- (UILabel *)contentLabel {

    
    if (!_contentLabel) {
        _contentLabel =[[UILabel alloc] init];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 0;

        
    }
    return _contentLabel;
}
- (UIButton *)jcBtn{
  
   
    if (!_jcBtn) {
        _jcBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _jcBtn.layer.masksToBounds = YES;
        _jcBtn.layer.cornerRadius = 4;
//        _jcBtn.backgroundColor = [UIColor redColor];
        _jcBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_jcBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_jcBtn setTitle:@"查看化验单》" forState:UIControlStateNormal];
        [_jcBtn  addTarget:self action:@selector(jcBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jcBtn;
}
- (void)jcBtnClicked:(UIButton *)sender{
    NSLog(@"jcBtn");
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
