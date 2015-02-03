//
//  niwenwodaListViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-24.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "niwenwodaListViewController.h"
#import "HttpUtil.h"
#import "zhengceTableViewCell.h"
#import "loadMoreTableViewCell.h"
#import "LoadWebViewController.h"
#import "tijiaoWentiViewController.h"
@interface niwenwodaListViewController ()

@end

@implementation niwenwodaListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setPage:1];
    self.isFinished = YES;
    [self setCount:0];
    self.isFirst = YES;
    [self.showTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];

}
-(void) viewDidAppear:(BOOL)animated
{
    if (self.isFirst) {
    dispatch_queue_t queue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        __block NSArray *httpArray;
        dispatch_group_t group =dispatch_group_create();
        dispatch_group_async(group, queue, ^{
            httpArray = [self getHttpJson:[self getPage]];
        });
        dispatch_group_notify(group, queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([httpArray count]== 0) {
                    _showNoneMessage.hidden =NO;
                    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
                    tijiaoWentiViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"tijiaoWentiView"];
                    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                    [self presentViewController:listView animated:YES completion:nil];
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
    
    NSArray *array = getArray;
    self.dataList = [[NSMutableArray alloc]initWithArray:array];
    self.isFinished = NO;
    
    if ([array isEqual:nil]) {
        self.count = 0;
    }else{
        
        self.dataList = [[NSMutableArray alloc]initWithArray:array];
        if ([self.dataList count]<6) {
            self.isFinished =YES;
        }
            [self setCount: [self.dataList count]];
        
        
    }
    [self.showTableView reloadData];
    [self.showTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    
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
-(NSArray *)getHttpJson:(int)currentPage
{
    NSString *JsonURLString;
    JsonURLString = [NSString stringWithFormat:@"%@%@",[HttpUtil getUrl],@"zsrs-zsk/zskAction!zsk_list"];
    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str ;//设置参数
    if ([self.flag isEqualToString:@"zcfg"]) {
           str = [NSString stringWithFormat:@"currentpage=%d&searchKey.keyword1=%@&searchKey.keyword2=%@&searchKey.keyword3=%@&searchKey.keyword4=%@",currentPage,[self getKeyWord1],[self getKeyWord2],[self getKeyWord3],[self getKeyWord4]];
    
        
    }else if ([self.flag isEqualToString:@"qk"]) {
        str = [NSString stringWithFormat:@"currentpage=%d&searchKey.keyword1=%@&searchKey.keyword2=%@&searchKey.keyword3=%@&searchKey.className=3",currentPage,[self getKeyWord1],[self getKeyWord2],[self getKeyWord3]];
    }else if ([self.flag isEqualToString:@"zswd"]) {
        str = [NSString stringWithFormat:@"currentpage=%d&searchKey.keyword1=%@&searchKey.keyword2=%@&searchKey.keyword3=%@&searchKey.keyword4=%@",currentPage,[self getKeyWord1],[self getKeyWord2],[self getKeyWord3],[self getKeyWord4]];
    }
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
    if (indexPath.row == [self.dataList count]) {
        NSString *more = @"moreCell";
        UINib *moreNib =[UINib nibWithNibName:@"loadMoreTableViewCell" bundle:nil];
        [tableView registerNib:moreNib forCellReuseIdentifier:more];
        loadMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:more];
        return cell;
        
    }
    NSString *CellTableIdentifier = @"ZhengceTableCellID";
    UINib *nib =[UINib nibWithNibName:@"zhengceTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
    
    zhengceTableViewCell *cell = [[zhengceTableViewCell alloc]init];
    cell= [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    
    NSDictionary *rowData = self.dataList[indexPath.row];
    cell.title = rowData[@"title"];
    cell.danwei= rowData[@"provideDept"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.dataList count]) {
        dispatch_queue_t queue =
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            [self setPage: [self getPage]+1];
            __block NSArray *httpArray;
            dispatch_group_t group =dispatch_group_create();
            dispatch_group_async(group, queue, ^{
                httpArray = [self getHttpJson:[self getPage]];
            });
            dispatch_group_async(group, queue, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    _waiting.hidden = NO;
                    [_waiting startAnimating];
                    
                });
            });
            dispatch_group_notify(group, queue, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (httpArray == nil) {
                        _showNoneMessage.hidden = NO;
                    }else{
                        [self getMoreData:httpArray];
                        [self.showTableView reloadData];
                    }
                    [_waiting stopAnimating];
                });
            });
        });
        
    }else {
        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
        LoadWebViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"LoadWebView"];
        [listView setFlag:self.flag];
        NSString *postUrl;
        if ([self.flag isEqualToString:@"zswd"]||[self.flag isEqualToString:@"qk"]) {
            postUrl = [NSString stringWithFormat:@"%@zsrs-zsk/zskAction!findWdks",
                       [HttpUtil getUrl]];
        }else {
            postUrl = [NSString stringWithFormat:@"%@zsrs-zsk/zskAction!findZcks",
                       [HttpUtil getUrl]];
        }
        NSDictionary *rowData = self.dataList[indexPath.row];
        NSString* newsId = rowData[@"id"];
        [listView setPostUrl:postUrl];
        [listView setNewsId:newsId];
        listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:listView animated:YES completion:nil];
    }
}
-(void) getMoreData:(NSArray *)httpArray{
    NSArray *array = httpArray ;
    if ([array count]<6) {
        self.isFinished =YES;
    }
    self.count += [array count];
    [self.dataList addObjectsFromArray:array];
}
- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)setPage:(int)page
{
    _page = page;
}
-(int) getPage
{
    return _page;
}
-(void) setKeyWord1:(NSString *)keyWord1
{
    _keyWord1 = [keyWord1 copy];
}
-(NSString*) getKeyWord1
{
    return _keyWord1;
}
-(void) setKeyWord2:(NSString *)keyWord2
{
    _keyWord2 = [keyWord2 copy];
}
-(NSString*) getKeyWord2
{
    return _keyWord2;
}
-(void) setKeyWord3:(NSString *)keyWord3
{
    _keyWord3 = [keyWord3 copy];
}
-(NSString*) getKeyWord3
{
    return _keyWord3;
}
-(void) setKeyWord4:(NSString *)keyWord4
{
    _keyWord4 = [keyWord4 copy];
}
-(NSString*) getKeyWord4
{
    return _keyWord4;
}
-(void) setCount:(int)count
{
    _count = count;
}
-(int) getCount
{
    return  _count;
}
@end
