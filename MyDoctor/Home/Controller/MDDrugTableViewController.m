//
//  MDDrugTableViewController.m
//  MyDoctor
//
//  Created by 张昊辰 on 15/11/30.
//  Copyright (c) 2015年 com.mingxing. All rights reserved.
//

#import "MDDrugTableViewController.h"
#import "MDConst.h"
#import "BRSTextField.h"
#import "MDDrugVO.h"
#import "MDDrugTableViewCell.h"
#import "MDNurseRootViewController.h"
#import "MDSmallADView.h"
#import "MDDrupDetailViewController.h"

@interface MDDrugTableViewController ()  {
    
    NSMutableArray *_dataArr;//数据源
    UITableView *_tableView;
    BRSTextField * _searchDrug;
    UIButton * search;
    
    UIButton * theDefault;
    UIButton * sales;
    UIButton * screen;
    NSMutableArray * dataArray;
}



@end

@implementation MDDrugTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarWithrightBtn:nil leftBtn:@"navigationbar_back"];
    //返回按钮点击
    [self.leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self searchDrug];
//    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo)];
//    [self.view addGestureRecognizer:tapGesture];
    //排序
    [self sorting];
    //数据
    [self dataArray];
    [self TableView];
    
}
-(void)dataArray
{
    dataArray=[[NSMutableArray alloc] init];
    MDDrugVO * drug1=[[MDDrugVO alloc] init];
    drug1.Namedrug=@"葵花胃康灵胶囊0.4g";
    drug1.numberDrug=@"*48粒";
    drug1.moneyDrug=@"¥15元";
    drug1.detailsDrug=@"药品简介";
    [dataArray addObject:drug1];
    
    MDDrugVO * drug2=[[MDDrugVO alloc] init];
    drug2.Namedrug=@"葵花胃康灵胶囊0.4g";
    drug2.numberDrug=@"*48粒";
    drug2.moneyDrug=@"¥15元";
    drug2.detailsDrug=@"药品简介";
    [dataArray addObject:drug2];
    
    MDDrugVO * drug3=[[MDDrugVO alloc] init];
    drug3.Namedrug=@"葵花胃康灵胶囊0.4g";
    drug3.numberDrug=@"*48粒";
    drug3.moneyDrug=@"¥15元";
    drug3.detailsDrug=@"药品简介";
    [dataArray addObject:drug3];
    
    MDDrugVO * drug4=[[MDDrugVO alloc] init];
    drug4.Namedrug=@"葵花胃康灵胶囊0.4g";
    drug4.numberDrug=@"*48粒";
    drug4.moneyDrug=@"¥15元";
    drug4.detailsDrug=@"药品简介";
    [dataArray addObject:drug4];
}
-(void)TableView
{
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,64+35, appWidth, appHeight-(64+35)) style:UITableViewStylePlain];
//    _tableView.separatorColor = [UIColor clearColor];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    _tableView.allowsMultipleSelectionDuringEditing = YES;
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
    [_tableView reloadData];
}

//搜索药品
-(void)searchDrug
{
    _searchDrug = [[BRSTextField alloc] initWithFrame:CGRectMake(60, 28, appWidth-60*2, 25)];
    //    logInField=[[BRSTextField alloc] initWithFrame:CGRectMake(0, 0, 240, 30) Icon:image];
    [_searchDrug setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    _searchDrug.backgroundColor=[UIColor whiteColor];
    //    logInField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter; //设置居中输入
    //    logInField.textAlignment = NSTextAlignmentLeft;
    _searchDrug.placeholder = @"本店内搜索"; //默认显示的字
    [_searchDrug setValue:[UIFont boldSystemFontOfSize:(15*(appWidth>320?appWidth/320:1))] forKeyPath:@"_placeholderLabel.font"];
    
    _searchDrug.returnKeyType = UIReturnKeySearch;  //键盘返回类型
    _searchDrug.delegate = self;
    _searchDrug.keyboardType = UIKeyboardTypeNumberPad;//键盘显示类型
    _searchDrug.layer.backgroundColor=(__bridge CGColorRef)([UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1]);
    UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"搜索药品"]];
    _searchDrug.leftView=image;
    _searchDrug.leftViewMode = UITextFieldViewModeAlways;
    _searchDrug.tag=1;
    
    [self.navigationController.view addSubview:_searchDrug];
    
    
    search=[[UIButton alloc] initWithFrame:CGRectMake(appWidth-50, 28, 45, 25)];
    [search addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    search.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    [search setTitle:@"确定" forState:UIControlStateNormal];
    [search setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [search setBackgroundColor:[UIColor clearColor]];
    search.hidden=YES;
    search.layer.cornerRadius =5;
    [self.navigationController.view addSubview:search];
    
    
}
-(void)search
{
    //搜索
    NSLog(@"search");
}

-(void)backBtnClick
{
    [_searchDrug removeFromSuperview];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)sorting
{
    theDefault=[[UIButton alloc] initWithFrame:CGRectMake(0, 64, appWidth/3, 35)];
    [theDefault addTarget:self action:@selector(theDefault:) forControlEvents:UIControlEventTouchUpInside];
    theDefault.titleLabel.font=[UIFont systemFontOfSize:15];
    [theDefault setTitle:@"综合排序" forState:UIControlStateNormal];
    [theDefault layoutIfNeeded];
    [theDefault setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [theDefault setBackgroundImage:[UIImage imageNamed:@"按钮框"] forState:UIControlStateNormal];
    [self.view addSubview:theDefault];
    [theDefault setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
    [theDefault setTitleEdgeInsets:UIEdgeInsetsMake(0, -2, 0, 15)];
    [theDefault setImageEdgeInsets:UIEdgeInsetsMake(0, 85, 0, 0)];
    
    
    sales=[[UIButton alloc] initWithFrame:CGRectMake(appWidth/3, 64, appWidth/3, 35)];
    [sales addTarget:self action:@selector(sales:) forControlEvents:UIControlEventTouchUpInside];
    sales.titleLabel.font=[UIFont systemFontOfSize:15];
    [sales setTitle:@"销量优先" forState:UIControlStateNormal];
    [sales setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sales setBackgroundImage:[UIImage imageNamed:@"按钮框"] forState:UIControlStateNormal];
    [self.view addSubview:sales];
    [sales setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
    [sales setTitleEdgeInsets:UIEdgeInsetsMake(0, -2, 0, 15)];
    [sales setImageEdgeInsets:UIEdgeInsetsMake(0, 85, 0, 0)];
    
    screen=[[UIButton alloc] initWithFrame:CGRectMake(appWidth/3*2, 64, appWidth/3, 35)];
    [screen addTarget:self action:@selector(screen:) forControlEvents:UIControlEventTouchUpInside];
    screen.titleLabel.font=[UIFont systemFontOfSize:15];
    [screen setTitle:@"筛    选" forState:UIControlStateNormal];
    [screen setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [screen setBackgroundImage:[UIImage imageNamed:@"按钮框"] forState:UIControlStateNormal];
    [self.view addSubview:screen];
    [screen setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
    [screen setTitleEdgeInsets:UIEdgeInsetsMake(0, -2, 0, 15)];
    [screen setImageEdgeInsets:UIEdgeInsetsMake(0, 85, 0, 0)];
    
    UIView * redLine=[[UIView alloc] initWithFrame:CGRectMake(0, 64, appWidth, 1)];
    redLine.backgroundColor=RedColor;
    [self.view addSubview:redLine];
    
    for (int i=1; i<3; i++) {
        UIView * redline1=[[UIView alloc] initWithFrame:CGRectMake(appWidth/3*i-1, 64, 1, 35)];
        redline1.backgroundColor=RedColor;
        [self.view addSubview:redline1];
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Cell=@"HeaderCell";
    MDDrugTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell==nil)
    {
        cell=[[MDDrugTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    }
    cell.backgroundColor=[UIColor clearColor];
    for (UIView *item in cell.contentView.subviews) {
        [item removeFromSuperview];
    }
    if ([dataArray count]>0) {
        MDDrugVO * service=dataArray[indexPath.row];
        cell.name=service.Namedrug;
        cell.number=service.numberDrug;
        cell.money=service.moneyDrug;
    }
    [cell drawCell];
    
    return cell;
}
-(void)viewWillAppear:(BOOL)animated
{
    _searchDrug.hidden=NO;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除搜索栏
    _searchDrug.hidden=YES;
    [_searchDrug resignFirstResponder];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    MDDrupDetailViewController * detailVC = [[MDDrupDetailViewController alloc] init];
    detailVC.hidesBottomBarWhenPushed=YES;
    detailVC.navigationItem.title=@"商品详情";
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [dataArray count];
    
}

//综合排序
-(void)theDefault:(UIButton *)button
{
    
}
//销量优先
-(void)sales:(UIButton *)button
{
    
}
//筛选
-(void)screen:(UIButton *)button
{
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    search.hidden=NO;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    search.hidden=YES;
}
//textfield被改变
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    //搜索
    [self search];
    return YES;
}

@end
