//
//  ylcxDetailTableViewCell.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-11-4.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ylcxDetailTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *bxzlLabel;
@property (strong, nonatomic) IBOutlet UILabel *yfLabel;
@property (strong, nonatomic) IBOutlet UILabel *jfrLabel;
@property (strong, nonatomic) IBOutlet UILabel *jfjsLabel;
@property (strong, nonatomic) IBOutlet UILabel *jfjeLabel;
@property (copy, nonatomic) NSString *bxzl;
@property (copy, nonatomic) NSString *yf;
@property (copy, nonatomic) NSString *jfr;
@property (copy, nonatomic) NSString *jfjs;
@property (copy, nonatomic) NSString *jfje;
@end
