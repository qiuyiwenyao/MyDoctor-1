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
    CGFloat oldKeyboardHight;
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
    oldKeyboardHight=0;
    [self setText];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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
    _requirBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    _requirBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 14);
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
    remarkLab.text = @"备注:";
    remarkLab.textColor = ColorWithRGB(97, 103, 111, 1);
    remarkLab.textAlignment = NSTextAlignmentLeft;
    remarkLab.numberOfLines = 0;
    remarkLab.font = [UIFont systemFontOfSize:14];
    [remarkLab sizeToFit];
    [self.scrollView addSubview:remarkLab];
    
    self.remarkView = [[UITextView alloc] initWithFrame:CGRectMake(remarkLab.x+remarkLab.width, remarkLab.y, appWidth - 45*2, 80 )];
   self.remarkView.backgroundColor = [UIColor whiteColor];
    self.remarkView.delegate=self;
    self.remarkView.font = [UIFont systemFontOfSize:14];
    [self.scrollView addSubview:self.remarkView];

    
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
    [self.remarkView resignFirstResponder];

    [self rel];
    NSLog(@"12");
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [textFiled resignFirstResponder];
    [self.remarkView resignFirstResponder];

    [dropDown hideDropDown:_requirBtn];

        [self rel];
//    NSLog(@"12");
}

-(void)requirBtnClick:(id)sender
{
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"膝关节术后康复", @"跟腱断裂术后康复", @"半月板损伤康复", @"脑血栓康复训练",nil];
    if(dropDown == nil) {
        CGFloat f = _requirBtn.height*arr.count;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr];
        dropDown.delegate = self;
        dropDown.font = 10;
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

//其次键盘的高度计算：
-(CGFloat)keyboardEndingFrameHeight:(NSDictionary *)userInfo//计算键盘的高度
{
    CGRect keyboardEndingUncorrectedFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGRect keyboardEndingFrame = [self.view convertRect:keyboardEndingUncorrectedFrame fromView:nil];
    return keyboardEndingFrame.size.height;
}

//然后，根据键盘高度将当前视图向上滚动同样高度。

-(void)keyboardWillAppear:(NSNotification *)notification
{
//    CGRect currentFrame = self.view.frame;
//    CGFloat change = [self keyboardEndingFrameHeight:[notification userInfo]];
//    currentFrame.origin.y = currentFrame.origin.y - change ;
//    
//    NSLog(@"==========%f",change);
//    self.view.frame = currentFrame;
    
    
    
    
//    CGRect begin = [[[notification userInfo] objectForKey:@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
//    CGRect end = [[[notification userInfo] objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
//    
//    // 第三方键盘回调三次问题，监听仅执行最后一次
//    if(begin.size.height>0 ){
        CGRect currentFrame = self.view.frame;
        CGFloat change = [self keyboardEndingFrameHeight:[notification userInfo]];
        CGFloat changeHight=0;
        if (oldKeyboardHight!=0) {
            changeHight=change-oldKeyboardHight;
        }else{
            changeHight=change;
        }
        currentFrame.origin.y = currentFrame.origin.y - changeHight ;
        NSLog(@"==========%f",changeHight);
        self.view.frame = currentFrame;
        oldKeyboardHight=change;
//    }
}
//最后，当键盘消失后，视图需要恢复原状。
-(void)keyboardWillDisappear:(NSNotification *)notification
{
    CGRect currentFrame = self.view.frame;
    CGFloat change = [self keyboardEndingFrameHeight:[notification userInfo]];
    currentFrame.origin.y = currentFrame.origin.y + change ;
    NSLog(@"==========%f",change);
    self.view.frame = currentFrame;
    oldKeyboardHight=0;
}


@end
