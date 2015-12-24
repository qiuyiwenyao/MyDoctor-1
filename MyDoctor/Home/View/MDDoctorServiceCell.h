//
//  MDDoctorServiceCell.h
//  MyDoctor
//
//  Created by 巫筠 on 15/12/24.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDDoctorServiceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *branchLab;
@property (weak, nonatomic) IBOutlet UILabel *hospitalLab;
@property (weak, nonatomic) IBOutlet UILabel *majorLab;

@end
