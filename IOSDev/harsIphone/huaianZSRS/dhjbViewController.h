//
//  dhjbViewController.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-12-18.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dhjbViewController : UIViewController
                                        <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSArray *jianchaArray;
- (IBAction)dismissSelf:(id)sender;
@end
