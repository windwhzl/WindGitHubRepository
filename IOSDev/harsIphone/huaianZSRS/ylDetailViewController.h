//
//  ylDetailViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-11-4.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ylDetailViewController : UIViewController
                                    <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UILabel *showNoneMessage;
@property (strong, nonatomic) IBOutlet UITableView *showTabelView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *waiting;
@property (copy, nonatomic) NSString *grbh;
@property (nonatomic) int page;
@property (strong, nonatomic) NSMutableArray *dataList;
@property (nonatomic) int count;
@property (nonatomic) BOOL isFinished;
-(NSArray *)getHttpJson:(NSString*)grbh
               currentPage:(int)page;
- (IBAction)dismissSelf:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *freshButton;
- (IBAction)freshButtonClick:(id)sender;

@end
