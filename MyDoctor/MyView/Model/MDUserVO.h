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

+(MDUserVO*)userVO;
+(MDUserVO*) convertFromAccountHomeUser:(NSDictionary *)dic;
+(MDUserVO*) registeredFromDignInUser:(NSDictionary *)dic;

-(void)clearUserVO;
+(void)initWithCoder:(MDUserVO *)userVO;

@end
