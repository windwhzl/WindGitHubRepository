//
//  rsksListViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-29.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "rsksListViewController.h"
#import "zhaopinhuiTableViewCell.h"
#import "HttpUtil.h"
#import "loadMoreTableViewCell.h"
@interface rsksListViewController ()

@end

@implementation rsksListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setPage:1];
    NSArray *array =[self getHttpJson:[self getPage] getNewsType:[self getNewsType]];
    self.dataList = [[NSMutableArray alloc]initWithArray:array];
    self.isFinished =NO;
    
    if ([array isEqual:nil]) {
        self.count = 0;
    }else{
        
        self.dataList = [[NSMutableArray alloc]initWithArray:array];
        if ([self.dataList count]<12) {
            self.isFinished =YES;
        }
        [self setCount: [self.dataList count]];
        
    }
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
    if (indexPath.row == [self.dataList count]) {
        [self setPage:[self getPage]+1];
        NSArray *array =[self getHttpJson:[self getPage] getNewsType:[self getNewsType]];
        if ([array count]<12) {
            self.isFinished =YES;
        }
        self.count += [array count];
        [self.dataList addObjectsFromArray:array];
        [tableView reloadData];
        
    }
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
-(void) setNewsType:(int)newsType
{
    _newsType = newsType;
}
-(int)getNewsType
{
    return _newsType;
}
-(void) setCount:(NSUInteger)count
{
    _count = count;
}
-(NSUInteger) getCount
{
    return  _count;
}
@end
