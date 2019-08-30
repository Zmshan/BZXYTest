//
//  OtherClassificationOfNavigationCollectionView.m
//  响应
//
//  Created by  open-roc on 2018/3/2.
//  Copyright © 2018年 kuaixun100. All rights reserved.
//

#import "OtherClassificationOfNavigationCollectionView.h"

#import "PGroupSectionCollectionReusableView.h"
#import "OtherClassificationOfNavigationCollectionViewCell.h"
#import "Masonry.h"
#define WEAKSELF(weakSelf) __weak __typeof(&*self)weakSelf = self
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SIZEWIDTH_X(w,SCREEN_WIDTH)  ((w*1.104)/ (414/SCREEN_WIDTH))
@implementation OtherClassificationOfNavigationCollectionView
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.otherClassificationOfNavigationView];
        [self layoutUI];
        
        
        
        //        self.imageArr = @[@"hrhome我的学习",@"在线课程",@"培训广场",@"讲师风采"];
        //        self.imageArrTitle = @[@"我的学习",@"在线课程",@"培训广场",@"讲师风采"];
        
        
    }
    return self;
}

- (void)layoutUI{
    
    WEAKSELF(weakSelf);
    //    self.homePageBarCollectionView.backgroundColor = [UIColor grayColor];
    
    [self.otherClassificationOfNavigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf);
        
    }];
    
    
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
//    return self.selectedSectionArr.count;
    return 1;
    
    
}
//行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    
 
        return self.arrTitle.count;
        
   
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    OtherClassificationOfNavigationCollectionViewCell *classificationOfNavigationCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"otherCollectionViewCell" forIndexPath:indexPath];
    classificationOfNavigationCell.indexCellRow = indexPath.row+1;
    classificationOfNavigationCell.titleLab.text = self.arrTitle[indexPath.row];
    
    
    classificationOfNavigationCell.backgroundColor = [UIColor whiteColor];
    return classificationOfNavigationCell;
    
    
    
    
    
}
//协议中的方法，用于返回单元格的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(SCREEN_WIDTH/3, SIZEWIDTH_X(48, SCREEN_WIDTH));
    
    
}

//协议中的方法，用于返回整个CollectionView上、左、下、右距四边的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    
    return UIEdgeInsetsMake(SIZEWIDTH_X(0, SCREEN_WIDTH), SIZEWIDTH_X(0, SCREEN_WIDTH), SIZEWIDTH_X(0, SCREEN_WIDTH), SIZEWIDTH_X(0, SCREEN_WIDTH));
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, SIZEWIDTH_X(0, SCREEN_WIDTH));
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0, SIZEWIDTH_X(0, SCREEN_WIDTH));
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击相应的标签%ld",(long)indexPath.row)   ;
    
}
/*
#pragma mark--   区头
//协议中的方法，用来返回CollectionView的分组头或者分组脚
//参数二：用来区分是分组头还是分组脚
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //重用分组头，因为前边注册过，所以重用一定会成功
    //参数一：用来区分是分组头还是分组脚
    //参数二：注册分组头时指定的ID
    
    
    //    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
    //
    //    }
    PGroupSectionCollectionReusableView *firstHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GroupSectionID" forIndexPath:indexPath];
    //    firstHeader.backgroundColor = [UIColor redColor];
    firstHeader.topBtn.tag = indexPath.section;
    [firstHeader.topBtn setTitle:@". 新人必修" forState:UIControlStateNormal];
    [firstHeader.topBtn addTarget:self action:@selector(firstHeaderClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return firstHeader;
    //    WEAKSELF(weakSelf);
    
    
    
}
 */
- (void)firstHeaderClickBtn:(UIButton *)sender{
    
    if ([self.selectedSectionArr[sender.tag] isEqualToString:@"0"]) {
        
        [self.selectedSectionArr replaceObjectAtIndex:sender.tag withObject:@"1"];
        NSLog(@"1sender.tag%ld==selectedSectionArr%@",(long)sender.tag,self.selectedSectionArr[sender.tag]);
        //
        //        sizeHeight = sizeHeight*self.sectionCount;
        //        高度应该为 每个区的 高度总和   基础高度为每个区头的高度
        //         CGFloat sizeHeight = SIZEWIDTH_X(48, SCREEN_WIDTH)*self.sectionCount;//基础高度
        NSInteger hangShu = self.arrTitle.count/3;
        if (self.arrTitle.count%3!=0) {
            hangShu = hangShu+1;
        }
        
        __block CGFloat zongSizeHeight = hangShu*SIZEWIDTH_X(48, SCREEN_WIDTH);
        zongSizeHeight = zongSizeHeight*self.sectionCount;
        
        [self.selectedSectionArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:@"0"]) {
                zongSizeHeight= zongSizeHeight-hangShu*SIZEWIDTH_X(48, SCREEN_WIDTH);
            }
            
        }];
        //        [UIView performWithoutAnimation:^{
        //            //刷新cell
        //
        //
        //        }];
        //        [self.otherClassificationOfNavigationView reloadData];
        //        [self.otherClassificationOfNavigationView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag]];
        if (self.upadteHeightBlock) {
            self.upadteHeightBlock(zongSizeHeight,self.selectedSection,self.selectedRow,self.selectedSectionArr);
            
        }
        //        double delayInSeconds = 0.685;
        //        //        WEAKSELF(weakSelf);
        //        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        //        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //
        //
        //
        //
        //
        //        });
        
        //        dispatch_async(dispatch_get_main_queue(), ^{
        ////
        //        });
        
    }else if([self.selectedSectionArr[sender.tag] isEqualToString:@"1"]){
        
        [self.selectedSectionArr replaceObjectAtIndex:sender.tag withObject:@"0"];
        NSLog(@"2sender.tag%ld==selectedSectionArr%@",(long)sender.tag,self.selectedSectionArr[sender.tag]);
        
        NSInteger hangShu = self.arrTitle.count/3;
        if (self.arrTitle.count%3!=0) {
            hangShu = hangShu+1;
        }
        
        __block CGFloat zongSizeHeight = hangShu*SIZEWIDTH_X(48, SCREEN_WIDTH);
        zongSizeHeight = zongSizeHeight*self.sectionCount;
        [self.selectedSectionArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:@"0"]) {
                zongSizeHeight= zongSizeHeight-hangShu*SIZEWIDTH_X(48, SCREEN_WIDTH);
            }
            
        }];
        [UIView performWithoutAnimation:^{
            //刷新cell
            
            
        }];
        //        [self.otherClassificationOfNavigationView reloadData];
        //         [self.otherClassificationOfNavigationView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag]];
        if (self.upadteHeightBlock) {
            self.upadteHeightBlock(zongSizeHeight,self.selectedSection,self.selectedRow,self.selectedSectionArr);
            
        }
        //        double delayInSeconds = 0.685;
        //        //        WEAKSELF(weakSelf);
        //        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        //        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //
        //
        //
        //
        //
        //        });
        
        
    }
    
}
- (void)setSectionCount:(NSInteger)sectionCount{
    _sectionCount = sectionCount;
    
}
- (void)setSelectedSection:(NSInteger)selectedSection{
    _selectedSection = selectedSection;
}
- (void)setSelectedRow:(NSInteger)selectedRow{
    _selectedRow = selectedRow;
}
//-(void)setSelectedArr:(NSMutableArray *)selectedArr{
//    _selectedArr = selectedArr;
//    [self.selectedSectionArr setArray:selectedArr];
//
//}
- (void)setArrTitle:(NSMutableArray *)arrTitle{
    
    _arrTitle = arrTitle;
    if (arrTitle.count%3!=0) {
        
    }
    NSInteger yushu = 0; //取出余数
    for (int i=1 ; i<arrTitle.count+1; i++)
    {
        yushu=i%3;
        NSLog(@"yushu%ld",(long)yushu);
    }
    
    NSMutableArray * arr = [NSMutableArray array];
    [arr setArray:arrTitle];
    yushu =3-yushu;//每行3个 3减去余数 得到空缺的个数
    for (int i=0 ; i<yushu; i++)
    {
        [arr addObject:@""];//填补一个假的空白数据
    }
    _arrTitle = arr;
    
    if (self.arrTitle.count==0) {
        return;
    }
    NSLog(@"调用次数");
    if (self.copyArrTitleArr.count==0) {
        [self.copyArrTitleArr setArray:arrTitle];
        
    }else{
        if (arrTitle.count!=0&&self.copyArrTitleArr.count!=0) {
            if([arrTitle isEqual:self.copyArrTitleArr]){
                NSLog(@"相等");
                [self.otherClassificationOfNavigationView reloadData];
                return;
            }else{
                NSLog(@"不相等");
                
            }
        }
    }
    

    NSInteger hangShu = self.arrTitle.count/3;
    if (arrTitle.count%3!=0) {
        hangShu = hangShu+1;
    }
    
    
 
    __block CGFloat zongSizeHeight = hangShu*SIZEWIDTH_X(48, SCREEN_WIDTH);
    zongSizeHeight = zongSizeHeight*self.sectionCount;
//    [self.selectedSectionArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj isEqualToString:@"0"]) {
//            zongSizeHeight= zongSizeHeight-hangShu*SIZEWIDTH_X(48, SCREEN_WIDTH);
//        }
//
//    }];
    double delayInSeconds = 0.685;
    //        WEAKSELF(weakSelf);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        if (self.upadteHeightBlock) {
            self.upadteHeightBlock(zongSizeHeight,self.selectedSection,self.selectedRow,self.selectedSectionArr);
        }
        
        
    });
    //    dispatch_async(dispatch_get_main_queue(), ^{
    
    //    });
    
    //    [self.otherClassificationOfNavigationView reloadData];
}
//- (void)setCellSizeWidthHeight:(NSString *)cellSizeWidthHeight{
//    _cellSizeWidthHeight = cellSizeWidthHeight;
//    [self.homePageBarCollectionView reloadData];
//}
- (UICollectionView *)otherClassificationOfNavigationView{
    
    if (!_otherClassificationOfNavigationView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        
        
        
        
        flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        
        _otherClassificationOfNavigationView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _otherClassificationOfNavigationView.showsHorizontalScrollIndicator = NO;
        _otherClassificationOfNavigationView.dataSource = self;
        _otherClassificationOfNavigationView.delegate = self;
        _otherClassificationOfNavigationView.backgroundColor = [UIColor whiteColor];
        
        [_otherClassificationOfNavigationView registerClass:[OtherClassificationOfNavigationCollectionViewCell class] forCellWithReuseIdentifier:@"otherCollectionViewCell"];
        
//        [_otherClassificationOfNavigationView registerClass:[PGroupSectionCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GroupSectionID"];
        //        通用头部
        //        [_otherClassificationOfNavigationView registerNib:[UINib nibWithNibName:@"PGroupSectionCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GroupSectionID"];
        
        
    }
    
    return _otherClassificationOfNavigationView;
}
- (NSMutableArray *)selectedSectionArr
{
    if (!_selectedSectionArr) {
        
        _selectedSectionArr = [NSMutableArray array];
        
    }
    return _selectedSectionArr;
}
- (NSMutableArray *)copyArrTitleArr
{
    if (!_copyArrTitleArr) {
        
        _copyArrTitleArr = [NSMutableArray array];
        
    }
    return _copyArrTitleArr;
}

@end

