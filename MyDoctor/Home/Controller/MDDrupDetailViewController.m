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
#import "BRSlogInViewController.h"

#import "HWPopTool.h"
#import "MDSelectNumView.h"

@interface MDDrupDetailViewController ()<sendInfoToCtr>
{
    NSMutableArray * dataSource;
    UIScrollView * bgScrollView;
    UIButton * shopCartButton;
    UIButton * buyButton;
    UIView * infoView;
    UIImage * drugImg;
    NSString * price;
}

@end

@implementation MDDrupDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BRSSysUtil *util = [BRSSysUtil sharedSysUtil];
    [util setNavigationLeftButton:self.navigationItem target:self selector:@selector(backBtnClick) image:[UIImage imageNamed:@"navigationbar_back"] title:nil];
    
    //下方按钮
    shopCartButton = [[UIButton alloc] init];
    [shopCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    [shopCartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shopCartButton setBackgroundColor:ColorWithRGB(227, 124, 2, 1)];
    shopCartButton.titleLabel.font = [UIFont systemFontOfSize:21];
    [shopCartButton addTarget:self action:@selector(shopCartClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shopCartButton];
    
    buyButton = [[UIButton alloc] init];
    [buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyButton setBackgroundColor:ColorWithRGB(227, 4, 47, 1)];
    [buyButton addTarget:self action:@selector(buyClick) forControlEvents:UIControlEventTouchUpInside];
    buyButton.titleLabel.font = [UIFont systemFontOfSize:21];
    [self.view addSubview:buyButton];
    
    [shopCartButton mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.height.equalTo(@(appWidth/2*0.26));
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.equalTo(buyButton);
    }];
    [buyButton mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(shopCartButton);
        make.left.equalTo(shopCartButton.mas_right);
        make.top.equalTo(shopCartButton.mas_top);
    }];


    
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
    MDDrupDetailModel * model = dataSource[0];

    bgScrollView = [[UIScrollView alloc] init];
    bgScrollView.scrollEnabled = YES;
    [self.view addSubview:bgScrollView];
    [bgScrollView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(TOPHEIGHT);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(buyButton.mas_top);
    }];
    
    UIImageView * topImageView = [[UIImageView alloc] init];
    topImageView.contentMode = UIViewContentModeScaleAspectFit;
    [topImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[MDUserVO userVO].photourl, model.photo]] placeholderImage:[UIImage imageNamed:@"药"]];
    drugImg = topImageView.image;
    [bgScrollView addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(bgScrollView.mas_top).with.offset(0);
        make.left.equalTo(bgScrollView.mas_left);
        make.height.equalTo(@(appWidth));
        
    }];
    
    UILabel * titleLab = [[UILabel alloc] init];
    titleLab.text = model.medicineName;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.numberOfLines = 0;
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.font = [UIFont boldSystemFontOfSize:22];
    [titleLab sizeToFit];
    [bgScrollView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgScrollView.mas_centerX);
        make.left.equalTo(bgScrollView.mas_left).with.offset(35);
        make.top.equalTo(topImageView.mas_bottom).with.offset(6);
    }];
    
    UILabel * priceLabel = [[UILabel alloc] init];
    priceLabel.text = @"¥10.0";
    price = @"10.0";
    priceLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.numberOfLines = 0;
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.font = [UIFont systemFontOfSize:24];
    priceLabel.textColor = ColorWithRGB(202, 0, 19, 1);
    [bgScrollView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(titleLab.mas_left);
        make.top.equalTo(titleLab.mas_bottom).with.offset(12);
        make.centerX.mas_equalTo(bgScrollView.mas_centerX);
    }];
    
    UILabel * primePriceLabel = [[UILabel alloc] init];
    NSMutableAttributedString *primePriceStr = [[NSMutableAttributedString alloc] initWithString:@"原价 ¥13.5"];
    [primePriceStr setAttributes:@{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(2, primePriceStr.length-2)];
    primePriceLabel.attributedText = primePriceStr;
    primePriceLabel.textAlignment = NSTextAlignmentLeft;
    primePriceLabel.numberOfLines = 0;
    primePriceLabel.backgroundColor = [UIColor clearColor];
    primePriceLabel.font = [UIFont systemFontOfSize:17];
    primePriceLabel.textColor = ColorWithRGB(130, 130, 130, 1);
    [bgScrollView addSubview:primePriceLabel];
    [primePriceLabel mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(titleLab.mas_left);
        make.top.equalTo(priceLabel.mas_bottom).with.offset(8);
        make.centerX.mas_equalTo(bgScrollView.mas_centerX);

    }];
    
    UILabel * nameLab = [[UILabel alloc] init];
    nameLab.text = [NSString stringWithFormat:@"【药 品 名 称】: %@",model.medicineName];
    nameLab.textColor = ColorWithRGB(97, 103, 111, 1);
    nameLab.textAlignment = NSTextAlignmentLeft;
    nameLab.font = [UIFont systemFontOfSize:14];
    nameLab.numberOfLines = 0;
    [nameLab sizeToFit];
    [bgScrollView addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(titleLab.mas_left).with.offset(-8);
        make.top.equalTo(primePriceLabel.mas_bottom).with.offset(50);
        make.centerX.mas_equalTo(bgScrollView.mas_centerX);
        
    }];
    
    UILabel * sizeLab = [[UILabel alloc] init];
    sizeLab.text = [NSString stringWithFormat:@"【规 格 型 号】%@",model.specification];
    sizeLab.textColor = ColorWithRGB(97, 103, 111, 1);
    sizeLab.textAlignment = NSTextAlignmentLeft;
    sizeLab.font = [UIFont systemFontOfSize:14];
    sizeLab.numberOfLines = 0;
    [sizeLab sizeToFit];
    [bgScrollView addSubview:sizeLab];
    [sizeLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(nameLab.mas_left);
        make.top.equalTo(nameLab.mas_bottom).with.offset(12);
        make.centerX.mas_equalTo(bgScrollView.mas_centerX);
        
    }];
    
    UILabel * unitLab = [[UILabel alloc] init];
    unitLab.text = [NSString stringWithFormat:@"【功 能 主 治】%@",model.function];
    unitLab.textColor = ColorWithRGB(97, 103, 111, 1);
    unitLab.textAlignment = NSTextAlignmentLeft;
    unitLab.font = [UIFont systemFontOfSize:14];
    unitLab.numberOfLines = 0;
    [unitLab sizeToFit];
    [bgScrollView addSubview:unitLab];
    [unitLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(nameLab.mas_left);
        make.top.equalTo(sizeLab.mas_bottom).with.offset(12);
        make.centerX.mas_equalTo(bgScrollView.mas_centerX);
        
    }];
    
    UILabel * usageLab = [[UILabel alloc] init];
    usageLab.text = [NSString stringWithFormat:@"【用 法 用 量】%@",model.medicinedosage];
    usageLab.textColor = ColorWithRGB(97, 103, 111, 1);
    usageLab.textAlignment = NSTextAlignmentLeft;
    usageLab.font = [UIFont systemFontOfSize:14];
    usageLab.numberOfLines = 0;
    [usageLab sizeToFit];
    [bgScrollView addSubview:usageLab];
    [usageLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(nameLab.mas_left);
        make.top.equalTo(unitLab.mas_bottom).with.offset(12);
        make.centerX.mas_equalTo(bgScrollView.mas_centerX);
        
    }];
    
    UILabel * functionLab = [[UILabel alloc] initWithFrame:CGRectMake(0, usageLab.y+usageLab.height+12, appWidth - 92, 0)];
    functionLab.text = [NSString stringWithFormat:@"【不 良 反 应】%@",model.untowardeffect];
    functionLab.textColor = ColorWithRGB(97, 103, 111, 1);
    functionLab.textAlignment = NSTextAlignmentLeft;
    functionLab.font = [UIFont systemFontOfSize:14];
    functionLab.numberOfLines = 0;
    [functionLab sizeToFit];
    [bgScrollView addSubview:functionLab];
    [functionLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(nameLab.mas_left);
        make.top.equalTo(usageLab.mas_bottom).with.offset(12);
        make.centerX.mas_equalTo(bgScrollView.mas_centerX);
        
    }];
    
    UILabel * ValidLab = [[UILabel alloc] initWithFrame:CGRectMake(0, functionLab.y+functionLab.height+12, bgScrollView.width, 0)];
    ValidLab.text = [NSString stringWithFormat:@"【禁 忌】%@",model.taboo];
    ValidLab.textColor = ColorWithRGB(97, 103, 111, 1);
    ValidLab.textAlignment = NSTextAlignmentLeft;
    ValidLab.font = [UIFont systemFontOfSize:14];
    [ValidLab sizeToFit];
    ValidLab.numberOfLines = 0;
    [bgScrollView addSubview:ValidLab];
    [ValidLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(nameLab.mas_left);
        make.top.equalTo(functionLab.mas_bottom).with.offset(12);
        make.centerX.mas_equalTo(bgScrollView.mas_centerX);
        
    }];
    
    UILabel * approvalNumLab = [[UILabel alloc] initWithFrame:CGRectMake(0, ValidLab.y+ValidLab.height+12, appWidth - 70, 0)];
    approvalNumLab.text = [NSString stringWithFormat:@"【保 质 期】%@",model.validity];
    approvalNumLab.numberOfLines = 0;
    [approvalNumLab sizeToFit];
    approvalNumLab.textColor = ColorWithRGB(97, 103, 111, 1);
    approvalNumLab.textAlignment = NSTextAlignmentLeft;
    approvalNumLab.font = [UIFont systemFontOfSize:14];
    [approvalNumLab sizeToFit];
    [bgScrollView addSubview:approvalNumLab];
    [approvalNumLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(nameLab.mas_left);
        make.top.equalTo(ValidLab.mas_bottom).with.offset(12);
        make.centerX.mas_equalTo(bgScrollView.mas_centerX);
        
    }];
    
    UILabel * productionLab = [[UILabel alloc] initWithFrame:CGRectMake(0, approvalNumLab.y+approvalNumLab.height+12,appWidth - 70, 0)];
    productionLab.text = [[NSString alloc] initWithFormat:@"【生 产 企 业】%@",model.commonName];
    productionLab.numberOfLines = 0;
    [productionLab sizeToFit];
    productionLab.textColor = ColorWithRGB(97, 103, 111, 1);
    productionLab.textAlignment = NSTextAlignmentLeft;
    productionLab.font = [UIFont systemFontOfSize:14];
    [bgScrollView addSubview:productionLab];
    [productionLab mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.left.equalTo(nameLab.mas_left);
        make.top.equalTo(approvalNumLab.mas_bottom).with.offset(12);
        make.centerX.mas_equalTo(bgScrollView.mas_centerX);
        
    }];
    
    //重新设置bgScrollView内容物大小
    [bgScrollView mas_updateConstraints:^(MX_MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(TOPHEIGHT);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(productionLab.mas_bottom).with.offset(8);
    
    }];
    
}

-(void)shopCartClick
{
    NSUserDefaults * stdDefault = [NSUserDefaults standardUserDefaults];
    NSString * str=[stdDefault objectForKey:@"user_name"];
    if ([str length]>0) {
        MDSelectNumView * view = [[MDSelectNumView alloc] initWithFrame:CGRectMake(0, appHeight * 0.60, appWidth, appHeight * 0.40) andImage:drugImg andReserveNum:@"9" andPlan:@"套餐二" andPrice:price];
        
        [HWPopTool sharedInstance].shadeBackgroundType = ShadeBackgroundTypeSolid;
        [HWPopTool sharedInstance].closeButtonType = ButtonPositionTypeRight;
        [[HWPopTool sharedInstance] showWithPresentView:view animated:YES];
        

        
    }else{
        BRSlogInViewController * logIn=[[BRSlogInViewController alloc] init];
        UINavigationController * nvc=[[UINavigationController alloc] initWithRootViewController:logIn];
        
        nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:nvc animated:NO completion:nil];
    }

}

-(void)buyClick
{
    NSUserDefaults * stdDefault = [NSUserDefaults standardUserDefaults];
    NSString * str=[stdDefault objectForKey:@"user_name"];
    if ([str length]>0) {
        MDSelectNumView * view = [[MDSelectNumView alloc] initWithFrame:CGRectMake(0, appHeight * 0.60, appWidth, appHeight * 0.40) andImage:drugImg andReserveNum:@"11" andPlan:@"套餐二" andPrice:price];
        
        [HWPopTool sharedInstance].shadeBackgroundType = ShadeBackgroundTypeSolid;
        [HWPopTool sharedInstance].closeButtonType = ButtonPositionTypeRight;
        [[HWPopTool sharedInstance] showWithPresentView:view animated:YES];
        
        
    }else{
        BRSlogInViewController * logIn=[[BRSlogInViewController alloc] init];
        UINavigationController * nvc=[[UINavigationController alloc] initWithRootViewController:logIn];
        
        nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:nvc animated:NO completion:nil];
    }
}

- (void)setInfoViewFrame:(BOOL)isDown{
    if(isDown == NO)
    {
        [UIView animateWithDuration:0.1
                              delay:0.0
                            options:0
                         animations:^{
                             [infoView setFrame:CGRectMake(0, appHeight+60, 320, 90)];
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.1
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveEaseIn
                                              animations:^{
                                                  [infoView setFrame:CGRectMake(0, appHeight, 320, 90)];
                                                  
                                                  [bgScrollView addSubview:infoView];
                                              }
                                              completion:^(BOOL finished) {
                                              }];
                         }];
        
    }else
    {
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:0
                         animations:^{
                             [infoView setFrame:CGRectMake(0, 100, 320, 90)];
                             
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.5
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveEaseIn
                                              animations:^{
                                                  [infoView setFrame:CGRectMake(0, 200 ,320, 90)];
                                              }
                                              completion:^(BOOL finished) {
                                              }];
                         }];
        
        [bgScrollView addSubview:infoView];

    }
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

#pragma mark - sendInfoToCtrDelegate
-(void)sendInfoFromRequest:(id)response andPath:(NSString *)path number:(NSInteger)num
{
    if (response) {
        NSLog(@"%@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
        NSDictionary * dictionary = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        MDDrupDetailModel * model = [[MDDrupDetailModel alloc] init];
        [model setValuesForKeysWithDictionary:[dictionary objectForKey:@"obj"]];
        
        dataSource = [[NSMutableArray alloc] initWithObjects:model, nil];
        
        MDLog(@"=====%@",model.validity);
        
        [self createView];

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
