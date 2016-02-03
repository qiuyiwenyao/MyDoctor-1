//
//  MDDrupDetailViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/12/15.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDDrupDetailViewController.h"
#import "MDRequestModel.h"
#import "MDDrupDetailModel.h"
#import "UIImageView+WebCache.h"

@interface MDDrupDetailViewController ()<sendInfoToCtr>
{
    NSMutableArray * dataSource;
}

@end

@implementation MDDrupDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BRSSysUtil *util = [BRSSysUtil sharedSysUtil];
    [util setNavigationLeftButton:self.navigationItem target:self selector:@selector(backBtnClick) image:[UIImage imageNamed:@"navigationbar_back"] title:nil];
    
    [self requestData];
    
//    [self createView];
    
    
    // Do any additional setup after loading the view.
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

-(void)createView
{
//    @property (nonatomic,assign) int id;
//    @property (nonatomic,assign) NSString * photo;
//    @property (nonatomic,assign) NSString * medicineName;
//    @property (nonatomic,assign) NSString * commonName;
//    @property (nonatomic,assign) NSString * function;
//    @property (nonatomic,assign) NSString * medicinedosage;
//    @property (nonatomic,assign) NSString * untowardeffect;
//    @property (nonatomic,assign) NSString * taboo;
//    @property (nonatomic,assign) NSString * pinyinCode;
//    @property (nonatomic,assign) int categaryId;
//    @property (nonatomic,assign) NSString * unit;
//    @property (nonatomic,assign) NSString * specification;
//    @property (nonatomic,assign) NSString * validity;
    MDDrupDetailModel * model = dataSource[0];
    NSLog(@"%@",model.validity);
    
    UIImageView * topImageView = [[UIImageView alloc] init];
    [topImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil];
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(TOPHEIGHT+18);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.height.equalTo(@((appWidth - 30)/2));
        
    }];

    //下方空白view
    UIView * bgView = [[UIView alloc] init];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    bgView.backgroundColor = ColorWithRGB(255, 255, 255, 0.7);
    [bgView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(topImageView.mas_bottom).with.offset(0);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.equalTo(topImageView.mas_width);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-15);
    }];
    
//    UIScrollView * bgView = [ui];
    //文字设置
    UILabel * titleLab = [[UILabel alloc] init];
    titleLab.text = model.commonName;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.font = [UIFont systemFontOfSize:17];
    titleLab.textColor = RedColor;
    [titleLab sizeToFit];
    [bgView addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(topImageView.mas_bottom).with.offset(15);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    //分割线
    UIView * wireViewLeft = [[UIView alloc] init];
    wireViewLeft.backgroundColor = RedColor;
    UIView * wireViewRirght = [[UIView alloc] init];
    wireViewRirght.backgroundColor = RedColor;
    [bgView addSubview:wireViewLeft];
    [bgView addSubview:wireViewRirght];
    
    [wireViewLeft mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).with.offset(40);
        make.right.equalTo(titleLab.mas_left).with.offset(-25);
        make.centerY.mas_equalTo(titleLab.mas_centerY);
        make.height.equalTo(@1);
    }];
    
    [wireViewRirght mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(bgView.mas_right).with.offset(-40);
        make.left.equalTo(titleLab.mas_right).with.offset(25);
        make.centerY.mas_equalTo(titleLab.mas_centerY);
        make.height.equalTo(@1);
    }];
    
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    //    _scrollView.userInteractionEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [bgView addSubview:scrollView];
    
    
    [scrollView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).with.offset(15);
        make.left.equalTo(bgView.mas_left).with.offset(30);
        make.right.equalTo(bgView.mas_right).with.offset(-30);
        make.bottom.equalTo(bgView.mas_bottom).with.offset(0);
        
    }];
    
    UILabel * nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, appWidth - 90, 0)];
    nameLab.text = [NSString stringWithFormat:@"【药 品 名 称】: %@",model.commonName];
    nameLab.textColor = ColorWithRGB(97, 103, 111, 1);
    nameLab.textAlignment = NSTextAlignmentLeft;
    nameLab.font = [UIFont systemFontOfSize:14];
    nameLab.numberOfLines = 0;
    [nameLab sizeToFit];
    [scrollView addSubview:nameLab];
    
    UILabel * sizeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, nameLab.y+nameLab.height+12, appWidth - 90, 0)];
    sizeLab.text = [NSString stringWithFormat:@"【规 格 型 号】%@",model.specification];
    sizeLab.textColor = ColorWithRGB(97, 103, 111, 1);
    sizeLab.textAlignment = NSTextAlignmentLeft;
    sizeLab.font = [UIFont systemFontOfSize:14];
    sizeLab.numberOfLines = 0;
    [sizeLab sizeToFit];
    [scrollView addSubview:sizeLab];
    
    UILabel * unitLab = [[UILabel alloc] initWithFrame:CGRectMake(0, sizeLab.y+sizeLab.height+12, appWidth - 90, 0)];
    unitLab.text = [NSString stringWithFormat:@"【功 能 主 治】%@",model.function];
    unitLab.textColor = ColorWithRGB(97, 103, 111, 1);
    unitLab.textAlignment = NSTextAlignmentLeft;
    unitLab.font = [UIFont systemFontOfSize:14];
    unitLab.numberOfLines = 0;
    [unitLab sizeToFit];
    [scrollView addSubview:unitLab];
    
    UILabel * usageLab = [[UILabel alloc] initWithFrame:CGRectMake(0, unitLab.y+unitLab.height+12, appWidth - 90, 0)];
    usageLab.text = [NSString stringWithFormat:@"【用 法 用 量】%@",model.medicinedosage];
    usageLab.textColor = ColorWithRGB(97, 103, 111, 1);
    usageLab.textAlignment = NSTextAlignmentLeft;
    usageLab.font = [UIFont systemFontOfSize:14];
    usageLab.numberOfLines = 0;
    [usageLab sizeToFit];
    [scrollView addSubview:usageLab];
    
//    UILabel * introduceLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, appWidth - 48*2, 0)];
//    introduceLab.text = @"    工作经验丰富专业技能娴熟，各类证书齐全，本着尽心尽职的同时现利用空余时间为本市区内不方便去医院打针，挂水，输液的病人提供上门服务";
//    introduceLab.textAlignment = NSTextAlignmentLeft;
//    introduceLab.font = [UIFont systemFontOfSize:14];
//    introduceLab.textColor = ColorWithRGB(97, 103, 111, 1);
//    introduceLab.numberOfLines = 0;
//    [introduceLab sizeToFit];
//    [self.scrollView addSubview:introduceLab];

    
    UILabel * functionLab = [[UILabel alloc] initWithFrame:CGRectMake(0, usageLab.y+usageLab.height+12, appWidth - 92, 0)];
    functionLab.text = [NSString stringWithFormat:@"【不 良 反 应】%@",model.untowardeffect];
    functionLab.textColor = ColorWithRGB(97, 103, 111, 1);
    functionLab.textAlignment = NSTextAlignmentLeft;
    functionLab.font = [UIFont systemFontOfSize:14];
    functionLab.numberOfLines = 0;
    [functionLab sizeToFit];
    [scrollView addSubview:functionLab];
    
    UILabel * ValidLab = [[UILabel alloc] initWithFrame:CGRectMake(0, functionLab.y+functionLab.height+12, scrollView.width, 0)];
    ValidLab.text = [NSString stringWithFormat:@"【禁 忌】%@",model.taboo];
    ValidLab.textColor = ColorWithRGB(97, 103, 111, 1);
    ValidLab.textAlignment = NSTextAlignmentLeft;
    ValidLab.font = [UIFont systemFontOfSize:14];
    [ValidLab sizeToFit];
    ValidLab.numberOfLines = 0;
    [scrollView addSubview:ValidLab];
    
    UILabel * approvalNumLab = [[UILabel alloc] initWithFrame:CGRectMake(0, ValidLab.y+ValidLab.height+12, appWidth - 90, 0)];
    approvalNumLab.text = [NSString stringWithFormat:@"【保 质 期】%@",model.validity];
    approvalNumLab.numberOfLines = 0;
    [approvalNumLab sizeToFit];
    approvalNumLab.textColor = ColorWithRGB(97, 103, 111, 1);
    approvalNumLab.textAlignment = NSTextAlignmentLeft;
    approvalNumLab.font = [UIFont systemFontOfSize:14];
    [approvalNumLab sizeToFit];
    [scrollView addSubview:approvalNumLab];
    
    UILabel * productionLab = [[UILabel alloc] initWithFrame:CGRectMake(0, approvalNumLab.y+approvalNumLab.height+12,appWidth - 90, 0)];
    productionLab.text = [[NSString alloc] initWithFormat:@"【生 产 企 业】%@",model.habitat];
    productionLab.numberOfLines = 0;
    [productionLab sizeToFit];
    productionLab.textColor = ColorWithRGB(97, 103, 111, 1);
    productionLab.textAlignment = NSTextAlignmentLeft;
    productionLab.font = [UIFont systemFontOfSize:14];
    [scrollView addSubview:productionLab];

    CGFloat scrollViewHeight = 0.0;
    for (UIView* view in scrollView.subviews)
    {
        scrollViewHeight += view.frame.size.height;
    }
    [scrollView setContentSize:(CGSizeMake(0, scrollViewHeight+12*7))];

    
}

//请求数据
-(void)requestData
{
    MDRequestModel * model = [[MDRequestModel alloc] init];
    model.path = MDPath;
    model.methodNum = 10305;
    NSString * parameter = [NSString stringWithFormat:@"%d",self.drugID];
    model.parameter = parameter;
    model.delegate = self;
    [model starRequest];
}

-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    /*
     "id": 3,
     "photo": "http://p3.maiyaole.com/img/50082/50082920/org_org.jpg?a=421394179",
     "medicineName": "美林 布洛芬混悬液 30ml",
     "commonName": "布洛芬混悬液",
     "function": "用于儿童普通感冒或流行性感冒引起的发热。也用于缓解儿童轻至中度疼痛如头痛、关节痛，神经痛，偏头痛，肌肉痛，牙痛。",
     "medicinedosage": "口服，12岁以下小儿用量见下： 1—3岁，体重10—15公斤，一次用量4毫升。4—6岁，体重16—21公斤， 一次用量5毫升。 7—9岁，体重22—27公斤，一次用量8毫升。 10—12岁，体重28—32公斤，一次用量10毫升。 若持续疼痛或发热，可每隔4—6小时重复用药一次，24小时不超过4次。",
     "untowardeffect": "1.少数病人可出现恶心、呕吐、胃烧灼感或轻度消化不良，胃肠道溃疡及出血、转氨酶升高、头痛、头晕、耳鸣、视力模糊、精神紧张、嗜睡、下肢水肿或体重骤增。2.罕见皮疹、过敏性肾炎、膀胱炎、肾病综合症、肾乳头坏死或肾功能衰竭、支气管痉挛。",
     "taboo": "1.对其他非甾体抗炎药过敏者禁用。2.对阿司匹林过敏的哮喘患者禁用。",
     "pinyinCode": "BuLuoFenHunXuanYe",
     "categaryId": 2,
     "unit": "1",
     "specification": "30ml*1瓶/盒",
     "validity": "暂定36个月"    },*/
//    MDLog(@"%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
    NSLog(@"%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
    NSDictionary * dictionary = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
    MDDrupDetailModel * model = [[MDDrupDetailModel alloc] init];
    [model setValuesForKeysWithDictionary:[dictionary objectForKey:@"obj"]];
    
    dataSource = [[NSMutableArray alloc] initWithObjects:model, nil];
    
    MDLog(@"=====%@",model.validity);
    
    [self createView];
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
