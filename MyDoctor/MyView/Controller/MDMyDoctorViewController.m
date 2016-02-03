//
//  MDMyDoctorViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/11/30.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDMyDoctorViewController.h"
#import "MDMyDoctorModel.h"
#import "MDMyDoctorCell.h"
#import "MDExpertConsultationViewController.h"

@interface MDMyDoctorViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}
@property (nonatomic,strong) NSMutableArray * dataSource;

@end

@implementation MDMyDoctorViewController

//对列表数据进行懒加载
-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
        
        MDMyDoctorModel * group0 = [MDMyDoctorModel ModelWithDrName:@"刘晓红" andheadView:@"默认头像" andHospitolName:@"北京协和医院" andmajor:@"消化系统疾病，老年胃肠病，肝硬化，便秘，消化不良，老年共病"];
        MDMyDoctorModel * group1 = [MDMyDoctorModel ModelWithDrName:@"宁晓红" andheadView:@"默认头像" andHospitolName:@"天津协和医院"  andmajor:@"老年综合内科，老年实体肿瘤的内科治疗和临床决策"];
        MDMyDoctorModel * group2 = [MDMyDoctorModel ModelWithDrName:@"康琳" andheadView:@"默认头像" andHospitolName:@"山西医科大学附属医院"  andmajor:@"老年心血管疾病(包括老年冠心病,高血压,房颤,心衰)的诊断,治疗及药物调整, 老年常见疾病的诊断处理"];
        
        [_dataSource addObject:group0];
        [_dataSource addObject:group1];
        [_dataSource addObject:group2];
        
    }
    return _dataSource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的医生";

    BRSSysUtil *util = [BRSSysUtil sharedSysUtil];
    [util setNavigationLeftButton:self.navigationItem target:self selector:@selector(backBtnClick) image:[UIImage imageNamed:@"navigationbar_back"] title:nil];
    
    [self createView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(21, TOPHEIGHT, appWidth - 42, appHeight - TOPHEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;_tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MDMyDoctorCell" bundle:nil] forCellReuseIdentifier:@"iden"];
}

-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES
     ];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25.0/69.0*(appWidth - 42);
}

//填充每个cell间距的view，使之透明
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * iden = @"iden";
    MDMyDoctorCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[MDMyDoctorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    MDMyDoctorModel * model = _dataSource[indexPath.section];
//    cell.headerView.image = [UIImage imageNamed:(nonnull NSString *)];
    cell.nameLab.text = [NSString stringWithFormat:@"%@医生",model.name];
    cell.hospitolName.text = [NSString stringWithFormat:@"所属医院: %@",model.hospitol];
    cell.majorLal.text=  [NSString stringWithFormat:@"主治: %@",model.major];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MDExpertConsultationViewController * expertConsultaVC = [[MDExpertConsultationViewController alloc] init];
    expertConsultaVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:expertConsultaVC animated:YES];
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
