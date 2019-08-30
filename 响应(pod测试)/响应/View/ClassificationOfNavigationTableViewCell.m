//
//  ClassificationOfNavigationTableViewCell.m
//  响应
//
//  Created by  open-roc on 2018/3/1.
//  Copyright © 2018年 kuaixun100. All rights reserved.
//

#import "ClassificationOfNavigationTableViewCell.h"
#import "Masonry.h"
#define WEAKSELF(weakSelf) __weak __typeof(&*self)weakSelf = self
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SIZEWIDTH_X(w,SCREEN_WIDTH)  ((w*1.104)/ (414/SCREEN_WIDTH))
@implementation ClassificationOfNavigationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
//        WEAKSELF(weakSelf);
        NSLog(@"创建次数22");
        
      
        [self addSubview:self.navigationView];
//        [self.navigationView setUpadteHeightBlock:^(CGFloat sizeHeight,NSInteger selectedSection,NSInteger selectedRow,NSArray *selectedSectionOneArr) {
//
//             NSLog(@"创建次数11");
//
//
//             double delayInSeconds = 0.685;
//             //        WEAKSELF(weakSelf);
//             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//             dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//
//                 if (weakSelf.eightBlock) {
//                     weakSelf.eightBlock(sizeHeight,selectedSection,selectedRow,selectedSectionOneArr);
//                 }
//
//
//        });
//
//        }];
        [self layoutCourseTypeUI];
       
    }
    return self;
}

- (void)layoutCourseTypeUI{
    
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SIZEWIDTH_X(0, SCREEN_WIDTH));
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
   
}
- (void)setSectionCount:(NSInteger)sectionCount{
    _sectionCount = sectionCount;
    
   
}
-(void)setSelectedSection:(NSInteger)selectedSection{
   _selectedSection = selectedSection;
}
- (void)setSelectedSectionOneArr:(NSMutableArray *)selectedSectionOneArr{
    _selectedSectionOneArr = selectedSectionOneArr;
}
- (void)setSelectedRow:(NSInteger)selectedRow{
    _selectedRow =selectedRow;
    
    self.navigationView.selectedSection = self.selectedSection;
    self.navigationView.selectedRow = self.selectedRow;
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"我的学习",@"在线课程",@"培训广场",@"讲师风采",@"1313",@"培训广场",@"讲师风采",nil];
    self.navigationView.sectionCount = self.selectedSectionOneArr.count;
    self.navigationView.selectedArr = self.selectedSectionOneArr;
    
    self.navigationView.arrTitle = arr;
}
- (ClassificationOfNavigationCollectionView *)navigationView{
    
    if (!_navigationView) {
        _navigationView = [[ClassificationOfNavigationCollectionView alloc]init];
        _navigationView.backgroundColor = [UIColor redColor];
        
        NSLog(@"创建次数");
       
        
//        [self.navigationView.arrTitle setArray:arr];
    }
    return _navigationView;
}

//- (ClassificationOfNavigationView *)navigationView{
//
//    if (!_navigationView) {
//        _navigationView = [[ClassificationOfNavigationView alloc]init];
//    }
//    return _navigationView;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
