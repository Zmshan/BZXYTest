//
//  FMDBBaseMange.m
//  响应
//
//  Created by open-roc on 2019/8/9.
//  Copyright © 2019 kuaixun100. All rights reserved.
//

#import "FMDBBaseMange.h"
//#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"

#import "ZPersonModel.h"
#import "ZplayModel.h"
#import "ZPersonAndPlayModel.h"

#define DBVersionNum @"DBVersionNum"
static dispatch_once_t onceToken1;
static FMDBBaseMange *_instance = nil;

typedef NS_ENUM(NSInteger, DBVersion) {
    DBVersionV1,    //历史版本
    DBVersionV2,    //当前版本
    DBVersionV3,    //当前版本
};

@interface FMDBBaseMange ()

@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

@end


@implementation FMDBBaseMange


//用户搜索记录的表
static NSString *const userTableName = @"USERSEARCHTABLE";

+ (FMDBBaseMange *)shareInstance {
    
    //    static dispatch_once_t onceToken1;
    dispatch_once(&onceToken1, ^{
        if (_instance == nil) {
            
            _instance = [[FMDBBaseMange alloc] init];
            [_instance dbQueue];
        }
        //        _instance = [[[self class] alloc] init];
        NSLog(@"%@:----创建了",NSStringFromSelector(_cmd));
        
        
    });
    return _instance;
}
+ (id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return _instance;
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    return _instance;
}

- (FMDatabaseQueue *)dbQueue {
    
    
    
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:UserKey] == nil) {
        return nil;
    }else{
        if (!_dbQueue) {//创建路径
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            NSString *documentDirectory = [paths objectAtIndex:0];
            NSString *dbPath = [documentDirectory
                                stringByAppendingPathComponent:
                                [NSString stringWithFormat:@"personTable%@.sqlite",
                                 UserID]];
            _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
            
            if (_dbQueue) {//路径存在 创建用户表
                
                //            用户是否存在  数据库是否存在   不存在 创建
                if (![[NSUserDefaults standardUserDefaults] objectForKey:DBVersionNum]||![[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"personTable%@",UserID]]) {
                    //系统之前没有数据库 新建立表。
                    [self createUserTableIfNeed];
                    //    当前版本
                    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:DBVersionV1] forKey:DBVersionNum];
                    //    不同用户表
                    [[NSUserDefaults standardUserDefaults] setObject:@"personTable"forKey:[NSString stringWithFormat:@"personTable%@",UserID]];
                    
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                }else{
                    
                    DBVersion ver = [[[NSUserDefaults standardUserDefaults] objectForKey:DBVersionNum] integerValue];
                    switch (ver) {
                        case DBVersionV1:{
                            //搜索记录
                            
                            [self.dbQueue inDatabase:^(FMDatabase *db) {
                                
                                NSLog(@"升级V1——V2");
//                                [self changeDBDataV1ToV2:db];
                            } ];
                            
                        }
                        case DBVersionV2:{
                            
                            NSLog(@"升级V2——V3");
                            [self.dbQueue inDatabase:^(FMDatabase *db) {
                                
                            } ];
                            [self  createUserTableIfNeed];
                        }
                        case DBVersionV3:{
                            NSLog(@"升级V3——V4");
                            [self  createUserTableIfNeed];
                        }
                            break;
                        default:
                            break;
                    }
                }
            }
        }else if(_dbQueue){
            NSLog(@"createUserTableIfNeed==%@,%@,%@",[[NSUserDefaults standardUserDefaults] objectForKey:DBVersionNum],[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"TPTable%@",UserID]],UserID);
            
        }
        return _dbQueue;
    }
  
}


//创建用户存储表
- (void)createUserTableIfNeed {
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        if (![self isTableOK:userTableName withDB:db]) {
            
            //搜索记录
            NSString *createTableSQL = @"CREATE TABLE USERSEARCHTABLE (id integer PRIMARY "
            @"KEY autoincrement, user_id integer,user_name text,user_age integer ,user_uid integer,user_kpoid integer, user_qujian text)";
            [db executeUpdate:createTableSQL];
            NSString *createIndexSQL =
            @"CREATE unique INDEX idx_userid ON USERSEARCHTABLE(user_kpoid);";
            [db executeUpdate:createIndexSQL];
            
        }
        
        
        
     }];
}
/*
简要说下三者的区别：
insert into 最普遍的插入，如果表中存在主键相同的数据，执行会报错。
replace into 如果表中存在主键相同的数据则根据主键修改当前主键的数据，反之则插入（存在就修改，反之插入）
insert ignore  如果表中存在主键相同的数据不在插入该条数据，反之则插入（存在则忽略，反之插入）
*/
#pragma mark--插入数据
- (void)insertUserPersonToDB:(ZPersonModel *)person andPlay:(ZplayModel *)playMode{
    if (person.user_id==0||playMode.user_kpoid==0) {
        return;
    }
    NSString *insertSql =
    [NSString stringWithFormat:@"REPLACE INTO %@ (user_id, user_name, user_age,user_kpoid,user_qujian) VALUES (?, ?,?,?,?)",userTableName];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:insertSql, @(person.user_id), person.user_name, @(person.user_age), @(playMode.user_kpoid), playMode.user_qujian];
    }];
}

#pragma mark--修改信息
- (void)updatePlayDataQujian:(NSString *)user_qujian andUser_age:(NSString *)user_age kpointId:(NSString *)kpointId
{

    NSString *sql = [NSString stringWithFormat:@"UPDATE '%@' SET user_qujian = '%@', user_age='%@' WHERE user_kpoid='%@'",userTableName,user_qujian,user_age,kpointId];
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        
        [db executeUpdate:sql, user_qujian,user_age, kpointId];
    }];
}
#pragma mark--删除表中的paly记录
- (void)deleteKpoToDB:(NSString *)user_kpoid andUser_id:(NSString *)user_id {
    if ([user_kpoid length] < 1)
        return;
    NSString *deleteSql =
    [NSString stringWithFormat:@"delete from %@ where user_kpoid = '%@' and user_id = '%@' ",
     userTableName, user_kpoid,user_id];
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:deleteSql];
    }];
}

#pragma mark--删除表中的paly记录
- (void)deleteKpoToDB:(NSString *)user_kpoid{
    if ([user_kpoid length] < 1)
        return;
    NSString *deleteSql =
    [NSString stringWithFormat:@"delete from %@ where user_kpoid = '%@'",
     userTableName, user_kpoid];
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:deleteSql];
    }];
}



#pragma mark--清空表中的所有的play记录
- (BOOL)clearSearchfromDB {
    __block BOOL result = NO;
    NSString *clearSql = [NSString stringWithFormat:@"DELETE FROM %@",userTableName];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:clearSql];
    }];
    return result;
}

/**
 *  获取所有
 *
 */
- (NSMutableArray *)getAllCarsFrom{
    
    NSMutableArray  *carArray = [[NSMutableArray alloc] init];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ ",userTableName]];
        while ([rs next]) {
            ZPersonAndPlayModel *model;
            model = [[ZPersonAndPlayModel alloc] init];
            model.user_id = [[rs stringForColumn:@"user_id"]integerValue];
            model.user_name = [rs stringForColumn:@"user_name"];
            model.user_age = [[rs stringForColumn:@"user_age"] integerValue];
            model.user_kpoid = [[rs stringForColumn:@"user_kpoid"]integerValue];
            model.user_qujian = [rs stringForColumn:@"user_qujian"] ;
            [carArray addObject:model];
        }
        [rs close];
    }];
    
    return carArray;
    
}


/**
 *  获取指定的用户
 *
 */
- (NSMutableArray *)getAllCarsFromUser_id:(NSString *)user_id{
    
    NSMutableArray  *carArray = [[NSMutableArray alloc] init];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ where user_id = %@",userTableName,user_id]];
        while ([rs next]) {
            ZPersonAndPlayModel *model;
            model = [[ZPersonAndPlayModel alloc] init];
            model.user_id = [[rs stringForColumn:@"user_id"]integerValue];
            model.user_name = [rs stringForColumn:@"user_name"];
            model.user_age = [[rs stringForColumn:@"user_age"] integerValue];
            model.user_kpoid = [[rs stringForColumn:@"user_kpoid"]integerValue];
            model.user_qujian = [rs stringForColumn:@"user_qujian"] ;
            [carArray addObject:model];
        }
        [rs close];
    }];
    
    return carArray;
    
}

/**
 *  获取person的指定条件(根据用户id和kpoid)
 *
 */
- (NSMutableArray *)getAllCarsFromUser_id:(NSString *)user_id kpoID:(NSString *)kpoid{
    
    NSMutableArray  *carArray = [[NSMutableArray alloc] init];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ where user_id = %@ and user_kpoid = %@ ",userTableName,user_id,kpoid]];
        while ([rs next]) {
            ZPersonAndPlayModel *model;
            model = [[ZPersonAndPlayModel alloc] init];
            model.user_id = [[rs stringForColumn:@"user_id"]integerValue];
            model.user_name = [rs stringForColumn:@"user_name"];
            model.user_age = [[rs stringForColumn:@"user_age"] integerValue];
            model.user_kpoid = [[rs stringForColumn:@"user_kpoid"]integerValue];
            model.user_qujian = [rs stringForColumn:@"user_qujian"] ;
            [carArray addObject:model];
        }
        [rs close];
    }];
    
    return carArray;
    
}

/**
 *  获取person的指定条件(根据用户id和kpoid)
 *
 */
- (NSMutableArray *)getAllCarsFromUser_id:(NSString *)user_id andAge:(NSString *)age{
    
    NSMutableArray  *carArray = [[NSMutableArray alloc] init];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ where user_id = %@ and user_age = %@ ",userTableName,user_id,age]];
        while ([rs next]) {
            ZPersonAndPlayModel *model;
            model = [[ZPersonAndPlayModel alloc] init];
            model.user_id = [[rs stringForColumn:@"user_id"]integerValue];
            model.user_name = [rs stringForColumn:@"user_name"];
            model.user_age = [[rs stringForColumn:@"user_age"] integerValue];
            model.user_kpoid = [[rs stringForColumn:@"user_kpoid"]integerValue];
            model.user_qujian = [rs stringForColumn:@"user_qujian"] ;
            [carArray addObject:model];
        }
        [rs close];
    }];
    
    return carArray;
    
}




#pragma mark--数据迁移
- (void)changeDBDataV1ToV2:(FMDatabase *)db {
    
    
    // 变更数据库表为一个旧数据表
    NSString *sqlStr = [NSString stringWithFormat:@"ALTER TABLE %@ RENAME TO %@", userTableName, [userTableName stringByAppendingString:@"_Old"]];
    // 执行SQL语句操作
    [db executeUpdate:sqlStr];
    
    NSString *executeStr = [NSString stringWithFormat:@"create table if not exists %@ (id integer PRIMARY "
                            @"KEY autoincrement not null,user_id integer,user_name text,user_age integer ,user_uid integer,user_kpoid integer, user_qujian integer)",userTableName];
    
    BOOL bRet = [db executeUpdate:executeStr];
    if (bRet) {
        // 从旧数据表把旧数据插入新的数据表中
        NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO %@ SELECT * ,'','','' FROM %@", userTableName, [userTableName stringByAppendingString:@"_Old"]];
        [db executeUpdate:insertSql];
        NSString *createIndexSQL =
        @"CREATE unique INDEX idx_userid ON USERSEARCHTABLE(user_kpoid);";
        [db executeUpdate:createIndexSQL];
    }
    // 删除旧的数据表
    [db executeUpdate:[NSString stringWithFormat:@"DROP TABLE %@",[userTableName stringByAppendingString:@"_Old"]]];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:DBVersionV2] forKey:DBVersionNum];
    [[NSUserDefaults standardUserDefaults]synchronize];
}






- (BOOL)isTableOK:(NSString *)tableName withDB:(FMDatabase *)db {
    BOOL isOK = NO;
    FMResultSet *rs =
    [db executeQuery:@"select count(*) as 'count' from sqlite_master where "
     @"type ='table' and name = ?",
     tableName];
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        
        if (0 == count) {
            isOK = NO;
        } else {
            isOK = YES;
        }
    }
    [rs close];
    
    return isOK;
}
     



@end
