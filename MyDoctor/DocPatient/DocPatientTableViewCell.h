//
//  DocPatientTableViewCell.h
//  
//
//  Created by 张昊辰 on 15/12/7.
//
//

#import <UIKit/UIKit.h>
#import "MDConst.h"

@interface DocPatientTableViewCell : UITableViewCell
@property (nonatomic, strong) NSString * patientName;
@property (nonatomic, strong) NSString * PatientTapy;
@property (nonatomic, strong) NSString * time;

-(void)drawCell;

@end
