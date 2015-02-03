//
//  qiuzhisousuoViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-12-22.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface qiuzhisousuoViewController : UIViewController
                                            <UIPickerViewDataSource,UIPickerViewDelegate>
- (IBAction)diquButtonClick:(id)sender;
- (IBAction)yuegongziButtonClick:(id)sender;
- (IBAction)hangyeButtonClick:(id)sender;

- (IBAction)dismissSelf:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *diquLabel;
@property (strong, nonatomic) IBOutlet UILabel *yuexinLabel;
@property (strong, nonatomic) IBOutlet UILabel *hangyeLabel;
@property (strong, nonatomic) IBOutlet UITextField *keyWordLabel;

- (IBAction)searchButtonClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIPickerView *diquPicker;
@property (strong, nonatomic) IBOutlet UIPickerView *yuegongziPicker;
@property (strong, nonatomic) IBOutlet UIPickerView *hangyePicker;

@property (strong, nonatomic) NSArray *diquArray;
@property (strong, nonatomic) NSArray *yuegongziArray;
@property (strong, nonatomic) NSArray *workTypeArray;

@property (strong, nonatomic) IBOutlet UILabel *tishiLabel;
- (IBAction)quitEditing:(id)sender;
@property (copy, nonatomic) NSString *diquString;
@property (copy, nonatomic) NSString *yuegongziString;
@property (copy, nonatomic) NSString *zhiweiSting;
@property (copy, nonatomic) NSString *workTypeString;
@end
