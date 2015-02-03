//
//  loadWebViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-11.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "LoadWebViewController.h"
#import "SystemSetViewController.h"
@interface LoadWebViewController ()

@end

@implementation LoadWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
}
-(void) viewDidAppear:(BOOL)animated
{
    
    dispatch_queue_t queue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        dispatch_group_t group =dispatch_group_create();
        
        dispatch_group_async(group, queue, ^{
            
            if ([[self getFlag] isEqualToString:@"gkk"]) {
                
                _jsonString = [self getJsonString:[self getPostUrl] newsID:[self getNewsId]];
                _loadString = [self analyseGkk:_jsonString];
            }else  if ([[self getFlag] isEqualToString:@"zswd"]||[[self getFlag] isEqualToString:@"qk"]) {
                
                _jsonString = [self getJsonString:[self getPostUrl] newsID:[self getNewsId]];
                _loadString = [self analyseWdk:_jsonString];
            }else  if ([[self getFlag] isEqualToString:@"zcfg"]) {
                
                _jsonString = [self getJsonString:[self getPostUrl] newsID:[self getNewsId]];
                _loadString = [self analyseZck:_jsonString];
            }else  if ([[self getFlag] isEqualToString:@"fwjg"]) {
                
                _jsonString = [self getJsonString:[self getPostUrl] newsID:[self getNewsId]];
                _loadString = [self analyseJgk:_jsonString];
            }else if([[self getFlag] isEqualToString:@"zph"]){
                _jsonString = [self getJsonString:[self getPostUrl] newsID:[self getNewsId]];
                _loadString = [self analyseZph:_jsonString];
            }else {
                
                _loadString = [self getFastJsonString:[self getPostUrl] newsID:[self getNewsId]];
            }
        });
        
        dispatch_group_notify(group, queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_waiting stopAnimating];
                [self loadString:_loadString];
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
#pragma mark- 加载概况库字符串
-(NSString*) getFastJsonString:(NSString*)postUrl
                        newsID:(NSString*)newsId
{
    NSString *JsonURLString = postUrl;
    
    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str = [NSString stringWithFormat:@"snewsId=%@",newsId];//设置参数
    
    NSData *data1 = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data1];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str1 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    NSString *jsonstring = str1;
    NSData *data = [jsonstring dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getData = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingAllowFragments
                                                          error:nil];
    NSData *jsonData = [getData dataUsingEncoding:NSUTF8StringEncoding ];
    id result = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    NSDictionary *resultDc = (NSDictionary*) result;
    NSString *content = resultDc[@"content"];
    return content;

}
-(NSDictionary*) getJsonString:(NSString*)postUrl
                        newsID:(NSString*)newsId
{
    NSString *JsonURLString = postUrl;
    
    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str;
    if ([[self getFlag] isEqualToString:@"zph"]) {
        str = [NSString stringWithFormat:@"hajyNews.id=%@",newsId];
    }else{
        str = [NSString stringWithFormat:@"id=%@",newsId];
    }
    
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
    
    return getData;
}
-(NSString*) analyseGkk:(NSDictionary*)jsonString//概况库
{
    NSString *result;
    NSString *summary = jsonString[@"summary"];
    NSString *lastResultHighlight = jsonString[@"lastResultHighlight"];
    NSString *lastYearData = jsonString[@"lastYearData"];
    NSString *thisYearPlan = jsonString[@"thisYearPlan"];
    result = [NSString stringWithFormat:@"概要：<p align='center'>%@</p>上一年成果和亮点：<p align='center'>%@</p>上半年数据：<p align='center'>%@</p>今年计划：<p align='center'>%@</p>",summary,lastResultHighlight,lastYearData,thisYearPlan];
    return result;
}
-(NSString*) analyseWdk:(NSDictionary*)jsonString//问答库
{
    NSString *result;
    NSString *accordingFile = jsonString[@"accordingFile"];
    NSString *departmentName = jsonString[@"departmentName"];
    NSString *answer = jsonString[@"answer"];
    NSString *question = jsonString[@"question"];
    NSString *ttelephone = jsonString[@"ttelephone"];
    NSString *departmentAddress = jsonString[@"departmentAddress"];
    result = [NSString stringWithFormat:@"</br><p align='center'><font color='#FF0000'>%@</font></p></br></br>解答：%@</br>依据：%@</br>信息提供者：</br>%@</br>电话：</br>%@</br>地址：</br>%@",question,answer,accordingFile,departmentName,ttelephone,departmentAddress];
    return result;
}
-(NSString*) analyseZph:(NSDictionary*)jsonString
{
    NSString *result;
    result = jsonString[@"content"];
    return result;
}
-(NSString*) analyseZck:(NSDictionary*)jsonString //政策库
{
    NSString *result;
    NSString *code = jsonString[@"fileCode"];
    NSString *name = jsonString[@"fileName"];
    NSString *jObject = jsonString[@"publihDate"];
    NSString *content = jsonString[@"fileContent"];
    result = [NSString stringWithFormat:@"</br><p align='center'><font color='#FF0000'>%@</font></p></br>%@</br>%@",name,code,content];
    return result;
}
-(NSString*) analyseJgk:(NSDictionary*)jsonString //机构库
{
    NSString *result;
    NSString *json1 = jsonString[@"duty"];
    NSString *title = jsonString[@"departmentName"];
    NSString *address = jsonString[@"address"];
    NSString *telephone = jsonString[@"telephoneNumber"];
    result = [NSString stringWithFormat:@"</br><p align='center'><font color='#FF0000'>%@</font></p></br>职责：%@</br>地址：%@</br>联系电话：%@",title,json1,address,telephone];
    return result;
}
-(void)loadString:(NSString *) string{
    [self.loadWebView loadHTMLString:string baseURL:nil];
    
}
- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)moreFunction:(id)sender { //更多按钮
    SystemSetViewController *systemSet = [[SystemSetViewController alloc] initWithNibName:nil bundle:nil];
    systemSet.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [self presentViewController:systemSet animated:YES completion:nil];
}

-(void) setLoadString:(NSString *)loadString
{
    _loadString = loadString;
}
-(void) setFlag:(NSString *)flag
{
    _flag = [flag copy];
}
-(NSString*) getFlag
{
    return _flag;
}
-(void) setPostUrl:(NSString *)postUrl
{
    _postUrl = [postUrl copy];
}
-(NSString*) getPostUrl
{
    return _postUrl;
}
-(void) setJsonString:(NSDictionary *)jsonString
{
    _jsonString = [jsonString copy];
}
-(NSDictionary *) setJsonString
{
    return _jsonString;
}
-(void) setNewsId:(NSString*)newsId
{
    _newsId = newsId;
}
-(NSString*) getNewsId
{
    return _newsId;
}
@end
