//
//  kaoshichengjiViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-11-13.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "kaoshichengjiViewController.h"

@interface kaoshichengjiViewController ()

@end

@implementation kaoshichengjiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleLabel.text = [[self getTitleString] copy];

}
-(void) viewDidAppear:(BOOL)animated
{

    dispatch_queue_t queue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        __block  NSURL *loadUrl;
        dispatch_group_t group =dispatch_group_create();

        dispatch_group_async(group, queue, ^{
            loadUrl = [[NSURL alloc] initWithString:[self getHrefString]];
        });
        dispatch_group_notify(group, queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
  
                [_kscjWebView loadRequest:[NSURLRequest requestWithURL:loadUrl]];

                [_waiting stopAnimating];
            });
        });
    });
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
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (NSUInteger)supportedInterfaceOrientations
{
    //    return UIInterfaceOrientationMaskLandscapeLeft;
    return UIInterfaceOrientationMaskLandscapeRight;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
    //    return UIInterfaceOrientationPortrait;
}
-(void) webViewDidFinishLoad:(UIWebView *)webView{
    NSURL *loadUrl;
    loadUrl = [[NSURL alloc] initWithString:[self getHrefString]];
    NSString *urlString = [loadUrl absoluteString];
    
    NSString *js;
    if ([urlString hasPrefix:@"http://www.harsks.com/Exam/Score/ScoreQuery.aspx"]) {
            js= @"window.scrollBy(260, 250);";
    }if ([urlString hasPrefix:@"http://222.190.114.116:8000/Score/score_work_find_list.aspx"]) {
        js = @"window.scrollBy(5, 350);";
    }else if ([urlString hasPrefix:@"http://www.harsks.com/Exam/Score/ScoreQuery.aspx"]){
            js= @"window.scrollBy(255, 225);";
    }

    [webView stringByEvaluatingJavaScriptFromString:js];
}
- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) setHrefString:(NSString *)hrefString
{
    _hrefString = hrefString;
}
-(NSString *) getHrefString
{
    return _hrefString;
}
-(void) setTitleString:(NSString *)titleString
{
    _titleString = [titleString copy];
}
-(NSString*) getTitleString
{
    return _titleString;
}
@end
