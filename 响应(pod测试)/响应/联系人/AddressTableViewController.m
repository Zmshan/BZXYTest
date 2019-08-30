//
//  AddressTableViewController.m
//  响应
//
//  Created by open-roc on 2018/11/23.
//  Copyright © 2018 kuaixun100. All rights reserved.
//

#import "AddressTableViewController.h"
#import "Masonry.h"


#import "pinyin.h"

@interface UserInfo : NSObject
@property (nonatomic, strong)   UserInfo *userInfo;
@property (nonatomic, assign)   int userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userSex;
@property (nonatomic, copy) NSString *userLocation;

@end

@implementation UserInfo


@end

@interface AddressTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableDictionary *nameDic;
@property (nonatomic,strong) NSMutableDictionary *numdic;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *modelArray;

@end

@implementation AddressTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.view  addSubview:self.tableView];
    [self pinyin];
    
    
//    NSArray *names = @[@"长沙",@"厦门",@"谢谢",@"111",@"曾志伟",@"张三",@"李四",@"王麻子",@"王五",@"刘备",@"张飞",@"关羽",@"刘玉婵",@"吕布",@"诸葛老神仙",@"陈二狗",@"曹蒹葭",@"白马探花"];
//    NSArray *nums = @[@"1111",@"2222",@"33333",@"222",@"曾志伟1",@"张三1",@"李四2",@"王麻子3",@"王五4",@"刘备5",@"张飞6",@"关羽7",@"刘玉婵4",@"吕布8",@"诸葛老神仙8",@"陈二狗3",@"曹蒹葭2",@"白马探花1"];
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    for ( int i = 0; i<names.count; i++) {
//        [dic setValue:nums[i] forKey:names[i]];
//    }
//    self.numdic = dic;
//    UITableView *tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//
//    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    [self.view  addSubview:tableView];
//    for (NSString *name in names) {
//        //获取汉子的首字母
//        //把中文转拼音
//        NSMutableString *ms = [[NSMutableString alloc] initWithString:name];
//        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
//            NSLog(@"Pingying: %@", ms);
//        }
//        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
//            NSLog(@"Pingying: %@", ms);
//        }
//        NSString * upPinyin2 = [ms uppercaseString];
//        NSString *firstString = [upPinyin2 substringToIndex:1];
//
//        //        NSLog(@"%@--%@--%@",cityName,ms,[ms substringToIndex:1]);
//
//        NSMutableArray * arr = [self.nameDic objectForKey:firstString];
//        if (arr) {
//            [arr addObject:name];
//        }else{//如果没有 则需要创建一个添加到里面
//            [self.nameDic setObject:[@[name] mutableCopy] forKey:firstString];
//        }
//
//    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.nameDic.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //对数组中的字符串进行排序
    NSArray *keys = [self.nameDic.allKeys sortedArrayUsingSelector:@selector(compare:)];
    
    NSString *key = keys[section];
    
    NSArray *citys = self.nameDic[key];
    
    return citys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *keys = [self.nameDic.allKeys sortedArrayUsingSelector:@selector(compare:)];
    
    NSString *key = keys[indexPath.section];
    
    NSArray *citys = self.nameDic[key];
    UserInfo *userInfo = citys[indexPath.row];
//    userInfo.userName;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text =  [NSString stringWithFormat:@"名字:%@ \n 电话：%@ ", userInfo.userName,self.numdic[citys[indexPath.row]]];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
//控制有没有索引
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    
    NSArray *keys = [self.nameDic.allKeys sortedArrayUsingSelector:@selector(compare:)];
    return keys;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray *keys = [self.nameDic.allKeys sortedArrayUsingSelector:@selector(compare:)];
    
    return keys[section];
}
-(NSMutableDictionary *)nameDic{
    if (_nameDic == nil) {
        _nameDic = [NSMutableDictionary dictionary];
    }
    return _nameDic;
}


-(void)pinyin{
    // -------------------- Method 1
    
    NSString *chinese = @"杨";
    
    NSString *firstLetter = [chinese firstLetter];
    printf("firstLetter:%s", [firstLetter UTF8String]);
    
    
    // -------------------- Method 2
    
    //    NSArray *array = @[@"sfes", @"sdfs", @"wang", @"join", @"张飞华", @"张晓乐", @"张斑浩", @"杨万里", @"杨丽华", @"孙晓"];
    NSArray *array = @[@"增产",@"长沙",@"厦门",@"夏雨",@"谢谢",@"111",@"曾志伟",@"张三",@"李四",@"王麻子",@"王五",@"刘备",@"张飞",@"关羽",@"刘玉婵",@"吕布",@"诸葛老神仙",@"陈二狗",@"曹蒹葭",@"白马探花"];
    //获取首字符
    NSDictionary *dic = [array sortedArrayUsingFirstLetter];
    //因为字典的无序，将所有的key取出来之后，重新输出
    NSArray *keys = [[dic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    for (NSString *key in keys) {
        
        NSArray *array = [dic objectForKey:key];
        
        printf("\n%s:\n", [key UTF8String]);
        
        for (NSString *str1 in array) {
            printf("  %s\n", [str1 UTF8String]);
        }
        
    }
    
    // -------------------- Method 3 Dictionary
    
    NSMutableArray *dictArray = [NSMutableArray array];
    for (NSString *name in array) {
        
        NSInteger index = [array indexOfObject:name];
        NSDictionary *userInfo = @{@"sex": @"男", @"name":name, @"index":@(index)};
        
        [dictArray addObject:userInfo];
    }
//    把”#“放在最后一位
    NSMutableArray *resultkArrSort2 = [[NSMutableArray alloc]initWithArray:dictArray];
    if ([resultkArrSort2 containsObject:@"#"]) {
        [resultkArrSort2 removeObject:@"#"];
        [resultkArrSort2 addObject:@"#"];
        
    }
  
    //获取首字符
    NSDictionary *dictDict = [resultkArrSort2 sortedArrayUsingFirstLetterByKeypath:@"name"];
    
    NSLog(@"获取首字符dictArray:%@", dictDict);
    
    // -------------------- Method 4  Model
    
//    NSMutableArray *modelArray = [NSMutableArray array];
    for (int i = 0; i < array.count; i++) {
        NSString *userName = array[i];
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo.userName = userName;
        userInfo.userSex = @"famel";
        userInfo.userLocation = @"北京";
        userInfo.userId = i;
        
        UserInfo *userInfo1 = [[UserInfo alloc] init];
        userInfo.userInfo = userInfo1;
        userInfo1.userName = userName;
        [self.modelArray addObject:userInfo];
    }
    
    NSDictionary *modelDict = [self.modelArray sortedArrayUsingFirstLetterByKeypath:@"userInfo.userName"];
    
    NSLog(@"modelArray:%@", modelDict);
    
    self.nameDic = [[self.modelArray sortedArrayUsingFirstLetterByKeypath:@"userInfo.userName"] mutableCopy];
    // -------------------- Method 5
    NSString * str = @"sdf获取汉字首字母，如果参数既不是汉字也不是英文字母，则返回 @“#”";
    //获取首字符
    printf("获取首字符：%s \n", [[str firstLetter] UTF8String]);
    
    //获取所有汉字的首字符
    printf("获取所有汉字的首字符：%s \n", [[str firstLetters] UTF8String]);
    
    [self.tableView reloadData];

}

- (NSMutableArray *)modelArray{
    
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

@end


