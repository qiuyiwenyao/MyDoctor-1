//
//  MDShopCartSQL.m
//  MyDoctor
//
//  Created by 巫筠 on 16/3/11.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import "MDShopCartSQL.h"
#import "FMDB.h"

@interface MDShopCartSQL()
@property(nonatomic,strong)FMDatabase *db;
@end

@implementation MDShopCartSQL

-(void)createAttachmentsDBTableWithDrug
{
    NSString *shopCart=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[shopCart stringByAppendingPathComponent:@"ShopCart.sqlite"];
    //2.获得数据库
    FMDatabase *db=[FMDatabase databaseWithPath:fileName];
    //3.打开数据库
    if ([db open]) {
    BOOL result=[db executeUpdate:@"CREATE TABLE IF NOT EXISTS ShopCart (name text,plan text,picture text,price float,amount integer);"];

        if (result) {
            NSLog(@"创表成功");
            
        }else{
            NSLog(@"创表失败");
        }
    }
    self.db=db;
}

-(void)insertInfoWithName:(NSString *)name plan:(NSString *)plan amount:(NSInteger)amount price:(float)price picture:(NSString *)picture
{
    //数据库中不能存放基本类型的数据  必须将基本类型的数据转化成OC的对象
    NSNumber * amountNum = [NSNumber numberWithInteger:amount];
    
    BOOL isSuccess = [self.db executeUpdate:@"insert into ShopCart(name,plan,picture,price,amount) values(?,?,?,?,?)",name,plan,picture,price,amountNum];
    
    if(isSuccess)
    {
        NSLog(@"插入数据成功");
    }
    else
    {
        NSLog(@"插入数据失败%@",self.db.lastErrorMessage);
    }
}

- (void)selectInfo
{
    //<1> 创建sql语句
    NSString * sql = @"select * from ShopCart";
    
    //<2>开始查询
    FMResultSet * result = [self.db executeQuery:sql];
    
    //<3>循环遍历表格 查找name = “张三”的所有信息
    if ([result next])
    {
        NSString * name = [result stringForColumn:@"name"];
        NSString * picture = [result stringForColumn:@"picture"];
        NSString * plan = [result stringForColumn:@"plan"];
        float price = [result doubleForColumn:@"price"];
       NSInteger amount = [result intForColumn:@"amount"];

        NSLog(@"%@  %@  %@  %0.2f  %ld",name,picture,plan,price,(long)amount);
    }
    else
    {
        NSLog(@"查询失败");
    }
}







@end
