//
//  WuxianListViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-27.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WuxianListViewController : UIViewController
                                        <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *showNoneMessage;
@property (strong, nonatomic) NSMutableArray *dataList;
@property (nonatomic) int page;
@property (strong, nonatomic) NSString *flag;//标记
-(NSArray *)getHttpJson:(int)currentPage;
@property (nonatomic) NSUInteger count;
@property (nonatomic) BOOL isFinished;
- (IBAction)dismissSelf:(id)sender;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *waiting;
@property (strong, nonatomic) IBOutlet UITableView *showTableView;
@property (nonatomic) BOOL isSearch;
@property (nonatomic) BOOL isFirst;
- (IBAction)startSerachButtonClick:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *keywordTextField;
@property (strong, nonatomic) IBOutlet UIView *showView;
- (IBAction)searchButtonClick:(id)sender;
@property (copy, nonatomic) NSString *keyWord;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (copy, nonatomic) NSString *titleString;
- (IBAction)dissMissView:(id)sender;
- (IBAction)dissMissKeyboard:(id)sender;
- (IBAction)moreFunction:(id)sender;
- (IBAction)zhuyeClick:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *searchLabel;
@property (strong, nonatomic) IBOutlet UIButton *missButton;
@property (strong, nonatomic) IBOutlet UILabel *attentionLabel;
@property (strong, nonatomic) IBOutlet UILabel *tishiLabel;
@property (strong, nonatomic) IBOutlet UIImageView *searchImage;
@property (strong, nonatomic) IBOutlet UIButton *freshButton;
- (IBAction)freshButtonClick:(id)sender;

@end
