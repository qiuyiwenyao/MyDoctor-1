//
//  MDRecoveryViewController.m
//  MyDoctor
//
//  Created by 巫筠 on 15/11/26.
//  Copyright © 2015年 com.mingxing. All rights reserved.
//

#import "MDRecoveryViewController.h"
#import "NIDropDown.h"


@interface MDRecoveryViewController ()<NIDropDownDelegate,UIGestureRecognizerDelegate>
{
    NIDropDown *dropDown;

}

@property(nonatomic,retain) UIButton * requirBtn;


@end

@implementation MDRecoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.title == nil) {
        self.navigationItem.title = @"术后康复";
    }else
    {
        self.navigationItem.title = self.title;
    }
    
    [self setText];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setText
{
    NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    UILabel * requirLab = [[UILabel alloc] init];
    requirLab.text = @"服务需求:";
    requirLab.frame = CGRectMake(0, 0, [requirLab.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:dic context:nil].size.width, 0);
    requirLab.textAlignment = NSTextAlignmentLeft;
    requirLab.font = [UIFont systemFontOfSize:14];
    requirLab.textColor = ColorWithRGB(97, 103, 111, 1);
    requirLab.numberOfLines = 0;
    [requirLab sizeToFit];
    [self.scrollView addSubview:requirLab];
    
    _requirBtn = [[UIButton alloc] init];
    NSDictionary * dic2 = @{NSFontAttributeName:[UIFont systemFontOfSize:10]};
    [_requirBtn setTitle:@"大型手术术后康复" forState:UIControlStateNormal];
    _requirBtn.frame = CGRectMake(requirLab.width+5, 0, [_requirBtn.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:dic2 context:nil].size.width+20, requirLab.height);
    [_requirBtn setBackgroundImage:[UIImage imageNamed:@"下拉框"] forState:UIControlStateNormal];
    [_requirBtn setTitleColor:ColorWithRGB(97, 103, 111, 1) forState:UIControlStateNormal];
    _requirBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [_requirBtn addTarget:self action:@selector(requirBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:_requirBtn];
    
    UILabel * priceLab = [[UILabel alloc] initWithFrame:CGRectMake(0, requirLab.y+requirLab.height+15, appWidth - 48*2, 0)];
    priceLab.text = @"每次价格:300元";
    priceLab.textColor = ColorWithRGB(97, 103, 111, 1);
    priceLab.textAlignment = NSTextAlignmentLeft;
    priceLab.font = [UIFont systemFontOfSize:14];
    priceLab.numberOfLines = 0;
    [priceLab sizeToFit];
    [self.scrollView addSubview:priceLab];
    
    UILabel * remarkLab = [[UILabel alloc] initWithFrame:CGRectMake(0, priceLab.y+priceLab.height+40, appWidth - 48*2, 0)];
    remarkLab.text = @"备注:视客户评估而定，价格以估计师实际评定为准";
    remarkLab.textColor = ColorWithRGB(97, 103, 111, 1);
    remarkLab.textAlignment = NSTextAlignmentLeft;
    remarkLab.numberOfLines = 0;
    remarkLab.font = [UIFont systemFontOfSize:14];
    [remarkLab sizeToFit];
    [self.scrollView addSubview:remarkLab];
    
    //设置scrollView内容物大小
    CGFloat scrollViewHeight = 0.0;
    for (UIView* view in self.scrollView.subviews)
    {
        scrollViewHeight += view.frame.size.height;
    }
    [self.scrollView setContentSize:(CGSizeMake(0, scrollViewHeight+60))];
    
    //scrollView添加点击事件，使下拉框收回
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    tapGr.delegate = self;
    [self.scrollView addGestureRecognizer:tapGr];
}

//判断点击的是哪个view，确定是否响应事件
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if(touch.view != self.scrollView){
        return NO;
    }else
        return YES;
}

//点击事件，使下拉框收回
-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [dropDown hideDropDown:_requirBtn];
    [self rel];
    NSLog(@"12");
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [textFiled resignFirstResponder];
    [dropDown hideDropDown:_requirBtn];
        [self rel];
//    NSLog(@"12");
}

-(void)requirBtnClick:(id)sender
{
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Hello 0", @"Hello 1", @"Hello 2", @"Hello 3",nil];
    if(dropDown == nil) {
        CGFloat f = _requirBtn.height*arr.count;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr];
        dropDown.delegate = self;
        dropDown.isOffset = 0;

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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
