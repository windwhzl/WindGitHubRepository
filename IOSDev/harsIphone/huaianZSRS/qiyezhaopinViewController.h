//
//  qiyezhaopinViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-22.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface qiyezhaopinViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UILabel *showNoneMessage;
@property (strong, nonatomic) NSMutableArray *dataList;
@property (nonatomic) int page;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *waiting;
- (IBAction)dismissSelf:(id)sender;
- (IBAction)zhuyeClick:(id)sender;//返回主页
- (IBAction)moreFunction:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *showTableView;
@property (nonatomic) int count;
@property (nonatomic) BOOL isFinished;
@property (strong, nonatomic) IBOutlet UIButton *freshButton;
- (IBAction)freshButtonClick:(id)sender;

@property (copy, nonatomic) NSString *diquString;
@property (copy, nonatomic) NSString *yuegongziString;
@property (copy, nonatomic) NSString *zhiweiSting;
@property (copy, nonatomic) NSString *workTypeString;
@end
