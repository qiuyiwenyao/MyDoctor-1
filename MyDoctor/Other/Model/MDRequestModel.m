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
#import "MBProgressHUD.h"


@implementation MDRequestModel

-(void)starRequest
{
    
//    // Configure for text only and offset down
//    hud.mode = MBProgressHUDModeText;
//    hud.labelText = @"Some message...";
//    hud.margin = 10.f;
//    hud.removeFromSuperViewOnHide = YES;
    
    if (_isHideHud) {
        hud = nil;
    }
    else
    {
        hud = [MBProgressHUD showHUDAddedTo:((UIViewController *)self.delegate).view animated:YES];
        [((UIViewController *)self.delegate).view addSubview:hud];
        
        // Regiser for HUD callbacks so we can remove it from the window at the right time
        hud.delegate = self;
        
        if (_hudTitle == nil) {
            hud.labelText = @"正在加载";
        }
        else
        {
            hud.labelText = _hudTitle;
            
        }

    }
    
    
    // Show the HUD while the provided method executes in a new thread
//    [hud showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];



    
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    date = [formatter stringFromDate:[NSDate date]];
    
    NSString * parameters = [NSString stringWithFormat:@"%d@`3@`3@`%@@`1@`3@`%@@`",self.methodNum,date,self.parameter];
    NSLog(@"%@",parameters);
    //参数加密
    parameters = [self GTMEncodeTest:parameters];
    NSLog(@"yi%@",parameters);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    
    [session POST:self.path parameters:@{@"b":parameters} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.delegate sendInfoFromRequest:responseObject andPath:self.path number:self.methodNum];
        [hud hide:YES afterDelay:0];
        NSLog(@"成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
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











