//
//  woyaoqiuzhiViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-29.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface woyaoqiuzhiViewController : UIViewController
- (IBAction)qyzpButtonClick:(id)sender;
- (IBAction)qzdjButtonClick:(id)sender;
- (IBAction)zphButtonClick:(id)sender;
- (IBAction)dismissSelf:(id)sender;
@property (nonatomic) int qianjinFlag;
- (IBAction)qianjinClick:(id)sender;
- (IBAction)zhuyeClick:(id)sender;
- (IBAction)moreFunction:(id)sender;
@end
