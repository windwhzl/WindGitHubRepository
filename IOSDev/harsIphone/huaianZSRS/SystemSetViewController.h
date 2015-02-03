//
//  SystemSetViewController.h
//  huaianZSRS
//
//  Created by xiaomage on 15/1/20.
//  Copyright (c) 2015年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SystemSetViewController : UIViewController <UIAlertViewDelegate>

/** 清空用户的信息*/
- (IBAction)emptyUserInfo:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *userInfoLabel;

/** 调整网页字体大小*/
@property (strong, nonatomic) IBOutlet UIView *webFontSizeView;
@property (strong, nonatomic) IBOutlet UISlider *adjustWebFontSizeSlider;
@property (strong, nonatomic) IBOutlet UILabel *webFontSizeLabel;

/** 关于我们*/
- (IBAction)aboutUs:(id)sender;

/** 返回按钮点击事件*/
- (IBAction)dismissSelf:(id)sender;
@end
