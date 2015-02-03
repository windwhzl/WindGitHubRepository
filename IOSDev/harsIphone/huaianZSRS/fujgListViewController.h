//
//  fujgListViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-29.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface fujgListViewController : UIViewController
                                    <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *showNoneMessage;
@property (strong, nonatomic) IBOutlet UITableView *showTableView;
@property (strong, nonatomic) NSMutableArray *dataList;
@property (nonatomic) int page;
@property (strong,nonatomic) NSString *keyword1;
@property (strong,nonatomic) NSString *keyword2;
@property (strong,nonatomic) NSString *keyword3;
@property (nonatomic) int count;
@property (nonatomic) BOOL isFinished;
-(NSArray *)getHttpJson:(int)currentPage
               KeyWord1:(NSString*)keyWord1
               KeyWord2:(NSString*)keyWord2;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *waiting;
- (IBAction)dismissSelf:(id)sender;
- (IBAction)moreFunction:(id)sender;
- (IBAction)zhuyeClick:(id)sender;
@property (nonatomic) BOOL isFirst;
@property (strong, nonatomic) IBOutlet UIButton *freshButton;
- (IBAction)freshButtonClick:(id)sender;

@end
