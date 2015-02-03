//
//  qiyezhaopinViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-22.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "qiyezhaopinViewController.h"
#import "HttpUtil.h"
#import "qiyezhaopinTableViewCell.h"
#import "loadMoreTableViewCell.h"
#import "zhiweishenqingViewController.h"
#import "SystemSetViewController.h"
#import "banshizhuanquViewController.h"
@interface qiyezhaopinViewController ()

@end

@implementation qiyezhaopinViewController

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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) freshUI:(NSArray *)getArray {

    NSArray *array = getArray;
    self.dataList = [[NSMutableArray alloc]initWithArray:array];
    self.isFinished =NO;
    
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
    self.showTableView.hidden = NO;
    [_waiting stopAnimating];
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
    JsonURLString = [NSString stringWithFormat:@"%@%@",[HttpUtil getUrl1],@"jobdata/ydzdAction!getCb21s.do"];
    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str ;//设置参数
    
    str = [NSString stringWithFormat:@"%@&%@&%@&%@&page=%d&rows=10",_zhiweiSting,_yuegongziString,_diquString,_workTypeString,currentPage];
    
    NSData *data1 = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data1];
    //第三步，连接服务器
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (received ==nil) {
        return  nil;
    }
    NSString *str1 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    NSString *jsonstring = str1;
    NSData *data = [jsonstring dataUsingEncoding:NSUTF8StringEncoding];
    NSString *getData = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingAllowFragments
                                                          error:nil];
    NSData *jsonData = [getData dataUsingEncoding:NSUTF8StringEncoding ];
    id result = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    NSArray *jsonArray = result[@"obj"];
    NSString *state = result[@"state"];
//    if (![state isEqualToString:@"1"]) {
//        return nil;
//    }
    return jsonArray;

}
#pragma mark- 表格相关操作
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self isFinished]) {
        return [self getCount];
    }else {
        return [self getCount]+1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.dataList count]) {
        NSString *more = @"moreCell";
        UINib *moreNib =[UINib nibWithNibName:@"loadMoreTableViewCell" bundle:nil];
        [tableView registerNib:moreNib forCellReuseIdentifier:more];
        loadMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:more];
        return cell;
        
    }
    NSString *CellTableIdentifier = @"qiyezhaopinCell";
    UINib *nib =[UINib nibWithNibName:@"qiyezhaopinTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
    qiyezhaopinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    NSDictionary *rowData = self.dataList[indexPath.row];
    
    //职位名称
    [cell setZhiwei:rowData[@"acb21a"]];
    
    //招聘日期
    {
        NSString *getDate = rowData[@"aae030"];
        NSArray *stringArray = [getDate componentsSeparatedByString:@" "];
        NSString *getRiqi = [stringArray objectAtIndex:0];
        [cell setRiqi:getRiqi];
    }
    
    //截止日期
    {
        NSString *getJiezhiDate = rowData[@"aae031"];
        NSArray *jiezhiStringArray = [getJiezhiDate componentsSeparatedByString:@" "];
        NSString *getJiezhiRiqi = [jiezhiStringArray objectAtIndex:0];
        [cell setJiezhiriqi:getJiezhiRiqi];
    }
    //月薪
    {
        NSString *gongzi = [NSString stringWithFormat:@"%@",rowData[@"acb214"]];
        [cell setGongzi:gongzi];
    }
    //公司名称
    [cell setGongsi:rowData[@"aab004"]];
    
    //工作地点
    [cell setDidian:rowData[@"bcb202"]];
    return  cell;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [self.dataList count]) {
        [self setPage:[self getPage]+1];
        NSArray *array = [self getHttpJson:[self getPage]];
        if ([array count]<6) {
            self.isFinished =YES;
        }
        self.count += [array count];
        [self.dataList addObjectsFromArray:array];
        [tableView reloadData];
        
    }else {
        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
        zhiweishenqingViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"zhiweishenqingView"];
        NSDictionary *rowData = self.dataList[indexPath.row];
        NSString* newsId = rowData[@"id"];
        [listView setZhiweiID:newsId];
        listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:listView animated:YES completion:nil];
    }
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
