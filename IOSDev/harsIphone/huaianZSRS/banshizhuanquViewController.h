//
//  banshizhuanquViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-29.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface banshizhuanquViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSMutableArray *slideImages;

- (IBAction)dismissSelf:(id)sender;
@property (nonatomic) int qianjinFlag;
- (IBAction)qianjinClick:(id)sender;
- (IBAction)wuxianClick:(id)sender;
- (IBAction)laodongClick:(id)sender;
- (IBAction)chuangyeClick:(id)sender;
- (IBAction)zhuyeClick:(id)sender;


- (IBAction)qiuzhiClick:(id)sender;
- (IBAction)peixunClick:(id)sender;
- (IBAction)wendaClick:(id)sender;
- (IBAction)jigouClick:(id)sender;
- (IBAction)kaoshiClick:(id)sender;
- (IBAction)danganClick:(id)sender;
- (IBAction)rensheyunClick:(id)sender;
- (IBAction)moreFunction:(id)sender;

@end
