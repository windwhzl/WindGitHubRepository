//
//  qiuzhiLoginViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-12-22.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "qiuzhiLoginViewController.h"
#import "qiuzhiRegisterViewController.h"
#import "HttpUtil.h"
@interface qiuzhiLoginViewController ()

@end

@implementation qiuzhiLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_waiting stopAnimating];
}

-(void) viewWillAppear:(BOOL)animated
{
    UITapGestureRecognizer *tapGestureRecognizer=[[UITapGestureRecognizer alloc]
                                                  initWithTarget:self
                                                  action:@selector(memberNameAndSfzh)
                                                  ];
    tapGestureRecognizer.numberOfTapsRequired=1;
    [self.memberView addGestureRecognizer:tapGestureRecognizer];
    
    self.userTextField.delegate=self;
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    if([userDefaults boolForKey:@"isMemberLoginSfzhAndPwd"]){//如果之前已经记住了身份证号和姓名
        self.memberIndicatorImageView.image=[UIImage imageNamed:@"checked.png"];
        self.userTextField.text=[userDefaults stringForKey:@"loginUserName"];
        self.passwordTextField.text=[userDefaults stringForKey:@"loginUserPwd"];
    }else{
        self.memberIndicatorImageView.image=[UIImage imageNamed:@"check.png"];
    }
}
-(void)memberNameAndSfzh{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    if([userDefaults boolForKey:@"isMemberLoginSfzhAndPwd"]){//如果之前已经记住了身份证号和姓名
        self.memberIndicatorImageView.image=[UIImage imageNamed:@"check.png"];
        [userDefaults setBool:false forKey:@"isMemberLoginSfzhAndPwd"];
        [userDefaults setObject:@"" forKey:@"loginUserName"];
        [userDefaults setObject:@"" forKey:@"loginUserPwd"];
    }else{//如果之前没有记住身份证号和姓名
        self.memberIndicatorImageView.image=[UIImage imageNamed:@"checked.png"];
        [userDefaults setBool:true forKey:@"isMemberLoginSfzhAndPwd"];
    }
    [userDefaults synchronize];
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
    JsonURLString = [NSString stringWithFormat:@"%@%@",[HttpUtil getZhaopinUrl],@"jobdata/ydzdAction!bm.do"];
    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str ;//设置参数
    
    str = [NSString stringWithFormat:@"aac002=%@&awb004=%@&id=%@",_userTextField.text,_passwordTextField.text,_zhiweiId];
    
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
    //    if (![state isEqualToString:@"1"]) {
    //        return nil;
    //    }
    return jsonString;
}
- (IBAction)loginButtonClick:(id)sender {
    
    [self quitEditing:sender];
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
                [self setMessage:httpString];
                [_waiting stopAnimating];
                
                if ([_message isEqualToString:@"岗位申请成功"]) {
                    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
                    if([userDefaults boolForKey:@"isMemberLoginSfzhAndPwd"]){
                        [userDefaults setObject:[self.userTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"loginUserName"];
                        [userDefaults setObject:[self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"loginUserPwd"];
                    }
                    [userDefaults synchronize];
                }
            });
        });
    });
    


}

- (IBAction)quitEditing:(id)sender {
    [_userTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

- (IBAction)registerButtonClick:(id)sender {
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"qiyezhaopin" bundle:nil];
    qiuzhiRegisterViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"qiuzhiRegisterView"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listView animated:YES completion:nil];
}
- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) setMessage:(NSString *)message
{
    _message = [message copy];
    _messageLabel.text = [_message copy];
}
@end
