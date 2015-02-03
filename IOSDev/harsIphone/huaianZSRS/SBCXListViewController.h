//
//  SBCXListViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-11-4.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBCXListViewController : UIViewController
                                    <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *showNoneMessage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) NSMutableArray *dataList;
@property (strong, nonatomic) NSString *flag;//标记
- (IBAction)dismissSelf:(id)sender;
-(NSArray *)getHttpJson:(NSString*)keyword1
               keyWord2:(NSString*)keyword2;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *waiting;
@property (strong, nonatomic) IBOutlet UITableView *showTableView;
@property (copy, nonatomic) NSString *keyWord1;
@property (copy, nonatomic) NSString *keyWord2;
@property (nonatomic) int count;
@property (strong, nonatomic) IBOutlet UIButton *freshButton;
- (IBAction)freshButtonClick:(id)sender;

@end
