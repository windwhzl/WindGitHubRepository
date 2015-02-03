//
//  gaikuangkuViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-21.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "gaikuangkuViewController.h"
#import "HttpUtil.h"
#import "gaikuangkuTableViewCell.h"
#import "loadMoreTableViewCell.h"
#import "LoadWebViewController.h"
#import "SystemSetViewController.h"
#import "banshizhuanquViewController.h"
@interface gaikuangkuViewController ()

@end

@implementation gaikuangkuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setPage:1];
    self.keyboardOriginY=0;
    //监听键盘的显示事件
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil
     ];
    //监听键盘的隐藏事件
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasHidden:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil
     ];
    
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
            httpArray = [self getHttpJson:[self getPage] getDepartmentCode:[self getDepcode] getKeywords:nil];
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

-(void) keyboardWasShown:(NSNotification *) notification{
    //动态获取键盘的高度
//    NSDictionary *info=[notification userInfo];
//    NSValue *value=[info objectForKey:UIKeyboardFrameEndUserInfoKey];
//    self.keyboardOriginY=[value CGRectValue].origin.y;
//    NSLog(@"keyboard的纵坐标为：%d",self.keyboardOriginY);
}

-(void) keyboardWasHidden:(NSNotification *) notification{
    [UIView beginAnimations:@"ResizeKeyboard" context:nil];
    [UIView setAnimationDuration:0.30f];
    
    self.textFields.frame=CGRectMake(self.textFields.frame.origin.x,
                                     self.textFieldsOriginY
                                     , self.textFields.frame.size.width, self.textFields.frame.size.height);
    
    [UIView commitAnimations];

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
}


-(NSArray *)getHttpJson:(int)currentPage
      getDepartmentCode:(NSString*) departmentCode
            getKeywords:(NSMutableDictionary *)params
{
    NSString *JsonURLString;

        JsonURLString = [NSString stringWithFormat:@"%@%@",[HttpUtil getUrl],@"zsrs-zsk/zskAction!gkk_list"];

    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    
    NSMutableString *paramsStr=[[NSMutableString alloc] initWithCapacity:40];
    [paramsStr appendFormat:@"currentPage=%d",currentPage];
    [paramsStr appendFormat:@"&gkk.departmentCode=%@",departmentCode];//写死的机构代码
    
    if(params!=nil){
        if([params objectForKey:@"keyword1"]!=nil){
            [paramsStr appendFormat:@"&gkk.departmentName=%@",[params objectForKey:@"keyword1"]];
        }
    }
 
    NSData *data1 = [paramsStr dataUsingEncoding:NSUTF8StringEncoding];
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
#pragma mark- 表格相关操作
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
/*    if (indexPath.row == [self.dataList count]) {
        NSString *more = @"moreCell";
        UINib *moreNib =[UINib nibWithNibName:@"loadMoreTableViewCell" bundle:nil];
        [tableView registerNib:moreNib forCellReuseIdentifier:more];
        loadMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:more];
        return cell;
        
    }*/
    NSString *CellTableIdentifier = @"gaikuangkuCell";
    UINib *nib =[UINib nibWithNibName:@"gaikuangkuTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
    gaikuangkuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    NSDictionary *rowData = self.dataList[indexPath.row];
    [cell setDanwei:rowData[@"departmentName"]];
    [cell setDizhi:rowData[@"address"]];
    return cell;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self isFinished]) {
        return [self getCount];
    }else {
        return [self getCount];
    }
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
{
            UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
            LoadWebViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"LoadWebView"];
            [listView setFlag:@"gkk"];
            NSString *postUrl = [NSString stringWithFormat:@"%@zsrs-zsk/zskAction!findGkks",
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
- (IBAction)startSearchButtonClick:(id)sender {
    
    CATransition *animShow=[CATransition animation];
    animShow.type=kCATransitionPush ;
    animShow.duration=0.5;
    animShow.subtype = kCATransitionFromTop;   /* 动画方向*/
    
    if(self.searchView!=nil && self.searchView.hidden==NO){//正在显示
    }else if(self.searchView!=nil && self.searchView.hidden!=NO){//被隐藏了
        [self.searchView.layer addAnimation:animShow forKey:nil];
        self.searchView.hidden=NO;
        
    }else{//没有被实例化
        NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"gaikuangkuSearchView" owner:nil options:nil];
        self.searchView=views[0];
        self.searchView.frame=self.view.frame;
        
        UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(dismissKeywordBoard)];
        gesture.numberOfTapsRequired=1;
        [self.searchView addGestureRecognizer:gesture];
        
        //记录searchView原来的纵坐标位置
        self.textFields=(UIView *)[self.searchView viewWithTag:1];
        self.textFieldsOriginY=self.textFields.frame.origin.y;
//        NSLog(@"textFields原来的纵坐标为：%d",self.textFieldsOriginY);
        
        
        UIButton *searchBtn=(UIButton *)[self.searchView viewWithTag:11];
        [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *closeBtn=(UIButton *)[self.searchView viewWithTag:4];
        [closeBtn addTarget:self action:@selector(closeSearchView) forControlEvents:UIControlEventTouchUpInside];
        
        self.keywordTF1=(UITextField *)[self.searchView viewWithTag:6];
        self.keywordTF1.delegate=self;
        
        [self.searchView.layer addAnimation:animShow forKey:nil];
        [self.view addSubview:self.searchView];
        
    }
    
}

-(void) dismissKeywordBoard{
    if(self.keywordTF1!=nil){
        [self.keywordTF1 resignFirstResponder];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [UIView beginAnimations:@"ResizeKeyboard" context:nil];
    [UIView setAnimationDuration:0.30f];
    
    int tmpTrans=0;
    if([self.keywordTF1 isEqual:textField]){
        tmpTrans=187;
    }
    
    self.textFields.frame=CGRectMake(self.textFields.frame.origin.x
                                     ,20+(227-tmpTrans)
                                     , self.textFields.frame.size.width
                                     , self.textFields.frame.size.height);
    
    [UIView commitAnimations];
    return YES;
}

-(void) searchBtnClick{
    NSMutableDictionary *dictionary=[NSMutableDictionary dictionaryWithCapacity:5];
    NSString *keyword1=[self.keywordTF1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(keyword1.length>0){
        [dictionary setObject:keyword1 forKey:@"keyword1"];
    }
//    NSString *keyword2=[self.keywordTF2.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    if(keyword2.length>0){
//        [dictionary setObject:keyword2 forKey:@"keyword2"];
//    }
//    NSString *keyword3=[self.keywordTF3.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    if(keyword3.length>0){
//        [dictionary setObject:keyword3 forKey:@"keyword3"];
//    }
//    NSString *keyword4=[self.keywordTF4.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    if(keyword4.length>0){
//        [dictionary setObject:keyword4 forKey:@"keyword4"];
//    }
//    NSString *keyword5=[self.keywordTF5.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    if(keyword5.length>0){
//        [dictionary setObject:keyword5 forKey:@"keyword5"];
//    }
    
    [self setPage:1];
    self.isFinished = YES;
    [self setCount:0];
    [self.dataList removeAllObjects];
    [_waiting startAnimating];
    [self closeSearchView];
    dispatch_queue_t queue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        __block NSArray *httpArray;
        dispatch_group_t group =dispatch_group_create();
        dispatch_group_async(group, queue, ^{
            httpArray = [self getHttpJson:[self getPage] getDepartmentCode:[self getDepcode] getKeywords:dictionary];
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

-(void) closeSearchView{
    [self dismissKeywordBoard];
    CATransition *animShow=[CATransition animation];
    animShow.type=kCATransitionPush ;
    animShow.duration=0.5;
    animShow.subtype = kCATransitionFromBottom;   /* 动画方向*/
    
    [self.searchView.layer addAnimation:animShow forKey:nil];
    self.searchView.hidden=YES;
    //在这里我先不把这个searchView移除，当用户退出概况库时，再移除searchView，想想这样的好处
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
-(int) getPage
{
    return _page;
}
-(void) setPage:(int)page
{
    _page = page;
}
-(void) setCount:(int)count
{
    _count = count;
}
-(int) getCount
{
    return  _count;
}
-(void) setDepcode:(NSString *)depcode
{
    _depcode = [depcode copy];
}
-(NSString*) getDepcode
{
    return _depcode;
}
- (IBAction)freshButtonClick:(id)sender {
    
    _freshButton.hidden = NO;
    [_waiting startAnimating];
    
    dispatch_queue_t queue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        __block NSArray *httpArray;
        dispatch_group_t group =dispatch_group_create();
        dispatch_group_async(group, queue, ^{
            httpArray = [self getHttpJson:[self getPage] getDepartmentCode:[self getDepcode] getKeywords:nil];
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
