//
//  DocPatientTableViewCell.m
//  
//
//  Created by 张昊辰 on 15/12/7.
//
//

#import "DocPatientTableViewCell.h"
#import "MX_MASConstraintMaker.h"
#import "View+MASAdditions.h"
@implementation DocPatientTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)drawCell
{
    UIView * view=[[UIView alloc] initWithFrame:CGRectMake(5, 5, appWidth-10, 110)];
    view.backgroundColor=[UIColor clearColor];
    
    //背景图层
    UIView * background=[[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth-10, 110)];
    background.backgroundColor=[UIColor whiteColor];
    background.alpha=0.6;
    [view addSubview:background];
    
    [self.contentView addSubview:view];
    
    
    UIImageView * headImage=[[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 90, 70)];
    [headImage setImage:[UIImage imageNamed:_headImg]];
    [view addSubview:headImage];
    
    UILabel * label=[[UILabel alloc] init];
    label.text=@"患者：";
    label.font=[UIFont systemFontOfSize:14];
    [view addSubview:label];
    [label mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top).with.offset(40);
        make.left.equalTo(headImage.mas_right).with.offset(25);
        make.right.equalTo(view.mas_right).with.offset(-10);
    }];
    
    UILabel * serviceStatus=[[UILabel alloc] init];
    serviceStatus.text=_patientName;
    serviceStatus.font=[UIFont systemFontOfSize:14];
    [view addSubview:serviceStatus];
    [serviceStatus mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top).with.offset(40);
        make.left.equalTo(headImage.mas_right).with.offset(60);
        make.right.equalTo(view.mas_right).with.offset(-10);
    }];
    
    UILabel * time=[[UILabel alloc] init];
    time.text=_time;
    time.font=[UIFont systemFontOfSize:14];
    [view addSubview:time];
    [time mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top).with.offset(60);
        make.left.equalTo(headImage.mas_right).with.offset(25);
        make.right.equalTo(view.mas_right).with.offset(-10);
    }];
    
    UILabel * nowCondition=[[UILabel alloc] init];
    nowCondition.textAlignment = UITextAlignmentRight;
    nowCondition.text=_PatientTapy;
    nowCondition.font=[UIFont systemFontOfSize:15];
    nowCondition.textColor=[UIColor colorWithRed:228/255.0 green:71/255.0 blue:78/255.0 alpha:1];
    [view addSubview:nowCondition];
    [nowCondition mas_makeConstraints:^(MX_MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).with.offset(-8);
        make.top.equalTo(view.mas_top).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(100,20));
    }];
    
    
}

@end
