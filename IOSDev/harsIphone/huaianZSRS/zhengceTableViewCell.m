//
//  zhengceTableViewCell.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-15.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "zhengceTableViewCell.h"

@implementation zhengceTableViewCell
@synthesize danwei;
@synthesize title;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) setTitle:(NSString *)t{
    if (![t isEqualToString:title]) {
        title = [t copy];
        self.titleLabel.text = [title copy];
    }
}
- (void) setDanwei:(NSString *)d{
    if (![d isEqualToString:danwei]) {
        danwei = [d copy];
        self.danweiLabel.text = [danwei copy];
    }
}
@end
