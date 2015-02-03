//
//  yibaodingdianjigouTableViewCell.h
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-27.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface yibaodingdianjigouTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *telLable;
@property (strong, nonatomic) IBOutlet UILabel *postLabel;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *tel;
@property (copy, nonatomic) NSString *post;
-(CGFloat) setNameHeight:(NSString*)nameText
        setAddressHeight:(NSString*)addressText;
@property (strong, nonatomic) IBOutlet UILabel *YbLabel;
@property (strong, nonatomic) IBOutlet UILabel *LxdhLabel;
@property (strong, nonatomic) IBOutlet UILabel *DwdzLabel;
@property (strong, nonatomic) IBOutlet UILabel *DwmcLabel;
@end
