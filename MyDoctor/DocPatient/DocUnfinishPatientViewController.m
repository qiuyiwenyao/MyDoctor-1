//
//  DocUnfinishPatientViewController.m
//  
//
//  Created by 张昊辰 on 15/12/7.
//
//

#import "DocUnfinishPatientViewController.h"
#import "DocPatientTableViewCell.h"
#import "DocPatientFolerVO.h"
@interface DocUnfinishPatientViewController ()

@end

@implementation DocUnfinishPatientViewController
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
    
    DocPatientFolerVO * sfv=[[DocPatientFolerVO alloc] init];
    sfv.patientTapy=@"线上咨询";
    sfv.patientName=@"小明";
    sfv.headImg = @"大叔";
    sfv.Time=@"2015年12月11日  13:00";
    
    DocPatientFolerVO * sfv1=[[DocPatientFolerVO alloc] init];
    sfv1.patientTapy=@"电话咨询";
    sfv1.patientName=@"小黄";
    sfv1.headImg = @"叔叔.jpg";
    sfv1.Time=@"2015年12月11日  13:00";
    
    DocPatientFolerVO * sfv2=[[DocPatientFolerVO alloc] init];
    sfv2.patientTapy=@"照护";
    sfv2.patientName=@"小白";
    sfv2.headImg = @"大婶.jpg";
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
    DocPatientTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell==nil)
    {
        cell=[[DocPatientTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    }
    cell.backgroundColor=[UIColor clearColor];
    for (UIView *item in cell.contentView.subviews) {
        [item removeFromSuperview];
    }
    if ([dataArray count]>0) {
        DocPatientFolerVO * service=dataArray[indexPath.row];
        cell.patientName=service.patientName;
        cell.PatientTapy=service.patientTapy;
        cell.time=service.Time;
        cell.headImg = service.headImg;
    }
    [cell drawCell];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    // 带字典的通知
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"12" forKey:@"text"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushViewInPatient" object:nil userInfo:userInfo];
    
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
