//
//  MDLectureModel.h
//  MyDoctor
//
//  Created by 巫筠 on 15/12/4.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDLectureModel : NSObject

@property (nonatomic,assign) int id;
@property (nonatomic,copy) NSString * healthEducateName;//讲座标题
@property (nonatomic,copy) NSString * participateInPeople;//接受教育的人群
@property (nonatomic,copy) NSString * starttime;
@property (nonatomic,copy) NSString * endtime;
@property (nonatomic,copy) NSString * addree;
@property (nonatomic,copy) NSString * purpose;
@property (nonatomic,copy) NSString * company;//主办单位
@property (nonatomic,copy) NSString * content;
@property (nonatomic,assign) int professionId;
@property (nonatomic,copy) NSString * professionName;//医疗专家姓名（通过下拉框选择）
@property (nonatomic,assign) int partPeopleNumber;
@property (nonatomic,copy) NSString * phone;
@property (nonatomic,copy) NSString * person;//联系人

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;


/*
 "id": 1,
 "healthEducateName": "健康讲座",
 "participateInPeople": "接受教育的人群",
 "starttime": "2015-11-30 21:10:53",
 "endtime": "2015-12-03 21:11:00",
 "content": "内容",
 "addree": "地点",
 "purpose": "目的",
 "company": "主办单位",
 "professionId": 1,
 "professionName": "\t医疗专家姓名（通过下拉框选择）",
 "partPeopleNumber": 100,
 "phone": "13800001111",
 "person": "联系人"
 */



@end
