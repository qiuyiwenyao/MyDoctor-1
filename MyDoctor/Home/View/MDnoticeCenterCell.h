//
//  noticeCenterCell.h
//  MyDoctor
//
//  Created by 巫筠 on 15/12/1.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDnoticeCenterCell : UITableViewCell
@property(nonatomic,strong) NSString * title;
@property(nonatomic,strong) NSString * time;
@property(nonatomic,strong) NSString * detail;
@property (nonatomic,strong) UILabel * contentLab;
@property (nonatomic,assign) CGFloat cellHeight;


-(void)drawCell;

@end
