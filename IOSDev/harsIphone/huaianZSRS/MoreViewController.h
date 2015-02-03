//
//  MoreViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-20.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shouyeTableViewCell.h"
#import "zhengceTableViewCell.h"

@interface MoreViewController : UIViewController
                            <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *waiting;
@property (strong, nonatomic) IBOutlet UITableView *showTabeleView;
@property (strong, nonatomic) IBOutlet shouyeTableViewCell *cell;
@property (strong, nonatomic) IBOutlet zhengceTableViewCell *zhengceCell;
@property (strong, nonatomic) NSMutableArray *shouyeData;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic) int newsType;
@property (nonatomic) int page;
@property (copy, nonatomic) NSString *flag;
@property (nonatomic) int count;
@property (nonatomic) BOOL isFinished;
-(NSArray *)getHttpJson:(int)currentPage;
- (IBAction)dismissSelf:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *showNoneMessage;
@property (nonatomic) BOOL isFirst;
@property (strong, nonatomic) IBOutlet UIButton *freshButton;
- (IBAction)freshButtonClick:(id)sender;

@end
