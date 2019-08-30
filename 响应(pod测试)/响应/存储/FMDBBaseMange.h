//
//  FMDBBaseMange.h
//  响应
//
//  Created by open-roc on 2019/8/9.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ZPersonModel,ZplayModel;
@interface FMDBBaseMange : NSObject
+ (FMDBBaseMange *)shareInstance;
- (void)insertUserPersonToDB:(ZPersonModel *)person andPlay:(ZplayModel *)playMode;

- (void)updatePlayDataQujian:(NSString *)user_qujian andUser_age:(NSString *)user_age kpointId:(NSString *)kpointId;

- (void)deleteKpoToDB:(NSString *)user_kpoid andUser_id:(NSString *)user_id ;

- (void)deleteKpoToDB:(NSString *)user_kpoid;
#pragma mark--清空表中的所有的play记录
- (BOOL)clearSearchfromDB;

- (NSMutableArray *)getAllCarsFrom;
- (NSMutableArray *)getAllCarsFromUser_id:(NSString *)user_id;
- (NSMutableArray *)getAllCarsFromUser_id:(NSString *)user_id kpoID:(NSString *)kpoid;
- (NSMutableArray *)getAllCarsFromUser_id:(NSString *)user_id andAge:(NSString *)age;
@end

NS_ASSUME_NONNULL_END
