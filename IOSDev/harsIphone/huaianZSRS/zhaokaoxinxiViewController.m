//
//  zhaokaoxinxiViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-11-3.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "zhaokaoxinxiViewController.h"
#import "rsksListViewController.h"
#import "wycyListViewController.h"
#import "banshizhuanquViewController.h"
@interface zhaokaoxinxiViewController ()

@end

@implementation zhaokaoxinxiViewController

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

- (IBAction)ksxxButtonClick:(id)sender {
    [self setQianjinFlag:1];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    wycyListViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"wycyListView"];
    [listView setNewsType:200];
    [listView setFlag:@"ksxx"];
    [listView setTitleString:@"考试信息"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)gkxxButtonClick:(id)sender {
    [self setQianjinFlag:2];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    wycyListViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"wycyListView"];
    [listView setNewsType:201];
    [listView setFlag:@"gkxx"];
    [listView setTitleString:@"工考信息"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}
- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)qianjinClick:(id)sender
{
    switch ([self getQianjinFlag]) {
        case 1:
            [self ksxxButtonClick:sender];
            break;
        case 2:
            [self gkxxButtonClick:sender];
            break;
        default:
            break;
    }
}
-(void) setQianjinFlag:(int)qianjinFlag
{
    _qianjinFlag = qianjinFlag;
}
-(int) getQianjinFlag
{
    return  _qianjinFlag;
}
- (IBAction)zhuyeClick:(id)sender {
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    banshizhuanquViewController *moreView =
    [mainStory instantiateViewControllerWithIdentifier:@"banshizhuanquView"];
    moreView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:moreView animated:YES completion:nil];
}
@end
