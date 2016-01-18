//
//  DocPatientSQL.m
//  MyDoctor
//
//  Created by 张昊辰 on 16/1/8.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import "DocPatientSQL.h"
#import "FMDB.h"
#import "DocPatientModel.h"

@interface DocPatientSQL ()
@property(nonatomic,strong)FMDatabase *db;
@end

@implementation DocPatientSQL

-(void)createAttachmentsDBTableWithPatient
{
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"Patient.sqlite"];
    //2.获得数据库
    FMDatabase *db=[FMDatabase databaseWithPath:fileName];
    //3.打开数据库
    if ([db open]) {
        BOOL result=[db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_Patient (id text, Phone text NOT NULL, name text,imagePath text);"];
        if (result) {
            NSLog(@"创t_Patient表成功");
        }else{
            NSLog(@"创t_Patient表失败");
        }
    }
    self.db=db;
}

-(void)updatePopAttachmentsDBTable:(NSArray *)attachmentArr{
    
    for(DocPatientModel *item in attachmentArr) {
        FMResultSet *result = [self.db executeQuery:@"select * from t_Patient where Phone = ?", item.phone];
        if ([result next]) {
            BOOL result = [self.db executeUpdate:@"update t_Patient set id=?, name=?, imagePath=? where Phone=?",item.ID, item.Name, item.ImagePath, item.phone];
            if(result) {
                NSLog(@"更新t_mail_attachment数据%@成功", item.Name);
            } else {
                NSLog(@"更新t_mail_attachment数据%@失败", item.Name);
            }
        } else {
        BOOL result = [self.db executeUpdate:@"insert into t_Patient(id, Phone, name, imagePath) values(?,?,?,?)", item.ID, item.phone, item.Name, item.ImagePath];
            if(result) {
                NSLog(@"插入t_mail_attachment数据%@成功", item.Name);
                
            } else {
                NSLog(@"插入t_mail_attachment数据%@失败", item.Name);
            }
            
        }
    }
}

-(NSArray *)getAttachmentswithMailPhone:(NSString *)Phone {
    NSMutableArray *attachmentArray = [NSMutableArray array];
  
        FMResultSet *result = [self.db executeQuery:@"select * from t_Patient where Phone = ?", Phone];
        while ([result next]) {
            DocPatientModel *item = [[DocPatientModel alloc] init];
            item.ID = [result stringForColumn:@"id"];
            item.Name = [result stringForColumn:@"name"];
            item.phone = [result stringForColumn:@"Phone"];
            item.ImagePath = [result stringForColumn:@"imagePath"];
            [attachmentArray addObject:item];
        }
    return attachmentArray;
}


@end
