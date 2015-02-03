//
//  tijiaoWentiViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-12-2.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "tijiaoWentiViewController.h"
#import "searchTableViewCell.h"
#import "HttpUtil.h"
#import "SfzHelper.h"
@interface tijiaoWentiViewController ()

@end

@implementation tijiaoWentiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _areaArray = @[
                        @{@"date":@"请选择您所在的县区",@"key":@""},
                        @{@"date":@"全市",@"key":@""},
                        @{@"date":@"市直",@"key":@""},
                        @{@"date":@"清河区",@"key":@""},
                        @{@"date":@"清浦区",@"key":@""},
                        @{@"date":@"淮阴区",@"key":@""},
                        @{@"date":@"淮安区",@"key":@""},
                        @{@"date":@"开发区",@"key":@""},
                        @{@"date":@"涟水县",@"key":@""},
                        @{@"date":@"金湖县",@"key":@""},
                        @{@"date":@"洪泽县",@"key":@""},
                        @{@"date":@"盱眙县",@"key":@""}
                        ];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSString *)getHttpJson
{
    NSString *JsonURLString;
    JsonURLString = [NSString stringWithFormat:@"%@%@",[HttpUtil getUrl1],@"zsrs-zsk/zskAction!addQuestion"];
    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str ;//设置参数
    
    str = [NSString stringWithFormat:@"question.asker=%@&question.identityId=%@&question.telphone=%@&question.questionName=%@&question.questionType=%@&question.type=%@",_nameTextField.text,_sfzhTextField.text,_telTextField.text,_wentiTextView.text,@"问答库",@"新问题"];
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)dissMissTable:(id)sender {
    [self dissmissShowTable];
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_areaArray count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        NSString *more = @"searchTableCell";
        UINib *moreNib =[UINib nibWithNibName:@"searchTableViewCell" bundle:nil];
        [tableView registerNib:moreNib forCellReuseIdentifier:more];
        searchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:more];
        NSDictionary *titleString = _areaArray[indexPath.row];
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != self.selected) {
        if (self.selected != NSNotFound) {
            NSIndexPath *old = [NSIndexPath indexPathForRow:self.selected inSection:0];
            searchTableViewCell *cell  = [tableView cellForRowAtIndexPath:old];
            UIImage *imageView = [UIImage imageNamed:@"check.png"];
            cell.selectImage.image  = imageView;
        }
    }
    NSDictionary *titleString = _areaArray[indexPath.row];
    NSString *xianqu = titleString[@"date"];
    searchTableViewCell *cell = [[searchTableViewCell alloc] init];
    cell = [tableView cellForRowAtIndexPath:indexPath];
    UIImage *imageView = [UIImage imageNamed:@"checked.png"];
    cell.selectImage.image  = imageView;
    _xianquLabel.text = [xianqu copy];
    self.selected = indexPath.row;

    
}
- (IBAction)selectXianquButton:(id)sender {
    _dissMissButton.hidden = NO;
    _areaTable.hidden = NO;
    _selectedButton.hidden = NO;
}
-(void) dissmissShowTable
{
    _dissMissButton.hidden = YES;
    _areaTable.hidden = YES;
    _selectedButton.hidden = YES;
}
- (IBAction)tijiaoButtonClick:(id)sender {
    
    if ([SfzHelper IdCardValidate:_sfzhTextField.text]) {
        if (_nameTextField.text.length>=2) {
            if (_telTextField.text.length == 11) {
                if (_wentiTextView.text.length>=8) {
                    dispatch_queue_t queue =
                    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                    dispatch_async(queue, ^{
                        __block NSString *httpString;
                        dispatch_group_t group =dispatch_group_create();
                        dispatch_group_async(group, queue, ^{
                            
                            httpString = [self getHttpJson];
                            
                        });
                        dispatch_group_notify(group, queue, ^{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                if (httpString == nil||[httpString isEqualToString:@""]) {
                                    _tishiLabel.text = @"提交问题失败";
                                    _tishiLabel.hidden = NO;
                                }else{
                                    _nameTextField.text =@"";
                                    _telTextField.text =@"";
                                    _sfzhTextField.text = @"";
                                    _wentiTextView.text = @"";
                                    _tishiLabel.text = @"提交成功";
                                    _tishiLabel.hidden = NO;
                                }
                                
                            });
                        });
                    });
                    
                }else{
                    _tishiLabel.text = @"问题描述最少为8个字";
                    _tishiLabel.hidden = NO;
                }
                
            }else{
                _tishiLabel.text = @"请填写正确的手机号";
                _tishiLabel.hidden = NO;
            }
        }else {
            _tishiLabel.text = @"请将信息填写完整";
            _tishiLabel.hidden = NO;
        }

    } else {
        _tishiLabel.text = @"请填写正确身份证号";
        _tishiLabel.hidden = NO;
    }
  }
- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

