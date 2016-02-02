//
//  MDRequestModel.h
//  MyDoctor
//
//  Created by 巫筠 on 15/12/4.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@protocol sendInfoToCtr <NSObject>

-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num;

@end

@interface MDRequestModel : NSObject<MBProgressHUDDelegate>
{
    id  response;
    MBProgressHUD *hud;
}

@property (nonatomic,copy) NSString * path;

@property (nonatomic,copy) NSString * ContentType;

@property (nonatomic,strong) NSString * parameter;

@property (nonatomic,strong) NSString * hudTitle;//等待文字

@property (nonatomic,assign) int methodNum;

@property (nonatomic,weak) id<sendInfoToCtr>delegate;

@property (nonatomic,assign) BOOL isHideHud;

-(void)starRequest;


@end



























