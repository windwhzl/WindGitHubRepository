//
//  WuxianfuwuViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-13.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "WuxianfuwuViewController.h"
#import "yibaodingdianjigouTableViewCell.h"
#import "WuxianListViewController.h"
#import "SBCXViewController.h"
#import "ShouyeViewController.h"
#import "nbcxViewController.h"
#import "AlertDialogWhenFunctionNotComplete.h"
#import "SystemSetViewController.h"
@interface WuxianfuwuViewController ()

@end

@implementation WuxianfuwuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setQianjinFlag:0];
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

- (IBAction)ylcxButtonClick:(id)sender { //养老查询点击事件
    [self setQianjinFlag:1];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    SBCXViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"SBCXView"];
    [listView setFlag:@"ylcx"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;//跳转样式
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)ybcxButtonClick:(id)sender { //医保查询点击事件
    [self setQianjinFlag:2];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    SBCXViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"SBCXView"];
    [listView setFlag:@"ybcx"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)nbcxButtonClick:(id)sender { //农保查询点击事件
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    nbcxViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"nbcxView"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)ybkmxButtonClick:(id)sender {//医保卡刷卡明细点击事件
    [self setQianjinFlag:4];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    SBCXViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"SBCXView"];
    [listView setFlag:@"ybmx"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)ybddjgButtonClick:(id)sender { //医保定点机构点击事件
    [self setQianjinFlag:5];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    WuxianListViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"wuxianlistView"];
    [listView setFlag:@"jg"];
    [listView setTitleString:@"医保定点机构"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)ybddyfButtonClick:(id)sender { //医保定点药房点击事件
    [self setQianjinFlag:6];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    WuxianListViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"wuxianlistView"];
    [listView setFlag:@"yf"];
    [listView setTitleString:@"医保定点药房"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)dismissSelf:(id)sender { // 返回点击事件
   [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)qianjinClick:(id)sender {//前进点击事件
    switch ([self getQianjinFlag]) {
        case 0:
            break;
        case 1:
            [self ylcxButtonClick:sender];
            break;
        case 2:
            [self ybcxButtonClick:sender];
            break;
        case 3:
            break;
        case 4:
            [self ybkmxButtonClick:sender];
            break;
        case 5:
            [self ybddjgButtonClick:sender];
            break;
        case 6:
            [self ybddyfButtonClick:sender];
            break;
        default:
            break;
    }
}
- (IBAction)zhuyeClick:(id)sender { //返回主页
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
-(void) setQianjinFlag:(int)qianjinFlag //
{
    _qianjinFlag = qianjinFlag;
}
-(int) getQianjinFlag
{
    return  _qianjinFlag;
}
@end
