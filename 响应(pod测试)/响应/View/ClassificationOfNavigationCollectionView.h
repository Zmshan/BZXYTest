//
//  ClassificationOfNavigationCollectionView.h
//  响应
//
//  Created by  open-roc on 2018/3/1.
//  Copyright © 2018年 kuaixun100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassificationOfNavigationCollectionView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView * classificationOfNavigationView;
@property(nonatomic,strong) NSArray * imageArr ;

@property(nonatomic,strong) NSArray * imageArrTitle;
@property(nonatomic,strong) NSMutableArray  * arrTitle;

@property(nonatomic,strong) NSMutableArray  * copyArrTitleArr;
@property(nonatomic,strong) NSMutableArray  * selectedArr;
@property (nonatomic, strong) NSMutableArray * selectedSectionArr;
@property (nonatomic, assign) NSInteger  sectionCount;

@property (nonatomic, assign) NSInteger  selectedSection;
@property (nonatomic, assign) NSInteger  selectedRow;
@property(nonatomic,copy)  void(^upadteHeightBlock)(CGFloat sizeHeight,NSInteger selectedSection,NSInteger selectedRow,NSArray *selectedSectionOneArr);
@end
