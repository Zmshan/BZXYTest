//
//  HKHealthStoreViewController.m
//  响应
//
//  Created by open-roc on 2019/8/23.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "HKHealthStoreViewController.h"
#import <HealthKit/HealthKit.h>
#import "Masonry.h"
@interface HKHealthStoreViewController ()
@property (nonatomic, strong)  UILabel *stepCountUnitLabel;
@property (nonatomic, strong)  UILabel *stepCountValueLabel;
@end

@implementation HKHealthStoreViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.title =@"健康数据HealthKit";
    
    [self.view addSubview: self.stepCountUnitLabel];
    [self.view addSubview: self.stepCountValueLabel];
    
    [self.stepCountUnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.left.right.equalTo(self.view);
        
        
    }];
    
    [self.stepCountValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stepCountUnitLabel.mas_bottom).offset(40);
        make.left.right.equalTo(self.view);
    }];
    
    if ([HKHealthStore isHealthDataAvailable]) {

        NSLog(@"查看是否授权-YES");

    }else{
        NSLog(@"查看是否授权-NO");
    }
    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
    NSSet *readObjectTypes = [NSSet setWithObjects:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount], nil];
    [healthStore requestAuthorizationToShareTypes:nil readTypes:readObjectTypes completion:^(BOOL success, NSError *error) {
        //进行一些操作
    }];

//    获取健康步数
    HKSampleType *sampleType = [HKSampleType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:nil endDate:nil options:HKQueryOptionStrictStartDate];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:YES];
    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc] initWithSampleType:sampleType predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:@[sortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if(!error && results) {
            for(HKQuantitySample *samples in results) {
                NSLog(@"获取健康步数A-####%@ 至 %@ : %@", samples.startDate, samples.endDate, samples.quantity);
            }
        } else {
            //error
        }
    }];
    [healthStore executeQuery:sampleQuery];


//    数据采集
// 有时候需求并不需要了解这么详尽的数据，只希望获取每小时、每天或者每月的步数，那么我们就需要用到另一个新类HKStatisticsCollectionQuery进行数据的分段采集
    HKQuantityType *quantityType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = 1;
    HKStatisticsCollectionQuery *collectionQuery = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:quantityType quantitySamplePredicate:nil options: HKStatisticsOptionCumulativeSum | HKStatisticsOptionSeparateBySource anchorDate:[NSDate dateWithTimeIntervalSince1970:0] intervalComponents:dateComponents];
    collectionQuery.initialResultsHandler = ^(HKStatisticsCollectionQuery *query, HKStatisticsCollection * __nullable result, NSError * __nullable error) {
        for (HKStatistics *statistic in result.statistics) {
            NSLog(@"获取健康B#####\n%@ 至 %@", statistic.startDate, statistic.endDate);
            for (HKSource *source in statistic.sources) {
                if ([source.name isEqualToString:[UIDevice currentDevice].name]) {
                     double count = [[statistic sumQuantityForSource:source] doubleValueForUnit:[HKUnit countUnit]];
                    NSLog(@"获取健康BB%@ -- CC%f",source, count);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.stepCountUnitLabel.text = [NSString stringWithFormat:@"日期：%@ 至 %@", statistic.startDate, statistic.endDate];
                        self.stepCountValueLabel.text = [NSString stringWithFormat:@"步数：%f",count];
                    });
                }
            }
        }
    };
    [healthStore executeQuery:collectionQuery];
    
}




/*
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.stepCountUnitLabel];
    [self.view addSubview: self.stepCountValueLabel];
    
    [self.stepCountUnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.left.right.equalTo(self.view);
        
        
    }];
    
    [self.stepCountValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stepCountUnitLabel.mas_bottom).offset(40);
        make.left.right.bottom.equalTo(self.view);
    }];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Set up an HKHealthStore, asking the user for read/write permissions. The profile view controller is the
    // first view controller that's shown to the user, so we'll ask for all of the desired HealthKit permissions now.
    // In your own app, you should consider requesting permissions the first time a user wants to interact with
    // HealthKit data.
    if ([HKHealthStore isHealthDataAvailable]) {
        NSSet *writeDataTypes = [self dataTypesToWrite];
        NSSet *readDataTypes = [self dataTypesToRead];
        
        [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
            if (!success) {
                NSLog(@"You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: %@. If you're using a simulator, try it on a device.", error);
                
                return;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateStepCountLabel];
            });
        }];
    }
}
#pragma mark - HealthKit Permissions

// Returns the types of data that Fit wishes to write to HealthKit.
// 写入数据
- (NSSet *)dataTypesToWrite
{
    HKQuantityType *dietaryCalorieEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed]; // 膳食能量
    HKQuantityType *activeEnergyBurnType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned]; // 活动能量
    HKQuantityType *heightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight]; // 身高
    HKQuantityType *weightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass]; // 体重
    
    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]; // 步数
    
    return [NSSet setWithObjects:dietaryCalorieEnergyType, activeEnergyBurnType, heightType, weightType, stepCountType, nil];
}

// Returns the types of data that Fit wishes to read from HealthKit.
// 读取数据
- (NSSet *)dataTypesToRead
{
    HKQuantityType *dietaryCalorieEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed]; // 膳食能量
    HKQuantityType *activeEnergyBurnType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned]; // 活动能量
    HKQuantityType *heightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight]; // 身高
    HKQuantityType *weightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass]; // 体重
    HKCharacteristicType *birthdayType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth]; // 出生日期
    HKCharacteristicType *biologicalSexType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex]; // 性别
    
    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]; // 步数
    
    return [NSSet setWithObjects:dietaryCalorieEnergyType, activeEnergyBurnType, heightType, weightType, birthdayType, biologicalSexType, stepCountType, nil];
}

//读取步数数据
- (void)updateStepCountLabel
{
    self.stepCountUnitLabel.text = @"步数 (健康+App步)";
    self.stepCountValueLabel.text = @"0";
    
    HKQuantityType *stepCountType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    //NSSortDescriptors用来告诉healthStore怎么样将结果排序。
    NSSortDescriptor *start = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    NSSortDescriptor *end = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    // 当天时间段
    NSPredicate *todayPredicate = [self predicateForSamplesToday];
    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc] initWithSampleType:stepCountType predicate:todayPredicate limit:HKObjectQueryNoLimit sortDescriptors:@[start, end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        //打印查询结果
        NSLog(@"resultCount = %ld result = %@",results.count,results);
        double deviceStepCounts = 0.f;
        double appStepCounts = 0.f;
        for (HKQuantitySample *result in results) {
            HKQuantity *quantity = result.quantity;
            HKUnit *stepCount = [HKUnit countUnit];
            double count = [quantity doubleValueForUnit:stepCount];
            // 实例数据
            //            "50 count \"Fit\" (1) 2016-07-11 17:43:03 +0800 2016-07-11 17:43:03 +0800",
            //            "26 count \"你的设备名\" (9.3.1) \"iPhone\" 2016-07-11 15:19:33 +0800 2016-07-11 15:19:41 +0800",
            
            //            26：result.quantity
            //            count：单位，还有其它kg、m等，不同单位使用不同HKUnit
            //            \"Fit\"：result.source.name
            //            (9.3.1)：result.device.softwareVersion，App写入的时候是空的
            //            \"iPhone\"：result.device.model
            //            2016-07-11 15:19:33 +0800：result.startDate
            //            2016-07-11 15:19:41 +0800：result.endDate
            
            
            // 区分手机自动计算步数和App写入的步数
            if ([result.source.name isEqualToString:[UIDevice currentDevice].name]) {
                // App写入的数据result.device.name为空
                if (result.device.name.length > 0) {
                    deviceStepCounts += count;
                }
                else {
                    appStepCounts += count;
                }
            }
            else {
                appStepCounts += count;
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *deviceStepCountsString = [NSNumberFormatter localizedStringFromNumber:@(deviceStepCounts) numberStyle:NSNumberFormatterNoStyle];
            NSString *stepCountsString = [NSNumberFormatter localizedStringFromNumber:@(appStepCounts) numberStyle:NSNumberFormatterNoStyle];
            NSString *totalCountsString = [NSNumberFormatter localizedStringFromNumber:@(deviceStepCounts+appStepCounts) numberStyle:NSNumberFormatterNoStyle];
            
            NSString *text = [NSString stringWithFormat:@"%@+%@=%@", deviceStepCountsString, stepCountsString, totalCountsString];
            self.stepCountValueLabel.text = text;
        });
        
    }];
    //执行查询
    [self.healthStore executeQuery:sampleQuery];
}

// 当天时间段
- (NSPredicate *)predicateForSamplesToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *now = [NSDate date];
    
    NSDate *startDate = [calendar startOfDayForDate:now];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    
    return [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
}

//写入步数数据

- (void)saveStepCountIntoHealthStore:(double)stepCount
{
    // Save the user's step count into HealthKit.
    HKUnit *countUnit = [HKUnit countUnit];
    HKQuantity *countUnitQuantity = [HKQuantity quantityWithUnit:countUnit doubleValue:stepCount];
    
    HKQuantityType *countUnitType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSDate *now = [NSDate date];
    
    HKQuantitySample *stepCountSample = [HKQuantitySample quantitySampleWithType:countUnitType quantity:countUnitQuantity startDate:now endDate:now];
    
    [self.healthStore saveObject:stepCountSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the step count sample %@. In your app, try to handle this gracefully. The error was: %@.", stepCountSample, error);
            abort();
        }
        
        [self updateStepCountLabel];
    }];
}






*/
- (UILabel *)stepCountUnitLabel {
    
    if (!_stepCountUnitLabel) {
        _stepCountUnitLabel =[[UILabel alloc] init];
        _stepCountUnitLabel.textColor = [UIColor greenColor];
        _stepCountUnitLabel.font = [UIFont systemFontOfSize:SIZEWIDTH_X(14, SCREEN_WIDTH)];
        _stepCountUnitLabel.textAlignment = NSTextAlignmentCenter;
        _stepCountUnitLabel.numberOfLines = 0;
        
    }
    return _stepCountUnitLabel;
}
- (UILabel *)stepCountValueLabel {
    
    if (!_stepCountValueLabel) {
        _stepCountValueLabel =[[UILabel alloc] init];
        _stepCountValueLabel.textColor =  [UIColor greenColor];
        _stepCountValueLabel.font = [UIFont systemFontOfSize:SIZEWIDTH_X(14, SCREEN_WIDTH)];
        _stepCountValueLabel.textAlignment = NSTextAlignmentCenter;
        _stepCountValueLabel.numberOfLines = 0;
        
    }
    return _stepCountValueLabel;
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
