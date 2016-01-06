//
//  MDSetViewController.m
//  MyDoctor
//
//  Created by 张昊辰 on 16/1/5.
//  Copyright © 2016年 com.mingxing. All rights reserved.
//

#import "MDSetViewController.h"
#import "EaseMob.h"

@interface MDSetViewController ()

@end

@implementation MDSetViewController
{
    NSMutableArray * _dataArray;
    UITableView * _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarWithrightBtn:nil leftBtn:@"navigationbar_back"];
    //返回按钮点击
    [self.leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.title = @"设置";

    [self DataArray];
    [self TableView];
    [self EXIT];

}
-(void)DataArray
{
    _dataArray=[[NSMutableArray alloc] initWithObjects:@"修改密码",@"版本信息",@"关于e+健康", nil];
}
-(void)TableView
{
    CGRect rx = [ UIScreen mainScreen ].bounds;
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,69, rx.size.width, rx.size.height) style:UITableViewStylePlain];
    _tableView.separatorColor = [UIColor colorWithRed:223.0f/255.0f green:223.0f/255.0f blue:223.0f/255.0f alpha:1];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];;
    }

    if (indexPath.row == 1) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *ver = [NSString stringWithFormat:@"%@(%@)",@"版本信息", [infoDictionary objectForKey:@"CFBundleShortVersionString"]];
        CGSize sz = [ver sizeWithFont:[UIFont systemFontOfSize:(15*autoSizeScaleX)] constrainedToSize:CGSizeMake(MAXFLOAT, 40)];
        cell.textLabel.text = ver;
        
    }else{
        cell.textLabel.text = @"版本信息";
    }
    
    UIImageView *lineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mx_tabLine"]];
    lineView.frame = CGRectMake(15, 39*autoSizeScaleY, appWidth-15, 1);
    [cell.contentView addSubview:lineView];
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row!=2) {
        [[cell textLabel]  setText:[_dataArray objectAtIndex:indexPath.row]];
    }
    cell.textLabel.font=[UIFont boldSystemFontOfSize:(15*autoSizeScaleX)];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    
    switch (indexPath.row) {
        case 0:
        {
            break;
        }
        case 1:
        {
//            BRSChangePasswordViewController * avc=[[BRSChangePasswordViewController alloc] init];
//            [self.navigationController pushViewController:avc animated:YES];
            break;
        }
        case 2:
        {
//            if (isNew)
//            {
//                //如果是第一行 是版本信息 提前计算一下字符的值 为的是算宽度 然后放置new的图片
//                NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
//                NSString *version = [defaults objectForKey:@"user_version"];
//                versionArray = [version componentsSeparatedByString:@","];
//                
//                NSString *title = @"新版本升级提示";
//                NSString *compulsory = versionArray[1];
//                BOOL isCompulsory = [compulsory boolValue];
//                if(isCompulsory)
//                {
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:versionArray[2] delegate:self cancelButtonTitle:@"前往升级" otherButtonTitles:nil, nil];
//                    [alert show];
//                    [alert setTag:101];
//                }
//                else
//                {
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:versionArray[2] delegate:self cancelButtonTitle:@"前往升级" otherButtonTitles:@"下次再说", nil];
//                    [alert show];
//                    [alert setTag:100];
//                }
//            }
//            else
//            {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已是最新版本，无需更新" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alert show];
//            }
            
            break;
        }
        case 3:
        {
//            BRSAboutViewController *aboutVC = [[BRSAboutViewController alloc] init];
//            [self.navigationController pushViewController:aboutVC animated:YES];
            break;
        }
            
        default:
            break;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40*autoSizeScaleY;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40*autoSizeScaleY;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)EXIT
{
    UIButton * button=[[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:@"按钮页-红"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tunch:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:[NSString stringWithFormat:@"退出登录"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(240*autoSizeScaleY);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.height.mas_equalTo(40*autoSizeScaleY);
    }];
    
}
-(void)tunch:(UIButton *)button
{
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"退出后无法接收离线通知,要退出吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
        alert.delegate =self;
        [alert setTag:999];
        [alert show];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag==100||alertView.tag==101) {
        if (buttonIndex==0) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateEdition" object:nil];
            
            
            
            
            
        }
        return;
    }
    
    if (buttonIndex==1) {
        NSLog(@"%@",[NSString stringWithFormat:@"%@/Library/", NSHomeDirectory()]);
//
        [[NSNotificationCenter defaultCenter] postNotificationName:@"backselected1" object:self];
        NSFileManager *file = [NSFileManager defaultManager];
        BOOL ret = [file removeItemAtPath:[NSString stringWithFormat:@"%@/Library/", NSHomeDirectory()] error:nil];
        
        NSUserDefaults *userDefatlut = [NSUserDefaults standardUserDefaults];
        NSDictionary *dictionary = [userDefatlut dictionaryRepresentation];
        for(NSString* key in [dictionary allKeys]){
            [userDefatlut removeObjectForKey:key];
            [userDefatlut synchronize];
        }
        [self.navigationController popViewControllerAnimated:YES];
        [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES/NO completion:^(NSDictionary *info, EMError *error) {
            if (!error && info) {
                NSLog(@"退出成功");
            }
        } onQueue:nil];
        
//        FileUtils *fileUtil = [FileUtils sharedFileUtils];
//        //创建文件下载目录
//        NSString *path = [fileUtil createCachePath:IMAGECACHE];
    }
}



@end
