//
//  ClassificationOfNavigationView.m
//  响应
//
//  Created by  open-roc on 2018/3/1.
//  Copyright © 2018年 kuaixun100. All rights reserved.
//

#import "ClassificationOfNavigationView.h"
@interface ClassificationOfNavigationView()
@property (nonatomic,strong) NSMutableArray *titleArr;
@end
@implementation ClassificationOfNavigationView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _titleArr = [NSMutableArray arrayWithObjects:@"OC",
                     @"Java",
                     @"JavaScript",
                     @"jQuery",
                     @"Python",
                     @"都是语言",
                     @"我都不会",
                     @"CF最牛",
                     @"CF最牛X",
                     @"我都会",
                     @"都是电脑语言",
                     @"PHP",
                     @"网站开发",
                     @"Object-C",nil];
        //创建视图
        [self setupTitleViewbtn];
    }
    return self;
}
- (void)setupTitleViewbtn{
    //拿到屏幕的宽
    CGFloat kScreenW = [UIScreen mainScreen].bounds.size.width;
    
    //间距
    CGFloat padding = 10;
    
    CGFloat titBtnX = 0;
    CGFloat titBtnY = 100;
    CGFloat titBtnH = 40;
    
    for (int i = 0; i < _titleArr.count; i++) {
        UIButton *titBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置按钮的样式
        titBtn.backgroundColor = [UIColor yellowColor];
        [titBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        titBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [titBtn setTitle:_titleArr[i] forState:UIControlStateNormal];
        titBtn.tag = 1000+i;
        [titBtn addTarget:self action:@selector(titBtnClike:) forControlEvents:UIControlEventTouchUpInside];
        
        //计算文字大小
        CGSize titleSize = [_titleArr[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, titBtnH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titBtn.titleLabel.font} context:nil].size;
        CGFloat titBtnW = titleSize.width + 2 * padding;
        //判断按钮是否超过屏幕的宽
        if ((titBtnX + titBtnW) > kScreenW) {
            titBtnX = 0;
            titBtnY += titBtnH + padding;
        }
        //设置按钮的位置
        titBtn.frame = CGRectMake(titBtnX, titBtnY, titBtnW, titBtnH);
        
        titBtnX += titBtnW + padding;
        
        [self addSubview:titBtn];
    }
}
/** 按钮点击事件 */
-(void)titBtnClike:(UIButton *)btn
{
  
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
