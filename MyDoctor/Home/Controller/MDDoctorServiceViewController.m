//
//  MDDoctorServiceViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/12/24.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//h

#import "MDDoctorServiceViewController.h"
#import "MDDoctorServiceCell.h"
#import "MDMoreDocViewController.h"
#import "MDHospitalViewController.h"
#import "MDDocModel.h"
#import "MDRequestModel.h"
#import "UIImageView+WebCache.h"
#import "MDHomeViewController.h"
#import "FileUtils.h"
#import "DocPatientSQL.h"
#import "DocPatientModel.h"
#define IMAGECACHE  @"PatientsIMAGE/"

@interface MDDoctorServiceViewController ()<UITableViewDataSource,UITableViewDelegate,sendInfoToCtr>
{
    UITableView * _tableView;
    UIView * _headerView;
    UIView * _headerView1;

}

@property (nonatomic,strong) NSMutableArray * dataSource;

@end

@implementation MDDoctorServiceViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"寻医";
    
    BRSSysUtil *util = [BRSSysUtil sharedSysUtil];
    [util setNavigationLeftButton:self.navigationItem target:self selector:@selector(backBtnClick) image:[UIImage imageNamed:@"navigationbar_back"] title:nil];
    
    [self createView];

    
    [self requestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newMessage:) name:@"newMessage" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteRedButton:) name:@"deleteRedButton" object:nil];

    
    // Do any additional setup after loading the view.
}



-(void)newMessage:(NSNotification *)notif
{
    //    UITableViewCell * cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathWithIndex:0]];
//    isNewMessage = NO;
    if (_messageArr.count == 0) {
        _messageArr = [[NSMutableArray alloc] init];
    }
  

    
    [_tableView reloadData];
    //    NSLog(@"%@",[notif.userInfo objectForKey:@"message"]);
    //    EMMessage * message=[notif.userInfo objectForKey:@"message"];
    NSString * sender = [notif.userInfo objectForKey:@"message"];
    
    if (_messageArr.count == 0) {
        [_messageArr addObject:sender];
    }
    
    for (int i=0; i<[_messageArr count]; i++) {
        
        if ([_messageArr[i] isEqualToString:sender]) {
            break;
        }
        if (i==[_messageArr count]-1) {
            [_messageArr addObject:sender];
        }
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"newMessage" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"deleteRedButton" object:nil];

}

-(void)backBtnClick
{
//    MDHomeViewController * homeVC = [[MDHomeViewController alloc] init];
//    self.delegate = homeVC;
//    [self.delegate getMessageArrWithArray:_messageArr];
    

    [self.navigationController popViewControllerAnimated:YES
     ];
    
}

-(void)requestData
{
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.path = MDPath;
    model.delegate = self;
    model.methodNum = 10401;
    int userId = [[MDUserVO userVO].userID intValue];
    
    NSString * parameter=[NSString stringWithFormat:@"%d",userId];
    model.parameter = parameter;
    [model starRequest];
}

-(void)createView
{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth, appWidth*67.0/750.0)];
    _headerView.backgroundColor = ColorWithRGB(18, 139, 120, 1);
    UILabel * categoryLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 45,_headerView.height)];
    categoryLab.text = @"专家";
    categoryLab.textColor = [UIColor whiteColor];
    categoryLab.font = [UIFont boldSystemFontOfSize:18];
    [_headerView addSubview:categoryLab];
    UIButton * moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    moreBtn.center = CGPointMake(appWidth - 45, _headerView.height/2);
    [moreBtn setTitle:@"更多..." forState:UIControlStateNormal];
    [moreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [moreBtn addTarget:self action:@selector(moreClick:) forControlEvents:UIControlEventTouchUpInside];
    moreBtn.tag = 11;
    moreBtn.backgroundColor = [UIColor clearColor];
    [_headerView addSubview:moreBtn];
    
    _headerView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth, appWidth*67.0/750.0)];
    _headerView1.backgroundColor = ColorWithRGB(18, 139, 120, 1);
    UILabel * categoryLab1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 45,_headerView.height)];
    categoryLab1.text = @"医生";
    categoryLab1.textColor = [UIColor whiteColor];
    categoryLab1.font = [UIFont boldSystemFontOfSize:18];
    [_headerView1 addSubview:categoryLab1];
    UIButton * moreBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    moreBtn1.center = CGPointMake(appWidth - 45, _headerView.height/2);
    [moreBtn1 setTitle:@"更多..." forState:UIControlStateNormal];
    [moreBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    moreBtn1.titleLabel.font = [UIFont systemFontOfSize:14];
    moreBtn1.backgroundColor = [UIColor clearColor];
    [moreBtn1 addTarget:self action:@selector(moreClick:) forControlEvents:UIControlEventTouchUpInside];
    moreBtn1.tag = 12;

    [_headerView1 addSubview:moreBtn1];

    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOPHEIGHT, appWidth, appHeight - TOPHEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.tableHeaderView = _headerView;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MDDoctorServiceCell" bundle:nil] forCellReuseIdentifier:@"iden"];
    
}

-(void)moreClick:(UIButton *)btn
{
    if (btn.tag == 11) {
        MDMoreDocViewController * moreDocVC = [[MDMoreDocViewController alloc] init];
        moreDocVC.title = @"所有专家";
        moreDocVC.categoryLab = @"专家";
        [self.navigationController pushViewController:moreDocVC animated:YES];

    }
    else if (btn.tag == 12)
    {
        MDMoreDocViewController * moreDocVC = [[MDMoreDocViewController alloc] init];
        moreDocVC.title = @"所有医生";
        moreDocVC.categoryLab = @"医生";
        [self.navigationController pushViewController:moreDocVC animated:YES];
        

    }

}

#pragma mark - sendInfoToCtr 请求数据回调
-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    DocPatientSQL * docPation = [[DocPatientSQL alloc] init];
    [docPation createAttachmentsDBTableWithPatient];
    _dataSource = [[NSMutableArray alloc] init];
    
//    MDLog(@"%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
    NSLog(@"%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    NSDictionary * dic1 = [dic objectForKey:@"obj"];
    NSMutableArray * arr1 = [[NSMutableArray alloc] init];
    NSMutableArray * arr2 = [[NSMutableArray alloc] init];
   
    MDDocModel * model;
    for (NSDictionary * dic in [dic1 objectForKey:@"list2"]) {
         model= [[MDDocModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [arr1 addObject:model];
        NSMutableArray * array=[[NSMutableArray alloc] init];
        DocPatientModel * patientModel = [[DocPatientModel alloc] init];
        patientModel.Name = model.RealName;
        patientModel.phone =model.Phone;
        patientModel.HxName = model.HxName;
        patientModel.ImagePath = [NSString stringWithFormat:@"/Library/Caches/PatientsIMAGE/%@.png",model.HxName];
        [array addObject:patientModel];
        [docPation updatePopAttachmentsDBTable:array];
        
        UIImageView * imageV=[[UIImageView alloc] init];
        [imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[MDUserVO userVO].photourl,model.Photo]]];
        UIImage *headImg = imageV.image;
            FileUtils * fileUtil = [FileUtils sharedFileUtils];
            NSString * path2 = [fileUtil createCachePath:IMAGECACHE];
            NSString *uniquePath=[path2 stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",model.HxName]];
            [UIImagePNGRepresentation(headImg)writeToFile: uniquePath atomically:YES];
    }
    
    for (NSDictionary * dic in [dic1 objectForKey:@"list1"]) {
        model = [[MDDocModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [arr2 addObject:model];
        
        NSMutableArray * array=[[NSMutableArray alloc] init];
        DocPatientModel * patientModel = [[DocPatientModel alloc] init];
        patientModel.Name = model.RealName;
        patientModel.phone =model.Phone;
        patientModel.HxName = model.HxName;
        patientModel.ImagePath = [NSString stringWithFormat:@"/Library/Caches/PatientsIMAGE/%@.png",model.HxName];
        [array addObject:patientModel];
        [docPation updatePopAttachmentsDBTable:array];
        UIImageView * imageV=[[UIImageView alloc] init];
        [imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[MDUserVO userVO].photourl,model.Photo]]];
        UIImage *headImg = imageV.image;
        FileUtils * fileUtil = [FileUtils sharedFileUtils];
        NSString * path2 = [fileUtil createCachePath:IMAGECACHE];
        NSString *uniquePath=[path2 stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",model.HxName]];
        [UIImagePNGRepresentation(headImg)writeToFile: uniquePath atomically:YES];
    }
    
    [_dataSource addObject:arr1];
    [_dataSource addObject:arr2];
    [_tableView reloadData];
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * iden = @"iden";
    MDDoctorServiceCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[MDDoctorServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    cell.backgroundColor = ColorWithRGB(255, 255, 255, 0.7);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    for (UIView *item in cell.contentView.subviews) {
//        [item removeFromSuperview];
//    }
    MDDocModel * model = _dataSource[indexPath.section][indexPath.row];
    cell.nameLab.text = model.RealName;
    cell.hospitalLab.text = model.HospitalName;
    cell.majorLab.text = model.Detail;
    cell.branchLab.text  =model.Department;
    [cell.headView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[MDUserVO userVO].photourl,model.Photo]] placeholderImage:[UIImage imageNamed:@"专家头像"]];
    cell.unReadView.hidden = YES;
    
    for (NSString * newMessage in _messageArr) {
        if ([newMessage isEqualToString:model.HxName]) {
            cell.unReadView.hidden = NO;
        }
    }
    
//    NSLog(@"%@%@",[MDUserVO userVO].photourl,model.Photo);

    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return _headerView;
    }
    
    return _headerView1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return appWidth*(67.0/750.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MDHospitalViewController * hospitalVC = [[MDHospitalViewController alloc] init];
    MDDocModel * docInfo = _dataSource[indexPath.section][indexPath.row];
    hospitalVC.title = docInfo.RealName;
    hospitalVC.docInfo = docInfo;
    
    [self.navigationController pushViewController:hospitalVC animated:YES];
}

//将_messageArr里已读的消息删除（取消红点）
-(void)deleteRedButton:(NSNotification *)notif
{
    NSString * sender = [notif.userInfo objectForKey:@"message"];
//    _messageArr
    for (int i=0 ; i<[_messageArr count]; i++) {
        NSString * newMessage=_messageArr[i];
        
        if ([newMessage isEqualToString:sender]) {
            [_messageArr removeObjectAtIndex:i];
        }
    }
    [_tableView reloadData];
}

@end
