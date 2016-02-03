//
//  MDLectureViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/11/27.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDLectureViewController.h"
#import "MDLectureModel.h"
#import "MDRequestModel.h"


@interface MDLectureViewController ()<UIAlertViewDelegate,sendInfoToCtr>
{
    int lectureID;
}

@end

@implementation MDLectureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"专题讲座";
    BRSSysUtil *util = [BRSSysUtil sharedSysUtil];
    [util setNavigationLeftButton:self.navigationItem target:self selector:@selector(backBtnClick) image:[UIImage imageNamed:@"navigationbar_back"] title:nil];
    [self.leftDownBtn setTitle:@"电话咨询" forState:UIControlStateNormal];
    [self.rightDownBtn setTitle:@"免费预约" forState:UIControlStateNormal];
    
    //  取消继承的点击事件
    [self.rightDownBtn removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    
    //添加点击事件
    [self.rightDownBtn addTarget:self action:@selector(orderBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
//    [self postRequest];

    
    [self setText];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - sendInfoToCtr
-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
//        NSLog(@"%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        if ([[dic objectForKey:@"msg"] isEqualToString:@"已经报名"]) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"预约成功" message:nil delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];

        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"预约失败，请重试" message:nil delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alert show];
        }
    
//    MDLog(@"%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
    //    healthEducateName": "健康讲座",
//    "participateInPeople": "接受教育的人群",
//    "starttime": "2015-11-30 21:10:53",
//    "endtime": "2015-12-03 21:11:00",
//    "content": "内容",
//    "addree": "地点",
//    "purpose": "目的",
//    "company": "主办单位",
//    NSLog(@"%@  %@  %@",[_dataSource[0] objectForKey:@"healthEducateName"],[_dataSource[0] objectForKey:@"participateInPeople"],[_dataSource[0] objectForKey:@"company"]);
    
    
//    NSArray *array = [str componentsSeparatedByString:@","];
//    NSArray *success=[array[0] componentsSeparatedByString:@":"];
//    
//    if ([success[1] isEqualToString:@"true"]) {
//        [[NSNotificationCenter defaultCenter]
//         postNotificationName:@"showBRSMainView" object:self];
//        NSUserDefaults *stdDefault = [NSUserDefaults standardUserDefaults];
//        [stdDefault setObject:logInField.text forKey:@"user_name"];
//        [self dismissViewControllerAnimated:YES completion:^{
//            NSLog(@"back");
//        }];
//    }
    

}

-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES
     ];
    
}

-(void)orderBtnClick
{
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.path = MDPath;
    model.methodNum = 10202;
//    model.methodNum = 10201;
    NSUserDefaults * stdDefault = [NSUserDefaults standardUserDefaults];
    int userId = [[stdDefault objectForKey:@"user_Id"] intValue];
    NSString * parameter = [NSString stringWithFormat:@"%d@`%d",userId,lectureID];
    model.parameter = parameter;
    model.delegate = self;
    [model starRequest];

    
    
}

-(void)setText
{
    
    UILabel * startTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, appWidth - 48*2, 0)];
    startTimeLab.text = [NSString stringWithFormat:@"开始时间:%@",self.lectureDetail.starttime];
//    startTimeLab.text = @"开始时间:2015-12-08";
    startTimeLab.textAlignment = NSTextAlignmentLeft;
    startTimeLab.font = [UIFont systemFontOfSize:14];
    startTimeLab.textColor = ColorWithRGB(97, 103, 111, 1);
    startTimeLab.numberOfLines = 0;
    [startTimeLab sizeToFit];
    [self.scrollView addSubview:startTimeLab];
    
    UILabel * endTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, startTimeLab.y+startTimeLab.height+21, appWidth - 48*2, 0)];
    endTimeLab.text = [NSString stringWithFormat:@"结束时间:%@",self.lectureDetail.endtime];
//    endTimeLab.text = @"结束时间:2015-12-09";
    endTimeLab.textAlignment = NSTextAlignmentLeft;
    endTimeLab.font = [UIFont systemFontOfSize:14];
    endTimeLab.textColor = ColorWithRGB(97, 103, 111, 1);
    endTimeLab.numberOfLines = 0;
    [endTimeLab sizeToFit];
    [self.scrollView addSubview:endTimeLab];
    
    UILabel * placeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, endTimeLab.y+endTimeLab.height+21, appWidth - 48*2, 0)];
    placeLab.text = [NSString stringWithFormat:@"地点%@:",self.lectureDetail.addree];
    placeLab.textAlignment = NSTextAlignmentLeft;
    placeLab.font = [UIFont systemFontOfSize:14];
    placeLab.textColor = ColorWithRGB(97, 103, 111, 1);
    placeLab.numberOfLines = 0;
    [placeLab sizeToFit];
    [self.scrollView addSubview:placeLab];
    
    UILabel * detailsLab = [[UILabel alloc] initWithFrame:CGRectMake(0, placeLab.y+placeLab.height+21, appWidth - 48*2, 0)];
    detailsLab.text = [NSString stringWithFormat:@"内容 :%@",self.lectureDetail.content];
    detailsLab.textAlignment = NSTextAlignmentLeft;
    detailsLab.font = [UIFont systemFontOfSize:14];
    detailsLab.textColor = ColorWithRGB(97, 103, 111, 1);
    detailsLab.numberOfLines = 0;
    
    //调整文字行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:detailsLab.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];//间距大小
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [detailsLab.text length])];
    detailsLab.attributedText = attributedString;
    [detailsLab sizeToFit];
    [self.scrollView addSubview:detailsLab];
    
    UILabel * telLab = [[UILabel alloc] initWithFrame:CGRectMake(0, detailsLab.y+detailsLab.height+21, detailsLab.width, 0)];
    telLab.text =[NSString stringWithFormat:@"联系电话%@: ",self.lectureDetail.phone];
    telLab.textAlignment = NSTextAlignmentLeft;
    telLab.font = [UIFont systemFontOfSize:14];
    telLab.textColor = ColorWithRGB(97, 103, 111, 1);
    telLab.numberOfLines = 0;
    [telLab sizeToFit];
    [self.scrollView addSubview:telLab];

    //设置scrollView内容物大小
    CGFloat scrollViewHeight = 0.0;
    for (UIView* view in self.scrollView.subviews)
    {
        scrollViewHeight += view.frame.size.height;
    }
    [self.scrollView setContentSize:(CGSizeMake(0, scrollViewHeight+21*4))];

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
