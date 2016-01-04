//
//  MDMyFocusViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/12/31.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDMyFocusViewController.h"
#import "MDRequestModel.h"
#import "MDDocModel.h"
#import "MDDoctorServiceCell.h"
#import "MDHospitalViewController.h"
#import "UIPopoverListView.h"

@interface MDMyFocusViewController ()<UITableViewDataSource,UITableViewDelegate,sendInfoToCtr,UIPopoverListViewDataSource,UIPopoverListViewDelegate>

{
    UITableView * _tableView;
}

@property (nonatomic,strong) NSMutableArray * dataSource;
@property (nonatomic,assign) int docType;

@end

@implementation MDMyFocusViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _docType = 1;
    
    [self setNavigationBarWithrightBtn:nil leftBtn:@"navigationbar_back"];
    //返回按钮点击
    [self.leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self createView];
    [self requestData];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES
     ];
    
}

-(void)requestData
{
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.path = MDPath;
    model.delegate = self;
    model.methodNum = 10406;
    int userId = [[MDUserVO userVO].userID intValue];
    int pageSize = 10;
    int pageIndex = 1;
    int lastID = 0;//最后一次获取的值，现在传0
    
    NSString * parameter=[NSString stringWithFormat:@"%d@`%d@`%d@`%d@`%d",userId,_docType,pageSize,pageIndex,lastID];
    //post键值对
    model.parameter = parameter;
    [model starRequest];
    
}

-(void)createView
{
    UIButton * titleButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 120, 20)];
    titleButton.tag = 11;
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
//    titleButton.backgroundColor = [UIColor redColor];
    [titleButton setTitle:@"我的关注" forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationController.navigationItem.titleView = titleButton;
    self.navigationItem.titleView = titleButton;

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOPHEIGHT, appWidth, appHeight - TOPHEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.tableHeaderView = _headerView;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MDDoctorServiceCell" bundle:nil] forCellReuseIdentifier:@"iden"];
    
}

-(void)selectBtn:(UIButton *)button
{
    MDLog(@"12");
    
    CGFloat xWidth = self.view.bounds.size.width - 20.0f;
    CGFloat yHeight = 150;
    CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
    UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
    poplistview.delegate = self;
    poplistview.datasource = self;
    poplistview.listView.scrollEnabled = FALSE;
//    [poplistview setTitle:@"Share to"];
    [poplistview show];
//    [poplistview release];
}

#pragma mark - sendInfoToCtr请求数据回调
-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    MDLog(@"%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
    NSDictionary * dictionary = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    _dataSource = [[NSMutableArray alloc] init];
    for (NSDictionary * dic in [dictionary objectForKey:@"obj"]) {
        MDDocModel * model = [[MDDocModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [_dataSource addObject:model];
    }
    [_tableView reloadData];
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
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
    MDDocModel * model = _dataSource[indexPath.row];
    cell.nameLab.text = model.RealName;
    cell.hospitalLab.text = model.HospitalName;
    cell.majorLab.text = model.Detail;
    cell.branchLab.text  =model.Department;
    cell.headView.layer.cornerRadius = cell.headView.height/2;
    
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return nil;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return appWidth*(67.0/750.0);
    //    return _headerView1.height*1.5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MDHospitalViewController * hospitalVC = [[MDHospitalViewController alloc] init];
    
    MDDocModel * docInfo = _dataSource[indexPath.row];
    hospitalVC.docInfo = docInfo;
    hospitalVC.title = docInfo.RealName;
    
    [self.navigationController pushViewController:hospitalVC animated:YES];
}

#pragma mark - UIPopoverListViewDataSource

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"popoverListView";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    long row = indexPath.row;
    
    if(row == 0){
        cell.textLabel.text = @"我关注的医生";
    }else if (row == 1){
        cell.textLabel.text = @"我关注的专家";
    }
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    MDLog(@"%ld",(long)indexPath.row);
    UIButton * button = (UIButton *)[self.navigationItem.titleView viewWithTag:11];

    if (indexPath.row == 0) {
        _docType = 1;
        [button setTitle:@"我关注的医生" forState:UIControlStateNormal];
    }
    else if (indexPath.row == 1)
    {
        _docType = 2;
        [button setTitle:@"我关注的专家" forState:UIControlStateNormal];
    }
    [self requestData];

}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
