//
//  searchTableViewCell.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-11-24.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "searchTableViewCell.h"

@implementation searchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) setSearchCondition:(NSString *)searchCondition
{
    _searchCondition = [searchCondition copy];
    _conditionLabel.text = [_searchCondition copy];
}
@end
