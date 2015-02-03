//
//  nbcxDetailViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-11-21.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface nbcxDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *xingmingLabel;
@property (copy, nonatomic) NSString *xingming;

@property (strong, nonatomic) IBOutlet UILabel *xingbieLabel;
@property (copy, nonatomic) NSString *xingbie;

@property (strong, nonatomic) IBOutlet UILabel *sfzhLabel;
@property (copy, nonatomic) NSString *sfzh;

@property (strong, nonatomic) IBOutlet UILabel *zhuzhiLabel;
@property (copy, nonatomic) NSString *zhuzhi;

@property (strong, nonatomic) IBOutlet UILabel *qsyfLabel;
@property (copy, nonatomic) NSString *qsyf;

@property (strong, nonatomic) IBOutlet UILabel *ljnxLabel;
@property (copy, nonatomic) NSString *ljnx;

@property (strong, nonatomic) IBOutlet UILabel *ffztLabel;
@property (copy, nonatomic) NSString *ffzt;

@property (strong, nonatomic) IBOutlet UILabel *jfdcLabel;
@property (copy, nonatomic) NSString *jfdc;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *waiting;
- (IBAction)zhxxButtonClick:(id)sender;
- (IBAction)dismissSelf:(id)sender;
@end
