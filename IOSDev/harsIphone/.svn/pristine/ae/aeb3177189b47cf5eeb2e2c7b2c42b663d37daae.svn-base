//
//  shouyeTableViewCell.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-10.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "shouyeTableViewCell.h"

@implementation shouyeTableViewCell
@synthesize title;
@synthesize date;
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) setTitle:(NSString *)t
{
    if (![t isEqualToString:title]) {
        title = [t copy];
        [self.titleLabel setText:[title copy]];
    }
}
- (void) setDate:(NSString *)d
{
    if (![d isEqualToString:date]) {
        date = [d copy];
        self.dateLabel.text = [date copy];
    }
}
-(CGFloat) height
{
    return self.titleLabel.frame.size.height+20;
}

@end
