//
//  AddressTableViewControllerTwo.m
//  响应
//
//  Created by open-roc on 2019/1/3.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "AddressTableViewControllerTwo.h"

#import "Masonry.h"
@interface AddressTableViewControllerTwo ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableDictionary *nameDic;
@property (nonatomic,strong) NSMutableDictionary *numdic;

@end

@implementation AddressTableViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *names = @[@"长沙",@"厦门",@"谢谢",@"111",@"曾志伟",@"张三",@"李四",@"王麻子",@"王五",@"刘备",@"张飞",@"关羽",@"刘玉婵",@"吕布",@"诸葛老神仙",@"陈二狗",@"曹蒹葭",@"白马探花"];
    NSArray *nums = @[@"1111",@"2222",@"33333",@"222",@"曾志伟1",@"张三1",@"李四2",@"王麻子3",@"王五4",@"刘备5",@"张飞6",@"关羽7",@"刘玉婵4",@"吕布8",@"诸葛老神仙8",@"陈二狗3",@"曹蒹葭2",@"白马探花1"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for ( int i = 0; i<names.count; i++) {
        [dic setValue:nums[i] forKey:names[i]];
    }
    self.numdic = dic;
    UITableView *tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view  addSubview:tableView];
    for (NSString *name in names) {
        //获取汉子的首字母
        //把中文转拼音
        NSMutableString *ms = [[NSMutableString alloc] initWithString:name];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
            NSLog(@"Pingying: %@", ms);
        }
        if ([[name substringToIndex:1] isEqualToString:@"长"])
        {
            [ms appendString:@"C"];
//            continue;
        }
        if ([[name substringToIndex:1] isEqualToString:@"曾"])
        {
            [ms appendString:@"Z"];
//            continue;
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
            NSLog(@"Pingying: %@", ms);
        }
        NSString * upPinyin2 = [ms uppercaseString];
        NSString *firstString = [upPinyin2 substringToIndex:1];
        
        //        NSLog(@"%@--%@--%@",cityName,ms,[ms substringToIndex:1]);
        
        NSMutableArray * arr = [self.nameDic objectForKey:firstString];
        if (arr) {
            [arr addObject:name];
        }else{//如果没有 则需要创建一个添加到里面
            [self.nameDic setObject:[@[name] mutableCopy] forKey:firstString];
        }
        
    }
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
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text =  [NSString stringWithFormat:@"名字:%@ \n 电话：%@ ", citys[indexPath.row],self.numdic[citys[indexPath.row]]];
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
@end
