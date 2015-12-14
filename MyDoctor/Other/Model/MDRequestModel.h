//
//  MDRequestModel.h
//  MyDoctor
//
//  Created by 巫筠 on 15/12/4.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol sendInfoToCtr <NSObject>

-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path;

@end

@interface MDRequestModel : NSObject
{
    id  response;
}

@property (nonatomic,copy) NSString * path;

@property (nonatomic,copy) NSString * ContentType;

@property (nonatomic,strong) NSDictionary * parameters;

@property (nonatomic,weak) id<sendInfoToCtr>delegate;

-(void)starRequest;


@end



























