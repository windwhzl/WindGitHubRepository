//
//  mohuTableViewCell.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-11-14.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "mohuTableViewCell.h"

@implementation mohuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) setTitle:(NSString *)title
{
    _title = [title copy];
    _titleLabel.text = [_title copy];
}
@end
