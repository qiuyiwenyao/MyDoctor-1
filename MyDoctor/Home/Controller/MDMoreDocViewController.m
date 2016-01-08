//
//  MDMoreDocViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/12/24.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDMoreDocViewController.h"
#import "MDDoctorServiceCell.h"
#import "MDHospitalViewController.h"
#import "MDDocModel.h"
#import "MDRequestModel.h"
#import "UIImageView+WebCache.h"

@interface MDMoreDocViewController ()<UITableViewDataSource,UITableViewDelegate,sendInfoToCtr>
{
    UIView * _headerView;
    UITableView * _tableView;
}

@property (nonatomic,strong) NSMutableArray * dataSource;

@end

@implementation MDMoreDocViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
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
    if ([self.title isEqualToString:@"所有医生"]) {
        model.methodNum = 10402;
    }
    else if ([self.title isEqualToString:@"所有专家"])
    {
        model.methodNum = 10403;
    }
    int userId = [[MDUserVO userVO].userID intValue];
    int pageSize = 10;
    int pageIndex = 1;
    int lastID = 0;//最后一次获取的值，现在传0
    
    NSString * parameter=[NSString stringWithFormat:@"%d@`%d@`%d@`%d",userId,pageSize,pageIndex,lastID];
    //post键值对
    model.parameter = parameter;
    [model starRequest];

}

-(void)createView
{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth, appWidth*67.0/750.0)];
    _headerView.backgroundColor = ColorWithRGB(18, 139, 120, 1);
    UILabel * categoryLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 45,_headerView.height)];
    categoryLab.text = self.categoryLab;
    categoryLab.textColor = [UIColor whiteColor];
    categoryLab.font = [UIFont boldSystemFontOfSize:18];
    [_headerView addSubview:categoryLab];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOPHEIGHT, appWidth, appHeight - TOPHEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.tableHeaderView = _headerView;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MDDoctorServiceCell" bundle:nil] forCellReuseIdentifier:@"iden"];
    
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
    [cell.headView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[MDUserVO userVO].photourl,model.Photo]] placeholderImage:[UIImage imageNamed:@"专家头像"]];

    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return _headerView;
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
