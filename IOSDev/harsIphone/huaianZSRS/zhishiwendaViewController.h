//
//  zhishiwendaViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-24.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zhishiwendaViewController : UIViewController
                                        <UIPickerViewDelegate,UIPickerViewDataSource>
- (IBAction)dismissSelf:(id)sender;
- (IBAction)chaxunClick:(id)sender;

- (IBAction)keyWord1Click:(id)sender;
- (IBAction)keyWord2Click:(id)sender;
- (IBAction)keyWord3Click:(id)sender;
- (IBAction)diquClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIPickerView *keyWord1Picker;
@property (strong, nonatomic) IBOutlet UIPickerView *keyWord2Picker;
@property (strong, nonatomic) IBOutlet UIPickerView *keyWord3Picker;
@property (strong, nonatomic) IBOutlet UIPickerView *diquPicker;

@property (strong, nonatomic) IBOutlet UILabel *keyWord1Label;
@property (strong, nonatomic) IBOutlet UILabel *keyWord2Label;
@property (strong, nonatomic) IBOutlet UILabel *keyWord3Label;
@property (strong, nonatomic) IBOutlet UILabel *diquLabel;
@property (strong, nonatomic) IBOutlet UILabel *attentionLabel;

@property (copy, nonatomic) NSString *keyWord1;
@property (copy, nonatomic) NSString *keyWord2;
@property (copy, nonatomic) NSString *keyWord3;
@property (copy, nonatomic) NSString *diqu;

@property (strong, nonatomic) NSMutableArray *keyWord1Array;
@property (strong, nonatomic) NSArray *keyWord2Array;
@property (strong, nonatomic) NSArray *keyWord3Array;
@property (strong, nonatomic) NSArray *diquArray;
@property (strong, nonatomic) NSArray *array;
@property (strong, nonatomic) NSMutableArray *picker2Array;
@property (strong, nonatomic) NSMutableArray *picker3Array;
@end
