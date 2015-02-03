//
//  mohuListViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-11-14.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "mohuListViewController.h"
#import "HttpUtil.h"
#import "loadMoreTableViewCell.h"
#import "mohuTableViewCell.h"
#import "LoadWebViewController.h"
@interface mohuListViewController ()

@end

@implementation mohuListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setPage:1];
    self.isFinished = YES;
    self.isFirst = YES;
    [self setCount:0];

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
                    if (httpArray == nil) {
                        _showNoneMessage.hidden = NO;
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
        if ([self.dataList count]<15) {
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
    JsonURLString = [NSString stringWithFormat:@"%@%@",[HttpUtil getMohuUrl],@"knowledgebase/searchAction!search_mobile"];
    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str ;//设置参数
    str = [NSString stringWithFormat:@"keyword=%@&currentpage=%d",[self getKeyWord1],currentPage];
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
        
    }else
    {
        NSString *CellTableIdentifier = @"mohuCell";
        UINib *nib =[UINib nibWithNibName:@"mohuTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
        
        mohuTableViewCell *cell = [[mohuTableViewCell alloc]init];
        cell= [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
        
        NSDictionary *rowData = self.dataList[indexPath.row];
        NSString *tempString = rowData[@"title"];
        tempString = [tempString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        cell.title = tempString;
        return cell;
    }
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
                    _waiting.hidden =YES;
                });
            });
        });
        
    }else {
        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
        LoadWebViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"LoadWebView"];
   //     [listView setFlag:self.flag];
        NSString *postUrl;
        NSDictionary *rowData = self.dataList[indexPath.row];
        NSString* newsId = rowData[@"id"];
        NSString* type = rowData[@"className"];
        if([type isEqualToString:@"问答库"]){
            
            postUrl = [NSString stringWithFormat:@"%@zsrs-zsk/zskAction!findWdks",[HttpUtil getUrl]];
            [listView setFlag:@"zswd"];
            
        }else if([type isEqualToString:@"政策库"]){
            
            postUrl = [NSString stringWithFormat:@"%@zsrs-zsk/zskAction!findZcks",[HttpUtil getUrl]];
            [listView setFlag:@"zcfg"];
        }else if([type isEqualToString:@"机构库"]){
            
            postUrl = [NSString stringWithFormat:@"%@zsrs-zsk/zskAction!findJgks",[HttpUtil getUrl]];
            [listView setFlag:@"fwjg"];
            
        }else if ([type isEqualToString:@"机构库2"]) {
            
            postUrl = [NSString stringWithFormat:@"%@zsrs-zsk/zskAction!findjgkfwz",[HttpUtil getUrl]];
            [listView setFlag:@"fwjg"];
        }
        [listView setPostUrl:postUrl];
        [listView setNewsId:newsId];
        listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:listView animated:YES completion:nil];
    }
}
-(void) getMoreData:(NSArray *)httpArray{
    NSArray *array = httpArray ;
    if ([array count]<15) {
        self.isFinished =YES;
    }
    self.count += [array count];
    [self.dataList addObjectsFromArray:array];
}
- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) setKeyWord1:(NSString *)keyWord1
{
    _keyWord1 = keyWord1;
}
-(NSString*)getKeyWord1
{
    return _keyWord1;
}
-(void) setPage:(int)page
{
    _page = page;
}
-(int) getPage
{
    return _page;
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
