//
//  SBCXViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-20.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBCXViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)changeNameColor:(id)sender;
- (IBAction)changeSFZHColor:(id)sender;
@property (copy, nonatomic) NSString *flag;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *sfzhTextField;
- (IBAction)searchButtonClick:(id)sender;
- (IBAction)dismissSelf:(id)sender;
- (IBAction)quitEdit:(id)sender;
- (IBAction)moreFunction:(id)sender;
- (IBAction)zhuyeClick:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *tishiLabel;

@property (strong, nonatomic) IBOutlet UIView *memberView;
@property (strong, nonatomic) IBOutlet UIImageView *memberIndicatorImageView;

@end
