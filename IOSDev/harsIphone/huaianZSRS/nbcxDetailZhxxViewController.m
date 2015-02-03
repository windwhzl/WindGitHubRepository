//
//  nbcxDetailZhxxViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-11-21.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "nbcxDetailZhxxViewController.h"
#import "HttpUtil.h"
@interface nbcxDetailZhxxViewController ()

@end

@implementation nbcxDetailZhxxViewController

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
    JsonURLString = [NSString stringWithFormat:@"%@%@",[HttpUtil getUrl],@"zsrs-nbcx/nbcxAction!analyticTable2"];
    
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
- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) doMakeView:(NSDictionary*) json
{
    [self setGrjf_bj:json[@"grjf_bj"]];
    [self setGrjf_jx:json[@"grjf_jx"]];
    [self setGrjf_hj:json[@"grjf_hj"]];
    
    [self setZfbt_bj:json[@"zfbt_bj"]];
    [self setZfbt_jx:json[@"zfbt_jx"]];
    [self setZfbt_hj:json[@"zfbt_hj"]];
    
    [self setJtbt_bj:json[@"jtbz_bj"]];
    [self setJtbt_jx:json[@"zfbt_jx"]];
    [self setJtbt_hj:json[@"jtbz_hj"]];
    
    [self setBnff:json[@"bnff"]];
    [self setZye:json[@"zye"]];
}
-(void) setGrjf_bj:(NSString *)grjf_bj
{
    _grjf_bj = [grjf_bj copy];
    _grjf_bjLabel.text = [_grjf_bj copy];
}
-(void) setGrjf_jx:(NSString *)grjf_jx
{
    _grjf_jx = [grjf_jx copy];
    _grjf_jxLabel.text = [_grjf_jx copy];
}
-(void) setGrjf_hj:(NSString *)grjf_hj
{
    _grjf_hj = [grjf_hj copy];
    _grjf_hjLabel.text = [_grjf_hj copy];
}
-(void) setZfbt_bj:(NSString *)zfbt_bj
{
    _zfbt_bj = [zfbt_bj copy];
    _zfbt_bjLabel.text = [_zfbt_bj copy];
}
-(void) setZfbt_jx:(NSString *)zfbt_jx
{
    _zfbt_jx = [zfbt_jx copy];
    _zfbt_jxLabel.text = [_zfbt_jx copy];
}
-(void) setZfbt_hj:(NSString *)zfbt_hj
{
    _zfbt_hj = [zfbt_hj copy];
    _zfbt_hjLabel.text = [_zfbt_hj copy];
}
-(void) setJtbt_bj:(NSString *)jtbt_bj
{
    _jtbt_bj = [jtbt_bj copy];
    _jtbt_bjLabel.text = [_jtbt_bj copy];
}
-(void) setJtbt_jx:(NSString *)jtbt_jx
{
    _jtbt_jx = [jtbt_jx copy];
    _jtbt_jxLabel.text = [_jtbt_jx copy];
}
-(void) setJtbt_hj:(NSString *)jtbt_hj
{
    _jtbt_hj = [jtbt_hj copy];
    _jtbt_hjLabel.text = [_jtbt_hj copy];
}
-(void) setBnff:(NSString *)bnff
{
    _bnff = [bnff copy];
    _bnffLabel.text = [bnff copy];
}
-(void) setZye:(NSString *)zye
{
    _zye = [zye copy];
    _zyeLabel.text = [_zye copy];
}
-(void) setSfzh:(NSString *)sfzh
{
    _sfzh = [sfzh copy];
}
-(NSString*) getSfzh
{
    return  _sfzh;
}
@end
