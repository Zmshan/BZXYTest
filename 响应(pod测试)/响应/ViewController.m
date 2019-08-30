//
//  ViewController.m
//  响应
//
//  Created by  open-roc on 2017/10/18.
//  Copyright © 2017年 kuaixun100. All rights reserved.
//

#import "ViewController.h"
#import "People.h"

#import "KCMainViewController.h"

#import "SearchTagListViewController.h"

 #import "ClassificationOfNavigationViewController.h"

#import "tableVCViewController.h"
#import "CoreTextViewController.h"
#import "AddressTableViewController.h"
#import "AddressTableViewControllerTwo.h"
#import "JCBaseViewController.h"
//#import "CFJCBaseViewController.h"
#import "TPScrollViewController.h"
#import "CJViewController.h"
#import "ProgressViewController.h"
#import "ZDatePickerViewViewController.h"
#import "ArrowViewController.h"
#import "TaskMapViewController.h"
#import "JumpAPPViewController.h"

#import "ActivityShareViewController.h"
#import "CoreAnimationViewController.h"
#import "MailComposeViewController.h"

#import "BinaryViewController.h"
#import "ThreadViewController.h"
#import "AlgorithmViewController.h"
#import "StorageViewController.h"
#import "DownLoadViewController.h"
#import "LoginViewController.h"
#import "DaFeiJiViewController.h"
#import "ReboundViewController.h"
#import "RunloopViewController.h"
#import "KVCORKVOViewController.h"
#import "ZCAGradientLayerViewController.h"
#import "ZCAEmitterCellViewController.h"
#import "BezierPathArrowViewController.h"
#import "ZuNiViewController.h"
#import "TestOCViewController.h"
#import "HKHealthStoreViewController.h"
#import "PieViewController.h"
@interface ViewController () <UITableViewDelegate,UITableViewDataSource >
@property (nonatomic, strong)UITableView *jcTableView;
@property (nonatomic,strong) NSMutableArray *jcMuArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    [self.view addSubview:self.jcTableView];
    self.jcTableView.frame = self.view.frame;
    
    
    People * person = [[People alloc]init];
    [person run];
    [person study];
    
    person.runBlock().studyBlock().runBlock().runBlock().runStrBlock(@"hahahhahah");
        People.addRunStrBlock(@"zhijiediaoyong");
//    person.studyBlock().studyBlock().runBlock();
    //    [self testBtn];
    //    [self testBtn1];
    //    [self testBtn2];
    //    [self testBtnTwo];
    //    [self testBtn3];
    //    [self testBtn4];
    //    [self testBtn5];
    
    [self.jcMuArray addObject:@"testBtn1"];
    [self.jcMuArray addObject:@"CoreText"];
    [self.jcMuArray addObject:@"联系人1"];
    [self.jcMuArray addObject:@"联系人2"];
    [self.jcMuArray addObject:@"scrollTitle"];
    [self.jcMuArray addObject:@"scrollTitle2"];
    [self.jcMuArray addObject:@"价格"];
    [self.jcMuArray addObject:@"问卷调查进度条"];
    [self.jcMuArray addObject:@"时间选择"];
    [self.jcMuArray addObject:@"自定义角标View"];
    [self.jcMuArray addObject:@"任务地图"];
    [self.jcMuArray addObject:@"jumpApp"];
    [self.jcMuArray addObject:@"原生分享"];
    [self.jcMuArray addObject:@"图形绘制"];
    [self.jcMuArray addObject:@"邮件"];
    [self.jcMuArray addObject:@"线程"];
    [self.jcMuArray addObject:@"二进制"];
    [self.jcMuArray addObject:@"算法"];
    [self.jcMuArray addObject:@"下载"];
    [self.jcMuArray addObject:@"存储"];
    [self.jcMuArray addObject:@"login"];
    [self.jcMuArray addObject:@"打飞机"];
    [self.jcMuArray addObject:@"弹弹弹"];
    [self.jcMuArray addObject:@"runloop"];
    [self.jcMuArray addObject:@"kvo-kvc"];
    [self.jcMuArray addObject:@"背景渐变色"];
    [self.jcMuArray addObject:@"粒子效果"];
    [self.jcMuArray addObject:@"连线"];
    [self.jcMuArray addObject:@"tab阻尼"];
    [self.jcMuArray addObject:@"OC_Swift混编"];
    [self.jcMuArray addObject:@"健康"];
    [self.jcMuArray addObject:@"饼状图"];
    [self.jcMuArray addObject:@"崩溃"];
    
    [self lodaDate];
    
    [self testLog];
    [self AlertAction];
    
    
}


- (void)AlertAction{
    
    NSString *exceptionLog = [[NSUserDefaults standardUserDefaults] objectForKey:@"exceptionLog"];
    if (exceptionLog) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:exceptionLog preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"exceptionLog"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }];
        UIAlertAction *otherActionA = [UIAlertAction actionWithTitle:@"A复制"style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
            
            NSString * strBuildID = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleIdentifier"];
            UIPasteboard * myPasteboard = [UIPasteboard pasteboardWithName:strBuildID create:YES];
            myPasteboard.string = exceptionLog;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"exceptionLog"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }];
        
        [alertController addAction:otherAction];
        [alertController addAction:otherActionA];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

- (void)lodaDate{
    // 日期格式化类
    
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    // 设置日期格式
    dateformat.dateFormat = @"yyyy-MM-dd";
    
    // NSString * -> NSDate *
    //获取当前时间
    NSDate *dataDay = [NSDate date];
    
    NSString * GuDiDate1212 =@"2018-1-1";
    NSString * GuDiDate =@"2017-1-1";
    
    
    
    //日期格式 转换
    NSString *todayStr = [dateformat stringFromDate:dataDay];
    
    
    NSInteger result = [GuDiDate compare:GuDiDate1212];
    
    if (result==-1) {
        //
        NSLog(@"大于固定时间-1version=%@==%@,",GuDiDate,GuDiDate1212);
        
    }else if (result==0){
        
        NSLog(@"等于固定日期version=%@==%@,",GuDiDate,GuDiDate1212);
        
    }else{
        //        result==1
        NSLog(@"小于固定日期version=%@==%@,",GuDiDate,GuDiDate1212);
    }
    
    //    先判断fist是否存在
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"fist"]) {
        
        
        
    }
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"todayKey"]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"fist"];
    }
    
    if ([self dateDay:dataDay string:GuDiDate]) {
        //        大于或等于
        
        
    }else{
        
        //        小于
    }
    
    
    
    
    
    NSString *string = @"2017-12-27";
    
    // 日期格式化类
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    // 设置日期格式 为了转换成功
    
    format.dateFormat = @"yyyy-MM-dd";
    
    // NSString * -> NSDate *
    
    NSDate *data = [format dateFromString:string];
    
    
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSString *newString = [format stringFromDate:currentDate];
    
    NSString *newString1 = [format stringFromDate:data];
    if([newString isEqualToString:string]){
        NSLog(@"%@,---%@,--%@",data,newString,newString1);
    }
    
    
}
- (BOOL)dateDay:(NSDate *)dateDay string:(NSString *)string{
    [[NSUserDefaults standardUserDefaults]setObject:dateDay forKey:@"todayKey"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    // 日期格式化类
    
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    // 设置日期格式
    dateformat.dateFormat = @"yyyy-MM-dd";
    
    // NSString * -> NSDate *
    //获取当前时间
    NSDate *dataDay = [NSDate date];
    
    
    //日期格式 转换
    NSString *todayStr = [dateformat stringFromDate:dataDay];
    
    
    NSInteger result = [string compare:todayStr];
    
    if (result==-1) {
        //        大于固定时间
        NSLog(@"-1version=%@==%@,",string,todayStr);
        return YES;
    }else if (result==0){
        
        NSLog(@"等于固定日期version=%@==%@,",string,todayStr);
        return YES;
        
    }else{
        // result==1           小于固定日期
        NSLog(@"version=%@==%@,",string,todayStr);
        return NO;
    }
    
}


- (void)testBtn{
    
    UIButton *exemptionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    exemptionBtn.frame = CGRectMake(100, 100, 100, 50);
    exemptionBtn.layer.masksToBounds = YES;
    exemptionBtn.layer.cornerRadius = 4;
    exemptionBtn.backgroundColor = [UIColor blueColor];
    [exemptionBtn setTintColor:[UIColor whiteColor]];
    [exemptionBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [exemptionBtn setTitle:@"TestBtn" forState:UIControlStateNormal];
    [exemptionBtn  addTarget:self action:@selector(Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exemptionBtn];
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy:MM:dd"];
    NSDate *date = [dateFormatter dateFromString:@"2017-12-25"];
    [self compareOneDay:[self getCurrentTime] withAnotherDay:date];
    
    //2、然后将指定日期（此处以2016-09-30-00点为例）转换为同样日期格式，返回NSDate形式

 
}
- (void)testLog{
    NSLog(@"我是类方法");
}
- (void)testBtn1{
    
    UIButton *exemptionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    exemptionBtn.frame = CGRectMake(100, 200, 100, 50);
    exemptionBtn.layer.masksToBounds = YES;
    exemptionBtn.layer.cornerRadius = 4;
    exemptionBtn.backgroundColor = [UIColor blueColor];
    [exemptionBtn setTintColor:[UIColor whiteColor]];
    [exemptionBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [exemptionBtn setTitle:@"CoreText" forState:UIControlStateNormal];
    [exemptionBtn  addTarget:self action:@selector(testBtn1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exemptionBtn];
    
    CGRect oldFrame = self.view.frame;
//    exemptionBtn.layer.anchorPoint = CGPointMake( 0.1f , .1f);
    
    //    self.view.frame = oldFrame;
    float arch  = M_PI_2;
    exemptionBtn.transform = CGAffineTransformMakeRotation(arch);
//    CGFloat max = MAX(self.view.frame.size.width, self.view.frame.size.height);
//    CGFloat min = MIN(self.view.frame.size.width, self.view.frame.size.height);
//    self.view.frame = CGRectMake(0, 0, min, max);

}
- (void)testBtn2{
    
    UIButton *exemptionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    exemptionBtn.frame = CGRectMake(100, 300, 100, 50);
    exemptionBtn.layer.masksToBounds = YES;
    exemptionBtn.layer.cornerRadius = 4;
    exemptionBtn.backgroundColor = [UIColor blueColor];
    [exemptionBtn setTintColor:[UIColor whiteColor]];
    [exemptionBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [exemptionBtn setTitle:@"联系人" forState:UIControlStateNormal];
    [exemptionBtn  addTarget:self action:@selector(testBtn2Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exemptionBtn];
}
- (void)testBtnTwo{
    
    UIButton *exemptionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    exemptionBtn.frame = CGRectMake(300, 300, 100, 50);
    exemptionBtn.layer.masksToBounds = YES;
    exemptionBtn.layer.cornerRadius = 4;
    exemptionBtn.backgroundColor = [UIColor blueColor];
    [exemptionBtn setTintColor:[UIColor whiteColor]];
    [exemptionBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [exemptionBtn setTitle:@"testBtn2" forState:UIControlStateNormal];
    [exemptionBtn  addTarget:self action:@selector(testBtnTwoClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exemptionBtn];
}
- (void)testBtn3{
    
    UIButton *exemptionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    exemptionBtn.frame = CGRectMake(100, 400, 100, 50);
    exemptionBtn.layer.masksToBounds = YES;
    exemptionBtn.layer.cornerRadius = 4;
    exemptionBtn.backgroundColor = [UIColor blueColor];
    [exemptionBtn setTintColor:[UIColor whiteColor]];
    [exemptionBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [exemptionBtn setTitle:@"scrollTitle" forState:UIControlStateNormal];
    [exemptionBtn  addTarget:self action:@selector(testBtn3Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exemptionBtn];
}
- (void)testBtn4{
    
    UIButton *exemptionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    exemptionBtn.frame = CGRectMake(100, 500, 100, 50);
    exemptionBtn.layer.masksToBounds = YES;
    exemptionBtn.layer.cornerRadius = 5;
    exemptionBtn.backgroundColor = [UIColor blueColor];
    [exemptionBtn setTintColor:[UIColor whiteColor]];
    [exemptionBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [exemptionBtn setTitle:@"scrollTitle2" forState:UIControlStateNormal];
    [exemptionBtn  addTarget:self action:@selector(testBtn4Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exemptionBtn];
    
}
- (void)testBtn5{
    
    UIButton *exemptionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    exemptionBtn.frame = CGRectMake(300, 500, 100, 50);
    exemptionBtn.layer.masksToBounds = YES;
    exemptionBtn.layer.cornerRadius = 5;
    exemptionBtn.backgroundColor = [UIColor blueColor];
    [exemptionBtn setTintColor:[UIColor whiteColor]];
    [exemptionBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [exemptionBtn setTitle:@"价格" forState:UIControlStateNormal];
    [exemptionBtn  addTarget:self action:@selector(testBtn5Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exemptionBtn];
    
}
- (void)Clicked:(UIButton *)sender{
//     KCMainViewController * person = [[KCMainViewController alloc]init];
//    UIWindow * window = [UIApplication sharedApplication].keyWindow;
//    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:person];
//    window.rootViewController = nav;
//    [window.navigationController pushViewController:nav animated:YES];
    NSLog(@"TestBtn");
    
    
//    SearchTagListViewController * person = [[SearchTagListViewController alloc]init];
//     ClassificationOfNavigationViewController * person = [[ClassificationOfNavigationViewController alloc]init];
//    [self.navigationController pushViewController:person animated:YES];
//    UIWindow * window = [UIApplication sharedApplication].keyWindow;
//    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:person];
//    window.rootViewController = nav;
    
//
    tableVCViewController * person = [[tableVCViewController alloc]init];
    [self.navigationController pushViewController:person animated:YES];
    

}
- (void)testBtn1Clicked:(UIButton *)sender{
    
  
        CoreTextViewController * person = [[CoreTextViewController alloc]init];
        [self.navigationController pushViewController:person animated:YES];
}

- (void)testBtn2Clicked:(UIButton *)sender{
  
    
    AddressTableViewController * person = [[AddressTableViewController alloc]init];
    person.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:person animated:YES];
    
}
- (void)testBtnTwoClicked:(UIButton *)sender{
    
    
    AddressTableViewControllerTwo * person = [[AddressTableViewControllerTwo alloc]init];
    person.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:person animated:YES];
    
}


- (void)testBtn3Clicked:(UIButton *)sender{
    
   
    
    JCBaseViewController * person = [[JCBaseViewController alloc]init];
    person.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:person animated:YES];
    
}
- (void)testBtn4Clicked:(UIButton *)sender{
    
    
    TPScrollViewController * person = [[TPScrollViewController alloc]init];
    person.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:person animated:YES];
    
}

- (void)testBtn5Clicked:(UIButton *)sender{
    
    CJViewController * person = [[CJViewController alloc]init];
    person.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:person animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//1、首先获取当前日期NSDate形式，指定一个日期格式


#pragma mark -得到当前时间
- (NSDate *)getCurrentTime{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy:MM:dd"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    
    NSLog(@"---------- currentDate == %@",date);
    return date;
}



//3、最后进行比较，将现在的时间与指定时间比较，如果没达到指定日期，返回-1，刚好是这一时间，返回0，否则返回1

- (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy:MM:dd"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        NSLog(@"Date1  is in the future");
        return 1;
        
    }
    else if (result == NSOrderedAscending){
        NSLog(@"Date1 is in the past");
        return -1;
    }
    NSLog(@"Both dates are the same");
    return 0;
    
}


//4、比较


- (UITableView *)jcTableView{
   
    if (!_jcTableView) {
        _jcTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _jcTableView.backgroundColor = [UIColor clearColor];
        //        _jcTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        iOS11TabViewEstimated(_jcTableView);
        _jcTableView.delegate =self;
        _jcTableView.dataSource = self;
    
        _jcTableView.rowHeight = 44;
        _jcTableView.estimatedRowHeight = 44;
        [_jcTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"jcTableViewCell"];
      
    }
    return _jcTableView;
}

#pragma mark numberOfSectionsInTableView:
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark tableView:numberOfRowsInSection:
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.jcMuArray.count;
}

#pragma mark tableView:cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jcTableViewCell"];
    cell.textLabel.text = self.jcMuArray[indexPath.row];
//    cell.textLabel.text = [NSString stringWithFormat:@"加载%ld",(long)indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * headView  = [[UIView alloc]init];
    return headView;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            {
                tableVCViewController * person = [[tableVCViewController alloc]init];
                [self.navigationController pushViewController:person animated:YES];
                
            }
            break;
        case 1:
        {
            CoreTextViewController * person = [[CoreTextViewController alloc]init];
            [self.navigationController pushViewController:person animated:YES];
            
            
        }
            break;
        case 2:
        {
            AddressTableViewController * person = [[AddressTableViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
        }
            break;
        case 3:
        {
           
            AddressTableViewControllerTwo * person = [[AddressTableViewControllerTwo alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
           
        }
            break;
        case 4:
        {
            JCBaseViewController * person = [[JCBaseViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
            
        }
            break;
        case 5:
        {
            TPScrollViewController * person = [[TPScrollViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
           
        }
            break;
        case 6:
        {
       
            CJViewController * person = [[CJViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
        }
            break;
        case 7:
        {
            
            ProgressViewController * person = [[ProgressViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
        }
            break;
        case 8:
        {
            
//            ZDatePickerViewViewController *datePicker = [[ZDatePickerViewViewController alloc]init];
//            datePicker.view.backgroundColor = [UIColor whiteColor];
//            [self.navigationController pushViewController:datePicker animated:YES];
          
            
            
            ZDatePickerViewViewController *datePicker = [[ZDatePickerViewViewController alloc]init];
            datePicker.beginDate = @"2019-04-07 00:00";
            datePicker.endDate = @"2019-04-08 00:00";
            [datePicker beginDate:datePicker.beginDate endDate:datePicker.endDate];
            datePicker.view.backgroundColor = [UIColor whiteColor];
            datePicker.dateBlock = ^(NSString * _Nonnull beginDate, NSString * _Nonnull endDate) {
                NSString * title = self.jcMuArray[8];
                NSString * date = [NSString stringWithFormat:@"%@至%@",beginDate,endDate];
                [self.jcMuArray replaceObjectAtIndex:8 withObject:[NSString stringWithFormat:@"%@%@",title,date]];
                [self.jcTableView reloadData];
            };
            
            
            datePicker.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            [self.view addSubview:datePicker.view];
            [self addChildViewController:datePicker];
            
            
        }
            break;
        case 9:
        {

            ArrowViewController * person = [[ArrowViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
        }
            break;
        case 10:
        {
            
            TaskMapViewController * person = [[TaskMapViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
        }
            break;
        case 11:
        {
            
            JumpAPPViewController * person = [[JumpAPPViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
        }
            break;
        case 12:
        {

            
            ActivityShareViewController * person = [[ActivityShareViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
      
           
        }
            break;
        case 13:
        {
            CoreAnimationViewController * person = [[CoreAnimationViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
            
        }
            break;
        case 14:
        {
            MailComposeViewController *person = [[MailComposeViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
            
        }
            break;
        case 15:
        {
            ThreadViewController *person = [[ThreadViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
            
        }
            break;
            
        case 16:
        {
            BinaryViewController *person = [[BinaryViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
            
            
        }
            break;
        case 17:
        {
            AlgorithmViewController *person = [[AlgorithmViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
            
        }
            break;
        case 18:
        {
            DownLoadViewController *person = [[DownLoadViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
            
        }
            break;
        case 19:
        {
            StorageViewController *person = [[StorageViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
            
        }
            break;
        case 20:
        {
            LoginViewController *person = [[LoginViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
            
        }
            break;
        case 21:
        {
            DaFeiJiViewController *person = [[DaFeiJiViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
            
        }
            break;
        case 22:
        {
            ReboundViewController *person = [[ReboundViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
            
        }
            break;
        case 23:
        {
            RunloopViewController *person = [[RunloopViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
            
        }
             break;
        case 24:
        {
            KVCORKVOViewController *person = [[KVCORKVOViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
            
        }
            
            break;
        case 25:
        {
            ZCAGradientLayerViewController *person = [[ZCAGradientLayerViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
            
        }
            break;
        case 26:
        {
            ZCAEmitterCellViewController *person = [[ZCAEmitterCellViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
            
        }
            break;
        case 27:
        {
            BezierPathArrowViewController *person = [[BezierPathArrowViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
            
        }
            break;
        case 28:
        {
            ZuNiViewController *person = [[ZuNiViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
            
        }
            break;
        case 29:
        {
            TestOCViewController *person = [[TestOCViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
            
        }
            break;
        case 30:
        {
            HKHealthStoreViewController *person = [[HKHealthStoreViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
            
        }
            break;
        case 31:
        {
            PieViewController *person = [[PieViewController alloc]init];
            person.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:person animated:YES];
            
        }
            break;
           
        case 32:
        {
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            [arr addObject:nil];
            
        }
            break;
        default:
            break;
    }

}

- (NSMutableArray *)jcMuArray{
   
    if (!_jcMuArray) {
        _jcMuArray = [NSMutableArray array];
    }
    return _jcMuArray;
}

@end
