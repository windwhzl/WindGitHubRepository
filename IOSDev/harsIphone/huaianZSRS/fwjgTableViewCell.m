//
//  fwjgTableViewCell.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-29.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "fwjgTableViewCell.h"

@implementation fwjgTableViewCell

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
-(void)setAddress:(NSString *)address
{
    _address = [address copy];
    _addressLabel.text = [_address copy];
}
-(void) setTelphone:(NSString *)telphone
{
    _telphone = [telphone copy];
    _telphoneLabel.text = [_telphone copy];
}
@end
