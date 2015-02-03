//
//  SBCXViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-20.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "SBCXViewController.h"
#import "SBCXListViewController.h"
#import "SfzHelper.h"
#import "SystemSetViewController.h"
#import "banshizhuanquViewController.h"
@interface SBCXViewController ()

@end

@implementation SBCXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([[self getFlag] isEqualToString:@"ylcx"]) {
        _titleLabel.text = @"个人应缴实缴明细查询";
    }
    if ([[self getFlag] isEqualToString:@"ybcx"]) {
        _titleLabel.text = @"医保年度账户查询";
    }
    if ([[self getFlag] isEqualToString:@"ybmx"]) {
        _titleLabel.text = @"个人医保卡刷卡明细";
    }
    

    
}
-(void) viewWillAppear:(BOOL)animated
{
    UITapGestureRecognizer *tapGestureRecognizer=[[UITapGestureRecognizer alloc]
                                                  initWithTarget:self
                                                  action:@selector(memberNameAndSfzh)
                                                  ];
    tapGestureRecognizer.numberOfTapsRequired=1;
    [self.memberView addGestureRecognizer:tapGestureRecognizer];
    
    self.sfzhTextField.delegate=self;
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    if([userDefaults boolForKey:@"isMemberSfzhAndName"]){//如果之前已经记住了身份证号和姓名
        self.memberIndicatorImageView.image=[UIImage imageNamed:@"checked.png"];
        self.nameTextField.text=[userDefaults stringForKey:@"userName"];
        self.sfzhTextField.text=[userDefaults stringForKey:@"userSfzh"];
    }else{
        self.memberIndicatorImageView.image=[UIImage imageNamed:@"check.png"];
    }
}
-(void)memberNameAndSfzh{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    if([userDefaults boolForKey:@"isMemberSfzhAndName"]){//如果之前已经记住了身份证号和姓名
        self.memberIndicatorImageView.image=[UIImage imageNamed:@"check.png"];
        [userDefaults setBool:false forKey:@"isMemberSfzhAndName"];
        [userDefaults setObject:@"" forKey:@"userName"];
        [userDefaults setObject:@"" forKey:@"userSfzh"];
    }else{//如果之前没有记住身份证号和姓名
        self.memberIndicatorImageView.image=[UIImage imageNamed:@"checked.png"];
        [userDefaults setBool:true forKey:@"isMemberSfzhAndName"];
    }
    [userDefaults synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidDisappear:(BOOL)animated
{
    _tishiLabel.hidden = YES;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if([textField isEqual:self.sfzhTextField]){
//        if (string.length==0){//判断是不是删除键
//            return YES;
//        }
//        if((self.sfzhTextField.text.length-range.length+string.length)>18){
//            return NO;
//        }
//    }
//    return YES;
//}

/*
-(BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
        if (textField.text.length>18) {
            return YES;
        }
    return NO;
}*/
- (IBAction)changeNameColor:(id)sender {
    [self.nameTextField setTextColor:[UIColor blackColor]];
}

- (IBAction)changeSFZHColor:(id)sender {
    [self.sfzhTextField setTextColor:[UIColor blackColor]];
}
- (IBAction)searchButtonClick:(id)sender {


    if ([SfzHelper IdCardValidate:[self.sfzhTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]] && ([self.nameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length>0)) {
        
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        if([userDefaults boolForKey:@"isMemberSfzhAndName"]){
            [userDefaults setObject:[self.nameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"userName"];
            [userDefaults setObject:[self.sfzhTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"userSfzh"];
        }
        [userDefaults synchronize];
        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
        SBCXListViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"SBCXListView"];
        [listView setFlag:[self getFlag]];
        [listView setKeyWord1:self.nameTextField.text];
        [listView setKeyWord2:self.sfzhTextField.text];
        listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:listView animated:YES completion:nil];
        
    } else {
        
        _tishiLabel.hidden = NO;
        
    }

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
- (IBAction)quitEdit:(id)sender {
    [_nameTextField resignFirstResponder];
    [_sfzhTextField resignFirstResponder];
}
-(void) setFlag:(NSString *)flag
{
    _flag = [flag copy];
}
-(NSString *) getFlag
{
    return _flag;
}


@end
