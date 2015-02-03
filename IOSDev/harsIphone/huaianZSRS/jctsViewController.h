//
//  jctsViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-12-17.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface jctsViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *jctsWebView;
- (IBAction)dismissSelf:(id)sender;
@end
