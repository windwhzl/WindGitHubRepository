//
//  PeopleInfo2.m
//  qiuzhidengji
//
//  Created by xiaomage on 14/11/21.
//  Copyright (c) 2014年 xiaomage. All rights reserved.
//

#import "PeopleInfo2.h"
#import "PeopleTabBarControllerViewController.h"
#import "SfzHelper.h"
#import "PopView.h"
#import "GTMBase64.h"

@interface PeopleInfo2 ()

@end

@implementation PeopleInfo2

- (void)viewDidLoad {
    
    //获取父ViewController的引用
    self.parent=(PeopleTabBarControllerViewController *)self.parentViewController;
    self.sfzhTextField.delegate=self;
    self.qzyxTextView.delegate=self;
    self.sfzhAreaY=self.sfzhArea.frame.origin.y;
    self.qzyxAreaY=self.qzyxArea.frame.origin.y;
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if([self.sfzhTextField isEqual:textField]){
        self.sfzhArea.backgroundColor=[UIColor grayColor];
        [UIView beginAnimations:@"ResizeKeyboard" context:nil];
        [UIView setAnimationDuration:0.30f];
        self.sfzhArea.frame=CGRectMake(self.sfzhArea.frame.origin.x,
                                       200,
                                       self.sfzhArea.frame.size.width,
                                       self.sfzhArea.frame.size.height);
        [UIView commitAnimations];
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if([self.sfzhTextField isEqual:textField]){
        self.sfzhArea.backgroundColor=[UIColor whiteColor];
        [UIView beginAnimations:@"ResizeKeyboard" context:nil];
        [UIView setAnimationDuration:0.30f];
        self.sfzhArea.frame=CGRectMake(self.sfzhArea.frame.origin.x,
                                       self.sfzhAreaY,
                                       self.sfzhArea.frame.size.width,
                                       self.sfzhArea.frame.size.height);
        [UIView commitAnimations];
    }
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if([self.qzyxTextView isEqual:textView]){
        self.qzyxArea.backgroundColor=[UIColor grayColor];
        [UIView beginAnimations:@"ResizeKeyboard" context:nil];
        [UIView setAnimationDuration:0.30f];
        self.qzyxArea.frame=CGRectMake(self.qzyxArea.frame.origin.x,
                                       110,
                                       self.qzyxArea.frame.size.width,
                                       self.qzyxArea.frame.size.height);
        [UIView commitAnimations];
    }
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if([self.qzyxTextView isEqual:textView]){
        self.qzyxArea.backgroundColor=[UIColor whiteColor];
        [UIView beginAnimations:@"ResizeKeyboard" context:nil];
        [UIView setAnimationDuration:0.30f];
        self.qzyxArea.frame=CGRectMake(self.qzyxArea.frame.origin.x,
                                       self.qzyxAreaY,
                                       self.qzyxArea.frame.size.width,
                                       self.qzyxArea.frame.size.height);
        [UIView commitAnimations];
    }
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if([textField isEqual:self.phoneTextField]){
//        if(string.length==0){
//            return YES;
//        }
//        if(textField.text.length>10){
//            return NO;
//        }
//    }else if([textField isEqual:self.sfzhTextField]){
//        if(string.length==0){
//            return YES;
//        }
//        if(textField.text.length>17){
//            return NO;
//        }
//    }
//    return YES;
//}

//当手指开始触摸屏幕时，将触发该delegate方法
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    // 手指开始触摸的位置
    touchBegan_ = [[touches anyObject] locationInView:self.view];
    NSLog(@"开始触摸:%f",touchBegan_.x);
}

// 当手指在屏幕上移动时，将触发该delegate方法
- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    // 手指移动后，手指离开的位置
    CGPoint point = [[touches anyObject] locationInView:self.view];
     NSLog(@"移动结束:%f",point.x);
    //
    if((point.x-touchBegan_.x)>100){
        ((PeopleTabBarControllerViewController *)self.parentViewController).selectedIndex=0;
    }
    
}

- (IBAction)hideKeyboard:(id)sender {
    [self.phoneTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.qzyxTextView resignFirstResponder];
    [self.addressTextField resignFirstResponder];
    [self.sfzhTextField resignFirstResponder];
}

- (IBAction)cancel:(id)sender {
    [((PeopleTabBarControllerViewController *)self.parentViewController) dismissViewControllerAnimated:YES completion:nil];
}

- (void) closeSelf{
    [((PeopleTabBarControllerViewController *)self.parentViewController) dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)previousPage:(id)sender {
    ((PeopleTabBarControllerViewController *)self.parentViewController).selectedIndex=0;
}

- (IBAction)submit:(id)sender {
    
    //警告提示语句
    NSMutableString *alertMsg=[NSMutableString stringWithCapacity:40];
    
    //获取手机号码
    NSString *phoneNumStr=[self.phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    BOOL phoneNumIsOk=(phoneNumStr.length==11);
    if(!phoneNumIsOk){
        [alertMsg appendString:@"请输入正确的手机号码！\n"];
    }
    
    //获取email
    NSString *emailStr=[self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    BOOL emailIsOk=(emailStr.length>0)&&(![emailStr isEqualToString:@"点击输入邮箱号"]);
    if(!emailIsOk){
        [alertMsg appendString:@"请输入正确的邮箱地址！\n"];
    }
    
    //获取现居住地地址
    NSString *addressStr=[self.addressTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    BOOL addressIsOk=(addressStr.length>0)&&(![addressStr isEqualToString:@"点击输入现居住地址"]);
    if(!addressIsOk){
        [alertMsg appendString:@"请输入现居住地地址！\n"];
    }
    //获取身份证号
    NSString *sfzhStr=[self.sfzhTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    BOOL sfzhIsOk=[SfzHelper IdCardValidate:sfzhStr];
    if(!sfzhIsOk){
        [alertMsg appendString:@"请输入正确的18位身份证号！\n"];
    }
    
    //获取求职意向
    NSString *qzyxStr=[self.qzyxTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    if(phoneNumIsOk && emailIsOk && addressIsOk && sfzhIsOk){
        
        CATransition *animShow=[CATransition animation];
        animShow.type=@"moveIn" ;
        animShow.duration=0.5;
        animShow.subtype = kCATransitionFromTop;   /* 动画方向*/
        
        //加载loading.xib文件
        NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"loading" owner:nil options:nil];
        UIView *rowView=views[0];
        rowView.frame=self.view.frame;
        //取出UIButton控件
        UIButton *closeBtn1=(UIButton *)[rowView viewWithTag:4];
        //为按钮添加点击事件
        [closeBtn1 addTarget:self action:@selector(closeSelf) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *closeBtn2=(UIButton *)[rowView viewWithTag:7];
        //为按钮添加点击事件
        [closeBtn2 addTarget:self action:@selector(closeSelf) forControlEvents:UIControlEventTouchUpInside];
        
        UIActivityIndicatorView *_waiting=(UIActivityIndicatorView *)[rowView viewWithTag:3];
        
        UILabel *alertLabel=(UILabel *)[rowView viewWithTag:8];
        
        [_waiting startAnimating];
        [rowView.layer addAnimation:animShow forKey:nil];
        
        [self.view addSubview:rowView];
        
        
//        PopView *popView=[[PopView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-50, self.view.bounds.size.height/2, 100.0, 10.0)];
//
//        [self.view addSubview:popView];
//        [popView setText:@"登记失败！"];
        
        
        //封装请求参数
        NSMutableString *paramStr=[[NSMutableString alloc] initWithCapacity:40];
        
        [paramStr appendFormat:@"%@=%@",@"name",[GTMBase64 stringByEncodingData:[self.parent.name dataUsingEncoding:NSUTF8StringEncoding]]];
        [paramStr appendFormat:@"&%@=%@",@"sex",[GTMBase64 stringByEncodingData:[self.parent.sex dataUsingEncoding:NSUTF8StringEncoding]]];
        [paramStr appendFormat:@"&%@=%@",@"nation",[GTMBase64 stringByEncodingData:[[NSString stringWithFormat:@"%d",self.parent.nation] dataUsingEncoding:NSUTF8StringEncoding]]];
        [paramStr appendFormat:@"&%@=%@",@"birthday",[GTMBase64 stringByEncodingData:[self.parent.birthday dataUsingEncoding:NSUTF8StringEncoding]]];
        [paramStr appendFormat:@"&%@=%@",@"tel",[GTMBase64 stringByEncodingData:[phoneNumStr dataUsingEncoding:NSUTF8StringEncoding]]];
        [paramStr appendFormat:@"&%@=%@",@"email",[GTMBase64 stringByEncodingData:[emailStr dataUsingEncoding:NSUTF8StringEncoding]]];
        [paramStr appendFormat:@"&%@=%@",@"address",[GTMBase64 stringByEncodingData:[addressStr dataUsingEncoding:NSUTF8StringEncoding]]];
        [paramStr appendFormat:@"&%@=%@",@"cardno",[GTMBase64 stringByEncodingData:[sfzhStr dataUsingEncoding:NSUTF8StringEncoding]]];
        [paramStr appendFormat:@"&%@=%@",@"description",[GTMBase64 stringByEncodingData:[qzyxStr dataUsingEncoding:NSUTF8StringEncoding]]];
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        [paramStr appendFormat:@"&%@=%@",@"qDate",[GTMBase64 stringByEncodingData:[[dateFormatter stringFromDate:[NSDate date]] dataUsingEncoding:NSUTF8StringEncoding]]];
        [paramStr appendFormat:@"&%@=%@",@"cType",[GTMBase64 stringByEncodingData:[@"5" dataUsingEncoding:NSUTF8StringEncoding]]];

        //获取已经定义好的全局的并发的队列
        dispatch_queue_t queue=
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

        //异步执行任务
        dispatch_async(queue, ^{
            //创建能够被快访问和设置的变量
            __block NSString *resultStr;
            dispatch_group_t group=dispatch_group_create();
            dispatch_group_async(group, queue, ^{
                
                resultStr=[self getHttpJson:[NSString stringWithString:paramStr]];
                
            });
            
            dispatch_group_notify(group, queue, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
  
                    [_waiting stopAnimating];
                    _waiting.hidden=YES;
                    if([resultStr isEqual:nil]){
                        alertLabel.text=@"登记失败！";
                        alertLabel.hidden=NO;
                    }else{
                        alertLabel.text=@"登记成功！";
                        alertLabel.hidden=NO;
                    }
                    
                });
            });
            
        });
        
    }else{
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"错误提示！" message:alertMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}

-(NSString *)getHttpJson:(NSString *)paramsStr{
    NSString *urlStr = @"http://192.168.16.28:7778/JobInterface/AstAction!qzdj";
    NSURL *url=[NSURL URLWithString:urlStr];
    
    //创建请求
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    NSLog(@"请求的数据%@",paramsStr);
    
    NSData *requestData=[paramsStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:requestData];
    
    //连接服务器
    NSData *responseData=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *jsonStr=[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    return jsonStr;
}
- (IBAction)backButtonClick:(id)sender {
    ((PeopleTabBarControllerViewController *)self.parentViewController).selectedIndex=0;
}
@end
