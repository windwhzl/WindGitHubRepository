//
//  woyaochuangyeViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-29.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "woyaochuangyeViewController.h"
#import "wycyListViewController.h"
#import "ShouyeViewController.h"
#import "AlertDialogWhenFunctionNotComplete.h"
#import "SystemSetViewController.h"
@interface woyaochuangyeViewController ()

@end

@implementation woyaochuangyeViewController

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

- (IBAction)cyzcButtonClick:(id)sender {
    [self setQianjinFlag:1];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    wycyListViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"wycyListView"];
    [listView setNewsType:443];
    [listView setFlag:@"cyzc"];
    [listView setTitleString:@"创业政策"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)cyxmButtonClick:(id)sender {
    [self setQianjinFlag:2];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    wycyListViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"wycyListView"];
    [listView setNewsType:394];
    [listView setFlag:@"cyxm"];
    [listView setTitleString:@"创业项目"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)cypxButtonClick:(id)sender {
    [self setQianjinFlag:3];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    wycyListViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"wycyListView"];
    [listView setNewsType:440];
    [listView setFlag:@"cypx"];
    [listView setTitleString:@"创业培训"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}

- (IBAction)cyfwButtonClick:(id)sender {
    AlertDialogWhenFunctionNotComplete *aa=[[AlertDialogWhenFunctionNotComplete alloc] initWithFrame:CGRectMake(60.0, 120.0, 200.0, 200.0)];
    [aa show];
    [self.view addSubview:aa];
}

- (IBAction)cydtButtonClick:(id)sender {
    [self setQianjinFlag:5];
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    wycyListViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"wycyListView"];
    [listView setNewsType:392];
    [listView setFlag:@"cydt"];
    [listView setTitleString:@"创业动态"];
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
            [self cyzcButtonClick:sender];
            break;
        case 2:
            [self cyxmButtonClick:sender];
            break;
        case 3:
            [self cypxButtonClick:sender];
            break;
        case 4:
            
            break;
        case 5:
            [self cydtButtonClick:sender];
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
