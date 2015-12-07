//
//  DocFinishPatientViewController.h
//  
//
//  Created by 张昊辰 on 15/12/7.
//
//

#import "MDBaseViewController.h"

@interface DocFinishPatientViewController : MDBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)     UITableView * tableView;

@end
