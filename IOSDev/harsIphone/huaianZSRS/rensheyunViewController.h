//
//  rensheyunViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-21.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rensheyunViewController : UIViewController

- (IBAction)gwxtButtonClick:(id)sender;
- (IBAction)gkkButtonClick:(id)sender;
- (IBAction)txlButtonClick:(id)sender;
- (IBAction)sjbbButtonClick:(id)sender;

- (IBAction)dismissSelf:(id)sender;
@property (nonatomic) int qianjinFlag;
- (IBAction)qianjinClick:(id)sender;
- (IBAction)zhuyeClick:(id)sender;
- (IBAction)moreFunction:(id)sender;
@property (copy, nonatomic) NSString *depcode;
@end
