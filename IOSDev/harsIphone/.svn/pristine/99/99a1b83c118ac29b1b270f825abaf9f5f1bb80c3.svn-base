//
//  shouyeWebViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-11-11.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "shouyeWebViewController.h"
#import "HttpUtil.h"
#import "SystemSetViewController.h"
@interface shouyeWebViewController ()

@end

@implementation shouyeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}
-(void) viewDidAppear:(BOOL)animated
{
    if ([[self getFlag] isEqualToString:@"zc"]) {
        _jsonString = [self getJsonString:[self getNewsId]];
        _loadString = [self analyseZck:_jsonString];
    }else {
        _loadString = [self getFastJsonString:[self getNewsId]];
    }

    [self loadString:_loadString];
    [_waiting stopAnimating];
    
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
-(NSString*) getFastJsonString:(NSString*)newsId
{
    NSString *JsonURLString = [NSString stringWithFormat:@"%@jobdata/snewsAction!getSNewsDetails.do",
                               [HttpUtil getUrl1]];
    
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
-(NSDictionary*) getJsonString:(NSString*)newsId
{
    NSString *JsonURLString = [NSString stringWithFormat:@"%@zsrs-zsk/zskAction!findZcks",[HttpUtil getUrl]];
    
    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str;
    str = [NSString stringWithFormat:@"id=%@",newsId];
    
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

-(NSString*) analyseZck:(NSDictionary*)jsonString //政策库
{
    NSString *result;
    NSString *code = jsonString[@"fileCode"];
    NSString *name = jsonString[@"fileName"];
   // NSString *jObject = jsonString[@"publihDate"];
    NSString *content = jsonString[@"fileContent"];
    result = [NSString stringWithFormat:@"</br><p align='center'><font color='#FF0000'>%@</font></p></br>%@</br>%@",name,code,content];
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
