//
//  nbcxViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-11-22.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface nbcxViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *sfzhTextField;
- (IBAction)chaxunClick:(id)sender;
- (IBAction)dismissSelf:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *tishiLabel;

@property (strong, nonatomic) IBOutlet UIView *memberView;
@property (strong, nonatomic) IBOutlet UIImageView *memberIndicatorImageView;
@end
