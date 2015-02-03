//
//  mohuListViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-11-14.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mohuListViewController : UIViewController
                                    <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *showNoneMessage;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *waiting;
@property (strong, nonatomic) IBOutlet UITableView *showTableView;
@property (strong, nonatomic) NSMutableArray *dataList;
@property (nonatomic) int page;
@property (copy, nonatomic) NSString *keyWord1;
@property (nonatomic) int count;
@property (nonatomic) BOOL isFinished;
@property (nonatomic) BOOL isFirst;
- (IBAction)dismissSelf:(id)sender;
@end
