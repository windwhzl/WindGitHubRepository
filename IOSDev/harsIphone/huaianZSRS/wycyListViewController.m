//
//  wycyListViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-28.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "wycyListViewController.h"
#import "HttpUtil.h"
#import "zhaopinhuiTableViewCell.h"
#import "loadMoreTableViewCell.h"
#import "LoadWebViewController.h"
#import "kaoshichengjiViewController.h"
#import "searchTableViewCell.h"
#import "SystemSetViewController.h"
#import "banshizhuanquViewController.h"
@interface wycyListViewController ()

@end

@implementation wycyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setPage:1];
    self.isFinished = YES;
    self.isSearch = NO;
    self.isFirst = YES;
    [self setCount:0];
    [self.showTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [self changeTitle:[self getTitleString]];


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
            if (self.isSearch == NO) {
                httpArray = [self getHttpJson:[self getPage] getNewsType:[self getNewsType]];
            }

        });
        dispatch_group_async(group, queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setRiqiFanwei:@"1"];
                NSString *imageString = [NSString stringWithFormat:@"search_png_%@_logo.png",self.flag];
                UIImage *imageView = [UIImage imageNamed:imageString];
                _searchImage.image = imageView;
                [self changeSearchTitle: [self getTitleString]];
                _conditionArray = @[
                                    @{@"date":@"一周以内",@"key":@"1"},
                                    @{@"date":@"半月以内",@"key":@"2"},
                                    @{@"date":@"一月以内",@"key":@"3"},
                                    @{@"date":@"三月以内",@"key":@"4"},
                                    @{@"date":@"半年以内",@"key":@"5"},
                                    @{@"date":@"一年以内",@"key":@"6"},
                                    @{@"date":@"一年以上",@"key":@"7"}
                                    ];
                [_searchConditionTable reloadData];
            });
        });
        dispatch_group_notify(group, queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.isSearch == NO) {
                    if (httpArray == nil) {
                        _freshButton.hidden = NO;
                    }else{
                        [self freshUI:httpArray];
                    }
                    [_waiting stopAnimating];
                }

            });
        });
    });
    }
    
}
-(void) freshUI:(NSArray *)getArray{
    
    NSArray *array = getArray;
    self.dataList = [[NSMutableArray alloc]initWithArray:array];
    self.isFinished = NO;
    
    if ([array isEqual:nil]) {
        self.count = 0;
    }else{
        
        self.dataList = [[NSMutableArray alloc]initWithArray:array];
        if ([self.dataList count]<12) {
            self.isFinished =YES;
        }
        [self setCount: [self.dataList count]];
        
    }
    [self.showTableView reloadData];
    [self.showTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    
}
-(void) viewDidDisappear:(BOOL)animated
{
    self.isFirst = NO;
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
#pragma mark- 网络取数
-(NSArray *)getHttpJson:(int)currentPage
            getNewsType:(int)newsType
{
    NSString *JsonURLString;
    JsonURLString = [NSString stringWithFormat:@"%@%@",[HttpUtil getUrl1],@"jobdata/snewsAction!getSNews.do"];
    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str ;//设置参数
    
    str = [NSString stringWithFormat:@"type=%d&page=%d&rows=12",newsType,currentPage];
    
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
    return result;
}
-(NSArray *)getHttpJson:(int)currentPage
            getNewsType:(int)newsType
          getriqiFanwei:(NSString*)riqiFanwei
       getzhuaQuKeyWord:(NSString*)zhuaQuKeyWord
{
    NSString *JsonURLString;
    JsonURLString = [NSString stringWithFormat:@"%@%@",[HttpUtil getUrl1],@"jobdata/snewsAction!searchSNewsWithKeyWord.do"];
    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str ;//设置参数
    str = [NSString stringWithFormat:@"type=%d&page=%d&rows=12&mark=true&riQiFanWei=%@&zhuaQuKeyWord=%@",newsType,currentPage,riqiFanwei,zhuaQuKeyWord];
    
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
    return result;
}

#pragma mark- 表格
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag ==1) {
        return [_conditionArray count];
    }else{
        
        if ([self isFinished]) {
            return [self getCount];
        }else {
            return [self getCount]+1;
        }
        
    }
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag ==1) {
        NSString *more = @"searchTableCell";
        UINib *moreNib =[UINib nibWithNibName:@"searchTableViewCell" bundle:nil];
        [tableView registerNib:moreNib forCellReuseIdentifier:more];
        searchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:more];
        NSDictionary *titleString = _conditionArray[indexPath.row];
        [cell setSearchCondition:titleString[@"date"]];
        if (indexPath.row == self.selected) {
            UIImage *imageView = [UIImage imageNamed:@"checked.png"];
            cell.selectImage.image  = imageView;
        } else {
            UIImage *imageView = [UIImage imageNamed:@"check.png"];
            cell.selectImage.image  = imageView;
        }
        return cell;
    }
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
    
    NSString *imageString = [NSString stringWithFormat:@"png_%@_logo.png",self.flag];
    UIImage *imageView = [UIImage imageNamed:imageString];
    cell.flagImage.image = imageView;
    
    NSDictionary *rowData = self.dataList[indexPath.row];
    cell.newstitle = rowData[@"title"];
    NSString *time = rowData[@"editTime"];
    [time doubleValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *edittime = [NSString stringWithFormat:@"%@",
                          [formatter stringFromDate:
                           [NSDate dateWithTimeIntervalSince1970:[time doubleValue]/1000]]];
    cell.edittime= edittime;
    
    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width,[cell setTitleHeight:rowData[@"title"]]);
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_keyWordTextField resignFirstResponder];
    
    if (tableView.tag ==1) {
        if (indexPath.row != self.selected) {
            if (self.selected != NSNotFound) {
                NSIndexPath *old = [NSIndexPath indexPathForRow:self.selected inSection:0];
                searchTableViewCell *cell  = [tableView cellForRowAtIndexPath:old];
                UIImage *imageView = [UIImage imageNamed:@"check.png"];
                cell.selectImage.image  = imageView;
            }
        }
        NSDictionary *titleString = _conditionArray[indexPath.row];
        NSString *riqi = titleString[@"key"];
        [self setRiqiFanwei:riqi];
        searchTableViewCell *cell = [[searchTableViewCell alloc] init];
        cell = [tableView cellForRowAtIndexPath:indexPath];
        UIImage *imageView = [UIImage imageNamed:@"checked.png"];
        cell.selectImage.image  = imageView;
        self.selected = indexPath.row;
    }else{
        if (indexPath.row == [self.dataList count]) {
            if (self.isSearch == NO) {
                [self loadMoreCellClick]; //未搜索时候，加载更多
                
            }else{
                
                [self loadSearchMoreCellClick];//搜索数据，加载更多
            }
            
        }else{
            [self xiangqingCellClick:indexPath.row];//查看详情
        }
    }
    
}
#pragma mark- 表格点击事件

-(void) getMoreData:(NSArray *)httpArray{ //添加更多数据
    NSArray *array = httpArray ;
    if ([array count]<12) {
        self.isFinished =YES;
    }
    self.count += [array count];
    [self.dataList addObjectsFromArray:array];
}

-(void) loadMoreCellClick //点击更多（未搜索）
{
    dispatch_queue_t queue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [self setPage: [self getPage]+1];
        __block NSArray *httpArray;
        dispatch_group_t group =dispatch_group_create();
        dispatch_group_async(group, queue, ^{
                httpArray = [self getHttpJson:[self getPage] getNewsType:[self getNewsType]]; //未搜索的数据
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
                [self.showTableView reloadData];//刷新数据列表
                _waiting.hidden =YES;
            });
        });
    });
}
-(void) loadSearchMoreCellClick
{
    dispatch_queue_t queue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [self setPage: [self getPage]+1];
        __block NSArray *httpArray;
        dispatch_group_t group =dispatch_group_create();
        dispatch_group_async(group, queue, ^{
                           httpArray = [self getHttpJson:[self getPage] getNewsType:[self getNewsType] getriqiFanwei:[self getRiqiFanwei] getzhuaQuKeyWord:[self getZhuaquKeyWord]]; //获取更多搜索数据
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
                [self.showTableView reloadData];
                _waiting.hidden =YES;
            });
        });
    });
}
-(void) xiangqingCellClick:(NSInteger) row
{
    
    if ([[self getFlag] isEqualToString:@"cjcx"]) {
        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
        
        kaoshichengjiViewController *listView = [mainStory                     instantiateViewControllerWithIdentifier:@"kaoshichengjiView"];
        NSDictionary *rowData = self.dataList[row];
        NSString* hrefSring = rowData[@"href"];
        [listView setHrefString:hrefSring];
        [listView setTitleString:@"成绩查询"];
        listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:listView animated:YES completion:nil];
    }else{
        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
        LoadWebViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"LoadWebView"];
        [listView setFlag:[self getFlag]];
        NSString *postUrl = [NSString stringWithFormat:@"%@jobdata/snewsAction!getSNewsDetails.do",
                             [HttpUtil getUrl1]];
        NSDictionary *rowData = self.dataList[row];
        NSString* newsId = rowData[@"id"];
        [listView setPostUrl:postUrl];
        [listView setNewsId:newsId];
        listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:listView animated:YES completion:nil];
    }
    
}
#pragma mark- 其他点击事件
- (IBAction)searchButtonClick:(id)sender { //搜索按钮点击事件
    CATransition *animShow=[CATransition animation];
    animShow.type=@"rippleEffect";
    animShow.duration=0.5;
    [_showConditionView.layer addAnimation:animShow forKey:nil];
    _showConditionView.hidden = NO;
    _bacButton.hidden = NO;
}

- (IBAction)startSearchButtonClick:(id)sender { //开始搜索
    
    if (_keyWordTextField.text.length == 0 ) {
        _tishiLabel.hidden = YES;
        _tixingLabel.hidden = NO;
        
    } else {
        
        [self setIsSearch:YES];
        [self setZhuaQuKeyWord:_keyWordTextField.text];
        [self setPage:1];//取第一页数据
        dispatch_queue_t queue =
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            __block NSArray *httpArray;
            dispatch_group_t group =dispatch_group_create();
            dispatch_group_async(group, queue, ^{
                
                httpArray = [self getHttpJson:[self getPage] getNewsType:[self getNewsType] getriqiFanwei:[self getRiqiFanwei] getzhuaQuKeyWord:[self getZhuaquKeyWord]];
            });
            dispatch_group_async(group, queue, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self hiddenShowView];
                    _showNoneMessage.hidden = YES;
                    _waiting.hidden = NO;
                    [_waiting startAnimating];
                });
            });
            dispatch_group_notify(group, queue, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (httpArray == nil) {
                        _showNoneMessage.hidden = NO;
                        [self freshSearchUI:httpArray];
                    }
                    [self freshSearchUI:httpArray];
                    [_waiting stopAnimating];
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
    
    if ([array isEqual:nil]) {
        self.count = 0;
    }else{
        
        [self.dataList addObjectsFromArray:array];
        if ([self.dataList count]<12) {
            self.isFinished =YES;
        }
        [self setCount: [self.dataList count]];
        
    }
    [self.showTableView reloadData];
    [self.showTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    
}

- (IBAction)dismissButtonClick:(id)sender { //关闭搜索界面
    [self hiddenShowView];

}

-(void) hiddenShowView //隐藏搜索界面并退出文本编辑
{
    _showConditionView.hidden = YES;
    _bacButton.hidden = YES;
    [_keyWordTextField resignFirstResponder];
    _tishiLabel.hidden = NO;
    _tixingLabel.hidden = YES;
}

- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)moreFunction:(id)sender { //更多按钮
    SystemSetViewController *systemSet = [[SystemSetViewController alloc] initWithNibName:nil bundle:nil];
    systemSet.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [self presentViewController:systemSet animated:YES completion:nil];
}

- (IBAction)missKeyboard:(id)sender { //退出文本编辑
    [_keyWordTextField resignFirstResponder];
}


#pragma mark- getter&setter


-(void)setPage:(int)page
{
    _page = page;
}
-(int) getPage
{
    return _page;
}
-(void) setNewsType:(int)newsType
{
    _newsType = newsType;
}
-(int)getNewsType
{
    return _newsType;
}
-(void) setCount:(int)count
{
    _count = count;
}
-(int) getCount
{
    return  _count;
}
-(void) setFlag:(NSString *)flag
{
    _flag = [flag copy];
}
-(NSString*) getFlag
{
    return _flag;
}
-(void) setTitleString:(NSString *)titleString
{
    _titleString = [titleString copy];
}
-(NSString*) getTitleString
{
    return _titleString;
}


-(void)setMark:(NSString *)mark
{
    _mark = [mark copy];
}
-(NSString*) getMark
{
    return _mark;
}
-(void) setRiqiFanwei:(NSString*)riqiFanwei
{
    _riqiFanwei =riqiFanwei;
}
-(NSString*) getRiqiFanwei
{
    return _riqiFanwei;
}
-(void) setZhuaQuKeyWord:(NSString *)zhuaQuKeyWord
{
    _zhuaQuKeyWord =[zhuaQuKeyWord copy];
}
-(NSString*) getZhuaquKeyWord
{
    return _zhuaQuKeyWord;
}

-(void) changeTitle:(NSString*) title
{
    _titileLabel.text = [title copy];
}
-(void) changeSearchTitle:(NSString*) title
{
    NSString *searchTitle = [NSString stringWithFormat:@"%@搜索",title];
    _searchTitleLabel.text = [searchTitle copy];
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
            if (self.isSearch == NO) {
                httpArray = [self getHttpJson:[self getPage] getNewsType:[self getNewsType]];
            }
            
        });
        dispatch_group_notify(group, queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.isSearch == NO) {
                    if (httpArray == nil) {
                        _freshButton.hidden = NO;
                    }else{
                        [self freshUI:httpArray];
                    }
                    [_waiting stopAnimating];
                }
                
            });
        });
    });

}
- (IBAction)zhuyeClick:(id)sender {
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    banshizhuanquViewController *moreView =
    [mainStory instantiateViewControllerWithIdentifier:@"banshizhuanquView"];
    moreView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:moreView animated:YES completion:nil];
}
@end
