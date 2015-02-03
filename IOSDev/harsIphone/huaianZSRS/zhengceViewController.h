//
//  zhengceViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-23.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zhengceViewController : UIViewController
                                    <UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UILabel *areaLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIPickerView *typePicker;
@property (strong, nonatomic) IBOutlet UIPickerView *areaPicker;
@property (strong, nonatomic) NSArray *areaArray;
@property (strong, nonatomic) NSArray *typeArray;
@property (copy, nonatomic) NSString *keyWord1;
@property (copy, nonatomic) NSString *keyWord2;
@property (copy, nonatomic) NSString *keyWord3;
@property (copy, nonatomic) NSString *keyWord4;
@property (strong, nonatomic) IBOutlet UITextField *keyWord4Field;
- (IBAction)areaButtonClick:(id)sender;
- (IBAction)typeButtonClick:(id)sender;
- (IBAction)chaxunButtonClick:(id)sender;
- (IBAction)dismissSelf:(id)sender;
- (IBAction)dateButtonClick:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *tishiLabel;
- (IBAction)dissMissAll:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *dateView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)dateSelectedClick:(id)sender;
- (IBAction)dateCancleClick:(id)sender;
@property (strong, nonatomic) NSDate *date;

@end
