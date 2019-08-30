//
//  ZDatePickerViewViewController.m
//  响应
//
//  Created by open-roc on 2019/5/7.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "ZDatePickerViewViewController.h"
#import "Masonry.h"
@interface ZDatePickerViewViewController ()
@property (nonatomic,strong) UILabel *startingTimeLabel;
@property (nonatomic,strong) UILabel *endTimeLabel;
@property (nonatomic,strong) UILabel *centerLabel;
@property (nonatomic,strong) UIButton *startingTimeBtn;
@property (nonatomic,strong) UIButton *endTimeBtn;
@property (nonatomic,strong) UILabel *currentSettingTimeLabel;//当前选择修改日期的提示标签

@property (nonatomic,strong) UIButton *cancelBtn;//取消
@property (nonatomic,strong) UIButton *completeBtn;//完成
//创建对象
@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, assign) NSInteger  selectedDateBtnTag;//1是起始 2是结束
@end

@implementation ZDatePickerViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view addSubview:self.startingTimeLabel];
//    [self.view addSubview:self.centerLabel];
//    [self.view addSubview:self.endTimeLabel];
//    self.startingTimeLabel.text = @"2019-04-07 00:00";
//    self.endTimeLabel.text = @"2019-04-08 00:00";
//    [self.startingTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).offset(100);
//        make.left.equalTo(self.view.mas_left).offset(30);
//
//    }];
//    [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).offset(100);
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.left.equalTo(self.startingTimeLabel.mas_right);
//        make.width.mas_equalTo(30);
//    }];
//    [self.endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).offset(100);
//        make.left.equalTo(self.centerLabel.mas_right);
//        make.right.equalTo(self.view.mas_right).offset(-30);
//    }];
    
    [self.view addSubview:self.startingTimeBtn];
    [self.view addSubview:self.centerLabel];
    [self.view addSubview:self.endTimeBtn];
    [self.view addSubview:self.currentSettingTimeLabel];
    [self.view addSubview:self.cancelBtn];
    [self.view addSubview:self.completeBtn];
    
    
    [self.startingTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cancelBtn.mas_bottom).offset(30);
        make.left.equalTo(self.view.mas_left).offset(30);
        make.height.mas_equalTo(40);
    }];
    [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.startingTimeBtn.mas_centerY);
        make.left.equalTo(self.startingTimeBtn.mas_right);
        make.width.mas_equalTo(30);
    }];
    [self.endTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startingTimeBtn.mas_top);
        make.left.equalTo(self.centerLabel.mas_right);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.height.mas_equalTo(40);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.left.equalTo(self.view.mas_left).offset(30);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
    }];
    [self.completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
    }];
    [self.currentSettingTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.startingTimeBtn.mas_bottom).offset(40);
        make.height.mas_equalTo(40);
    }];

    
    
    self.selectedDateBtnTag = 1;
    UIDatePicker *picker = [[UIDatePicker alloc]init];
    picker.backgroundColor = [UIColor blueColor];
    //设置地区: zh-中国
    picker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    
    //设置日期模式(Displays month, day, and year depending on the locale setting)
    picker.datePickerMode = UIDatePickerModeDateAndTime;
    // 设置当前显示时间
    [picker setDate:[NSDate date] animated:YES];
    
//    // 设置显示最大时间（此处为当前时间）
//    [picker setMinimumDate:[NSDate date]];
//    // 设置显示最大时间（此处为当前时间）
//    [picker setMaximumDate:[NSDate date]];
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:10];//设置最大时间为：当前时间推后十年
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    [comps setYear:-10];//设置最小时间为：当前时间前推十年
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    [picker setMaximumDate:maxDate];
    [picker setMinimumDate:minDate];
   
   
    //设置时间格式
    //监听DataPicker的滚动
    [picker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    
    self.datePicker =picker;
    [self.view addSubview:picker];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.currentSettingTimeLabel.mas_bottom).offset(0);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)beginDate:(NSString *)beginDat endDate:(NSString *)endDate{
    self.startingTimeBtn.layer.borderColor = [UIColor blueColor].CGColor;
    [self.startingTimeBtn setTitle:beginDat forState:UIControlStateNormal];
    [self.endTimeBtn setTitle:endDate forState:UIControlStateNormal];
    self.currentSettingTimeLabel.text = @"请选择起始时间";
}

- (void)dateChange:(UIDatePicker *)datePicker {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //设置时间格式
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateStr = [formatter  stringFromDate:datePicker.date];
    
    if (self.selectedDateBtnTag ==1) {
       [self.startingTimeBtn setTitle:dateStr forState:UIControlStateNormal];
       
    }else{
       [self.endTimeBtn setTitle:dateStr forState:UIControlStateNormal];
    }
    
    
 
}
-(int)compareDate:(NSString*)date01 withDate:(NSString*)date02{
    
    int ci;
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *dt1 = [[NSDate alloc]init];
    
    NSDate *dt2 = [[NSDate alloc]init];
    
    dt1 = [df dateFromString:date01];
    
    dt2 = [df dateFromString:date02];
    
    NSComparisonResult result = [dt1 compare:dt2];
    
    switch (result)
    
    {
            
            //date02比date01大
            
        case NSOrderedAscending:
            ci=1;
            NSLog(@"date02比date01大%d", ci);
            break;
            
            //date02比date01小
            
        case NSOrderedDescending:
            ci=-1;
            NSLog(@"date02比date01小%d", ci);
            break;
            
            //date02=date01
            
        case NSOrderedSame:
            ci=0;
            NSLog(@"date02=date01%d", ci);
            break;
            
        default: NSLog(@"erorr dates %@, %@", dt2, dt1);break;
            
    }
    
    return ci;
    
}

- (UILabel *)startingTimeLabel {
    
    if (!_startingTimeLabel) {
        _startingTimeLabel =[[UILabel alloc] init];
        _startingTimeLabel.textColor = [UIColor grayColor];
        _startingTimeLabel.font = [UIFont systemFontOfSize:14];
        _startingTimeLabel.textAlignment = NSTextAlignmentCenter;
        _startingTimeLabel.layer.borderColor = [UIColor grayColor].CGColor;
        _startingTimeLabel.layer.borderWidth = 1;
    }
    return _startingTimeLabel;
}
- (UILabel *)centerLabel {
    
    if (!_centerLabel) {
        _centerLabel =[[UILabel alloc] init];
        _centerLabel.textColor = [UIColor grayColor];
        _centerLabel.font = [UIFont systemFontOfSize:14];
        _centerLabel.textAlignment = NSTextAlignmentCenter;
        _centerLabel.text = @"至";
    }
    return _centerLabel;
}
- (UILabel *)endTimeLabel {
    
    if (!_endTimeLabel) {
        _endTimeLabel =[[UILabel alloc] init];
        _endTimeLabel.textColor = [UIColor grayColor];
        _endTimeLabel.font = [UIFont systemFontOfSize:14];
        _endTimeLabel.textAlignment = NSTextAlignmentCenter;
        _endTimeLabel.layer.borderColor = [UIColor grayColor].CGColor;
        _endTimeLabel.layer.borderWidth = 1;
    }
    return _endTimeLabel;
}


- (UIButton *)startingTimeBtn{
   
   
    if (!_startingTimeBtn) {
        _startingTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _startingTimeBtn.tag = 1;
        _startingTimeBtn.backgroundColor = [UIColor whiteColor];
        _startingTimeBtn.layer.borderWidth = 1;
        _startingTimeBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _startingTimeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_startingTimeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_startingTimeBtn setImage:[UIImage imageNamed:@"icon_like"] forState:UIControlStateNormal];
        [_startingTimeBtn  addTarget:self action:@selector(startingTimeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startingTimeBtn;
}
- (void)startingTimeBtnClicked:(UIButton *)sender{
    NSLog(@"startingTimeBtn");
    self.currentSettingTimeLabel.text = @"请选择起始时间";
    self.selectedDateBtnTag = sender.tag;
    self.startingTimeBtn.layer.borderColor = [UIColor blueColor].CGColor;
    self.endTimeBtn.layer.borderColor = [UIColor grayColor].CGColor;
}

- (UIButton *)endTimeBtn{
    
    if (!_endTimeBtn) {
        _endTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _endTimeBtn.tag = 2;
        _endTimeBtn.backgroundColor = [UIColor whiteColor];
        _endTimeBtn.layer.borderWidth = 1;
        _endTimeBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _endTimeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_endTimeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_endTimeBtn setImage:[UIImage imageNamed:@"icon_like"] forState:UIControlStateNormal];
        [_endTimeBtn  addTarget:self action:@selector(endTimeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _endTimeBtn;
}
- (void)endTimeBtnClicked:(UIButton *)sender{
    NSLog(@"endTimeBtnClicked");
    self.currentSettingTimeLabel.text = @"请选择结束时间";
    self.selectedDateBtnTag = sender.tag;
    self.startingTimeBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.endTimeBtn.layer.borderColor = [UIColor blueColor].CGColor;
}
- (UILabel *)currentSettingTimeLabel {
  
    if (!_currentSettingTimeLabel) {
        _currentSettingTimeLabel =[[UILabel alloc] init];
        _currentSettingTimeLabel.textColor = [UIColor blackColor];
        _currentSettingTimeLabel.backgroundColor = [UIColor blueColor];
        _currentSettingTimeLabel.font = [UIFont systemFontOfSize:18];
        _currentSettingTimeLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _currentSettingTimeLabel;
}

- (UIButton *)cancelBtn{
    
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.backgroundColor = [UIColor blueColor];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelBtn setImage:[UIImage imageNamed:@"icon_like"] forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn  addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (void)cancelBtnClicked:(UIButton *)sender{
    NSLog(@"cancelBtnClicked");
    self.currentSettingTimeLabel.hidden = YES;
    self.view.hidden = YES;
}

- (UIButton *)completeBtn{
    
    if (!_completeBtn) {
        _completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _completeBtn.backgroundColor = [UIColor blueColor];
        _completeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_completeBtn setImage:[UIImage imageNamed:@"icon_like"] forState:UIControlStateNormal];
        [_completeBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_completeBtn  addTarget:self action:@selector(completeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _completeBtn;
}
- (void)completeBtnClicked:(UIButton *)sender{
    NSString *beginDate = self.startingTimeBtn.currentTitle;
    NSString *endDate = self.endTimeBtn.currentTitle;
    NSLog(@"completeBtnClicked%@=%@",beginDate,endDate);

    
   NSInteger dateCompare = [self compareDate:beginDate withDate:endDate];
    if (dateCompare==-1) {
        return; //结束日期小于起始日期
    }
   self.currentSettingTimeLabel.hidden = YES;
   self.view.hidden = YES;
    if (self.dateBlock) {
        
        self.dateBlock(beginDate,endDate);
    }
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
