//
//  MDShopCartSQL.h
//  MyDoctor
//
//  Created by 巫筠 on 16/3/11.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDShopCartSQL : NSObject

-(void)createAttachmentsDBTableWithDrug;
//name text,amount integer,plan text,price float,picture text
-(void)insertInfoWithName:(NSString *)name plan:(NSString *)plan amount:(NSInteger)amount price:(float)price picture:(NSString *)picture;

- (void)selectInfo;
@end
