//
//  MyPatientsCell.h
//  MyDoctor
//
//  Created by 巫筠 on 15/12/8.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DocMyPatientsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *sexyLab;
@property (weak, nonatomic) IBOutlet UILabel *ageLab;

@end
