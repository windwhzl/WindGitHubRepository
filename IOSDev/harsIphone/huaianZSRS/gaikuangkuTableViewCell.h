//
//  gaikuangkuTableViewCell.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-21.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gaikuangkuTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *danweiLabel;
@property (strong, nonatomic) IBOutlet UILabel *dizhiLabel;
@property (copy, nonatomic) NSString* danwei;
@property (copy, nonatomic) NSString* dizhi;

@end
