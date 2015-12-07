//
//  DocMyPatientsViewController.h
//  MyDoctor
//
//  Created by 巫筠 on 15/12/7.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDBaseViewController.h"

@interface DocMyPatientsViewController : MDBaseViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    NSMutableArray *dataArray;
    NSMutableArray *searchResults;
    UISearchBar *mySearchBar;
    UISearchDisplayController *searchDisplayController;
    
}


@end
