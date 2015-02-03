//
//  WuxianListViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-27.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "WuxianListViewController.h"
#import "HttpUtil.h"
#import "yibaodingdianjigouTableViewCell.h"
#import "loadMoreTableViewCell.h"
#import "SystemSetViewController.h"
#import "banshizhuanquViewController.h"
@interface WuxianListViewController ()

@end

@implementation WuxianListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setPage:1];
    self.isFinished = YES;
    _isSearch = NO;
    [self setCount:0];
    [self changeTitle];
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
        dispatch_group_async(group, queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self changeSearchTitle];
                if ([[self getFlag]isEqualToString:@"yf"]) {
                    _keywordTextField.placeholder = @"关键词（如：天颐药房）";
                }
                NSString *imageString = [NSString stringWithFormat:@"search_png_%@_logo.png",self.flag];
                UIImage *imageView = [UIImage imageNamed:imageString];
                _searchImage.image = imageView;
            });
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
        
    //    self.dataList = [[NSMutableArray alloc]initWithArray:array];
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
#pragma mark- 获取网络数据
-(NSArray *)getHttpJson:(int)currentPage
{
    NSString *JsonURLString;
    if ([[self getFlag] isEqualToString:@"yf"]) {
         JsonURLString = [NSString stringWithFormat:@"%@%@",[HttpUtil getUrl],@"zsrs-sbcx/sbcxAction!ddyf_list"];
    }else  if ([[self getFlag] isEqualToString:@"jg"]) {
        JsonURLString = [NSString stringWithFormat:@"%@%@",[HttpUtil getUrl],@"zsrs-sbcx/sbcxAction!ddjg_list"];
    }
    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    
    NSString *str ;//设置参数
    
         str = [NSString stringWithFormat:@"currentPage=%d",currentPage];
    
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
-(NSArray *)getHttpJson:(int)currentPage
                keyWord:(NSString*) name
{
    NSString *JsonURLString;
    JsonURLString = [NSString stringWithFormat:@"%@%@",[HttpUtil getUrl],@"zsrs-zsk/sbcxAction!Ybdd_List"];

    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    
    NSString *str ;//设置参数
    if ([[self getFlag] isEqualToString:@"jg"]) {
        str = [NSString stringWithFormat:@"flag=%@&ybddjg.name=%@&currentpage=%d",[self getFlag],name,currentPage];
    }else  if ([[self getFlag] isEqualToString:@"yf"]) {
        str = [NSString stringWithFormat:@"flag=%@&ybddyf.name=%@&currentpage=%d",[self getFlag],name,currentPage];    }
    
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
#pragma mark-表格相关操作
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
    CellTableIdentifier = @"yibaodingdianjigouCell";
    nib =[UINib nibWithNibName:@"yibaodingdianjigouTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
    
    yibaodingdianjigouTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if ([[self getFlag] isEqualToString:@"yf"]) {
        NSDictionary *rowData = self.dataList[indexPath.row];
        //       cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, [cell setNameHeight:rowData[@"name"] setAddressHeight:rowData[@"address"]]);
        cell.name = rowData[@"name"];
        cell.address= rowData[@"address"];
        cell.tel = rowData[@"tel"];
        cell.post = rowData[@"lxr"];
        
    }else if ([[self getFlag] isEqualToString:@"jg"]) {
        NSDictionary *rowData = self.dataList[indexPath.row];
        //        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, [cell setNameHeight:rowData[@"name"] setAddressHeight:rowData[@"address"]]);
        cell.name = rowData[@"name"];
        cell.address= rowData[@"address"];
        cell.tel = rowData[@"tel"];
        cell.post = rowData[@"post"];
        
    }
    
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
        if (_isSearch == NO) {
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
            dispatch_queue_t queue =
            dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(queue, ^{
                [self setPage: [self getPage]+1];
                __block NSArray *httpArray;
                dispatch_group_t group =dispatch_group_create();
                dispatch_group_async(group, queue, ^{
                    httpArray = [self getHttpJson:[self getPage] keyWord:[self getKeyWord]];
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
                            [self getMoreSerachData:httpArray];
                            [self.showTableView reloadData];
                        }
                        [_waiting stopAnimating];
                    });
                });
            });
        }
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
-(void) getMoreSerachData:(NSArray *)httpArray{
    NSArray *array = httpArray ;
    if ([array count]<10) {
        self.isFinished =YES;
    }
    self.count += [array count];
    [self.dataList addObjectsFromArray:array];
}
#pragma mark- 其他点击事件
- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)searchButtonClick:(id)sender {
    CATransition *animShow=[CATransition animation];
    animShow.type=@"rippleEffect";
    animShow.duration=0.5;
    [_showView.layer addAnimation:animShow forKey:nil];
    _showView.hidden = NO;
    _missButton.hidden = NO;
}

- (IBAction)startSerachButtonClick:(id)sender {
    _showNoneMessage.hidden = YES;
    if (_keywordTextField.text.length ==0) {
        _tishiLabel.hidden = YES;
        _attentionLabel.hidden =NO;
    } else {
        [self setKeyWord:_keywordTextField.text];
        _isSearch = YES;
        [self setPage:1];//取第一页数据
        dispatch_queue_t queue =
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            __block NSArray *httpArray;
            dispatch_group_t group =dispatch_group_create();
            dispatch_group_async(group, queue, ^{
                
                httpArray = [self getHttpJson:[self getPage] keyWord:[self getKeyWord]];
            });
            dispatch_group_async(group, queue, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_waiting startAnimating];
                });
            });
            dispatch_group_notify(group, queue, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (httpArray == nil) {
                        
                    }
                    [self freshSearchUI:httpArray];
                    [self missView];
                    [_waiting stopAnimating];
                    _tishiLabel.hidden = NO;
                    _attentionLabel.hidden =YES;
                });
            });
        });
    }

    
}
-(void) freshSearchUI:(NSArray *)getArray{ //更新搜索后的界面
    [self.dataList removeAllObjects];
    NSArray *array = getArray;
    //   [self.dataList addObjectsFromArray:getArray];
    self.isFinished = NO;
    
    if ([array count]==0) {
        self.count = 0;
        _showNoneMessage.hidden = NO;
    }else{
        
        [self.dataList addObjectsFromArray:array];
        if ([self.dataList count]<10) {
            self.isFinished =YES;
        }
        [self setCount: [self.dataList count]];
        
    }
    [self.showTableView reloadData];
    [self.showTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    
}

- (IBAction)dissMissView:(id)sender {
    [self missView];
}

- (IBAction)dissMissKeyboard:(id)sender {
    [_keywordTextField resignFirstResponder];
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
#pragma mark- 其他事件
-(void) changeTitle
{
    [_titleLabel setText:[self getTitlString]];
}
-(void) changeSearchTitle
{
    NSString *searchTitle = [NSString stringWithFormat:@"%@搜索",[self getTitlString]];
    [_searchLabel setText:searchTitle];
}
-(void) missView
{
    [_keywordTextField resignFirstResponder];
    _showView.hidden = YES;
    _missButton.hidden = YES;
    _tishiLabel.hidden = NO;
    _attentionLabel.hidden =YES;
}
-(void) setPage:(int)page
{
    _page = page;
}
-(int) getPage
{
    return  _page;
}
-(void) setFlag:(NSString *)flag
{
    _flag = flag;
}
-(NSString*) getFlag
{
    return _flag;
}
-(void) setCount:(NSUInteger)count
{
    _count = count;
}
-(NSUInteger) getCount
{
    return  _count;
}
-(void) setKeyWord:(NSString *)keyWord
{
    _keyWord = [keyWord copy];
}
-(NSString*) getKeyWord
{
    return _keyWord;
}
-(void) setTitleString:(NSString *)titleString
{
    _titleString = [titleString copy];
}
-(NSString*) getTitlString
{
    return _titleString;
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
