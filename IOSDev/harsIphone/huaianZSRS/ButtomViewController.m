//
//  ButtomViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-9.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "ButtomViewController.h"

@interface ButtomViewController ()

@end

@implementation ButtomViewController

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

- (IBAction)forwardClick:(id)sender {
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    UIViewController *temp = [mainStory instantiateViewControllerWithIdentifier:@"webView"];
    temp.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:temp animated:YES completion:nil];
}
@end
