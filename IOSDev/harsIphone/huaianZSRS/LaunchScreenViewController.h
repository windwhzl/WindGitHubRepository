//
//  LaunchScreenViewController.h
//  huaianZSRS
//
//  Created by xiaomage on 14/12/10.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LaunchScreenViewController : UIViewController<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;


- (IBAction)nextPageForButton1Click:(id)sender;
- (IBAction)nextPageForButton2Click:(id)sender;

- (IBAction)skipForButton1Click:(id)sender;
@end
