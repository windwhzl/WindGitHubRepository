//
//  loadWebViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-11.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadWebViewController : UIViewController
@property (copy, nonatomic) NSString *loadString; //加载字符串
@property (strong, nonatomic) IBOutlet UIWebView *loadWebView;
- (IBAction)dismissSelf:(id)sender;
- (IBAction)moreFunction:(id)sender;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *waiting;
@property (strong, nonatomic) NSString *flag;//标记
@property (copy, nonatomic) NSString *postUrl;//请求地址
@property (copy, nonatomic) NSDictionary *jsonString;//解析好的json串
@property (copy, nonatomic) NSString* newsId;
@end
