//
//  MDnoticeCenterModel.h
//  MyDoctor
//
//  Created by 巫筠 on 15/12/16.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//
/*  "Content": "123",
 "UserID": 1,
 "TiTle": "123",
 "SendFlag": 0,
 "ID": 1,
 "PicUrl": "123",
 "AddTime": "2015-12-09 20:57:23",
 "NoticeTime": "2015-12-09 20:57:19"*/

#import <Foundation/Foundation.h>

@interface MDnoticeCenterModel : NSObject

@property (nonatomic,assign) int UserID;
@property (nonatomic,strong) NSString * Content;
@property (nonatomic,strong) NSString * TiTle;
@property (nonatomic,assign) int SendFlag;
@property (nonatomic,assign) int ID;
@property (nonatomic,strong) NSString * AddTime;
@property (nonatomic,strong) NSString * NoticeTime;
@property (nonatomic,strong) NSString * PicUrl;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;


@end
