//
//  zhaokaoxinxiViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-11-3.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zhaokaoxinxiViewController : UIViewController
- (IBAction)ksxxButtonClick:(id)sender;
- (IBAction)gkxxButtonClick:(id)sender;
- (IBAction)dismissSelf:(id)sender;
- (IBAction)zhuyeClick:(id)sender;
@property (nonatomic) int qianjinFlag;
- (IBAction)qianjinClick:(id)sender;
@end
