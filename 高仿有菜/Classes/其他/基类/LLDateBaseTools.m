//
//  LLDateBaseTools.m
//  高仿有菜
//
//  Created by JYD on 2016/11/17.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

#import "LLDateBaseTools.h"


@interface LLDateBaseTools()
@property (nonatomic,strong)  FMDatabaseQueue * queue;
@end

@implementation LLDateBaseTools


+(instancetype)sharedTools {
    static LLDateBaseTools *instance =nil;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc]init];
       
    });
    return instance;
}


-(void)initDateBase {
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *sqlFilePath = [path stringByAppendingPathComponent:@"youCai.sqlite"];
    NSLog(@"%@",path);
    self.queue = [FMDatabaseQueue databaseQueueWithPath:sqlFilePath];
    
    [self.queue inDatabase:^(FMDatabase *db) {
        BOOL susscess = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_youCai (id INTEGER NOT NULL ,  title TEXT NOT NULL, buyCount INTEGER DEFAULT 1 ,price INTEGER DEFAULT 0 ,quantity INTEGER DEFAULT 0,imgs TEXT ,unit TEXT)"];
        
        if (susscess) {
            NSLog(@"创表成功");
        }
    }];


}

-(void)inseartDateOrUpdateDate :(int)ID :(int)buyCout :(NSString *)title :(int)quantity :(int )price :(NSString *)imgs :(NSString *)unit{
    
    [self.queue inDatabase:^(FMDatabase *db) {
         FMResultSet * set = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM t_youCai WHERE id= %d",ID]];
        
        if ([set next]) {
            
            [db executeUpdate:[NSString stringWithFormat:@"UPDATE t_youCai SET buyCount= %d WHERE id = %d", buyCout ,ID]];
            
        }else {
         NSString * insertSql = [NSString stringWithFormat:@"INSERT INTO t_youCai (id, title ,buyCount ,price ,quantity ,imgs,unit) VALUES ( %d, '%@',%d ,%d ,%d ,'%@' ,'%@')",ID,title,buyCout ,price,quantity,imgs ,unit];
            
            [db executeQuery:insertSql];
        }
    }];
 
}

-(void)delectDate:(int) ID {
    [self.queue inDatabase:^(FMDatabase *db) {
         NSString *sql = [NSString stringWithFormat:@"DELETE FROM t_youCai WHERE id= %d",ID];
        [db executeUpdate:sql];
    }];

}
-(void)selectDate   {
    
    [self.queue inDatabase:^(FMDatabase *db) {
         NSString *sql = @"SELECT * FROM t_youCai";
        
        FMResultSet * set = [db executeQuery:sql];
        
        while ([set next]) {
            
           
        }
        
      

    }];

}


@end
