//
//  MDDrupDetailModel.h
//  MyDoctor
//
//  Created by 巫筠 on 15/12/16.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//
/*
"id": 1,
"photo": "照片",
"medicineBarcode": "条码",
"medicineName": "药品名称",
"commonName": "通用名称",
"function": "功能主治",
"medicinedosage": "用法用量",
"untowardeffect": "不良反应",
"taboo": "禁忌",
"pinyinCode": "拼音码",
"categaryId": 1,
"unit": "单位",
"specification": "规格",
"formulation": "剂型",
"habitat": "产地",
"packageQuantity": 1,
"validity": "有效期",
"qualityStandard": "质量标准",
"managementMode": "经营方式",
"batchNumber": "批号",
"retailPrice": 0,
"purchasePrice": 0,
"wholesalePrice": 0,
"medicineInsuranceId": "12123",
"medicinesource": 1
 */

#import <Foundation/Foundation.h>

@interface MDDrupDetailModel : NSObject

@property (nonatomic,assign) int id;
@property (nonatomic,assign) NSString * photo;
@property (nonatomic,assign) NSString * medicineBarcode;
@property (nonatomic,assign) NSString * medicineName;
@property (nonatomic,assign) NSString * commonName;
@property (nonatomic,assign) NSString * function;
@property (nonatomic,assign) NSString * medicinedosage;
@property (nonatomic,assign) NSString * untowardeffect;
@property (nonatomic,assign) NSString * taboo;
@property (nonatomic,assign) NSString * pinyinCode;
@property (nonatomic,assign) int categaryId;
@property (nonatomic,assign) NSString * unit;
@property (nonatomic,assign) NSString * specification;
@property (nonatomic,assign) NSString * formulation;
@property (nonatomic,assign) NSString * habitat;
@property (nonatomic,assign) int packageQuantity;
@property (nonatomic,assign) NSString * validity;
@property (nonatomic,assign) NSString * qualityStandard;
@property (nonatomic,assign) NSString * managementMode;
@property (nonatomic,assign) NSString * batchNumber;
@property (nonatomic,assign) int retailPrice;
@property (nonatomic,assign) int purchasePrice;
@property (nonatomic,assign) int wholesalePrice;
@property (nonatomic,assign) NSString * medicineInsuranceId;
@property (nonatomic,assign) int medicinesource;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;


@end
