//
//  ConvertImageView.m
//  响应
//
//  Created by open-roc on 2019/4/18.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "ConvertImageView.h"




@implementation ConvertImageView
- (id)initWithFrame:(CGRect)frame BackGroundColor:(UIColor *)backGroundColor Text:(NSString *)text TextColor:(UIColor *)textColor TextFontOfSize:(CGFloat)size{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *backView = [[UIView alloc] initWithFrame:frame];
        backView.backgroundColor = backGroundColor;
        [self addSubview:backView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.text = text;
        label.textColor = textColor;
        label.backgroundColor = backGroundColor;
        label.textAlignment = 1;
        label.font = [UIFont systemFontOfSize:size];
        [backView addSubview:label];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
