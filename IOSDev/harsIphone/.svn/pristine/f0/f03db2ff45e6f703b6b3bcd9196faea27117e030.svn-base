//
//  ylDetailViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-11-4.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "ylDetailViewController.h"
#import "HttpUtil.h"
#import "ylcxDetailTableViewCell.h"
#import "loadMoreTableViewCell.h"
@interface ylDetailViewController ()

@end

@implementation ylDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPage:1];
    self.isFinished = YES;
    [self setCount:0];
    [self.showTabelView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];

    // Do any additional setup after loading the view.
}
-(void) viewDidAppear:(BOOL)animated
{
    dispatch_queue_t queue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        __block NSArray *httpArray;
        dispatch_group_t group =dispatch_group_create();
        dispatch_group_async(group, queue, ^{
            httpArray = [self getHttpJson:[self getGrbh] currentPage:[self getPage]];
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
        if ([self.dataList count]<10) {
            self.isFinished =YES;
        }
        [self setCount: [self.dataList count]];
        
        
    }
    [self.showTabelView reloadData];
    [self.showTabelView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
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
-(NSArray *)getHttpJson:(NSString*)grbh
            currentPage:(int)page
{
    NSString *JsonURLString;
    JsonURLString = [NSString stringWithFormat:@"%@%@",[HttpUtil getUrl],@"zsrs-sb/yb/ybAction!ylmx"];
    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    
    NSString *str ;//设置参数
        str = [NSString stringWithFormat:@"grzh.aac001=%@&currentPage=%d",[self getGrbh],[self getPage]];
    
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
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.dataList count]) {
        NSString *more = @"moreCell";
        UINib *moreNib =[UINib nibWithNibName:@"loadMoreTableViewCell" bundle:nil];
        [tableView registerNib:moreNib forCellReuseIdentifier:more];
        loadMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:more];
        return cell;
        
    }
    
    NSString *CellTableIdentifier;
    UINib *nib;
    CellTableIdentifier = @"ylcxDetailTableCell";
    nib =[UINib nibWithNibName:@"ylcxDetailTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
    
    ylcxDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    
    NSDictionary *rowData = self.dataList[indexPath.row];
    cell.bxzl = rowData[@"aae140"];
    cell.yf= rowData[@"aae003"];
    cell.jfr = rowData[@"aae210"];
    cell.jfjs = rowData[@"aac150"];
    cell.jfje =rowData[@"aac123"];
    return cell;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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
                httpArray = [self getHttpJson:[self getGrbh] currentPage:[self getPage]];
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
                    [self.showTabelView reloadData];
                    }
                    [_waiting stopAnimating];
                });
            });
        });
        
    }
}
-(void) getMoreData:(NSArray *)httpArray{
    NSArray *array = httpArray ;
    if ([array count]<10) {
        self.isFinished =YES;
    }
    self.count += [array count];
    [self.dataList addObjectsFromArray:array];
}
- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) setGrbh:(NSString *)grbh
{
    _grbh = [grbh copy];
}
-(NSString*) getGrbh
{
    return _grbh;
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
            httpArray = [self getHttpJson:[self getGrbh] currentPage:[self getPage]];
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
