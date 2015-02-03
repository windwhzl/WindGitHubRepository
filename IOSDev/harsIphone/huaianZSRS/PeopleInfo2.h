//
//  PeopleInfo2.h
//  qiuzhidengji
//
//  Created by xiaomage on 14/11/21.
//  Copyright (c) 2014年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeopleTabBarControllerViewController.h"

@interface PeopleInfo2 : UIViewController<UITextFieldDelegate,UITextViewDelegate>{
    @private
    CGPoint touchBegan_;
}

@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *addressTextField;
@property (strong, nonatomic) IBOutlet UITextField *sfzhTextField;
@property (strong, nonatomic) IBOutlet UITextView *qzyxTextView;

@property (strong, nonatomic) IBOutlet UIView *sfzhArea;
@property (nonatomic) int sfzhAreaY;
@property (strong, nonatomic) IBOutlet UIView *qzyxArea;
@property (nonatomic) int qzyxAreaY;


- (IBAction)backButtonClick:(id)sender;


@property (nonatomic,retain) PeopleTabBarControllerViewController *parent;

- (IBAction)hideKeyboard:(id)sender;

- (IBAction)cancel:(id)sender;
- (IBAction)previousPage:(id)sender;
- (IBAction)submit:(id)sender;

-(NSString *)getHttpJson:(NSString *)paramsStr;

@end
