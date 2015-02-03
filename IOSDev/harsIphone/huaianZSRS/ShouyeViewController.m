//
//  ShouyeViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-9.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "ShouyeViewController.h"
#import "ButtomViewController.h"
#import "shouyeTableViewCell.h"
#import "LoadWebViewController.h"
#import "HttpUtil.h"
#import "NewsClass.h"
#import "zhengceTableViewCell.h"
#import "MoreViewController.h"
#import "shouyeWebViewController.h"
#import "zhaokaoxinxiViewController.h"
#import "banshizhuanquViewController.h"
#import "wycyListViewController.h"
#import "AlertDialogWhenFunctionNotComplete.h"
#import "loadMoreTableViewCell.h"
#import "SystemSetViewController.h"
@interface ShouyeViewController ()

@end

@implementation ShouyeViewController
@synthesize scrollView;
@synthesize slideImages,pageControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flag = @"yaowen";
    self.isFirst =YES;
    [self.shouyeTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    // Do any additional setup after loading the view.
    [self doScrollImg];
    [self setNewsType:@"251"];
    _isLoaded = NO;
    _queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

}
-(void) viewDidAppear:(BOOL)animated
{
    if (self.isFirst) {
        __block NSString* httpVersion;
            dispatch_async(_queue, ^{
            dispatch_group_t group =dispatch_group_create();
            dispatch_group_async(group, _queue, ^{
                self.shouyeData = [self getHttpJson];
            });
            dispatch_group_async(group, _queue, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    httpVersion = [self getHttpVersion];
                    [self makeButtonDisable];
                });
            });
            dispatch_group_notify(group, _queue, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (_isLoaded == NO) {
                        [self reloadTableView];
                        [_waiting stopAnimating];
                        _isLoaded = YES;
                        [self makeButtonAble];
                    }
                    if ([[self getLocalVersion] isEqualToString:httpVersion]) {

                    }else {
                        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"版本更新" message:@"检测到新版本，是否更新" delegate:self cancelButtonTitle:@"稍后再说" otherButtonTitles:@"立即更新", nil];
                        [alert show];

                    }
                });
            });
            
        });
    }

}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex!= alertView.cancelButtonIndex) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id949803188"]];
    }
}
-(void) viewDidDisappear:(BOOL)animated
{
    self.isFirst = NO;
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
#pragma mark- 要闻等按钮事件
- (IBAction)yaowenClick:(id)sender {
    dispatch_async(_queue, ^{
        dispatch_group_t group =dispatch_group_create();
        dispatch_group_async(group, _queue, ^{
            self.flag = @"yaowen";
            [self setNewsType:@"251"];
            self.shouyeData = [self getHttpJson];
        });
        dispatch_group_async(group, _queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                _showNoneMessage.hidden =YES;
                _freshButton.hidden = YES;
                [self.yaowenButton setTintColor:[UIColor whiteColor]];
                [self.xianquButton setTintColor:[UIColor blackColor]];
                [self.tongzhiButton setTintColor:[UIColor blackColor]];
                [self.zhaokaoButton setTintColor:[UIColor blackColor]];
                [self.zhengceButton setTintColor:[UIColor blackColor]];
                [self changeBaiseLocal:self.yaowenButton];
                self.flagLabel.text = @"  要闻》";
                [_waiting startAnimating];
                [self makeButtonDisable];
            });
        });
        dispatch_group_notify(group, _queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadTableView];
                [_waiting stopAnimating];
                 [self makeButtonAble];
            });
        });
        
    });
}

- (IBAction)xianquClick:(id)sender {
    dispatch_async(_queue, ^{
        dispatch_group_t group =dispatch_group_create();
        dispatch_group_async(group, _queue, ^{
            self.flag = @"xianqu";
            [self setNewsType:@"252"];
            self.shouyeData = [self getHttpJson];
        });
        dispatch_group_async(group, _queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                _showNoneMessage.hidden =YES;
                _freshButton.hidden = YES;
                [self.yaowenButton setTintColor:[UIColor blackColor]];
                [self.xianquButton setTintColor:[UIColor whiteColor]];
                [self.tongzhiButton setTintColor:[UIColor blackColor]];
                [self.zhaokaoButton setTintColor:[UIColor blackColor]];
                [self.zhengceButton setTintColor:[UIColor blackColor]];
                [self changeBaiseLocal:self.xianquButton];
                self.flagLabel.text = @"  县区》";
                [_waiting startAnimating];
                [self makeButtonDisable];
            });
        });
        dispatch_group_notify(group, _queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadTableView];
                [_waiting stopAnimating];
                 [self makeButtonAble];
            });
        });
        
    });
}

- (IBAction)tongzhiClick:(id)sender {

    dispatch_async(_queue, ^{
        dispatch_group_t group =dispatch_group_create();
        dispatch_group_async(group, _queue, ^{
            self.flag = @"tongzhi";
            [self setNewsType:@"280"];
            self.shouyeData = [self getHttpJson];
        });
        dispatch_group_async(group, _queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                _showNoneMessage.hidden =YES;
                _freshButton.hidden = YES;
                [self.yaowenButton setTintColor:[UIColor blackColor]];
                [self.xianquButton setTintColor:[UIColor blackColor]];
                [self.tongzhiButton setTintColor:[UIColor whiteColor]];
                [self.zhaokaoButton setTintColor:[UIColor blackColor]];
                [self.zhengceButton setTintColor:[UIColor blackColor]];
                [self changeBaiseLocal:self.tongzhiButton];
                self.flagLabel.text = @"  通知》";
                [_waiting startAnimating];
                [self makeButtonDisable];
            });
        });

        dispatch_group_notify(group, _queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadTableView];
                [_waiting stopAnimating];
                 [self makeButtonAble];
            });
        });
        
    });

}
- (IBAction)zhaokaoClick:(id)sender {
    dispatch_async(_queue, ^{
        dispatch_group_t group =dispatch_group_create();
        dispatch_group_async(group, _queue, ^{
            self.flag = @"zhaokao";
            [self setNewsType:@"200"];
            self.shouyeData = [self getHttpJson];
        });
        dispatch_group_async(group, _queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                _showNoneMessage.hidden =YES;
                _freshButton.hidden = YES;
                [self.yaowenButton setTintColor:[UIColor blackColor]];
                [self.xianquButton setTintColor:[UIColor blackColor]];
                [self.tongzhiButton setTintColor:[UIColor blackColor]];
                [self.zhaokaoButton setTintColor:[UIColor whiteColor]];
                [self.zhengceButton setTintColor:[UIColor blackColor]];
                [self changeBaiseLocal:self.zhaokaoButton];
                self.flagLabel.text = @"  招考》";
                [_waiting startAnimating];
                [self makeButtonDisable];
            });
        });
        dispatch_group_notify(group, _queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadTableView];
                [_waiting stopAnimating];
                 [self makeButtonAble];
            });
        });
        
    });

}
- (IBAction)zhengceClick:(id)sender {
    dispatch_async(_queue, ^{
        dispatch_group_t group =dispatch_group_create();
        dispatch_group_async(group, _queue, ^{
            self.flag = @"zc";
            [self setNewsType:@"1"];
            self.shouyeData = [self getJSonData];
        });
        dispatch_group_async(group, _queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                _showNoneMessage.hidden =YES;
                _freshButton.hidden = YES;
                [self.yaowenButton setTintColor:[UIColor blackColor]];
                [self.xianquButton setTintColor:[UIColor blackColor]];
                [self.tongzhiButton setTintColor:[UIColor blackColor]];
                [self.zhaokaoButton setTintColor:[UIColor blackColor]];
                [self.zhengceButton setTintColor:[UIColor whiteColor]];
                [self changeBaiseLocal:self.zhengceButton];
                self.flagLabel.text = @"  政策》";
                [_waiting startAnimating];
                [self makeButtonDisable];
            });
        });
        dispatch_group_notify(group, _queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadTableView];
                [_waiting stopAnimating];
                 [self makeButtonAble];
            });
        });
        
    });


}
-(void) reloadTableView
{
    if (self.shouyeData == nil) {
        _showNoneMessage.hidden = NO;
        _freshButton.hidden = NO;
        
    }
    [self.shouyeTableView reloadData];
}
- (void) changeBaiseLocal:(UIButton*) sender
{
    CGRect buttonFrame = sender.frame;
    CGRect baiseFrame = self.baiseImage.frame;
    baiseFrame.origin.x = buttonFrame.origin.x;
    baiseFrame.size.width = buttonFrame.size.width;
    self.baiseImage.frame = baiseFrame;
}
#pragma mark- 线程获取数据
-(NSArray *)getHttpJson{
    
    NSString *JsonURLString;
 
     JsonURLString = [NSString stringWithFormat:@"%@jobdata/snewsAction!getSNews.do",[HttpUtil getUrl1]];
    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str ;//设置参数
    if([self.flag isEqualToString:@"zc"])
    {
        str = @"searchKey.className=2";
    }else {
        str = [NSString stringWithFormat:@"type=%@&page=1&rows=12",[self getNewsType]];
    }
    
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
//获取政策的JSON
- (NSArray *) getJSonData{
    NSString *JsonURLString;
    JsonURLString = [NSString stringWithFormat:@"%@zsrs-zsk/zskAction!zsk_list",[HttpUtil getUrl]];
    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str ;//设置参数
        str = @"searchKey.className=2";
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

- (IBAction)qianjinClick:(id)sender {
    
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    banshizhuanquViewController *moreView =
    [mainStory instantiateViewControllerWithIdentifier:@"banshizhuanquView"];
    moreView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:moreView animated:YES completion:nil];
}

- (IBAction)moreFunction:(id)sender {
    SystemSetViewController *systemSet = [[SystemSetViewController alloc] initWithNibName:nil bundle:nil];
    systemSet.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [self presentViewController:systemSet animated:YES completion:nil];
}
- (IBAction)gengduoButtonClick:(id)sender {
    if ([self.flag isEqualToString:@"zhaokao"]) {
        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
        zhaokaoxinxiViewController *moreView =
                                [mainStory instantiateViewControllerWithIdentifier:@"zhaokaoxinxiView"];
        moreView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:moreView animated:YES completion:nil];
    }else if ([self.flag isEqualToString:@"zc"]){
     UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    MoreViewController *moreView = [mainStory instantiateViewControllerWithIdentifier:@"moreView"];
    [moreView setFlag:self.flag];
    moreView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:moreView animated:YES completion:nil];
    }else {
        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
        wycyListViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"wycyListView"];
        if ([self.flag isEqualToString:@"yaowen"]) {
            [listView setNewsType:251];
            [listView setTitleString:@"人社要闻"];
        }else  if ([self.flag isEqualToString:@"xianqu"]) {
            [listView setNewsType:252];
            [listView setTitleString:@"县区动态"];
        }else {
            [listView setNewsType:280];
            [listView setTitleString:@"通知公告"];
        }
        [listView setFlag:self.flag];
        listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:listView animated:YES completion:nil];
    }
}
#pragma mark- JSON解析
#pragma mark- 表格控制
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.shouyeData == nil||([self.shouyeData count]==0))
    {
        return 0;
    }
    NSInteger count = [self.shouyeData count]+1;
    return count;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
        
        _cell.title = rowData[@"title"];
        NSString *imageString = [NSString stringWithFormat:@"png_%@_logo.png",self.flag];
        UIImage *imageView = [UIImage imageNamed:imageString];
        _cell.flagImage.image = imageView;
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
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [self.shouyeData count]) {
        
        if ([self.flag isEqualToString:@"zhaokao"]) {
            UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
            zhaokaoxinxiViewController *moreView =
            [mainStory instantiateViewControllerWithIdentifier:@"zhaokaoxinxiView"];
            moreView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:moreView animated:YES completion:nil];
        }else if ([self.flag isEqualToString:@"zc"]){
            UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
            MoreViewController *moreView = [mainStory instantiateViewControllerWithIdentifier:@"moreView"];
            [moreView setFlag:self.flag];
            moreView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:moreView animated:YES completion:nil];
        }else {
            UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
            wycyListViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"wycyListView"];
            if ([self.flag isEqualToString:@"yaowen"]) {
                [listView setNewsType:251];
                [listView setTitleString:@"人社要闻"];
            }else  if ([self.flag isEqualToString:@"xianqu"]) {
                [listView setNewsType:252];
                [listView setTitleString:@"县区动态"];
            }else {
                [listView setNewsType:280];
                [listView setTitleString:@"通知公告"];
            }
            [listView setFlag:self.flag];
            listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:listView animated:YES completion:nil];
        }
        
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
#pragma mark- cell处理
-(void) setTongzhiCell:(NSDictionary *)rowData{
    self.cell.title = rowData[@"newstitle"];
    NSDictionary *rowInData =  rowData[@"edittime"];
    NSString *time = rowInData[@"time"];
    [time doubleValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [NSString stringWithFormat:@"%@",
                      [formatter stringFromDate:
                       [NSDate dateWithTimeIntervalSince1970:[time doubleValue]/1000]]];
    self.cell.date = date;

}
-(void) setZhengcecell:(NSDictionary *)rowData{
    self.zhengceCell.title = rowData[@"title"];
    self.zhengceCell.danwei = rowData[@"provideDept"];
}
#pragma mark- 图片滚动处理
-(void) doScrollImg{
   [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    slideImages = [[NSMutableArray alloc] init];
    [slideImages addObject:@"scrollImg01.jpg"];
    [slideImages addObject:@"scrollImg02.png"];
    [slideImages addObject:@"scrollImg03.jpg"];
//    [slideImages addObject:@"scrollImg04.jpg"];
    [pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
    for (int i = 0;i<[slideImages count];i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:i]]];
        imageView.frame = CGRectMake((scrollView.frame.size.width * i) + scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
        [scrollView addSubview:imageView]; // 首页是第0页,默认从第1页开始的。所以+320。。。
    }
    // 取数组最后一张图片 放在第0页
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:([slideImages count]-1)]]];
    imageView.frame = CGRectMake(0,0, scrollView.frame.size.width, scrollView.frame.size.height); // 添加最后1页在首页 循环
    [scrollView addSubview:imageView];
    // 取数组第一张图片 放在最后1页
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:0]]];
    imageView.frame = CGRectMake((scrollView.frame.size.width * ([slideImages count] + 1)) , 0, scrollView.frame.size.width, scrollView.frame.size.height); // 添加第1页在最后 循环
    [scrollView addSubview:imageView];
    
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width * ([slideImages count] + 2), scrollView.frame.origin.y)]; //  +上第1页和第4页  原理：4-[1-2-3-4]-1
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [self.scrollView scrollRectToVisible:CGRectMake(scrollView.frame.size.width,0,scrollView.frame.size.width,scrollView.frame.size.height) animated:NO]; // 默认从序号1位置放第1页 ，序号0位置位置放第4页
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pagewidth/([slideImages count]+2))/pagewidth)+1;
    page --;  // 默认从第二页开始
    pageControl.currentPage = page;
}
// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int currentPage = floor((self.scrollView.contentOffset.x - pagewidth/ ([slideImages count]+2)) / pagewidth) + 1;
    //    int currentPage_ = (int)self.scrollView.contentOffset.x/320; // 和上面两行效果一样
    //    NSLog(@"currentPage_==%d",currentPage_);
    if (currentPage==0)
    {
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width * [slideImages count],0,self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==([slideImages count]+1))
    {
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width,0,self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:NO]; // 最后+1,循环第1页
    }
}
- (void)runTimePage
{
    int page = pageControl.currentPage; // 获取当前的page
    page++;
    page = page > 2 ? 0 : page ;
    pageControl.currentPage = page;
    [self turnPage];
}
- (void)turnPage
{
    int page = pageControl.currentPage; // 获取当前的page
    [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width*(page+1),0,self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:YES]; // 触摸pagecontroller那个点点 往后翻一页 +1
}
- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) setNewsType:(NSString *)newsType
{
    _newsType = [newsType copy];
}
-(NSString*) getNewsType
{
    return _newsType;
}
- (IBAction)clickForFresh:(id)sender {
    dispatch_async(_queue, ^{
        dispatch_group_t group =dispatch_group_create();
        dispatch_group_async(group, _queue, ^{
            self.shouyeData = [self getHttpJson];
        });
        dispatch_group_async(group, _queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                _freshButton.hidden = YES;
                [_waiting startAnimating];
                [self makeButtonDisable];
            });
        });
        dispatch_group_notify(group, _queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadTableView];
                [_waiting stopAnimating];
                [self makeButtonAble];
            });
        });
        
    });
}
-(void) makeButtonDisable
{
    _yaowenButton.enabled = NO;
    _xianquButton.enabled = NO;
    _tongzhiButton.enabled = NO;
    _zhaokaoButton.enabled = NO;
    _zhengceButton.enabled = NO;
}
-(void) makeButtonAble
{
    _yaowenButton.enabled = YES;
    _xianquButton.enabled = YES;
    _tongzhiButton.enabled = YES;
    _zhaokaoButton.enabled = YES;
    _zhengceButton.enabled = YES;
}
-(NSString*) getHttpVersion
{
    NSString *JsonURLString;
    JsonURLString = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@",@"949803188"];
    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str ;//设置参数
    str = @"";
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
    NSArray *infoArray = [getData objectForKey:@"results"];
    NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
    NSString *latestVersion = [releaseInfo objectForKey:@"version"];
    return latestVersion;
}
-(NSString*) getLocalVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    //CFShow((__bridge CFTypeRef)(infoDic));
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    NSString* localVersion = currentVersion;
    return localVersion;
}

@end
