//
//  DocOnLineViewController2.m
//  MyDoctor
//
//  Created by 巫筠 on 15/12/28.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "DocOnLineViewController2.h"

@interface DocOnLineViewController2 ()

@end

@implementation DocOnLineViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.searchDisplayController.searchBar removeFromSuperview];
    self.tableView.frame = CGRectMake(0, 110, self.view.frame.size.width, self.view.frame.size.height - 110);
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
