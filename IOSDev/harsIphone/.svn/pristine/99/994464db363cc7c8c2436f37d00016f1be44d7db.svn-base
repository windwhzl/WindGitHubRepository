//
//  rensheLoginViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-12-1.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "rensheLoginViewController.h"
#import "HttpUtil.h"
#import "rensheyunViewController.h"
@interface rensheLoginViewController ()

@end

@implementation rensheLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setEditViewFrame:_editView.frame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewWillAppear:(BOOL)animated
{
    UITapGestureRecognizer *tapGestureRecognizer=[[UITapGestureRecognizer alloc]
                                                  initWithTarget:self
                                                  action:@selector(memberNameAndSfzh)
                                                  ];
    tapGestureRecognizer.numberOfTapsRequired=1;
    [self.memberView addGestureRecognizer:tapGestureRecognizer];
    
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    if([userDefaults boolForKey:@"loginIsMemberSfzhAndName"]){//如果之前已经记住了身份证号和姓名
        self.memberIndicatorImageView.image=[UIImage imageNamed:@"checked.png"];
        self.userTextField.text=[userDefaults stringForKey:@"loginUserName"];
        self.passWordTextField.text=[userDefaults stringForKey:@"loginUserPwd"];
    }else{
        self.memberIndicatorImageView.image=[UIImage imageNamed:@"check.png"];
    }
}
-(void)memberNameAndSfzh{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    if([userDefaults boolForKey:@"loginIsMemberSfzhAndName"]){//如果之前已经记住了身份证号和姓名
        self.memberIndicatorImageView.image=[UIImage imageNamed:@"check.png"];
        [userDefaults setBool:false forKey:@"loginIsMemberSfzhAndName"];
        [userDefaults setObject:@"" forKey:@"loginUserName"];
        [userDefaults setObject:@"" forKey:@"loginUserPwd"];
    }else{//如果之前没有记住身份证号和姓名
        self.memberIndicatorImageView.image=[UIImage imageNamed:@"checked.png"];
        [userDefaults setBool:true forKey:@"loginIsMemberSfzhAndName"];
    }
    [userDefaults synchronize];
}
-(void) viewDidDisappear:(BOOL)animated
{
    _tishiLabel.hidden = YES ;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSDictionary*) getJsonString:(NSString*)user
                        password:(NSString*)password
{
    NSString *JsonURLString;
    JsonURLString = [NSString stringWithFormat:@"%@%@", [HttpUtil getUrl],@"zsrs-zsk/zskAction!login_Sys"];
    NSURL *url = [NSURL URLWithString:JsonURLString];
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str;
    str = [NSString stringWithFormat:@"userInfo.name=%@&userInfo.password=%@",user,password];
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
    
    return getData;
}
- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)dissmissKeyBoard:(id)sender {
    [_userTextField resignFirstResponder];
    [_passWordTextField resignFirstResponder];
    _editView.frame = [self getEditViewFrame];
}
- (IBAction)upEditView:(id)sender{
    CGRect viewFrame = [self getEditViewFrame];
    viewFrame.origin.y -= 80;
    _editView.frame = viewFrame;
}
- (IBAction)loginButtonClick:(id)sender {
    dispatch_queue_t queue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        __block NSDictionary *httpArray;
        dispatch_group_t group =dispatch_group_create();
        dispatch_group_async(group, queue, ^{
            httpArray = [self getJsonString:_userTextField.text password:_passWordTextField.text];
        });
        dispatch_group_notify(group, queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *message = httpArray[@"message"];
                if ([message isEqualToString:@"登陆成功"]) {
                    NSString *depcode = httpArray[@"depcode"];
                        
                        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
                        if([userDefaults boolForKey:@"loginIsMemberSfzhAndName"]){
                            [userDefaults setObject:[self.userTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"loginUserName"];
                            [userDefaults setObject:[self.passWordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"loginUserPwd"];
                        }
                        [userDefaults synchronize];
                    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
                    rensheyunViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"rensheyunView"];
                    [listView setDepcode:depcode];
                    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                    [self presentViewController:listView animated:YES completion:nil];
                    
                }else {
                    
                _tishiLabel.text = message;
                _tishiLabel.hidden = NO;
                [self dissmissKeyBoard:sender];
                }
   
            });
        });
    });
}
-(void) setEditViewFrame:(CGRect)editViewFrame
{
    _editViewFrame = editViewFrame;
}
-(CGRect) getEditViewFrame
{
    return _editViewFrame;
}
@end
