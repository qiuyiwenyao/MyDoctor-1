//
//  MDNurseViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/11/25.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDNurseViewController.h"
#import "MDNurseRootViewController.h"
#import "MDTransfuseViewController.h"
#import "MDExaminationViewController.h"
#import "MDRecoveryViewController.h"
#import "MDRequestModel.h"

@interface MDNurseViewController ()<UITableViewDataSource,UITableViewDelegate,sendInfoToCtr>
{
    UITableView * _tableView;
    NSMutableArray * _listArray;
}

@end

@implementation MDNurseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"照护";
    [self setNavigationBarWithrightBtn:nil leftBtn:@"navigationbar_back"];
    //返回按钮点击
    [self.leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self createTableView];
    
//    [self postRequest];

    // Do any additional setup after loading the view.
}

-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES
     ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)postRequest
{
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.path = MDPath;
    model.methodNum = 10302;
    NSString * parameter=[NSString stringWithFormat:@"%d@`%d@`%d",3,10,1];
    model.parameter = parameter;
    model.delegate = self;
    [model starRequest];
}

-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    NSLog(@"======%@",[NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil]);
    NSString * str = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
}


-(void)createTableView
{
    NSArray * group0 = @[@"输液",@"上门输液"];
    NSArray * group1 = @[@"上门体检",@"上门体检"];
    NSArray * group2 = @[@"术后康复",@"术后康复"];
    NSArray * group3 = @[@"专业照护",@"专业照护"];
    
    if (_listArray == nil) {
        _listArray = [NSMutableArray arrayWithObjects:group0,group1,group2,group3, nil];
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(21,TOPHEIGHT+18, SCREENWIDTH - 21*2, self.view.frame.size.height - TOPHEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor redColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = YES;
    //去掉下面多余的线
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDelegate代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _listArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * iden = @"iden";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    cell.imageView.image = [UIImage imageNamed:_listArray[indexPath.section][0]];
    cell.textLabel.text = _listArray[indexPath.section][1];
    cell.backgroundColor = ColorWithRGB(255, 255, 255, 0.7);
    [cell setSelectionStyle:0];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _tableView.frame.size.width/(700.0/180.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 15;
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
    if (indexPath.section==0) {
        MDTransfuseViewController * transfuseVC = [[MDTransfuseViewController alloc] init];
        transfuseVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:transfuseVC animated:YES];
    }else if(indexPath.section==1){
        MDExaminationViewController * examinationVC = [[MDExaminationViewController alloc] init];
        examinationVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:examinationVC animated:YES];
        
    }else if (indexPath.section==2){
        MDRecoveryViewController * recoveryVC = [[MDRecoveryViewController alloc] init];
        recoveryVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:recoveryVC animated:YES];
    }else if (indexPath.section==3){
        MDRecoveryViewController * recoveryVC = [[MDRecoveryViewController alloc] init];
        recoveryVC.hidesBottomBarWhenPushed=YES;
        recoveryVC.title = @"专业照护";
        [self.navigationController pushViewController:recoveryVC animated:YES];
        
    }

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
