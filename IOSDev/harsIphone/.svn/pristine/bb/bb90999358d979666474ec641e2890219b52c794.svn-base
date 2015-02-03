//
//  mohuSearchViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-24.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "mohuSearchViewController.h"
#import "mohuListViewController.h"
@interface mohuSearchViewController ()

@end

@implementation mohuSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void) viewDidAppear:(BOOL)animated
{
    
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
- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)searchClick:(id)sender {
        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
        mohuListViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"mohuListView"];
        [listView setKeyWord1:_keyWordTextField.text];
        listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:listView animated:YES completion:nil];

}
-(void) setKeyWord:(NSString *)keyWord
{
    _keyWord = keyWord;
}
-(NSString*) getKeyWord
{
    return _keyWord;
}
@end
