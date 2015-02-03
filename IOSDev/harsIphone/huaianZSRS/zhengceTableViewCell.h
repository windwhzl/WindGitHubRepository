//
//  zhengceTableViewCell.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-15.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zhengceTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *danweiLabel;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *danwei;
@end
