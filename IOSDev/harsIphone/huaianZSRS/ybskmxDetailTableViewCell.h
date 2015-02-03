//
//  ybskmxDetailTableViewCell.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-11-4.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ybskmxDetailTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *hosNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *xiaofeiLabel;
@property (strong, nonatomic) IBOutlet UILabel *yueLabel;
@property (strong, nonatomic) NSString *hosNameString;
@property (strong, nonatomic) NSString *dateString;
@property (strong, nonatomic) NSString *xiaofeiString;
@property (strong, nonatomic) NSString *yueString;
@end
