//
//  nbcxDetailViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-11-21.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "nbcxDetailViewController.h"
#import "HttpUtil.h"
#import "nbcxDetailZhxxViewController.h"
@interface nbcxDetailViewController ()

@end

@implementation nbcxDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void) viewDidAppear:(BOOL)animated
{
    dispatch_queue_t queue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        __block NSDictionary *httpArray;
        dispatch_group_t group =dispatch_group_create();
        dispatch_group_async(group, queue, ^{
            httpArray = [self getHttpJson];
        });
        dispatch_group_notify(group, queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self doMakeView:httpArray];
                [_waiting stopAnimating];
            });
        });
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSDictionary *)getHttpJson
{
    NSString *JsonURLString;
        JsonURLString = [NSString stringWithFormat:@"%@%@",[HttpUtil getUrl],@"zsrs-nbcx/nbcxAction!analyticTable1"];

    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    
    NSString *str ;//设置参数
        str = [NSString stringWithFormat:@"identity=%@",[self getSfzh]];

    
    NSData *data1 = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data1];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str1 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    NSString *jsonstring = str1;
    NSData *data = [jsonstring dataUsingEncoding:NSUTF8StringEncoding];
   NSDictionary *getData = [NSJSONSerialization JSONObjectWithData:data
                                                       options:NSJSONReadingAllowFragments
                                                         error:nil];
//    NSDictionary *result = [getData objectAtIndex:0];
    return getData;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)zhxxButtonClick:(id)sender {
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    nbcxDetailZhxxViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"nbcxDetailZhxxView"];
    [listView setSfzh:[self getSfzh]];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}
- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) doMakeView:(NSDictionary*) json
{
    [self setXingming:json[@"name"]];
    [self setXingbie:json[@"sex"]];
    [self setSfzh:json[@"identity"]];
    [self setZhuzhi:json[@"address"]];
    [self setQsyf:json[@"startMonth"]];
    [self setLjnx:json[@"totalYear"]];
    [self setFfzt:json[@"type"]];
    [self setJfdc:json[@"payGrade"]];
}
-(void) setXingming:(NSString *)xingming
{
    _xingming = [xingming copy];
    _xingmingLabel.text = [_xingming copy];
}
-(void) setXingbie:(NSString *)xingbie
{
    _xingbie = [xingbie copy];
    _xingbieLabel.text = [_xingbie copy];
}
-(void) setSfzh:(NSString *)sfzh
{
    _sfzh = [sfzh copy];
    _sfzhLabel.text = [_sfzh copy];
}
-(NSString*) getSfzh
{
    return _sfzh;
}
-(void) setZhuzhi:(NSString *)zhuzhi
{
    _zhuzhi = [zhuzhi copy];
    _zhuzhiLabel.text = [_zhuzhi copy];
}
-(void) setQsyf:(NSString *)qsyf
{
    _qsyf = [qsyf copy];
    _qsyfLabel.text = [_qsyf copy];
}
-(void) setLjnx:(NSString *)ljnx
{
    _ljnx = [ljnx copy];
    _ljnxLabel.text = [_ljnx copy];
}
-(void) setFfzt:(NSString *)ffzt
{
    _ffzt = [ffzt copy];
    _ffztLabel.text = [ffzt copy];
}
-(void) setJfdc:(NSString *)jfdc
{
    _jfdc = [jfdc copy];
    _jfdcLabel.text = [_jfdc copy];
}


@end
