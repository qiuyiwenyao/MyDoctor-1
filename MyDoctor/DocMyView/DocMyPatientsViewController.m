//
//  DocMyPatientsViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/12/7.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "DocMyPatientsViewController.h"
#import "NIDropDown.h"

@interface DocMyPatientsViewController ()<NIDropDownDelegate>
{
    UIView * _headerView;
    UITableView * _tableView;
    UIView * backView;
    NIDropDown *dropDown;

}
@property(nonatomic,retain) UIButton * requirBtn;

@end



@implementation DocMyPatientsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的患者";
    
    [self setNavigationBarWithrightBtn:nil leftBtn:@"navigationbar_back"];
    
    //返回按钮点击
    [self.leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self createTableView];

    
    [self createHeaderView];
    


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//返回按钮点击

-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES
     ];
    
}

-(void)createHeaderView
{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, TOPHEIGHT+18, appWidth, appWidth/4)];
    _headerView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:_headerView];
    
    mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, appWidth, 40)];
    mySearchBar.delegate = self;
    [mySearchBar setPlaceholder:@"输入患者姓名"];
    
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:mySearchBar contentsController:self];
    searchDisplayController.active = NO;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    backView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth, 40)];
    backView.backgroundColor=[UIColor clearColor];
    [backView addSubview:mySearchBar];
    [_headerView addSubview:backView];
    
    
    _requirBtn = [[UIButton alloc] init];
    [_requirBtn setTitle:@"2015年7月" forState:UIControlStateNormal];
    _requirBtn.frame = CGRectMake(0, mySearchBar.y+mySearchBar.height+10, appWidth*25.0/62.0, _headerView.height - mySearchBar.height - 10);
    [_requirBtn setBackgroundImage:[UIImage imageNamed:@"下拉框"] forState:UIControlStateNormal];
    [_requirBtn setTitleColor:ColorWithRGB(97, 103, 111, 1) forState:UIControlStateNormal];
    _requirBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_requirBtn addTarget:self action:@selector(requirBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_headerView addSubview:_requirBtn];

}

-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, appWidth, appHeight - 18) style:UITableViewStylePlain];
    _tableView.delegate  =self;
    _tableView.dataSource = self;
    _tableView.contentInset = UIEdgeInsetsMake(TOPHEIGHT+18, 0, 0, 0);
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(18+TOPHEIGHT, 0, 0, 0);
    [self.view addSubview:_tableView];
    
    _tableView.tableHeaderView = _headerView;
}

-(void)requirBtnClick:(id)sender
{
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Hello 0", @"Hello 1", @"Hello 2", @"Hello 3",nil];
    if(dropDown == nil) {
        CGFloat f = _requirBtn.height*arr.count;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr];
        dropDown.delegate = self;
        
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
    
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    dropDown = nil;
}

#pragma UISearchDisplayDelegate
//searchBar开始编辑时改变取消按钮的文字
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    mySearchBar.showsCancelButton = YES;
    backView.frame=CGRectMake(0, 20, appWidth, appHeight);
    NSArray *subViews;
    
    if (is_IOS_7) {
        subViews = [(mySearchBar.subviews[0]) subviews];
    }
    else {
        subViews = mySearchBar.subviews;
    }
    
    for (id view in subViews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton* cancelbutton = (UIButton* )view;
            [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
            break;
        }
    }
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    
    backView.frame= CGRectMake(0, 0, appWidth, 40);
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    searchResults = [[NSMutableArray alloc]init];
    
    [self filterContentForSearchText:searchText];
    
}

-(void)filterContentForSearchText:(NSString*)searchText
{
    NSMutableArray *tempResults = [NSMutableArray array];
    NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
    
    for (int i = 0; i < dataArray.count; i++) {
        NSString *storeString = dataArray[i];
        NSRange storeRange = NSMakeRange(0, storeString.length);
        NSRange foundRange = [storeString rangeOfString:searchText options:searchOptions range:storeRange];
        if (foundRange.length) {
            [tempResults addObject:storeString];
        }
    }
    
    [searchResults removeAllObjects];
    [searchResults addObjectsFromArray:tempResults];
}

#pragma UITableViewDataSource
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    _tableView.tableHeaderView = _headerView;
    [_tableView sendSubviewToBack:_headerView];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   
    return 20;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * iden = @"iden";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == 0) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    
    return cell;
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
