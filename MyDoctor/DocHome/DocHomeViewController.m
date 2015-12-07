//
//  DocHomeViewController.m
//  
//
//  Created by 张昊辰 on 15/12/7.
//
//

#import "DocHomeViewController.h"
#import "DocAllWorkViewController.h"
#import "DocOnlineViewController.h"
#import "DocPhoneViewController.h"
#import "DocLookAfterViewController.h"
#import "WbToolBarFour.h"

@interface DocHomeViewController ()

@end

@implementation DocHomeViewController
{
    DocAllWorkViewController * allWork;
    DocOnlineViewController * online;
    DocPhoneViewController * phone;
    DocLookAfterViewController * lookAfter;
    WbToolBarFour * bar;
    int firstShow;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    firstShow=1;
    self.navigationItem.title=@"医生";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushViewInParent:) name:@"pushViewInDocHome" object:nil];
    
    
    if (!bar) {
        bar = [[WbToolBarFour alloc] initWithFrame:CGRectMake(0, 64, appWidth, 40)];
        bar.dataSource = [[NSArray alloc] initWithObjects:@"全部",@"线上咨询",@"电话咨询",@"照护", nil];
        bar.delegate = self;
        [bar drawFristRect:CGRectMake(0, 64, appWidth, 40)];
        [self.view addSubview:bar];
    }
    [self draw];

}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pushViewInDocHome" object:nil];
}
-(void)draw
{
    if(!allWork){
        allWork=[[DocAllWorkViewController alloc] init];
        [self.view addSubview:allWork.view];
    }
    allWork.view.hidden=NO;
    online.view.hidden=YES;
    phone.view.hidden=YES;
    lookAfter.view.hidden=YES;
    if(firstShow==1){
        [self.view bringSubviewToFront:allWork.view];
        [self.view bringSubviewToFront:bar];
        firstShow=0;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//标签选择后调用
-(void) elementSelected:(int)index toolBar:(WbToolBarFour*)toolBar
{
    if (index == 0) {
        if(!allWork){
            allWork=[[DocAllWorkViewController alloc] init];
            [self.view addSubview:allWork.view];
        }
        allWork.view.hidden=NO;
        online.view.hidden=YES;
        phone.view.hidden=YES;
        lookAfter.view.hidden=YES;
        [self.view bringSubviewToFront:allWork.view];
        [self.view bringSubviewToFront:bar];
    }else if (index==1){
        if (!online) {
            online=[[DocOnlineViewController alloc] init];
            [self.view addSubview:online.view];
        }
        allWork.view.hidden=YES;
        online.view.hidden=NO;
        phone.view.hidden=YES;
        lookAfter.view.hidden=YES;
        [self.view bringSubviewToFront:online.view];
        [self.view bringSubviewToFront:bar];
        
    }else if (index==2){
        if (!phone) {
            phone=[[DocPhoneViewController alloc] init];
            [self.view addSubview:phone.view];
        }
        allWork.view.hidden=YES;
        online.view.hidden=YES;
        phone.view.hidden=NO;
        lookAfter.view.hidden=YES;
        [self.view bringSubviewToFront:phone.view];
        [self.view bringSubviewToFront:bar];
    }
    else if (index==3){
        if (!lookAfter) {
            lookAfter=[[DocLookAfterViewController alloc] init];
            [self.view addSubview:lookAfter.view];
        }
        allWork.view.hidden=YES;
        online.view.hidden=YES;
        phone.view.hidden=YES;
        lookAfter.view.hidden=NO;
        [self.view bringSubviewToFront:lookAfter.view];
        [self.view bringSubviewToFront:bar];
    }
}
-(void)pushViewInParent:(id)sender
{
    
    NSString * text= [[sender userInfo] objectForKey:@"text"];
  
}


@end
