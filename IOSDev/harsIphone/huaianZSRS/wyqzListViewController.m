//
//  wyqzListViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-28.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "wyqzListViewController.h"
#import "zhaopinhuiTableViewCell.h"
#import "HttpUtil.h"
#import "loadMoreTableViewCell.h"
#import "LoadWebViewController.h"
#import "SystemSetViewController.h"
#import "banshizhuanquViewController.h"
@interface wyqzListViewController ()

@end

@implementation wyqzListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setPage:1];
    self.isFinished = YES;
    [self setCount:0];
    [self.showTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
}
-(void) viewDidAppear:(BOOL)animated
{
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
                    _freshButton.hidden = NO;
                }else{
                [self freshUI:httpArray];
                }
                [_waiting stopAnimating];
            });
        });
    });
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
    JsonURLString = [NSString stringWithFormat:@"%@%@",[HttpUtil getUrl],@"zsrs-hajynews/hajynews/hajyNewsAction!list"];
    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str ;//设置参数
    str = [NSString stringWithFormat:@"hajyNews.classid=zph&currentPage=%d",currentPage];
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
    NSString *CellTableIdentifier = @"zhaopinhuiCell";
    UINib *nib =[UINib nibWithNibName:@"zhaopinhuiTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
    
    zhaopinhuiTableViewCell *cell = [[zhaopinhuiTableViewCell alloc]init];
    cell= [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    
    NSDictionary *rowData = self.dataList[indexPath.row];
    cell.newstitle = rowData[@"newstitle"];
    NSDictionary *rowInData =  rowData[@"edittime"];
    NSString *time = rowInData[@"time"];
    [time doubleValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *edittime = [NSString stringWithFormat:@"%@",
                      [formatter stringFromDate:
                       [NSDate dateWithTimeIntervalSince1970:[time doubleValue]/1000]]];
    cell.edittime= edittime;
    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width,[cell setTitleHeight:rowData[@"newstitle"]]);
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
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
                    [_waiting startAnimating];
                });
            });
            dispatch_group_notify(group, queue, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self getMoreData:httpArray];
                    [self.showTableView reloadData];
                    [_waiting stopAnimating];
                });
            });
        });
        
    }else {
        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
        LoadWebViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"LoadWebView"];
        [listView setFlag:@"zph"];
        NSString *postUrl = [NSString stringWithFormat:@"%@zsrs-hajynews/hajynews/hajyNewsAction!findNewsById",
                             [HttpUtil getUrl]];
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
- (IBAction)moreFunction:(id)sender { //更多按钮
    SystemSetViewController *systemSet = [[SystemSetViewController alloc] initWithNibName:nil bundle:nil];
    systemSet.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [self presentViewController:systemSet animated:YES completion:nil];
}

- (IBAction)zhuyeClick:(id)sender {
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    banshizhuanquViewController *moreView =
    [mainStory instantiateViewControllerWithIdentifier:@"banshizhuanquView"];
    moreView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:moreView animated:YES completion:nil];
}
-(void)setPage:(int)page
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
- (IBAction)freshButtonClick:(id)sender {
    _freshButton.hidden = YES;
    [_waiting startAnimating];
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
