//
//  dhjbViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-12-18.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "dhjbViewController.h"
#import "dhjbTableViewCell.h"
@interface dhjbViewController ()

@end

@implementation dhjbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"dhjbList" ofType:@"plist"];
    _jianchaArray = [NSArray arrayWithContentsOfFile:plistPath];
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
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *more = @"dhjbCell";
    UINib *moreNib =[UINib nibWithNibName:@"dhjbTableViewCell" bundle:nil];
    [tableView registerNib:moreNib forCellReuseIdentifier:more];
    dhjbTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:more];
    NSDictionary *rowData = _jianchaArray[indexPath.row];
    [cell setName:rowData[@"name"]];
    [cell setAddress:rowData[@"address"]];
    [cell setTel:rowData[@"tel"]];
    return cell;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
