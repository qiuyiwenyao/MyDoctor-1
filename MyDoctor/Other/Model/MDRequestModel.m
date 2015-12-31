//
//  MDRequestModel.m
//  MyDoctor
//
//  Created by 巫筠 on 15/12/4.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDRequestModel.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
//#import "AFNetworkReachabilityManager.h"
//#import "AFHTTPRequestOperationManager.h"
#import "MDConst.h"
#import "GTMBase64.h"


@implementation MDRequestModel

-(void)starRequest
{
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    date = [formatter stringFromDate:[NSDate date]];
    
    NSString * parameters = [NSString stringWithFormat:@"%d@`3@`3@`%@@`1@`3@`%@@`",self.methodNum,date,self.parameter];
    //参数加密
    parameters = [self GTMEncodeTest:parameters];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:self.path parameters:@{@"b":parameters} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate sendInfoFromRequest:responseObject andPath:self.path number:self.methodNum];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MDLog(@"%@",error.description);
    }];
}
//转吗
-(NSString *)GTMEncodeTest:(NSString *)text

{
    
    NSString* originStr = text;
    
    NSString* encodeResult = nil;
    
    NSData* originData = [originStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData* encodeData = [GTMBase64 encodeData:originData];
    
    encodeResult = [[NSString alloc] initWithData:encodeData encoding:NSUTF8StringEncoding];
    
    return encodeResult;
}

@end











