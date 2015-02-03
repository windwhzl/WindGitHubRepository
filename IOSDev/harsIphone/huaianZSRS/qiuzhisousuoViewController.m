//
//  qiuzhisousuoViewController.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-12-22.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "qiuzhisousuoViewController.h"
#import "qiyezhaopinViewController.h"
@interface qiuzhisousuoViewController ()

@end

@implementation qiuzhisousuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _workTypeString =@"";
}
-(void) viewDidAppear:(BOOL)animated
{
    NSString *workTypePlistPath = [[NSBundle mainBundle] pathForResource:@"workType" ofType:@"plist"];
    NSString *yuegongziPlistPath = [[NSBundle mainBundle] pathForResource:@"yuegongzi" ofType:@"plist"];
    _workTypeArray = [NSArray arrayWithContentsOfFile:workTypePlistPath];
    [_hangyePicker reloadAllComponents];
    _yuegongziArray = [NSArray arrayWithContentsOfFile:yuegongziPlistPath];
    [_yuegongziPicker reloadAllComponents];
    _diquArray = @[@"淮安市",@"清河区",@"清浦区",@"淮阴区",@"淮安区",@"开发区",@"涟水县",@"金湖县",@"洪泽县",@"盱眙县"];
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
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag ==0) {
        return [_diquArray count];
    }if (pickerView.tag == 1) {
        return [_yuegongziArray count];
    }else {
        return [_workTypeArray count];
    }
}
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    if(pickerView.tag == 2){
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumFontSize = 8.;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:UITextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:17]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
        return pickerLabel;
    }else {
        if (!pickerLabel){
            pickerLabel = [[UILabel alloc] init];
            pickerLabel.minimumFontSize = 8.;
            pickerLabel.adjustsFontSizeToFitWidth = YES;
            [pickerLabel setTextAlignment:UITextAlignmentCenter];
            [pickerLabel setBackgroundColor:[UIColor clearColor]];
            [pickerLabel setFont:[UIFont systemFontOfSize:20]];
        }
        pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
        return pickerLabel;
    }

}
-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSDictionary *rowData;
    if (pickerView.tag ==0 ) {
        _diquLabel.text = [_diquArray[row] copy];
        _diquString = [NSString stringWithFormat:@"bcb202=%@",_diquArray[row]];
    }else if(pickerView.tag == 1) {
        rowData = _yuegongziArray[row];
        _yuexinLabel.text = [rowData[@"typeString"] copy];
        _yuegongziString = [rowData[@"typeValue"] copy];
    }else {
        rowData = _workTypeArray[row];
        _hangyeLabel.text = [rowData[@"typeString"] copy];
        _workTypeString  = [rowData[@"typeValue"] copy];
    }
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary *rowData ;
    if (pickerView.tag == 0) {
        return _diquArray[row];
    }else if(pickerView.tag == 1) {
        rowData = _yuegongziArray[row];
        
        return rowData[@"typeString"];
    }else {
        rowData = _workTypeArray[row];
        return rowData[@"typeString"];
    }
}
- (IBAction)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)diquButtonClick:(id)sender {
    
    CATransition *animShow=[CATransition animation];
    animShow.type=kCATransitionMoveIn ;
    animShow.duration=0.5;
    animShow.subtype = kCATransitionFromTop;
    [_diquPicker.layer addAnimation:animShow forKey:nil];
    
    _diquLabel.text = @"淮安市";
    _diquString = @"bcb202=淮安市";
    _diquPicker.hidden = NO;
    _yuegongziPicker.hidden = YES;
    _hangyePicker.hidden = YES;
     _tishiLabel.hidden = YES;
    
}

- (IBAction)yuegongziButtonClick:(id)sender {
    
    CATransition *animShow=[CATransition animation];
    animShow.type=kCATransitionMoveIn ;
    animShow.duration=0.5;
    animShow.subtype = kCATransitionFromTop;
    [_yuegongziPicker.layer addAnimation:animShow forKey:nil];
    
    _yuexinLabel.text = @"0-999元";
    _yuegongziString = @"acb214=1";
    _diquPicker.hidden = YES;
    _yuegongziPicker.hidden = NO;
    _hangyePicker.hidden = YES;
     _tishiLabel.hidden = YES;
    
}

- (IBAction)hangyeButtonClick:(id)sender {
    
    CATransition *animShow=[CATransition animation];
    animShow.type=kCATransitionMoveIn ;
    animShow.duration=0.5;
    animShow.subtype = kCATransitionFromTop;
    [_hangyePicker.layer addAnimation:animShow forKey:nil];
    
    _hangyeLabel.text = @"不限";
    _diquPicker.hidden = YES;
    _yuegongziPicker.hidden = YES;
    _hangyePicker.hidden = NO;
     _tishiLabel.hidden = YES;
    
}
- (IBAction)searchButtonClick:(id)sender {
    if ([_diquLabel.text isEqualToString:@"点击选择地区"]) {
        _tishiLabel.hidden = NO;
    }else {
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    qiyezhaopinViewController *listView = [mainStory instantiateViewControllerWithIdentifier:@"qiyezhaopinView"];
    listView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    listView.diquString = [_diquString copy];
    listView.yuegongziString = [_yuegongziString copy];
    listView.workTypeString = [_workTypeString copy];
    NSString *zhiwei = [NSString stringWithFormat:@"acb21a=%@",[_keyWordLabel.text copy]];
    listView.zhiweiSting = [zhiwei copy];
    [self presentViewController:listView animated:YES completion:nil];
        
    }
}
- (IBAction)quitEditing:(id)sender {
    [_keyWordLabel resignFirstResponder];
}
@end
