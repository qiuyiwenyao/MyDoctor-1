//
//  DocMyPatientsViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/12/7.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "DocMyPatientsViewController.h"
#import "NIDropDown.h"
#import "DocMyPatientsCell.h"
#import "DocMyPatientsModel.h"

@interface DocMyPatientsViewController ()<NIDropDownDelegate,UIGestureRecognizerDelegate>
{
    UIView * _headerView;
    UITableView * _tableView;
    UIView * backView;
    NIDropDown *dropDown;

}
@property(nonatomic,retain) UIButton * requirBtn;
@property (nonatomic,strong) NSMutableArray * dataSource;

@end



@implementation DocMyPatientsViewController

-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
        DocMyPatientsModel * group0 = [[DocMyPatientsModel alloc] init];
        group0.headImg = @"大妈.jpg";
        group0.name = @"张大妈";
        group0.age = @"58";
        group0.sex = @"女";
        
        DocMyPatientsModel * group1 = [[DocMyPatientsModel alloc] init];
        group1.headImg = @"大叔";
        group1.name = @"李大叔";
        group1.age = @"44";
        group1.sex = @"男";
        
        DocMyPatientsModel * group2 = [[DocMyPatientsModel alloc] init];
        group2.headImg = @"大爷.jpg";
        group2.name = @"赵大爷";
        group2.age = @"68";
        group2.sex = @"男";
        
        DocMyPatientsModel * group3 = [[DocMyPatientsModel alloc] init];
        group3.headImg = @"叔叔.jpg";
        group3.name = @"老王";
        group3.age = @"39";
        group3.sex = @"男";
        
        DocMyPatientsModel * group4 = [[DocMyPatientsModel alloc] init];
        group4.headImg = @"大婶.jpg";
        group4.name = @"张妈";
        group4.age = @"58";
        group4.sex = @"女";
        
        [_dataSource addObject:group0];
        [_dataSource addObject:group1];
        [_dataSource addObject:group2];
        [_dataSource addObject:group3];
        [_dataSource addObject:group4];

    }
    return _dataSource;
}

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
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth, 20)];
    _headerView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:_headerView];
    
    mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, appWidth, 40)];
    mySearchBar.delegate = self;
    [mySearchBar setPlaceholder:@"输入患者姓名"];
    
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:mySearchBar contentsController:self];
    searchDisplayController.active = NO;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
//    backView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, appWidth, 40)];
//    backView.backgroundColor=[UIColor clearColor];
//    [backView addSubview:mySearchBar];
    
    
    _requirBtn = [[UIButton alloc] init];
    [_requirBtn setTitle:@"2015年7月" forState:UIControlStateNormal];
    _requirBtn.frame = CGRectMake(0, 0,100,20);
    [_requirBtn setBackgroundImage:[UIImage imageNamed:@"下拉框"] forState:UIControlStateNormal];
    [_requirBtn setTitleColor:ColorWithRGB(97, 103, 111, 1) forState:UIControlStateNormal];
    _requirBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    _requirBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_requirBtn addTarget:self action:@selector(requirBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_headerView addSubview:_requirBtn];

}

-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOPHEIGHT, appWidth, appHeight-TOPHEIGHT) style:UITableViewStylePlain];
    _tableView.delegate  =self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
//    _tableView.contentInset = UIEdgeInsetsMake(18, 0, 0, 0);
//    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(18, 0, 0, 0);
    [self.view addSubview:_tableView];
    
//    _tableView.tableHeaderView = mySearchBar;
    
    //注册nib
    [_tableView registerNib:[UINib nibWithNibName:@"DocMyPatientsCell" bundle:nil] forCellReuseIdentifier:@"iden"];
    
    //scrollView添加点击事件，使下拉框收回
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    tapGr.delegate = self;
//    [_tableView addGestureRecognizer:tapGr];

}

//判断点击的是哪个view，确定是否响应事件
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if(touch.view != _tableView.tableHeaderView){
        return NO;
    }else
        return YES;
}

//点击事件，使下拉框收回
-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [dropDown hideDropDown:_requirBtn];
    [self rel];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //    [textFiled resignFirstResponder];
    [dropDown hideDropDown:_requirBtn];
    [self rel];
}


-(void)requirBtnClick:(id)sender
{
//    dropDown.isOffset = @"1";

    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"2015年10月",@"2015年11月",@"2015年12月",nil];
    if(dropDown == nil) {
        CGFloat f = _requirBtn.height*arr.count;
        dropDown = [[NIDropDown alloc] init];
        dropDown.Offset = 45;
        dropDown.textshowStyle = TextShowStyleLeft;
        dropDown.font = 13;
        [dropDown showDropDown:sender :&f :arr];
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
//    backView.frame=CGRectMake(0, 20, appWidth, appHeight);
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
   
//    _headerView.frame=CGRectMake(0, 40, 100, 20);
//    _headerView.hidden=NO;
//    backView.frame= CGRectMake(0, 0, appWidth, 40);
    [_tableView reloadData];
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

#pragma UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}


-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    _tableView.tableHeaderView = mySearchBar;
    [_tableView sendSubviewToBack:mySearchBar];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30;
    }
    else
    {
        return 20;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * iden = @"iden";
    DocMyPatientsCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == 0) {
        cell = [[DocMyPatientsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    
    cell.backgroundColor = ColorWithRGB(255, 255, 255, 0.7);
    
    //取出数据源数据
    DocMyPatientsModel * model = self.dataSource[indexPath.section];
    cell.headerView.image = [UIImage imageNamed:model.headImg];
    cell.nameLab.text = [NSString stringWithFormat:@"姓名: %@",model.name];
    cell.ageLab.text = [NSString stringWithFormat:@"年龄: %@岁",model.age];
    cell.sexyLab.text = [NSString stringWithFormat:@"性别: %@",model.sex];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return appWidth/3;
}

//填充每个cell间距的view，使之透明
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        [_tableView sendSubviewToBack:_headerView];
        return _headerView;
        
    }
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
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
