//
//  wyqzListViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-28.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wyqzListViewController : UIViewController
                                    <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *showNoneMessage;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *waiting;
@property (strong, nonatomic) NSMutableArray *dataList;
-(NSArray *)getHttpJson:(int)currentPage;
@property (nonatomic) int page;
@property (nonatomic) int count;
@property (nonatomic) BOOL isFinished;
- (IBAction)dismissSelf:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *showTableView;
@property (strong, nonatomic) IBOutlet UIButton *freshButton;
- (IBAction)freshButtonClick:(id)sender;
- (IBAction)zhuyeClick:(id)sender;//返回主页
- (IBAction)moreFunction:(id)sender;
@end
