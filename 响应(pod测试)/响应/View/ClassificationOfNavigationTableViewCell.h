//
//  ClassificationOfNavigationTableViewCell.h
//  响应
//
//  Created by  open-roc on 2018/3/1.
//  Copyright © 2018年 kuaixun100. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ClassificationOfNavigationView.h"
#import "ClassificationOfNavigationCollectionView.h"
@interface ClassificationOfNavigationTableViewCell : UITableViewCell

//@property (nonatomic,strong) ClassificationOfNavigationView * navigationView;

@property (nonatomic,strong) ClassificationOfNavigationCollectionView * navigationView;
@property (nonatomic, assign) NSInteger  sectionCount;
@property (nonatomic, assign) NSInteger  selectedSection;
@property (nonatomic, assign) NSInteger  selectedRow;
@property (nonatomic, strong) NSMutableArray * selectedSectionOneArr;
@property (nonatomic, strong) NSMutableArray *  dataArr;
@property(nonatomic,copy)  void(^eightBlock)(CGFloat sizeHeight,NSInteger selectedSection,NSInteger selectedRow,NSArray *selectedSectionOneArr);
@end
