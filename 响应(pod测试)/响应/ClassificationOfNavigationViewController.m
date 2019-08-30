//
//  ClassificationOfNavigationViewController.m
//  响应
//
//  Created by  open-roc on 2018/3/1.
//  Copyright © 2018年 kuaixun100. All rights reserved.
//

#import "ClassificationOfNavigationViewController.h"
#import "ClassificationOfNavigationTableViewCell.h"
#import "OtherClassificationOfNavigationTableViewCell.h"
#import "Masonry.h"
#define WEAKSELF(weakSelf) __weak __typeof(&*self)weakSelf = self
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SIZEWIDTH_X(w,SCREEN_WIDTH)  ((w*1.104)/ (414/SCREEN_WIDTH))
@interface ClassificationOfNavigationViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * tabView;
@property (nonatomic,strong)NSMutableArray * dataSourceArr;
@property (nonatomic, strong) NSMutableArray * selectedArr;

@property (nonatomic,strong)NSMutableDictionary *  cellSizeHeightDic;

@property (nonatomic,assign)CGFloat  cellSizeHeight;
//@property (nonatomic,assign)CGFloat  lscellSizeHeight;

@property (nonatomic, strong) NSMutableArray * selectedSectionOneArr;

@property (nonatomic,assign)BOOL  reload;
@end

@implementation ClassificationOfNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.tabView];
//    self.tabView.frame = self.view.bounds;
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
    [self.dataSourceArr addObject:@"应知应会"];
    [self.dataSourceArr addObject:@"关键技能"];
    [self.dataSourceArr addObject:@"应知应会"];
    [self.dataSourceArr addObject:@"新人60天"];
    [self.dataSourceArr  enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.selectedArr addObject:@"0"];
    }];
    
   
    [self.selectedSectionOneArr addObject:@"0"];
    [self.selectedSectionOneArr addObject:@"0"];
    [self.selectedSectionOneArr addObject:@"0"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
}
#pragma mark numberOfSectionsInTableView:
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSourceArr.count;
}

#pragma mark tableView:numberOfRowsInSection:
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([self.selectedArr[section] isEqualToString:@"0"]) {
//        if (section==0) {
//            return 1;
//        }
        return 0;
    }else{
        
      return 1;
    }
    
//    return self.dataSourceArr.count;
    
}
/*
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *forFooter = [[UIView alloc]init];
    forFooter.backgroundColor = WHITEColor;
    
    
    BaseFooterView * footView = [[BaseFooterView  alloc]init];
    
    [forFooter addSubview:footView];
    
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(forFooter.mas_top).offset(SIZEWIDTH_X(8, SCREEN_WIDTH));
        make.left.right.equalTo(forFooter);
        make.bottom.equalTo(forFooter.mas_bottom).offset(1);
        
        
    }];
    
    return forFooter;
    
    
}
 */

#pragma mark tableView:cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF(weakSelf);
    if (indexPath.section==0) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯 确定cell
        ClassificationOfNavigationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //出列可重 的cell
        if (cell == nil) {
        cell = [[ClassificationOfNavigationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        }
       
        //    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"我的学习",@"在线课程",@"培训广场",@"讲师风采",@"1313", nil];
        cell.selectedSectionOneArr =self.selectedSectionOneArr;
        cell.sectionCount = self.selectedSectionOneArr.count;

        cell.selectedSection = indexPath.section;
        
        cell.selectedRow = indexPath.row;
        
        //    cell.navigationView.arrTitle = arr;
        [cell.navigationView setUpadteHeightBlock:^(CGFloat sizeHeight,NSInteger selectedSection,NSInteger selectedRow,NSArray *selectedSectionOneArr) {
            [weakSelf.selectedSectionOneArr setArray: selectedSectionOneArr];
            weakSelf.cellSizeHeight = sizeHeight;
//            weakSelf.lscellSizeHeight =sizeHeight;
            [weakSelf.cellSizeHeightDic setObject:@(sizeHeight) forKey:[NSString stringWithFormat:@"%ldkey",(long)selectedSection]];
            //        NSIndexPath * index = [NSIndexPath indexPathWithIndex:selectedSection];
            //        [self.tabView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
             NSLog(@"回调调用次数");
            NSIndexPath  *indexPath = [NSIndexPath indexPathForRow:selectedRow inSection:selectedSection];
            [self.tabView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            //           [self.tabView reloadSections:[NSIndexSet indexSetWithIndex:selectedSection] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            //        [self.tabView reloadData];
        }];
        cell.backgroundColor = [UIColor greenColor];
    
         return cell;
    }else{
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯 确定cell
        OtherClassificationOfNavigationTableViewCell *otherCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //出列可重 的cell
        if (otherCell == nil) {
            otherCell = [[OtherClassificationOfNavigationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }
       
//        otherCell.selectedSectionOneArr =self.selectedSectionOneArr;
//        otherCell.sectionCount = self.selectedSectionOneArr.count;
        
        otherCell.selectedSection = indexPath.section;
        
        otherCell.selectedRow = indexPath.row;
        
        [otherCell.navigationView setUpadteHeightBlock:^(CGFloat sizeHeight,NSInteger selectedSection,NSInteger selectedRow,NSArray *selectedSectionOneArr) {

            [weakSelf.cellSizeHeightDic setObject:@(sizeHeight) forKey:[NSString stringWithFormat:@"%ldkey",(long)selectedSection]];
            NSLog(@"otherCell回调调用次数");
            NSIndexPath  *indexPath = [NSIndexPath indexPathForRow:selectedRow inSection:selectedSection];
            [self.tabView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
         
        }];
        otherCell.backgroundColor = [UIColor greenColor];
        return otherCell;
    }
 
//    [cell setUpadteHeightBlock:^(CGFloat sizeHeight) {
//        weakSelf.cellSizeHeight = sizeHeight;
//        [self.tabView reloadData];
//    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
     return SIZEWIDTH_X(48, SCREEN_WIDTH);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
     return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
//        return self.cellSizeHeight;
        CGFloat sizeHeight = [[self.cellSizeHeightDic objectForKey:[NSString stringWithFormat:@"%ldkey",(long)indexPath.section]] floatValue];
        return sizeHeight;
    }else{
     
        CGFloat sizeHeight = [[self.cellSizeHeightDic objectForKey:[NSString stringWithFormat:@"%ldkey",(long)indexPath.section]] floatValue];
        return sizeHeight;

    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    点选后立即取消点选状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
   
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor lightGrayColor];
    
    
    UIButton *exemptionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    //        exemptionBtn.frame = CGRectMake(100, 100, 100, 50);
    //        exemptionBtn.layer.masksToBounds = YES;
    //        exemptionBtn.layer.cornerRadius = 4;
    exemptionBtn.backgroundColor = [UIColor lightGrayColor];
    [exemptionBtn setTintColor:[UIColor blueColor]];
    exemptionBtn.tag = section;
    [exemptionBtn setTitle:@"必修" forState:UIControlStateNormal];
    [exemptionBtn  addTarget:self action:@selector(Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:exemptionBtn];
    [exemptionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    
    
    
    
    
    return view;
    
    
}
- (void)Clicked:(UIButton *)sender{
    
    if ([self.selectedArr[sender.tag] isEqualToString:@"0"]) {
        
        [self.selectedArr replaceObjectAtIndex:sender.tag withObject:@"1"];
        //        self.cellSizeHeight = 0.00000;
        [self.tabView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }else{
        
        [self.selectedArr replaceObjectAtIndex:sender.tag withObject:@"0"];
        //        self.cellSizeHeight = self.lscellSizeHeight;
        [self.tabView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
    
}
- (void)firstHeaderClickBtn:(UIButton *)sender{
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tabView{
    if (!_tabView) {
        _tabView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tabView.backgroundColor = [UIColor clearColor];
        _tabView.delegate =self;
        _tabView.dataSource = self;
//        _tabView.scrollEnabled = NO;
//        _tabView.bounces = NO;
        _tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [_tabView registerClass:[ClassificationOfNavigationTableViewCell class] forCellReuseIdentifier:@"ClassificationOfNavigationCell"];
//        [_tabView registerClass:[OtherClassificationOfNavigationTableViewCell class] forCellReuseIdentifier:@"navigationCell"];
        
//        [_tabView registerNib:[UINib nibWithNibName:@"CoursePlayTableViewCell" bundle:nil] forCellReuseIdentifier:@"courPlayseCell"];
    }
    return _tabView;
}
- (NSMutableArray *)dataSourceArr{
    if (!_dataSourceArr) {
        _dataSourceArr = [NSMutableArray array];
    }
    return _dataSourceArr;
}
- (NSMutableArray *)selectedArr{
    if (!_selectedArr) {
        _selectedArr = [NSMutableArray array];
    }
    return _selectedArr;
}
- (NSMutableArray *)selectedSectionOneArr{
    if (!_selectedSectionOneArr) {
        _selectedSectionOneArr = [NSMutableArray array];
    }
    return _selectedSectionOneArr;
}
- (NSMutableDictionary *)cellSizeHeightDic{
    
    if (!_cellSizeHeightDic) {
        _cellSizeHeightDic = [NSMutableDictionary dictionary];
    }
    return _cellSizeHeightDic;
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
