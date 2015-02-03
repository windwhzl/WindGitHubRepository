//
//  ybskmxDetailTableViewCell.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-11-4.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "ybskmxDetailTableViewCell.h"

@implementation ybskmxDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) setHosNameString:(NSString *)hosNameString
{
    _hosNameString = [hosNameString copy];
    _hosNameLabel.text = [_hosNameString copy];
}
-(void) setDateString:(NSString *)dateString
{
    _dateString = [dateString copy];
    _dateLabel.text = [_dateString copy];
}
-(void) setXiaofeiString:(NSString *)xiaofeiString
{
    _xiaofeiString = [xiaofeiString copy];
    _xiaofeiLabel.text = [_xiaofeiString copy];
}
-(void) setYueString:(NSString *)yueString
{
    _yueString = [yueString copy];
    _yueLabel.text = [_yueString copy];
}
@end
