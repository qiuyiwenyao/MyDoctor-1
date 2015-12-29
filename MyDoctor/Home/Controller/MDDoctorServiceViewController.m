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
#import "GTMBase64.h"

@interface MDDoctorServiceViewController ()<UITableViewDataSource,UITableViewDelegate,sendInfoToCtr>
{
    UITableView * _tableView;
    UIView * _headerView;
    UIView * _headerView1;

}

@property (nonatomic,strong) NSMutableArray * dataSource;

@end

@implementation MDDoctorServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"寻医";
    
    [self setNavigationBarWithrightBtn:nil leftBtn:@"navigationbar_back"];
    //返回按钮点击
    [self.leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self requestData];
    
    [self createView];

    
    // Do any additional setup after loading the view.
}

//临时懒加载数据源
/*
周凤阳  男  大专  主治医师  各种小儿科疾病，尤以消化系统、呼吸系统及各种发热 疾患  小儿各种上呼吸道疾患、哮喘、肺炎、腹泻 及外感发热、食积发热等
王荣宝 男 研究生  主治医师  心脑血管常见病、多发病、急危重症 冠心病、心衰、心绞痛、心肌梗死、心律失 常、高血压、高脂血症、支气管哮喘、慢性 支气管炎、慢性阻塞性肺病、肺心病、胃溃 疡、胃炎   
 张月霞 女 本科 副主任医师 糖尿病、心血管系统疾病  
 赵中华  女  本科  副主任医师  心血管、呼吸系统疾病    发表《炙甘草汤加附子治疗Ⅲ°房室传导阻滞20例》、《支气管哮喘 治验》等论文4篇 
 陈兰燕 女  主治医师 内科常见病  冠心病、脑梗塞、高血压病、支气管炎、肺 炎、糖尿病及消化系统疾病    
 杨翠萍 女 研究生 主治医师 内科常见病  各种急慢性肾炎、继发性肾损害及糖尿病等疾病的治疗，运用血液净化技术，对急慢性肾功能不全、惊醒中毒等危重病的抢救有较 丰富的临床经验  发表论文4篇，参与省级和市级课 题各一项 
 王跃峰 男 大专 主治医师 外科、泌尿男科 泌尿系感染疾病、各种性病、男女不孕不育症、性功能障碍及男性各种整形手术  发表论文3篇
 天津肿瘤医院 (三甲, 特色:肿瘤) 天津医科大学第二医院 (三甲) 天津医院 (三甲, 特色:骨科) 天津环湖医院 (三甲, 特色:神外、神内) 天津儿童医院 (三甲, 特色:儿童) 天津安定医院 (三甲, 特色:精神)
 和平
 天津总医院 (三甲, 特色:综合) 天津市口腔医院 (三甲, 特色:口腔) 天津血液病医院 (三甲, 特色:血液病) 天津眼科医院 (三甲, 特色:眼科) 天津医科大学口腔医院 (三甲, 特色:口腔)
 */
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
        
        NSArray * group1 = @[model1,model3,model4];
        NSArray * gropu2 = @[model2,model4,model1];
        
        [_dataSource addObject:group1];
        [_dataSource addObject:gropu2];
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

-(void)requestData
{
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.path = MDPath;
    model.delegate = self;
    model.methodNum = 10401;
    
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    date = [formatter stringFromDate:[NSDate date]];
    int userId = [[MDUserVO userVO].userID intValue];
    
    NSString * parameter=[NSString stringWithFormat:@"%d@`3@`3@`%@@`1@`3@`%d",model.methodNum,date,userId];
    parameter=[self GTMEncodeTest:parameter];
    //post键值对
    model.parameters = @{@"b":parameter};
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
    MDLog(@"%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
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

    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    return _headerView;
    if (section == 0) {
        return _headerView;
    }
    
    return _headerView1;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
