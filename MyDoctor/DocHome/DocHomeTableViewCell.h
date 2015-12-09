//
//  DocHomeTableViewCell.h
//  
//
//  Created by 张昊辰 on 15/12/7.
//
//

#import <UIKit/UIKit.h>
#import "MDConst.h"

@interface DocHomeTableViewCell : UITableViewCell
@property (nonatomic, strong) NSString * serviceType;
@property (nonatomic, strong) NSString * serviceStatus;
@property (nonatomic, strong) NSString * time;
@property (nonatomic, strong) NSString * headImg;

-(void)drawCell;

@end
