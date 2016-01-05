//
//  BRSEndSignlnViewController.m
//  BRSClient
//
//  Created by 张昊辰 on 15/3/10.
//  Copyright (c) 2015年 minxing. All rights reserved.
//

#import "BRSEndSignlnViewController.h"
#import "MX_MASConstraintMaker.h"
#import "View+MASAdditions.h"
#import "MX_MASConstraintMaker.h"
#import "View+MASAdditions.h"
#import "MDConst.h"
#define autoSizeScaleX  (appWidth>320?appWidth/320:1)
#define autoSizeScaleY  (appHeight>568?appHeight/568:1)
#define T4FontSize (15*autoSizeScaleX)
#import "FileUtils.h"
#define IMAGECACHE  @"IMAGE/"
#import "MDRequestModel.h"
#import "MDRequestModel.h"
#import "AFHTTPSessionManager.h"

@interface BRSEndSignlnViewController ()<sendInfoToCtr>

@end

@implementation BRSEndSignlnViewController
{
    UIButton * headButton;
    UIButton * finish;
    UIImage *image222;
    int i;
    NSString * headImg;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    i=0;
    self.view.backgroundColor=[UIColor whiteColor];
    [self sethead];
    [self setNavigationBarWithrightBtn:nil leftBtn:@"navigationbar_back"];

    //返回按钮点击
    [self.leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.title=@"设置头像";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
-(void)sethead
{
    headButton =[[UIButton alloc] init];
    [headButton setBackgroundImage:[UIImage imageNamed:@"注册-添加照片"] forState:UIControlStateNormal];
    [headButton addTarget:self action:@selector(head:) forControlEvents:UIControlEventTouchUpInside];
    finish=[[UIButton alloc] init];
    [finish setBackgroundImage:[UIImage imageNamed:@"按钮页"] forState:UIControlStateNormal];
    [finish addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    [finish setTitle:[NSString stringWithFormat:@"完成"] forState:UIControlStateNormal];
    UILabel * lable=[[UILabel alloc] init];
    lable.text=@"拍照或上传个人头像(可选)";
    lable.font = [UIFont fontWithName:@"STHeiti-Medium" size:7];
    lable.textColor=[UIColor grayColor];
    lable.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:headButton];
    [self.view addSubview:finish];
    [self.view addSubview:lable];
    [headButton mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(90);
        make.size.mas_equalTo(CGSizeMake(100, 100));
//        make.height.mas_equalTo(100);
    }];
    [lable mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(195);
        make.left.equalTo(self.view.mas_left).with.offset(60);
        make.right.equalTo(self.view.mas_right).with.offset(-60);
        make.height.mas_equalTo(40);
    }];
    [finish mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(250);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
        make.height.mas_equalTo(40);
    }];
    
}


-(void)head:(UIButton *)head
{
    if (i==0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择图片来源"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"拍照"
                                  otherButtonTitles:@"从相册选择",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        actionSheet.tag=1000;
        [actionSheet showInView:self.view];
        
    }else if (i==1){
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"请选择图片来源"
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:@"拍照"
                                      otherButtonTitles:@"从相册选择",@"撤销头像",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        actionSheet.tag=1001;
        [actionSheet showInView:self.view];
        
    }
    
    
}
-(void)finish:(UIButton *)finish
{
//    if (!image222) {
//        [[NSNotificationCenter defaultCenter]
//         postNotificationName:@"showBRSMainView" object:self];
//        return;
//    }
    
//    FileUtils * fileUtil = [FileUtils sharedFileUtils];
//    //创建文件下载目录
//    NSString *path = [fileUtil createCachePath:IMAGECACHE];
//    NSUserDefaults * stdDefault = [NSUserDefaults standardUserDefaults];
//    NSString * str=[stdDefault objectForKey:@"user_name"];
//    NSString * user_Id=[stdDefault objectForKey:@"user_Id"];
//    NSString *uniquePath=[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",str]];
//    BOOL result=[UIImagePNGRepresentation(image222)writeToFile: uniquePath atomically:YES];
//    
//    MDRequestModel * model = [[MDRequestModel alloc] init];
//    model.path = MDPath;
//    model.methodNum = 10103;
//    NSString * parameter=[NSString stringWithFormat:@"%@@`%@",user_Id,uniquePath];
//    model.parameter = parameter;
//    model.delegate = self;
//    [model starRequest];
    
    //    NSString * url=[NSString stringWithFormat:@"%@/api/v1/photos.json?auto_save=true",BASE_URL];
//    NSMutableDictionary * attach=[[NSMutableDictionary alloc] init];
//    [attach setObject:uniquePath forKey:@"[uploading][]data"];
//    MXNetModel *netModel = [MXNetModel shareNetModel];
//    [netModel startRequset:@"POST" withURL:url withParams:nil withAttachment:attach withIndicator:YES withCallback:^(id object, MXError *error) {
//        NSLog(@"reply == %@", object);
//        
//        if (result) {
//            if(!error) {
//                NSArray *picArr = (NSArray *)object;
//                NSString *headerUrl = [picArr[0] objectForKey:@"normal_url"];
//                [WBUserVO userVO].userExtVO.avatar_url = headerUrl;
//            }
////            [picker dismissViewControllerAnimated:YES completion:^{}];
//            [[NSNotificationCenter defaultCenter]
//     postNotificationName:@"showBRSMainView" object:self];
//        }
//        //        [self hadeView];
//        
//        NSLog(@"error == %@",error);
//        
//    }];
//
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"back");
    }];

    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==1000) {
        if (buttonIndex == 0) {
            [self camera];
        }else if (buttonIndex == 1) {
            [self PhotoLibrary];
        }
    }else if (actionSheet.tag==1001){
        if (buttonIndex == 0) {
            
            [self camera];
        }else if (buttonIndex == 1) {
            [self PhotoLibrary];
        }else if (buttonIndex == 2){
            [self deletePictur];
        }
    }
    
    
}
-(void)camera
{
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //Input
    NSError *error;
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    //判断是否有输入
    if (!input)
    {
        NSLog(@"error info:%@", error.description);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请手动打开相机访问权限" message:@"设置-->隐私-->相机" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        alert.delegate =self;
        [alert setTag:100];
        [alert show];
        
        return;
    }
    
    UIImagePickerControllerSourceType sourceType =UIImagePickerControllerSourceTypeCamera;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:^{}];//进入照相界面
}
-(void)PhotoLibrary
{
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
//    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = YES;
    [self presentViewController:pickerImage animated:YES completion:^{}];
}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==100) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }
}

-(void)deletePictur
{
    [headButton setBackgroundImage:[UIImage imageNamed:@"注册-添加照片"] forState:UIControlStateNormal];
    i=0;
}
#pragma mark - image picker delegte

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    image222= [[UIImage alloc] init];
    [picker dismissViewControllerAnimated:YES completion:^{}];
    image222 = [info objectForKey:UIImagePickerControllerEditedImage];

    [headButton setBackgroundImage:image222 forState:UIControlStateNormal];
    i=1;
    
    //将头像存入本地
    FileUtils * fileUtil = [FileUtils sharedFileUtils];
    //创建文件下载目录
    NSString * path2 = [fileUtil createCachePath:IMAGECACHE];
    
    NSString *uniquePath=[path2 stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[MDUserVO userVO].userID]];
    NSLog(@"%@",uniquePath);
    BOOL result=[UIImagePNGRepresentation(image222)writeToFile: uniquePath atomically:YES];
    
    //上传头像
    [self uploadImage2Server:UIImageJPEGRepresentation(image222, 0.5) callback:^(BOOL su, NSDictionary *dic) {
        NSLog(@"dic   %@",dic);
        
        headImg = [dic objectForKey:@"msg"];
        
//        设置头像
        MDRequestModel * model = [[MDRequestModel alloc] init];
        model.path = MDPath;
        model.methodNum = 10103;
        model.delegate = self;
        int userId = [[MDUserVO userVO].userID intValue];
        model.parameter = [NSString stringWithFormat:@"%d@`%@",userId,headImg];
        [model starRequest];
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
   
    [self dismissViewControllerAnimated:YES completion:^{}];
    
}

-(void)uploadImage2Server:(NSData *)data callback:(void (^)(BOOL, NSDictionary *))callback
{
    //    NSURL *url = [NSURL URLWithString:@"http://rmabcdef001:8080/CommunityWs/servlet/UploadPhoto"];
    
    //    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //
    //    [manager POST:@"http://111.160.245.75:8082/CommunityWs/servlet/UploadPhoto" parameters:/*@{@"b":@"test222",@"username":@"13662142222"}*/nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    //        //        [formData appendPartWithFileData:data name:@"f1" fileName:@"1234567.jpeg" mimeType:@"image/jpeg"];
    //        [formData appendPartWithFormData:data name:@"f1"];
    //    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        NSLog(@"====");
    //        callback(YES,responseObject);
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"====");
    //        callback(YES,nil);
    //    }];
    
    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //    session.requestSerializer  = [AFJSONRequestSerializer serializer];
    //    session.responseSerializer = [AFJSONResponseSerializer serializer];
    //    [session.requestSerializer setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //    [session.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"encoding"];
    
    [session POST:@"http://111.160.245.75:8082/CommunityWs/servlet/UploadPhoto" parameters:@{@"b":@"test222",@"username":@"13718065686"} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"img" fileName:@"1234567.jpeg" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        [responseObject appendPartWithFormData:data name:@"f1.jpeg"];
        MDLog(@"头像上传成功");
        callback(YES,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MDLog(@"头像失败");
        callback(YES,nil);
    }];
    
    
    //    [session POST:@"http://111.160.245.75:8082/CommunityWs/servlet/UploadPhoto" parameters:@{@"b":@"test222",@"username":@"f1"} progress:^(NSProgress * _Nonnull uploadProgress) {
    //        [uploadProgress appendPartWithFileData:data name:@"img" fileName:@"1234567.jpeg" mimeType:@"image/jpeg"];
    //
    //    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //        [responseObject appendPartWithFormData:data name:@"f1.jpeg"];
    //        NSLog(@"成功");
    //        callback(YES,responseObject);
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //         NSLog(@"失败");
    //        callback(YES,nil);
    //    }];
    
    
    
}

#pragma mark - 请求数据回调

//请求数据回调
-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    NSString * str = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    //回馈数据
    NSLog(@"%@", str);
    
}



@end
