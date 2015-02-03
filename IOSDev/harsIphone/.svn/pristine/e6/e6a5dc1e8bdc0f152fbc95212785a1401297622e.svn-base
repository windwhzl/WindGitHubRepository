//
//  zhishiwendaViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-24.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "zhishiwendaViewController.h"
#import "HttpUtil.h"
#import "niwenwodaListViewController.h"
@interface zhishiwendaViewController ()

@end

@implementation zhishiwendaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.]

}
-(void) viewDidAppear:(BOOL)animated{
    _array= @[@{@"name":@"请选择类别"}];
    _keyWord1Array = [[NSMutableArray alloc]initWithArray:_array];
    [_keyWord1Array addObjectsFromArray:[self getHttpJson:@"0"]];
    self.keyWord2Array = _array;
    self.keyWord3Array = _array;
    self.diquArray = @[@"请选择地区",@"市直",@"清河区",@"清浦区",@"淮阴区",@"淮安区",@"开发区",@"涟水县",@"金湖县",@"洪泽县",@"盱眙县"];
    _picker2Array = [[NSMutableArray alloc] initWithArray:_array];
    _picker3Array = [[NSMutableArray alloc] initWithArray:_array];
    [_keyWord1Picker reloadAllComponents];
    [_diquPicker reloadAllComponents];
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
-(NSArray *)getHttpJson:(NSString*)newId
{
    NSString *JsonURLString;
    JsonURLString = [NSString stringWithFormat:@"%@%@",[HttpUtil getUrl],@"zsrs-zsk/zskAction!getWord"];
    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str ;//设置参数
    str = [NSString stringWithFormat:@"parentID=%@",newId];
    
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
- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)chaxunClick:(id)sender {
    _keyWord1Picker.hidden = YES;
    _keyWord2Picker.hidden = YES;
    _keyWord3Picker.hidden = YES;
    _diquPicker.hidden = YES;
    [self setKeyWord1:self.keyWord1Label.text];
    [self setKeyWord2:self.keyWord2Label.text];
    [self setKeyWord3:self.keyWord3Label.text];
    [self setDiqu:self.diquLabel.text];
    if ([[self getKeyWord1] isEqualToString:@"请滚动选择"]||
        [[self getKeyWord2] isEqualToString:@"请滚动选择"]||
        [[self getKeyWord3] isEqualToString:@"请滚动选择"]||
        [[self getDiqu] isEqualToString:@"请选择地区"]) {
        
        self.attentionLabel.hidden = NO;
    }else{
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    niwenwodaListViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"niwenwodaListView"];
    [listView setFlag:@"zswd"];
    [listView setKeyWord1:[self getKeyWord1]];
    [listView setKeyWord2:[self getKeyWord2]];
    [listView setKeyWord3:[self getKeyWord3]];
    [listView setKeyWord4:[self getDiqu]];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
    }
}

- (IBAction)keyWord1Click:(id)sender {
    CATransition *animShow=[CATransition animation];
    animShow.type=kCATransitionPush ;
    animShow.duration=0.7;
    animShow.subtype = kCATransitionFromTop;
    [_keyWord1Picker.layer addAnimation:animShow forKey:nil];
    _keyWord1Picker.hidden = NO;
    _keyWord2Picker.hidden = YES;
    _keyWord3Picker.hidden = YES;
    _diquPicker.hidden = YES;
    self.attentionLabel.hidden = YES;
}

- (IBAction)keyWord2Click:(id)sender {
    CATransition *animShow=[CATransition animation];
    animShow.type=@"rippleEffect" ;
    animShow.duration=0.7;
    [_keyWord2Picker.layer addAnimation:animShow forKey:nil];
    _keyWord1Picker.hidden = YES;
    _keyWord2Picker.hidden = NO;
    _keyWord3Picker.hidden = YES;
    _diquPicker.hidden = YES;
    self.attentionLabel.hidden = YES;
}

- (IBAction)keyWord3Click:(id)sender {
    CATransition *animShow=[CATransition animation];
    animShow.type=@"cube";
    animShow.duration=0.5;
    [_keyWord3Picker.layer addAnimation:animShow forKey:nil];
    _keyWord1Picker.hidden = YES;
    _keyWord2Picker.hidden = YES;
    _keyWord3Picker.hidden = NO;
    _diquPicker.hidden = YES;
    self.attentionLabel.hidden = YES;
}

- (IBAction)diquClick:(id)sender {
    CATransition *animShow=[CATransition animation];
    animShow.type=kCATransitionMoveIn ;
    animShow.duration=0.7;
    animShow.subtype = kCATransitionFromTop;
    [_diquPicker.layer addAnimation:animShow forKey:nil];
    
    _keyWord1Picker.hidden = YES;
    _keyWord2Picker.hidden = YES;
    _keyWord3Picker.hidden = YES;
    _diquPicker.hidden = NO;
    self.attentionLabel.hidden = YES;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == _keyWord1Picker) {
        return [_keyWord1Array count];
    }else if(pickerView == _keyWord2Picker)
    {
        return [_picker2Array count];
    }else if(pickerView ==_keyWord3Picker)
    {
        return [_picker3Array count];
    }else {
        return [_diquArray count];
    }
    
}
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == _keyWord1Picker) {
        NSDictionary *rowData = _keyWord1Array[row];
        NSString *title = rowData[@"name"];
        return title;
    }else if(pickerView == _keyWord2Picker)
    {
        NSDictionary *rowData = _picker2Array[row];
        NSString *title = rowData[@"name"];
        return title;
    }else if(pickerView ==_keyWord3Picker)
    {
        NSDictionary *rowData = _picker3Array[row];
        NSString *title = rowData[@"name"];
        return title;
    }else {

        return _diquArray[row];
    }

}
-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == _keyWord1Picker) {
        
        [_picker2Array removeAllObjects];
        [_picker2Array addObjectsFromArray:_array];
        
        [_picker3Array removeAllObjects];
        [_picker3Array addObjectsFromArray:_array];
        [_keyWord3Picker reloadAllComponents];
        
        _keyWord2Label.text = @"请点击选择";
        
        NSDictionary *rowData = _keyWord1Array[row];
        NSString *newsId = rowData[@"id"];
        NSString *title = rowData[@"name"];
        self.keyWord1Label.text = [title copy];
        self.keyWord2Array = [self getHttpJson:newsId];
        [_picker2Array addObjectsFromArray:_keyWord2Array];
        [_keyWord2Picker reloadAllComponents];
        
    }else if(pickerView == _keyWord2Picker){
        
        [_picker3Array removeAllObjects];
        [_picker3Array addObjectsFromArray:_array];
        [_keyWord3Picker reloadAllComponents];
        _keyWord3Label.text = @"请点击选择";
        
        NSDictionary *rowData = self.picker2Array[row];
        NSString *newsId = rowData[@"id"];
        NSString *title = rowData[@"name"];
        self.keyWord2Label.text = [title copy];
        if (newsId != nil) {
            self.keyWord3Array = [self getHttpJson:newsId];
            [_picker3Array addObjectsFromArray:_keyWord3Array];
            [_keyWord3Picker reloadAllComponents];
        }

        
    }else if(pickerView == _keyWord3Picker){
        
        NSDictionary *rowData = self.picker3Array[row];
        NSString *title = rowData[@"name"];
        self.keyWord3Label.text = [title copy];
        
    }else {
        _diquLabel.text = [_diquArray[row] copy];
    }
}

-(void) setKeyWord1:(NSString *)keyWord1
{
    _keyWord1 = keyWord1;
}
-(NSString *) getKeyWord1
{
    return  _keyWord1;
}
-(void) setKeyWord2:(NSString *)keyWord2
{
    _keyWord2 = keyWord2;
}
-(NSString *) getKeyWord2
{
    return  _keyWord2;
}
-(void) setKeyWord3:(NSString *)keyWord3
{
    _keyWord3 = keyWord3;
}
-(NSString *) getKeyWord3
{
    return  _keyWord3;
}
-(void) setDiqu:(NSString *)diqu
{
    _diqu = [diqu copy];
}
-(NSString*) getDiqu
{
    return _diqu;
}
@end
