//
//  DocOnlineViewController.m
//  
//
//  Created by 张昊辰 on 15/12/7.
//
//

#import "DocOnlineViewController.h"
#import "DocServiceFolerVO.h"
#import "DocHomeTableViewCell.h"
#import "MainViewController.h"
#import "DocHomeCell.h"

@interface DocOnlineViewController ()

@end

@implementation DocOnlineViewController
{
    NSMutableArray * dataArray;
    
}
@synthesize tableView = _tableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    [self dataArray];
    [self TableView];
}
-(void)dataArray
{
    dataArray=[[NSMutableArray alloc] init];
    
    DocServiceFolerVO * sfv=[[DocServiceFolerVO alloc] init];
    sfv.serviceType=@"线上咨询";
    sfv.serviceStatus=@"未完成";
    sfv.headImg = @"叔叔.jpg";
    sfv.Time=@"2015-12-25 13:00";
    sfv.details = @"你应该多喝水就行";
    sfv.name = @"赵铁柱";
    
    DocServiceFolerVO * sfv1=[[DocServiceFolerVO alloc] init];
    sfv1.serviceType=@"线上咨询";
    sfv1.serviceStatus=@"已完成";
    sfv1.headImg = @"大婶.jpg";
    sfv1.name = @"杨大婶";
    sfv1.details = @"你应该多跳广场舞";
    sfv1.Time=@"2015-12-25 13:00";
    
    DocServiceFolerVO * sfv2=[[DocServiceFolerVO alloc] init];
    sfv2.serviceType=@"线上咨询";
    sfv2.serviceStatus=@"已完成";
    sfv2.headImg = @"大爷.jpg";
    sfv2.name = @"李大爷";
    sfv2.details = @"每天吃三次";
    sfv2.Time=@"2015-12-25 13:00";
    
    [dataArray addObject:sfv];
    [dataArray addObject:sfv1];
    [dataArray addObject:sfv2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)TableView
{
    
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,104, appWidth, appHeight-104-49) style:UITableViewStylePlain];
    _tableView.separatorColor = [UIColor colorWithRed:223.0f/255.0f green:223.0f/255.0f blue:223.0f/255.0f alpha:1];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    _tableView.allowsMultipleSelectionDuringEditing = YES;
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
    [_tableView reloadData];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Cell=@"HeaderCell";
    DocHomeCell * cell=[tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell==nil)
    {
        cell=[[DocHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    }
    cell.backgroundColor=[UIColor clearColor];
//    for (UIView *item in cell.contentView.subviews) {
//        [item removeFromSuperview];
//    }
        DocServiceFolerVO * service=dataArray[indexPath.row];
//        cell.serviceType=service.serviceType;
        cell.serviceStatusLab.text=service.serviceStatus;
        cell.timeLabel.text=service.Time;
    cell.nameLab.text = service.name;
        cell.headView.image = [UIImage imageNamed:service.headImg];
    cell.detailLab.text = service.details;
//    [cell drawCell];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DocHomeTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    // 带字典的通知
    NSDictionary *userInfo = @{@"text":cell.serviceStatus,@"text2":cell.serviceType};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushViewInDocHome" object:nil userInfo:userInfo];
    
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [dataArray count];
    
}



@end