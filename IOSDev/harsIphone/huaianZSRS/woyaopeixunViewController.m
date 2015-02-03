//
//  woyaopeixunViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-29.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "woyaopeixunViewController.h"
#import "wycyListViewController.h"
#import "ShouyeViewController.h"
#import "AlertDialogWhenFunctionNotComplete.h"
#import "SystemSetViewController.h"
@interface woyaopeixunViewController ()

@end

@implementation woyaopeixunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)pxbmButtonClick:(id)sender { //创业培训
    [self setQianjinFlag:1];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    wycyListViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"wycyListView"];
    [listView setNewsType:440];
    [listView setFlag:@"cypx"];
    [listView setTitleString:@"创业培训"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)ddpxButtonClick:(id)sender {//就业培训
    [self setQianjinFlag:2];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    wycyListViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"wycyListView"];
    [listView setNewsType:281];
    [listView setFlag:@"jypx"];
    [listView setTitleString:@"就业培训"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)shpxButtonClick:(id)sender {
    SystemSetViewController *systemSet = [[SystemSetViewController alloc] initWithNibName:nil bundle:nil];
    systemSet.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [self presentViewController:systemSet animated:YES completion:nil];
}
- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)qianjinClick:(id)sender
{
    switch ([self getQianjinFlag]) {
        case 1:
            [self pxbmButtonClick:sender];
            break;
        case 2:
            [self ddpxButtonClick:sender];
            break;
        case 3:
            
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

- (IBAction)moreFunction:(id)sender { //更多按钮
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
