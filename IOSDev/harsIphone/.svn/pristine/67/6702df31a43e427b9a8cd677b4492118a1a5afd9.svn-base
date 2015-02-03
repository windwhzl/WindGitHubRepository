//
//  nbcxViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-11-22.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "nbcxViewController.h"
#import "nbcxDetailViewController.h"
#import "SfzHelper.h"
@interface nbcxViewController ()

@end

@implementation nbcxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    if([userDefaults boolForKey:@"nbcxISMemberSfzhAndName"]){//如果之前已经记住了身份证号和姓名
        self.memberIndicatorImageView.image=[UIImage imageNamed:@"checked.png"];
        self.sfzhTextField.text=[userDefaults stringForKey:@"nbcxUserSfzh"];
    }else{
        self.memberIndicatorImageView.image=[UIImage imageNamed:@"check.png"];
    }
}
-(void)memberNameAndSfzh{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    if([userDefaults boolForKey:@"nbcxISMemberSfzhAndName"]){//如果之前已经记住了身份证号和姓名
        self.memberIndicatorImageView.image=[UIImage imageNamed:@"check.png"];
        [userDefaults setBool:false forKey:@"nbcxISMemberSfzhAndName"];
        [userDefaults setObject:@"" forKey:@"nbcxUserSfzh"];
    }else{//如果之前没有记住身份证号和姓名
        self.memberIndicatorImageView.image=[UIImage imageNamed:@"checked.png"];
        [userDefaults setBool:true forKey:@"nbcxISMemberSfzhAndName"];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/*
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if([textField isEqual:self.sfzhTextField]){
        return [self.sfzhTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length<18?YES:NO;
    }
    return YES;
}
 */
- (IBAction)chaxunClick:(id)sender {
    if ([SfzHelper IdCardValidate:[self.sfzhTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]) {
        
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        if([userDefaults boolForKey:@"nbcxISMemberSfzhAndName"]){
            [userDefaults setObject:[self.sfzhTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"nbcxUserSfzh"];
        }
        [userDefaults synchronize];
        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
        nbcxDetailViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"nbcxDetailView"];
        [listView setSfzh:_sfzhTextField.text];
        listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:listView animated:YES completion:nil];
    } else {
        _tishiLabel.hidden = NO;
    }

}
- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
