//
//  DocAllWorkViewController.m
//  
//
//  Created by 张昊辰 on 15/12/7.
//
//

#import "DocAllWorkViewController.h"
#import "DocServiceFolerVO.h"
#import "DocHomeTableViewCell.h"
#import "DocRecordViewController.h"

@interface DocAllWorkViewController ()

@end

@implementation DocAllWorkViewController
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
    sfv.headImg = @"大婶.jpg";
    sfv.Time=@"2015年12月11日  13:00";
    
    DocServiceFolerVO * sfv1=[[DocServiceFolerVO alloc] init];
    sfv1.serviceType=@"电话咨询";
    sfv1.serviceStatus=@"已完成";
    sfv1.headImg = @"大叔";
    sfv1.Time=@"2015年12月11日  13:00";
    
    DocServiceFolerVO * sfv2=[[DocServiceFolerVO alloc] init];
    sfv2.serviceType=@"照护";
    sfv2.serviceStatus=@"已完成";
    sfv2.headImg = @"叔叔.jpg";
    sfv2.Time=@"2015年12月11日  13:00";
    
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
    DocHomeTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell==nil)
    {
        cell=[[DocHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    }
    cell.backgroundColor=[UIColor clearColor];
    for (UIView *item in cell.contentView.subviews) {
        [item removeFromSuperview];
    }
    if ([dataArray count]>0) {
        DocServiceFolerVO * service=dataArray[indexPath.row];
        cell.serviceType=service.serviceType;
        cell.serviceStatus=service.serviceStatus;
        cell.time=service.Time;
        cell.headImg = service.headImg;
    }
    [cell drawCell];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DocHomeTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
//    NSLog(@"%@",cell.serviceStatus);

    cell.selected = NO;
    // 带字典的通知
//    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"text",cell.serviceType];
    
//    NSDictionary * userInfo =[ [NSDictionary alloc] initWithObjectsAndKeys:@"text",cell.serviceStatus,@"text2",cell.serviceStatus ,nil];
    
    NSDictionary *userInfo = @{@"text":cell.serviceStatus,@"text2":cell.serviceType};
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushViewInDocHome" object:nil userInfo:userInfo];
    
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



@end
