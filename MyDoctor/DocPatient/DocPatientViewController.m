//
//  DocPatientViewController.m
//  
//
//  Created by 张昊辰 on 15/12/7.
//
//

#import "DocPatientViewController.h"
#import "DocAllPatientViewController.h"
#import "DocUnfinishPatientViewController.h"
#import "DocFinishPatientViewController.h"

@interface DocPatientViewController ()

@end

@implementation DocPatientViewController
{
    WBToolBar *bar;
    DocAllPatientViewController * allPatient;
    DocUnfinishPatientViewController * unfinish;
    DocFinishPatientViewController *finish;
    int firstShow;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    firstShow=1;
    self.navigationItem.title=@"患者";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushViewInParent:) name:@"pushViewInPatient" object:nil];
    
    
    if (!bar) {
        bar = [[WBToolBar alloc] initWithFrame:CGRectMake(0, 64, appWidth, 40)];
        bar.dataSource = [[NSArray alloc] initWithObjects:@"全部",@"待付款",@"进行中", nil];
        bar.delegate = self;
        [bar drawFristRect:CGRectMake(0, 64, appWidth, 40)];
        [self.view addSubview:bar];
    }
    [self draw];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pushViewInPatient" object:nil];
    
    
}
-(void)draw
{
    if(!allPatient){
        allPatient=[[DocAllPatientViewController alloc] init];
        [self.view addSubview:allPatient.view];
    }
    allPatient.view.hidden=NO;
    unfinish.view.hidden=YES;
    finish.view.hidden=YES;
    if(firstShow==1){
        [self.view bringSubviewToFront:allPatient.view];
        [self.view bringSubviewToFront:bar];
        firstShow=0;
    }
    
}
//标签选择后调用
-(void) elementSelected:(int)index toolBar:(WBToolBar*)toolBar
{
    if (index == 0) {
        if(!allPatient){
            allPatient=[[DocAllPatientViewController alloc] init];
            [self.view addSubview:allPatient.view];
        }
        allPatient.view.hidden=NO;
        unfinish.view.hidden=YES;
        finish.view.hidden=YES;
        [self.view bringSubviewToFront:allPatient.view];
        [self.view bringSubviewToFront:bar];
    }else if (index==1){
        if (!unfinish) {
            unfinish=[[DocUnfinishPatientViewController alloc] init];
            [self.view addSubview:unfinish.view];
        }
        allPatient.view.hidden=YES;
        unfinish.view.hidden=NO;
        finish.view.hidden=YES;
        [self.view bringSubviewToFront:unfinish.view];
        [self.view bringSubviewToFront:bar];
        
    }else if (index==2){
        if (!finish) {
            finish=[[DocFinishPatientViewController alloc] init];
            [self.view addSubview:finish.view];
        }
        allPatient.view.hidden=YES;
        unfinish.view.hidden=YES;
        finish.view.hidden=NO;
        [self.view bringSubviewToFront:finish.view];
        [self.view bringSubviewToFront:bar];
    }
}

-(void)pushViewInParent:(id)sender
{
    
    NSString * text= [[sender userInfo] objectForKey:@"text"];
}

@end
