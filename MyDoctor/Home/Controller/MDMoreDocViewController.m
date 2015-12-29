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

@interface MDMoreDocViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView * _headerView;
    UITableView * _tableView;
}

@property (nonatomic,strong) NSMutableArray * dataSource;

@end

@implementation MDMoreDocViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self setNavigationBarWithrightBtn:nil leftBtn:@"navigationbar_back"];
    //返回按钮点击
    [self.leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];

    
    [self createView];
    // Do any additional setup after loading the view.
}

-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
        MDDocModel * model1 = [[MDDocModel alloc] init];
        model1.name = @"周凤阳";
        model1.branch = @"小儿科";
        model1.hospital = @"天津环湖医院";
        model1.major = @"小儿各种上呼吸道疾患、哮喘、肺炎、腹泻 及外感发热、食积发热等";
        
        MDDocModel * model2 = [[MDDocModel alloc] init];
        model2.name = @"王荣宝";
        model2.branch = @"耳鼻喉科";
        model2.hospital = @"天津医科大学口腔医院";
        model2.major = @"支气管哮喘、慢性 支气管炎、慢性阻塞性肺病、肺心病";
        
        MDDocModel * model3 = [[MDDocModel alloc] init];
        model3.name = @"王跃峰";
        model3.branch = @"内科";
        model3.hospital = @"天津医院";
        model3.major = @"冠心病、脑梗塞、高血压病、支气管炎、肺 炎";
        
        MDDocModel * model4 = [[MDDocModel alloc] init];
        model4.name = @"杨翠萍";
        model4.branch = @"内科";
        model4.hospital = @"天津安定医院";
        model4.major = @"泌尿系感染疾病、各种性病、男女不孕不育症、性功能障碍";
        
        NSArray * group1 = @[model1,model3,model4,model2,model1,model3];
        
        [_dataSource addObject:group1];
    }
    return _dataSource;
    
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

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
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
    cell.nameLab.text = model.name;
    cell.hospitalLab.text = model.hospital;
    cell.majorLab.text = model.major;
    cell.branchLab.text  =model.branch;
    cell.headView.layer.cornerRadius = cell.headView.height/2;
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
    MDDoctorServiceCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    MDHospitalViewController * hospitalVC = [[MDHospitalViewController alloc] init];
    hospitalVC.title = [NSString stringWithFormat:@"%@医生",cell.nameLab.text];
    hospitalVC.name = cell.nameLab.text;
    hospitalVC.hospital = cell.hospitalLab.text;
    hospitalVC.major = cell.majorLab.text;
    hospitalVC.brand = cell.branchLab.text;

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
