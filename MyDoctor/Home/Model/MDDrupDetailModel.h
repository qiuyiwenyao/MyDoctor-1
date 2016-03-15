//
//  MDDrupDetailModel.h
//  MyDoctor
//
//  Created by 巫筠 on 15/12/16.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//
/*
 "id": 3,
 "photo": "http://p3.maiyaole.com/img/50082/50082920/org_org.jpg?a=421394179",
 "medicineName": "美林 布洛芬混悬液 30ml",
 "commonName": "布洛芬混悬液",
 "function": "用于儿童普通感冒或流行性感冒引起的发热。也用于缓解儿童轻至中度疼痛如头痛、关节痛，神经痛，偏头痛，肌肉痛，牙痛。",
 "medicinedosage": "口服，12岁以下小儿用量见下： 1—3岁，体重10—15公斤，一次用量4毫升。4—6岁，体重16—21公斤， 一次用量5毫升。 7—9岁，体重22—27公斤，一次用量8毫升。 10—12岁，体重28—32公斤，一次用量10毫升。 若持续疼痛或发热，可每隔4—6小时重复用药一次，24小时不超过4次。",
 "untowardeffect": "1.少数病人可出现恶心、呕吐、胃烧灼感或轻度消化不良，胃肠道溃疡及出血、转氨酶升高、头痛、头晕、耳鸣、视力模糊、精神紧张、嗜睡、下肢水肿或体重骤增。2.罕见皮疹、过敏性肾炎、膀胱炎、肾病综合症、肾乳头坏死或肾功能衰竭、支气管痉挛。",
 "taboo": "1.对其他非甾体抗炎药过敏者禁用。2.对阿司匹林过敏的哮喘患者禁用。",
 "pinyinCode": "BuLuoFenHunXuanYe",
 "categaryId": 2,
 "unit": "1",
 "specification": "30ml*1瓶/盒",
 "validity": "暂定36个月"
 */

#import <Foundation/Foundation.h>

@interface MDDrupDetailModel : NSObject

//drugstore;
//@property (nonatomic, strong) NSString * title;
//@property (nonatomic, strong) NSString * picture;
//@property (nonatomic, strong) NSString * type;
//@property (nonatomic, strong) NSString * price;
//@property (nonatomic,strong) NSString * amount;

@property (nonatomic,assign) int id;
@property (nonatomic,copy) NSString * photo;
@property (nonatomic,copy) NSString * medicineName;
@property (nonatomic,copy) NSString * commonName;
@property (nonatomic,copy) NSString * function;
@property (nonatomic,copy) NSString * medicinedosage;
@property (nonatomic,copy) NSString * untowardeffect;
@property (nonatomic,copy) NSString * taboo;
@property (nonatomic,copy) NSString * pinyinCode;
@property (nonatomic,assign) int categaryId;
@property (nonatomic,copy) NSString * unit;
@property (nonatomic,copy) NSString * specification;
@property (nonatomic,copy) NSString * validity;
@property (nonatomic,copy) NSString * habitat;
@property (nonatomic,assign) int reserve;//库存
@property (nonatomic,assign) float price;//价格
@property (nonatomic,copy) NSString * plan;//套餐
@property (nonatomic,assign) int amount;//购买数量



-(void)setValue:(id)value forUndefinedKey:(NSString *)key;


@end
