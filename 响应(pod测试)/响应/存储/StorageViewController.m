//
//  StorageViewController.m
//  响应
//
//  Created by open-roc on 2019/6/28.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "StorageViewController.h"

#import "FMDBBaseMange.h"
#import "ZPersonModel.h"
#import "ZplayModel.h"
#import "ZPersonAndPlayModel.h"

#import "Masonry.h"

@interface StorageViewController ()<UITableViewDelegate,UITableViewDataSource >
@property (nonatomic, strong)UITableView *jcTableView;
@property(nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation StorageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *homeDir = NSHomeDirectory();
    NSLog(@"homeDir%@",homeDir);
    
    
//    self.navigationItem.title = [NSString stringWithFormat:@"当前数量（%ld）", (long)_count];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtn:)];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtn:)];
    self.navigationItem.rightBarButtonItems = @[item,item1];
    
   NSMutableArray *dbArr =  [[FMDBBaseMange shareInstance]getAllCarsFromUser_id:NSStringFormat(@"%d", 123)];
   NSMutableArray *dbArr1 =  [[FMDBBaseMange shareInstance]getAllCarsFromUser_id:NSStringFormat(@"%d", 123) kpoID:NSStringFormat(@"%d", 123)];
    NSMutableArray *dbArr2 =  [[FMDBBaseMange shareInstance]getAllCarsFrom];
    NSLog(@"dbArr%@--dbArr1%@--dbArr2%@",dbArr,dbArr1,dbArr2);
    
    [self.view addSubview:self.jcTableView];
    [self.jcTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.jcTableView.tableFooterView = [[UIView alloc] init];
    self.dataArray = [[FMDBBaseMange shareInstance]getAllCarsFrom];
    
//   self.dataArray =  [[FMDBBaseMange shareInstance]getAllCarsFromUser_id:NSStringFormat(@"%d", 111) andAge:NSStringFormat(@"%d", 30)];
    
}




- (void)rightBtn:(UIBarButtonItem *)item{
    
    NSInteger sj = arc4random()%1000;
    NSInteger age = arc4random()%100;
    
    NSInteger user_kpoid = arc4random()%1000;
    
    
    sj = [UserID integerValue];
    if ([item.title isEqualToString:@"添加"]) {
        ZPersonModel *mode = [[ZPersonModel alloc]init];
        mode.user_id = sj;
        mode.user_name = NSStringFormat(@"小张%ld", (long)sj);
        mode.user_age = age;
        
        ZplayModel *playModel = [[ZplayModel alloc]init];
        playModel.user_kpoid = user_kpoid;
        playModel.user_qujian = @"100-200";
        [[FMDBBaseMange shareInstance] insertUserPersonToDB:mode andPlay:playModel];
    }else if ([item.title isEqualToString:@"删除"]){
        
//        [[FMDBBaseMange shareInstance]deleteKpoToDB:NSStringFormat(@"%d", 123)];
        
//        [[FMDBBaseMange shareInstance]deleteKpoToDB:NSStringFormat(@"%d", 123) andUser_id:NSStringFormat(@"%d", 123)];
    }
    
    self.dataArray = [[FMDBBaseMange shareInstance]getAllCarsFrom];
  
    [self.jcTableView reloadData];
    
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jcTableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"jcTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    ZPersonAndPlayModel *person = self.dataArray[indexPath.row];
    cell.textLabel.text = NSStringFormat(@"%@---%ld----%@",person.user_name,(long)person.user_kpoid,person.user_qujian);
   
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"age: %ld",person.user_age];
    
    
    return cell;
    
    
    
}



/**
 *  设置删除按钮
 *
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        
        ZPersonAndPlayModel *person = self.dataArray[indexPath.row];
        
        
//        [[FMDBBaseMange shareInstance]deleteKpoToDB:NSStringFormat(@"%ld", (long)person.user_kpoid)];
        [[FMDBBaseMange shareInstance]deleteKpoToDB:NSStringFormat(@"%ld", (long)person.user_kpoid) andUser_id:NSStringFormat(@"%ld", (long)person.user_id)];
        
       self.dataArray = [[FMDBBaseMange shareInstance]getAllCarsFrom];
        [self.jcTableView reloadData];
        
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZPersonAndPlayModel *person = self.dataArray[indexPath.row];
    [[FMDBBaseMange shareInstance]updatePlayDataQujian:@"50-100" andUser_age:NSStringFormat(@"%d", 188) kpointId:NSStringFormat(@"%ld", (long)person.user_kpoid)];
    
    self.dataArray = [[FMDBBaseMange shareInstance]getAllCarsFrom];
    [self.jcTableView reloadData];
    

    
}
#pragma mark - Getter
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        
    }
    return _dataArray;
    
}
- (UITableView *)jcTableView{
    
    if (!_jcTableView) {
        _jcTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _jcTableView.backgroundColor = [UIColor clearColor];
        //        _<#jcTableView#>.separatorStyle = UITableViewCellSeparatorStyleNone;
//        iOS11TabViewEstimated(_jcTableView)
        _jcTableView.delegate =self;
        _jcTableView.dataSource = self;
        
//        [_jcTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"jcTableViewCell"];
//        _jcTableView.scrollEnabled = NO;
//        _jcTableView.bounces = NO;
    }
    return _jcTableView;
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
