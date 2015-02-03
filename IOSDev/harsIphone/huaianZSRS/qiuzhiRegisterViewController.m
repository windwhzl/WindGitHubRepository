//
//  qiuzhiRegisterViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-12-22.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "qiuzhiRegisterViewController.h"
#import "SfzHelper.h"
#import "HttpUtil.h"
#import "SfzHelper.h"
@interface qiuzhiRegisterViewController ()

@end

@implementation qiuzhiRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void) viewDidAppear:(BOOL)animated
{
    NSString *wenhuachengduPlistPath = [[NSBundle mainBundle] pathForResource:@"wenhuachengdu" ofType:@"plist"];
    NSString *renyuanleibiePlistPath = [[NSBundle mainBundle] pathForResource:@"renyuanleibie" ofType:@"plist"];
    NSString *jishudengjiPlistPath = [[NSBundle mainBundle] pathForResource:@"jishudengji" ofType:@"plist"];
    
    _wenhuachengduArray = [NSArray arrayWithContentsOfFile:wenhuachengduPlistPath];
    _renyuanleibieArray = [NSArray arrayWithContentsOfFile:renyuanleibiePlistPath];
    _jishudengjiArray = [NSArray arrayWithContentsOfFile:jishudengjiPlistPath];
    
    [_wenhuachengduPicker reloadComponent:0];
    [_renyuandengjiPicker reloadComponent:0];
    [_jishudengjiPicker reloadComponent:0];
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
-(NSString*) getHttpJson{
    NSString *JsonURLString;
    JsonURLString = [NSString stringWithFormat:@"%@%@",[HttpUtil getZhaopinUrl],@"jobdata/ydzdAction!register.do"];
    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str ;//设置参数
    str = [NSString stringWithFormat:@"aac003=%@&aac002=%@&awb004=%@&aae139=%@&aae015=%@&aac011=%@&acc20t=%@&jsdj=%@",_name_TextField.text,_sfzh_TextField.text,_pwd_TextField.text,_num_TextField.text,_mail_textField.text,[self getWhcdValue],[self getRylbValue],[self getJsdjValue]];

    
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
    NSString *jsonString = result[@"message"];
    return jsonString;
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == 0) {
        return [_wenhuachengduArray count];
    } else if(pickerView.tag==1) {
        return [_renyuanleibieArray count];
    }else {
        return [_jishudengjiArray count];
    }
}
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    
     if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumFontSize = 8.;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:UITextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:17]];
        }
        pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    
        return pickerLabel;
    
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
     NSDictionary *rowData ;
    if (pickerView.tag == 0) {
        
        rowData = _wenhuachengduArray[row];
        return rowData[@"string_value"];
        
    }else if(pickerView.tag == 1){
        
        rowData = _renyuanleibieArray[row];
        return rowData[@"string_value"];
        
    }else {
        
        rowData = _jishudengjiArray[row];
        return rowData[@"string_value"];
    }
}
-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSDictionary *rowData;
    if (pickerView.tag == 0) {
        
        rowData = _wenhuachengduArray[row];
        [self setWhcdString: rowData[@"string_value"]];
        [self setWhcdValue:rowData[@"key_value"]];
        
    }else if(pickerView.tag == 1){
        
        rowData = _renyuanleibieArray[row];
        [self setRylbString:rowData[@"string_value"]];
        [self setRylbValue:rowData[@"key_value"]];
        
    }else {
        
        rowData = _jishudengjiArray[row];
        [self setJsdjString:rowData[@"string_value"]];
        [self setJsdjValue:rowData[@"key_value"]];
        
    }
}
- (IBAction)missKeyboard:(id)sender {
    [_sfzh_TextField resignFirstResponder];
    [_name_TextField resignFirstResponder];
    [_password_TextField resignFirstResponder];
    [_pwd_TextField resignFirstResponder];
    [_num_TextField resignFirstResponder];
    [_mail_textField resignFirstResponder];
}

- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showSecondView:(id)sender {
    CATransition *animShow=[CATransition animation];
    animShow.type=kCATransitionMoveIn ;
    animShow.duration=0.5;
    animShow.subtype = kCATransitionFromTop;
    [_secondView.layer addAnimation:animShow forKey:nil];
    _secondView.hidden = NO;
}

- (IBAction)hidenSecondView:(id)sender {
    CATransition *animShow=[CATransition animation];
    animShow.type=kCATransitionPush ;
    animShow.duration=0.5;
    animShow.subtype = kCATransitionFromBottom;
    [_secondView.layer addAnimation:animShow forKey:nil];
    _secondView.hidden = YES;
}

- (IBAction)registClick:(id)sender {
    BOOL condition = YES;
    while (condition) {
        
        if (![SfzHelper IdCardValidate:_sfzh_TextField.text]) {
            [self setTishiString:@"上一页中身份证号不正确"];
            condition = NO;
            break;
        }
        if (_name_TextField.text.length<2) {
            
            [self setTishiString:@"上一页中姓名输入有误"];
            condition = NO;
            break;
        }
        if (_password_TextField.text.length<5) {
            [self setTishiString:@"密码长度小于5位"];
            condition = NO;
            break;
        }
        
        if (![_pwd_TextField.text isEqualToString:_password_TextField.text]) {
            
            [self setTishiString:@"两次密码输入不一致"];
            condition = NO;
            break;
        }
        if (_num_TextField.text.length!=11) {
            
            [self setTishiString:@"请输入正确的手机号"];
            condition = NO;
            break;
        }
        if (_mail_textField.text.length == 0) {
            [self setTishiString:@"请输入正确的邮箱地址"];
            condition = NO;
            break;
        }
        if (_whcdValue.length == 0) {
            
            [self setTishiString:@"请选择文化程度"];
            condition = NO;
            break;
        }
        if (_rylbValue.length == 11) {
            
            [self setTishiString:@"请选择人员类别"];
            condition = NO;
            break;
        }
        if (_jsdjValue.length == 0) {
            [self setTishiString:@"请选择技术等级"];
            condition = NO;
            break;
        }
        dispatch_queue_t queue =
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            __block NSString *httpString;
            dispatch_group_t group =dispatch_group_create();
            dispatch_group_async(group, queue, ^{
                httpString = [self getHttpJson];
            });
            dispatch_group_async(group, queue, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_waiting startAnimating];
                });
            });
            dispatch_group_notify(group, queue, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setTishiString:httpString];
                    [_waiting stopAnimating];
                    
                    if ([_tishiString isEqualToString:@"注册成功"]) {
                        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
                        if([userDefaults boolForKey:@"isMemberLoginSfzhAndPwd"]){
                            
                            [userDefaults setObject:[self.sfzh_TextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"loginUserName"];
                            
                            [userDefaults setObject:[self.password_TextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"loginUserPwd"];
                        }
                        [userDefaults synchronize];
                    }
                });
            });
        });
        condition = NO;
        break;
    }
}

- (IBAction)wenhuaButtonClick:(id)sender {
    
    CATransition *animShow=[CATransition animation];
    animShow.type=kCATransitionMoveIn ;
    animShow.duration=0.5;
    animShow.subtype = kCATransitionFromTop;
    [_wenhuachengduPicker.layer addAnimation:animShow forKey:nil];
    
    _wenhuachengduPicker.hidden = NO;
    _renyuandengjiPicker.hidden = YES;
    _jishudengjiPicker.hidden = YES;
}

- (IBAction)renyuanButtonClick:(id)sender {
    
    CATransition *animShow=[CATransition animation];
    animShow.type=kCATransitionMoveIn ;
    animShow.duration=0.5;
    animShow.subtype = kCATransitionFromTop;
    [_renyuandengjiPicker.layer addAnimation:animShow forKey:nil];
    
    _wenhuachengduPicker.hidden = YES;
    _renyuandengjiPicker.hidden = NO;
    _jishudengjiPicker.hidden = YES;
}

- (IBAction)jishuButtonClick:(id)sender {
    
    CATransition *animShow=[CATransition animation];
    animShow.type=kCATransitionMoveIn ;
    animShow.duration=0.5;
    animShow.subtype = kCATransitionFromTop;
    [_jishudengjiPicker.layer addAnimation:animShow forKey:nil];
    
    _wenhuachengduPicker.hidden = YES;
    _renyuandengjiPicker.hidden = YES;
    _jishudengjiPicker.hidden = NO;
}

-(void) setWhcdValue:(NSString *)whcdValue
{
    _whcdValue = [whcdValue copy];
}
-(NSString*) getWhcdValue
{
    return _whcdValue;
}

-(void) setRylbValue:(NSString *)rylbValue
{
    _rylbValue = [rylbValue copy];
}
-(NSString*) getRylbValue
{
    return _rylbValue;
}

-(void) setJsdjValue:(NSString *)jsdjValue
{
    _jsdjValue = [jsdjValue copy];
}
-(NSString*) getJsdjValue
{
    return _jsdjValue;
}


-(void) setWhcdString:(NSString *)whcdString
{
    _whcdString = [whcdString copy];
    _whcdLabel.text = [_whcdString copy];
}
-(void) setRylbString:(NSString *)rylbString
{
    _rylbString = [rylbString copy];
    _rylbLabel.text = [_rylbString copy];
}
-(void) setJsdjString:(NSString *)jsdjString
{
    _jsdjString = [jsdjString copy];
    _jsdjLabel.text = [_jsdjString copy];
}
-(void) setTishiString:(NSString *)tishiString
{
    _tishiString = [tishiString copy];
    _tishiLabel.text = [_tishiString copy];
}

@end
