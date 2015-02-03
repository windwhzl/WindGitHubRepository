//
//  gaikuangkuViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-21.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gaikuangkuViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *showNoneMessage;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *waiting;
@property (strong, nonatomic) IBOutlet UITableView *showTableView;
@property (strong, nonatomic) NSMutableArray *dataList;
@property (nonatomic) int page;
@property (nonatomic) int count;
@property (nonatomic) BOOL isFinished;
@property (strong, nonatomic) IBOutlet UIButton *freshButton;
- (IBAction)freshButtonClick:(id)sender;

@property (nonatomic,retain) UIView *searchView;
@property (nonatomic,retain) UIView *textFields;
@property (nonatomic,retain) UITextField *keywordTF1;

//记录键盘y坐标的位置
@property (nonatomic,assign) int keyboardOriginY;
//记录searchView初始时在屏幕上原点的纵坐标
@property (nonatomic,assign) int textFieldsOriginY;

- (IBAction)startSearchButtonClick:(id)sender;
- (IBAction)dismissSelf:(id)sender;
- (IBAction)moreFunction:(id)sender;
- (IBAction)zhuyeClick:(id)sender;
@property (copy, nonatomic) NSString *depcode;
@end
