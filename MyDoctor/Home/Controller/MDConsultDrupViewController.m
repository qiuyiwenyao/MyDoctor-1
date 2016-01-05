//
//  MDConsultDrupViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/11/25.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDConsultDrupViewController.h"
#import "MDDrugTableViewController.h"
#import "MDConst.h"
#import "MDSmallADView.h"
#import "MDConst.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "MDRequestModel.h"
#import "MDUserVO.h"
#import "MDConsultDrugModel.h"

@interface MDConsultDrupViewController ()<sendInfoToCtr>

@end

@implementation MDConsultDrupViewController

{
    UITableView *_tableView;
    UIView * backView;
    NSMutableArray * amedicineArray;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"药品咨询";
    amedicineArray=[[NSMutableArray alloc] init];
    [self postRequest];
    
    [self setNavigationBarWithrightBtn:nil leftBtn:@"navigationbar_back"];
    //返回按钮点击
    [self.leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self searchview];
    
    
}

#pragma mark - POST请求
- (void)postRequest
{
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.path = MDPath;
    model.methodNum = 10302;
    NSString * parameter=[NSString stringWithFormat:@"%@@`%@@`%@",@"2",@"10",@"1"];
    model.parameter = parameter;
    model.delegate = self;
    [model starRequest];
    
    
}
//请求数据回调
-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    //回馈数据
    
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",[dic objectForKey:@"success"]);
    
    if ([dic objectForKey:@"success"]) {
        
        NSArray * array=[[NSArray alloc] init];
        array=[dic objectForKey:@"obj"];
        for (int i =0; i<[array count]; i++) {
            NSDictionary * type=[[NSDictionary alloc] init];
            type=array[i];
            MDConsultDrugModel * consult=[[MDConsultDrugModel alloc] init];
            consult.DrugTypeId=[type objectForKey:@"ID"];
            consult.TypeName=[type objectForKey:@"CategaryName"];
            
            [amedicineArray addObject:consult];
        }
        
    }
    
    [self medicineButton];
}



-(void)searchview{
    mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, appWidth, 40)];
    mySearchBar.delegate = self;
    [mySearchBar setPlaceholder:@"输入药品名"];
    
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:mySearchBar contentsController:self];
    searchDisplayController.active = NO;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    
//    _tableView = [[UITableView alloc] init];
//    _tableView.frame = CGRectMake(0, 0, appWidth, appHeight);
//    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    _tableView.backgroundColor = [UIColor whiteColor];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
////    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.tableHeaderView=mySearchBar;
    
    backView=[[UIView alloc] initWithFrame:CGRectMake(0, 64, appWidth, appHeight-64)];
    backView.backgroundColor=[UIColor clearColor];
    [backView addSubview:mySearchBar];
    [self.view addSubview:backView];
//    [self.view addSubview:_tableView];
     dataArray = [@[@"百度",@"六六",@"谷歌",@"苹果",@"and",@"table",@"view",@"and",@"and",@"苹果IOS",@"谷歌android",@"微软",@"微软WP",@"table",@"table",@"table",@"六六",@"六六",@"六六",@"table",@"table",@"table"]mutableCopy];
//    [self medicineButton];
}
-(void)medicineButton
{
    int a=0;
    for (int i=0; i<([amedicineArray count]+1)/2; i++) {
        for (int j=0; j<2; j++) {
            UIButton * medicineButton=[[UIButton alloc] init];
            medicineButton.tag=a;
            [medicineButton addTarget:self action:@selector(medicineButton:) forControlEvents:UIControlEventTouchUpInside];
            medicineButton.titleLabel.font=[UIFont systemFontOfSize:15];
            MDConsultDrugModel * consult=amedicineArray[a];
            [medicineButton setTitle:consult.TypeName forState:UIControlStateNormal];
            [medicineButton setBackgroundImage:[UIImage imageNamed:@"按钮框"] forState:UIControlStateNormal];
            [medicineButton setBackgroundColor:[UIColor clearColor]];
            [medicineButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            a++;
            if (a==[amedicineArray count]) {
                break;
            }
            [backView addSubview:medicineButton];
            
            [medicineButton mas_makeConstraints:^(MX_MASConstraintMaker *make) {
                make.left.equalTo(backView.mas_left).with.offset(10+(appWidth/2-5)*j);
                make.top.equalTo(backView.mas_top).with.offset(50+35*i);
                make.size.mas_equalTo(CGSizeMake(appWidth/2-15,30));
            }];
            
        }
    }
    [self createADView];

}

//下方滚动广告位
-(void)createADView
{
    NSLog(@"%lu",(unsigned long)amedicineArray.count);
    UIButton * bottonBtn = (UIButton *)[self.view viewWithTag:amedicineArray.count - 2];
    MDSmallADView * adView = [[MDSmallADView alloc] initWithFrame:CGRectMake(0, 0, appWidth, 50)];
    adView.adTitleArray = @[@"12月大促药店选择鸿康健药店，100%正品",@"e＋康服务到家,健康生活在你家",@"国家药监局认证，一站式网上购药"];
    [adView setText];
    
    [self.view addSubview:adView];
    
    [adView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(bottonBtn.mas_bottom).with.offset(10);
    }];
}


-(void)medicineButton:(UIButton *)button
{
    MDDrugTableViewController * drugTable=[[MDDrugTableViewController alloc] init];
    MDConsultDrugModel * dic=amedicineArray[button.tag];
    drugTable.DrugTypeId=dic.DrugTypeId;
    drugTable.TypeName=dic.TypeName;
    drugTable.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:drugTable animated:YES];
}

-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return searchResults.count;
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = searchResults[indexPath.row];
    }
    else {
        cell.textLabel.text = dataArray[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma UISearchDisplayDelegate
//searchBar开始编辑时改变取消按钮的文字
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    mySearchBar.showsCancelButton = YES;
    backView.frame=CGRectMake(0, 20, appWidth, appHeight);
    NSArray *subViews;
    
    if (is_IOS_7) {
        subViews = [(mySearchBar.subviews[0]) subviews];
    }
    else {
        subViews = mySearchBar.subviews;
    }
    
    for (id view in subViews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton* cancelbutton = (UIButton* )view;
            [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
            break;
        }
    }
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    
    backView.frame= CGRectMake(0, 64, appWidth, appHeight-64);
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    searchResults = [[NSMutableArray alloc]init];

    [self filterContentForSearchText:searchText];
    
}

-(void)filterContentForSearchText:(NSString*)searchText
{
    NSMutableArray *tempResults = [NSMutableArray array];
    NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
    
    for (int i = 0; i < dataArray.count; i++) {
        NSString *storeString = dataArray[i];
        NSRange storeRange = NSMakeRange(0, storeString.length);
        NSRange foundRange = [storeString rangeOfString:searchText options:searchOptions range:storeRange];
        if (foundRange.length) {
            [tempResults addObject:storeString];
        }
    }
    
    [searchResults removeAllObjects];
    [searchResults addObjectsFromArray:tempResults];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end