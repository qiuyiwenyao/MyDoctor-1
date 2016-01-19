//
//  MDServiceModel.h
//  MyDoctor
//
//  Created by 巫筠 on 16/1/18.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDServiceModel : NSObject

@property (nonatomic,assign) int OrderType;
@property (nonatomic,strong) NSString * UserMsg;
@property (nonatomic,strong) NSString * CareInfoName;
@property (nonatomic,assign) int UserId;
@property (nonatomic,strong) NSString * CreateTime;
@property (nonatomic,assign) int CareInfoId;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;


@end
