//
//  MDMyViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/11/25.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDMyViewController.h"
#import "MDMyViewItem.h"
#import "MX_MASConstraintMaker.h"
#import "View+MASAdditions.h"
#import "MDServiceViewController.h"
#import "MDMyDoctorViewController.h"
#import "MDFeedBackViewController.h"
#import "BRSlogInViewController.h"
#import "MDDataViewController.h"
#import "FileUtils.h"
#define IMAGECACHE  @"IMAGE/"
#import "MDRequestModel.h"
#import "GTMBase64.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "MDMyFocusViewController.h"
#import "GTMBase64.h"
#import "MDSetViewController.h"

@interface MDMyViewController ()<UITableViewDataSource,UITableViewDelegate,sendInfoToCtr>
{
    UITableView * _tableView;
    UIButton *headButton;
    UIImage *image222;
    NSString * headImg;
    NSString * name;
    UILabel * userName;
}

@property (nonatomic,strong) NSMutableArray * dataList;

@end

@implementation MDMyViewController

//对列表数据进行懒加载
-(NSMutableArray *)dataList
{
    if (_dataList == nil) {
        _dataList = [[NSMutableArray alloc] init];
        
//        MDMyViewItem * group0 = [MDMyViewItem itemsWithIcon:@"mydoctor" andTitle:@"我的医生" andRightImage:@"arrow"];
        
        MDMyViewItem * group2 = [MDMyViewItem itemsWithIcon:@"feedback" andTitle:@"意见反馈" andRightImage:@"arrow"];
        
        MDMyViewItem * group3 = [MDMyViewItem itemsWithIcon:@"mydoctor" andTitle:@"我的关注" andRightImage:@"arrow"];
        

        
//        [_dataList addObject:group0];
        [_dataList addObject:group3];
        [_dataList addObject:group2];
        
    }
    return _dataList;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSUserDefaults * stdDefault = [NSUserDefaults standardUserDefaults];
    NSString * str=[stdDefault objectForKey:@"user_name"];
    if ([str length]>0) {
        NSLog(@"%@",str);
        [self reloadData];
        
    }else{
        BRSlogInViewController * logIn=[[BRSlogInViewController alloc] init];
        UINavigationController * nvc=[[UINavigationController alloc] initWithRootViewController:logIn];
        
        nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:nvc animated:YES completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息";
    
    [self setNavigationBarWithrightBtn:@"设置" leftBtn:nil];
//    [self.rightBtn addTarget:self action:@selector(setButton) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn addTarget:self action:@selector(noticeClick) forControlEvents:UIControlEventTouchUpInside];
    [self createView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUserName:) name:@"changeUserName" object:nil] ;
    // Do any additional setup after loading the view.
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeUserName" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)noticeClick
{
    MDSetViewController *avc=[[MDSetViewController alloc] init];
    avc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:avc animated:YES];
    
}

-(void)createView
{
    
    headButton =[[UIButton alloc] init];
    NSLog(@"%@",[NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),[MDUserVO userVO].photoPath]);
    if ([UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),[MDUserVO userVO].photoPath]]) {
        [headButton setBackgroundImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),[MDUserVO userVO].photoPath]] forState:UIControlStateNormal];

    }
    else
    {
        [headButton setBackgroundImage:[UIImage imageNamed:@"个人头像默认"]forState:UIControlStateNormal];
    }
    
    [headButton addTarget:self action:@selector(head:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:headButton];
    
    UIView * nameView = [[UIView alloc] init];
    nameView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:nameView];
    
    [headButton mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(21);
        make.top.equalTo(self.view.mas_top).with.offset(18+TOPHEIGHT);
        make.size.mas_equalTo(CGSizeMake(167.0/750.0*SCREENWIDTH, 167.0/750.0*SCREENWIDTH));
    }];
    
    [nameView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(headButton.mas_right).with.offset(8);
        make.right.equalTo(self.view.mas_right).with.offset(-21);
        make.height.equalTo(headButton.mas_height);
        make.top.equalTo(self.view.mas_top).with.offset(18+TOPHEIGHT);
    }];
    UIImage*img =[UIImage imageNamed:@"按钮框"];
    [nameView setBackgroundColor:[UIColor colorWithPatternImage:img]];
   
    userName=[[UILabel alloc] initWithFrame:CGRectMake(5, 10, appWidth-29-10, 20)];
    userName.text=[MDUserVO userVO].userName;
    
    NSLog(@"~~~~~~userName%@",[MDUserVO userVO].userName);
    
    userName.font=[UIFont boldSystemFontOfSize:16];
    userName.tag = 11;
    
    UILabel * signature=[[UILabel alloc] initWithFrame:CGRectMake(5, 30, appWidth-29-10, 20)];
    signature.text=@"人老心不老";
    signature.textColor=[UIColor grayColor];
    signature.font=[UIFont systemFontOfSize:12];
    [nameView addSubview:userName];
    [nameView addSubview:signature];
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo)];
    [nameView addGestureRecognizer:tapGesture];

    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    //去掉下面多余的线
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(headButton.mas_bottom).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 42, 400));

    }];
}

-(void)reloadData
{
    if ([UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),[MDUserVO userVO].photoPath]]) {
        [headButton setBackgroundImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),[MDUserVO userVO].photoPath]] forState:UIControlStateNormal];
        
    }
    else
    {
        [headButton setBackgroundImage:[UIImage imageNamed:@"个人头像默认"]forState:UIControlStateNormal];
    }
    
    userName.text=[MDUserVO userVO].userName;


}
-(void)head:(UIButton *)head
{
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"请选择图片来源"
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:@"拍照"
                                      otherButtonTitles:@"从相册选择",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        actionSheet.tag=1000;
        [actionSheet showInView:self.view];
    
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
#pragma mark - 代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (SCREENWIDTH-16*2)/(687.0/92.0);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * iden = @"iden";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    MDMyViewItem * item = _dataList[indexPath.section];
    cell.textLabel.text = item.title;
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:item.rightImg]];
    cell.imageView.image = [UIImage imageNamed:item.icon];
    cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
        return cell;
}

//填充每个cell间距的view，使之透明
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 1) {
//        MDServiceViewController * serviceVc = [[MDServiceViewController alloc] init];
//        serviceVc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:serviceVc animated:YES];
//    }
    if(indexPath.section == 0)
    {
//        MDMyDoctorViewController * myDoctorVC = [[MDMyDoctorViewController alloc] init];
//        myDoctorVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:myDoctorVC animated:YES];
        MDMyFocusViewController * myFocusVC = [[MDMyFocusViewController alloc] init];
//        myFocusVC.title  =@"我的关注";
        myFocusVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myFocusVC animated:YES];
    }
//    else if (indexPath.section == 2)
//    {
//        MDFeedBackViewController * feedBackVC = [[MDFeedBackViewController alloc] init];
//        feedBackVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:feedBackVC animated:YES];
//    }
    else if (indexPath.section == 1)
    {
        MDFeedBackViewController * feedBackVC = [[MDFeedBackViewController alloc] init];
                feedBackVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:feedBackVC animated:YES];

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
}
#pragma mark - image picker delegte

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    image222= [[UIImage alloc] init];
    [picker dismissViewControllerAnimated:YES completion:^{}];
    image222 = [info objectForKey:UIImagePickerControllerEditedImage];
    
//    NSData* imageData = UIImageJPEGRepresentation(image222, 0.5);
//    [self uploadImage2Server:imageData callback:^(BOOL erroy, NSDictionary *dict) {
//        NSLog(@"%@---%@",erroy,dict);
//    }];
    
    [self uploadImage2Server:UIImageJPEGRepresentation(image222, 0.5) callback:^(BOOL su, NSDictionary *dic) {
        NSLog(@"dic   %@",dic);
        
        headImg = [dic objectForKey:@"msg"];
        
        MDRequestModel * model = [[MDRequestModel alloc] init];
        model.path = MDPath;
        model.methodNum = 10103;
        model.delegate = self;
        int userId = [[MDUserVO userVO].userID intValue];
        model.parameter = [NSString stringWithFormat:@"%d@`%@",userId,headImg];
        [model starRequest];

    }];
    
    [headButton setBackgroundImage:image222 forState:UIControlStateNormal];
    
    //将头像存入本地
    FileUtils * fileUtil = [FileUtils sharedFileUtils];
    //创建文件下载目录
    NSString * path2 = [fileUtil createCachePath:IMAGECACHE];
    
    NSString *uniquePath=[path2 stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[MDUserVO userVO].userID]];
    BOOL result=[UIImagePNGRepresentation(image222)writeToFile: uniquePath atomically:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [self dismissViewControllerAnimated:YES completion:^{}];
    
}

-(void)Actiondo
{
    MDDataViewController * myDoctorVC = [[MDDataViewController alloc] init];
    myDoctorVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myDoctorVC animated:YES];
}

//接收通知更新username
-(void)changeUserName:(NSNotification *)not
{
    UILabel * nameLab = (UILabel *)[self.view viewWithTag:11];
    nameLab.text = [MDUserVO userVO].userName;
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

#pragma mark - asendInfoToCtrDelegate
-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    MDLog(@"头像设置%@",[[NSString alloc]initWithData:response encoding:NSUTF8StringEncoding]);
    
//    MDLog(@"");
}

@end





































