//
//  DocUnfinishPatientViewController.h
//  
//
//  Created by 张昊辰 on 15/12/7.
//
//

#import "MDBaseViewController.h"

@interface DocUnfinishPatientViewController : MDBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)     UITableView * tableView;

@end
