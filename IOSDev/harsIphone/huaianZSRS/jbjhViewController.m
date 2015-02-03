//
//  jbjhViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-12-16.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "jbjhViewController.h"

@interface jbjhViewController ()

@end

@implementation jbjhViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *loadUrl = [[NSURL alloc] initWithString:@"http://218.2.6.10:10009/jobdata/accept.html"];
    [_jbjhwebView loadRequest:[NSURLRequest requestWithURL:loadUrl]];

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
@end
