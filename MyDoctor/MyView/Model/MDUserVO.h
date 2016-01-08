//
//  MDUserVO.h
//  MyDoctor
//
//  Created by 张昊辰 on 15/12/16.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDUserVO : NSObject<NSCoding>
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *userID;
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString * photo;
@property (nonatomic,copy) NSString * baseurl;
@property (nonatomic,copy) NSString * photourl;
@property (nonatomic,copy) NSString * photoPath;

+(MDUserVO*)userVO;
+(MDUserVO*) setPersonInfoFromUserInfer:(NSDictionary *)dic;
+(MDUserVO*) convertFromAccountHomeUser:(NSDictionary *)dic;
+(MDUserVO*) registeredFromDignInUser:(NSDictionary *)dic;

-(void)clearUserVO;
+(void)initWithCoder:(MDUserVO *)userVO;

@end
