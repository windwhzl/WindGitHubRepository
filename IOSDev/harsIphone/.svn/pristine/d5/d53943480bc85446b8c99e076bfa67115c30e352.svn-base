//
//  niwenwodaListViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-24.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface niwenwodaListViewController : UIViewController
                                        <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *showNoneMessage;
@property (strong, nonatomic) IBOutlet UITableView *showTableView;
@property (strong, nonatomic) NSMutableArray *dataList;
@property (nonatomic) int page;
@property (strong, nonatomic) NSString *flag;
@property (copy, nonatomic) NSString *keyWord1;
@property (copy, nonatomic) NSString *keyWord2;
@property (copy, nonatomic) NSString *keyWord3;
@property (copy, nonatomic) NSString *keyWord4;
@property (nonatomic) int count;
@property (nonatomic) BOOL isFinished;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *waiting;
@property (nonatomic) BOOL isFirst;
- (IBAction)dismissSelf:(id)sender;
@end
