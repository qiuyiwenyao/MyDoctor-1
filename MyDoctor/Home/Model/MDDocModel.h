//
//  MDDocModel.h
//  MyDoctor
//
//  Created by 巫筠 on 15/12/24.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDDocModel : NSObject
//"Department": "内科",
//"Telephone": "58392222",
//"Phone": "18234087856",
//"id": 2,
//"RealName": "王跃峰",
//"HospitalName": "天津医院",
//"Detail": "冠心病、脑梗塞、高血压病、支气管炎、肺炎"

//@property (nonatomic,copy) NSString * headImg;
@property (nonatomic,copy) NSString * RealName;
@property (nonatomic,copy) NSString * Department;
@property (nonatomic,copy) NSString * HospitalName;
@property (nonatomic,copy) NSString * Detail;
@property (nonatomic,copy) NSString * Telephone;
@property (nonatomic,copy) NSString * Phone;
@property (nonatomic,assign) int id;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
