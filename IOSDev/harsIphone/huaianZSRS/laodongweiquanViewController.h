//
//  laodongweiquanViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-29.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface laodongweiquanViewController : UIViewController
- (IBAction)dismissSelf:(id)sender;
- (IBAction)zcggButtonClick:(id)sender;
- (IBAction)jctsButtonClick:(id)sender;
- (IBAction)jbjhButtonClick:(id)sender;
- (IBAction)dhjbButtonClick:(id)sender;

@property (nonatomic) int qianjinFlag;
- (IBAction)qianjinClick:(id)sender;
- (IBAction)zhuyeClick:(id)sender;
- (IBAction)moreFunction:(id)sender;
@end
