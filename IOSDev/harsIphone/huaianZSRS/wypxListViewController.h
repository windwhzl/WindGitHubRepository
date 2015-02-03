//
//  wypxListViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-28.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wypxListViewController : UIViewController
                                        <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *showTabelView;
@property (strong, nonatomic) NSMutableArray *dataList;
@property (nonatomic) int page;
@property (strong, nonatomic) NSString *flag;
@property (nonatomic) int count;
@property (nonatomic) BOOL isFinished;
- (IBAction)dismissSelf:(id)sender;
@end
