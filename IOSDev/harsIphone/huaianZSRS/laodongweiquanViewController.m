//
//  laodongweiquanViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-29.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "laodongweiquanViewController.h"
#import "rsksListViewController.h"
#import "wycyListViewController.h"
#import "ShouyeViewController.h"
#import "AlertDialogWhenFunctionNotComplete.h"
#import "jbjhViewController.h"
#import "jctsViewController.h"
#import "dhjbViewController.h"
#import "SystemSetViewController.h"
@interface laodongweiquanViewController ()

@end

@implementation laodongweiquanViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self setQianjinFlag:0];
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
- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)zcggButtonClick:(id)sender {
    [self setQianjinFlag:1];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    wycyListViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"wycyListView"];
    [listView setNewsType:250];
    [listView setFlag:@"zcgg"];
    [listView setTitleString:@"仲裁公告"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)jctsButtonClick:(id)sender {
//    AlertDialogWhenFunctionNotComplete *aa=[[AlertDialogWhenFunctionNotComplete alloc] initWithFrame:CGRectMake(60.0, 120.0, 200.0, 200.0)];
//    [aa show];
//    [self.view addSubview:aa];
    [self setQianjinFlag:3];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    jctsViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"jctsView"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)jbjhButtonClick:(id)sender {
     [self setQianjinFlag:2];
//    AlertDialogWhenFunctionNotComplete *aa=[[AlertDialogWhenFunctionNotComplete alloc] initWithFrame:CGRectMake(60.0, 120.0, 200.0, 200.0)];
//    [aa show];
//    [self.view addSubview:aa];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    jbjhViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"jbjhView"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
    

}


- (IBAction)dhjbButtonClick:(id)sender {
    [self setQianjinFlag:4];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    dhjbViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"dhjbView"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

-(IBAction)qianjinClick:(id)sender
{
    
    switch ([self getQianjinFlag]) {
        case 1:
            [self zcggButtonClick:sender];
            break;
        case 2:
            [self jbjhButtonClick:sender];
            break;
        case 3:
            [self jctsButtonClick:sender];
            break;
        case 4:
            [self dhjbButtonClick:sender];
            break;
        default:
            break;
    }
}
- (IBAction)zhuyeClick:(id)sender {
//    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
//    ShouyeViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"ShouyeView"];
//    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:listView animated:YES completion:nil];
       [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)moreFunction:(id)sender {
    SystemSetViewController *systemSet = [[SystemSetViewController alloc] initWithNibName:nil bundle:nil];
    systemSet.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [self presentViewController:systemSet animated:YES completion:nil];
    
}



-(void) setQianjinFlag:(int)qianjinFlag
{
    _qianjinFlag = qianjinFlag;
}
-(int) getQianjinFlag
{
    return  _qianjinFlag;
}
@end
