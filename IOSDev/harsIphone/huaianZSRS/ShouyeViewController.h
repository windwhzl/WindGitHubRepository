//
//  ShouyeViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-9.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shouyeTableViewCell.h"
#import "zhengceTableViewCell.h"
@interface ShouyeViewController : UIViewController
                                        <UITableViewDataSource,UITableViewDelegate,
                                        UIScrollViewDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSMutableArray *slideImages;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) IBOutlet UIButton *yaowenButton;
@property (strong, nonatomic) IBOutlet UIButton *xianquButton;
@property (strong, nonatomic) IBOutlet UIButton *tongzhiButton;
@property (strong, nonatomic) IBOutlet UIButton *zhaokaoButton;
@property (strong, nonatomic) IBOutlet UIButton *zhengceButton;
@property (strong, nonatomic) IBOutlet UIImageView *baiseImage;
@property (strong, nonatomic) IBOutlet shouyeTableViewCell *cell;
@property (strong, nonatomic) IBOutlet zhengceTableViewCell *zhengceCell;
@property (strong, nonatomic) NSArray *shouyeData;
@property (strong, nonatomic) IBOutlet UITableView *shouyeTableView;
@property (strong, nonatomic) NSString *flag;
@property (strong, nonatomic) NSString *newsType;
@property (strong, nonatomic) IBOutlet UILabel *flagLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *waiting;
@property (strong, nonatomic) IBOutlet UILabel *showNoneMessage;
@property (strong, nonatomic) IBOutlet UIButton *freshButton;
@property (strong, nonatomic) dispatch_queue_t queue;
- (IBAction)clickForFresh:(id)sender;
@property (nonatomic) BOOL isLoaded;
- (IBAction)yaowenClick:(id)sender;
- (IBAction)xianquClick:(id)sender;
- (IBAction)tongzhiClick:(id)sender;
- (IBAction)zhengceClick:(id)sender;
- (IBAction)zhaokaoClick:(id)sender;
- (void) changeBaiseLocal:(UIButton*) sender;
- (NSArray *) getJSonData:(NSString*)httpUrl;
- (IBAction)qianjinClick:(id)sender;
- (IBAction)moreFunction:(id)sender;

- (IBAction)gengduoButtonClick:(id)sender;
- (IBAction)dismissSelf:(id)sender;
@property(nonatomic) BOOL isFirst;
@end
