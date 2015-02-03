//
//  MoreViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-20.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "MoreViewController.h"
#import "shouyeTableViewCell.h"
#import "loadMoreTableViewCell.h"
#import "HttpUtil.h"
#import "zhengceTableViewCell.h"
#import "shouyeWebViewController.h"
@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"政策法规";
    [self setPage:1];
    self.count = -1;
    self.isFirst = YES;
    [self.showTabeleView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];

}
-(void) viewDidAppear:(BOOL)animated{
    
    if (self.isFirst) {
            
    dispatch_queue_t queue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        __block NSArray *httpArray;
        dispatch_group_t group =dispatch_group_create();
        dispatch_group_async(group, queue, ^{
            
                 httpArray = [self getJSonData:[self getPage]];

        });
        dispatch_group_notify(group, queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (httpArray == nil) {
                    _freshButton.hidden = NO;
                }else{
                    [self freshUI:httpArray];
                }
                [_waiting stopAnimating];
            });
        });
    });
        }

}
-(void) viewDidDisappear:(BOOL)animated
{
    self.isFirst = NO;
    [_waiting stopAnimating];
}
-(void) freshUI:(NSArray *)getArray{
    if ([[self getFlag] isEqualToString:@"zc"]) {
        NSArray *array = getArray;
        if ([array isEqual:nil]) {
            self.count = 0;
        }else{
            
            self.shouyeData = [[NSMutableArray alloc]initWithArray:array];
            if ([self.shouyeData count]<6) {
                self.isFinished =YES;
            }
            [self setCount: [self.shouyeData count]];
            
        }
        
    }else {
        NSArray *array = getArray;
        if ([array isEqual:nil]) {
            self.count = 0;
        }else{
            
            self.shouyeData = [[NSMutableArray alloc]initWithArray:array];
            if ([self.shouyeData count]<12) {
                self.isFinished =YES;
            }
            [self setCount: [self.shouyeData count]];
            
        }
    }
    [_showTabeleView reloadData];
    [self.showTabeleView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
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
//获取新闻列表
-(NSArray *)getHttpJson:(int)newsType
            currentpage:(int)page{
    
    NSString *JsonURLString;
        JsonURLString = [NSString stringWithFormat:@"%@jobdata/snewsAction!getSNews.do",[HttpUtil getUrl1]];
    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    
    NSString *str ;//设置参数

        str = [NSString stringWithFormat:@"type=%d&page=%d&rows=12",newsType,page];
    
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
    return result;
}
//获取政策的JSON
- (NSArray *) getJSonData:(int)page{
    NSString *JsonURLString;
    JsonURLString = [NSString stringWithFormat:@"%@zsrs-zsk/zskAction!zsk_list",[HttpUtil getUrl]];
    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str ;//设置参数
    str = [NSString stringWithFormat:@"currentpage=%d&searchKey.keyword1=&searchKey.keyword2=&searchKey.keyword3=&searchKey.keyword4=&searchKey.className=2",page];
    NSData *data1 = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data1];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str1 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    NSString *jsonstring = str1;
    NSData *data = [jsonstring dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *getData = [NSJSONSerialization JSONObjectWithData:data
                                                       options:NSJSONReadingAllowFragments
                                                         error:nil];
    return getData;
    
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self isFinished]) {
        return [self getCount];
    }else {
        return [self getCount]+1;
    }
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.shouyeData count]) {
        NSString *more = @"moreCell";
        UINib *moreNib =[UINib nibWithNibName:@"loadMoreTableViewCell" bundle:nil];
        [tableView registerNib:moreNib forCellReuseIdentifier:more];
        loadMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:more];
        return cell;
        
    }
    NSString *shouyeTableCellID = @"ShouyeTableCellID";
    NSString *zhengceTableCellID = @"ZhengceTableCellID";
    NSDictionary *rowData = self.shouyeData[indexPath.row];
    
    if ([self.flag isEqualToString:@"zc"]) {
        UINib *znib = [UINib nibWithNibName:@"zhengceTableViewCell" bundle:nil];
        [tableView registerNib:znib forCellReuseIdentifier:zhengceTableCellID];
        self.zhengceCell =[tableView dequeueReusableCellWithIdentifier:zhengceTableCellID];
        [self setZhengcecell:rowData];
        return self.zhengceCell;
    }else {
        UINib *znib = [UINib nibWithNibName:@"shouyeTableViewCell" bundle:nil];
        [tableView registerNib:znib forCellReuseIdentifier:shouyeTableCellID];
        self.cell = [[shouyeTableViewCell alloc] init];
        self.cell =[tableView dequeueReusableCellWithIdentifier:shouyeTableCellID];
        NSString *imageString = [NSString stringWithFormat:@"png_%@_logo.png",self.flag];
        UIImage *imageView = [UIImage imageNamed:imageString];
        _cell.flagImage.image = imageView;
        _cell.title = rowData[@"title"];
        NSString *time = rowData[@"editTime"];
        [time doubleValue];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *date = [NSString stringWithFormat:@"%@",
                          [formatter stringFromDate:
                           [NSDate dateWithTimeIntervalSince1970:[time doubleValue]/1000]]];
        _cell.date =[date copy];
        return self.cell;
    }
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.shouyeData count]) {
        dispatch_queue_t queue =
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            [self setPage: [self getPage]+1];
            __block NSArray *httpArray;
            dispatch_group_t group =dispatch_group_create();
            dispatch_group_async(group, queue, ^{
                if ([[self getFlag] isEqualToString:@"zc"]) {
                    httpArray = [self getJSonData:[self getPage]];
                }else{
                    httpArray =[self getHttpJson:[self getNewsType] currentpage:[self getPage]];
                }
            });
            dispatch_group_async(group, queue, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    _waiting.hidden = NO;
                    [_waiting startAnimating];
                    
                });
            });
            dispatch_group_notify(group, queue, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self getMoreData:httpArray];
                    [self.showTabeleView reloadData];
                    _waiting.hidden =YES;
                });
            });
        });
    }else {
        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
        shouyeWebViewController *webView = [mainStory instantiateViewControllerWithIdentifier:@"shouyeWebView"];
        NSDictionary *rowData = self.shouyeData[indexPath.row];
        [webView setFlag:_flag];
        NSString *newsId = rowData[@"id"];
        [webView setNewsId:newsId];
        webView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:webView animated:YES completion:nil];
    }
}
-(void) getMoreData:(NSArray *)httpArray{
    NSArray *array = httpArray ;
    if ([[self getFlag] isEqualToString:@"zc"]) {
    if ([array count]<6) {
        self.isFinished =YES;
    }
    }else {
    if ([array count]<12) {
            self.isFinished =YES;
        }
    }
    self.count += [array count];
    [self.shouyeData addObjectsFromArray:array];
}
- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) setZhengcecell:(NSDictionary *)rowData{
    self.zhengceCell.title = rowData[@"title"];
    self.zhengceCell.danwei = rowData[@"provideDept"];
}
#pragma mark- Getter和Setter
-(void)setPage:(int)page
{
    _page = page;
}

-(int)getPage
{
    return _page;
}

-(void) setFlag:(NSString *)flag
{
    _flag = flag;
}

-(NSString*) getFlag
{
    return _flag;
}

-(void) setCount:(int)count
{
    _count = count;
}
-(int) getCount
{
    return  _count;
}
-(void) setNewsType:(int)newsType
{
    _newsType = newsType;
}
-(int)getNewsType
{
    return _newsType;
}
- (IBAction)freshButtonClick:(id)sender {
    
    _freshButton.hidden = YES;
    [_waiting startAnimating];
    
    dispatch_queue_t queue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        __block NSArray *httpArray;
        dispatch_group_t group =dispatch_group_create();
        dispatch_group_async(group, queue, ^{
            
            httpArray = [self getJSonData:[self getPage]];
            
        });
        dispatch_group_notify(group, queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (httpArray == nil) {
                    _freshButton.hidden = NO;
                }else{
                    [self freshUI:httpArray];
                }
                [_waiting stopAnimating];
            });
        });
    });
}
@end
