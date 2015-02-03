//
//  zhaopinhuiTableViewCell.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-28.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "zhaopinhuiTableViewCell.h"

@implementation zhaopinhuiTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) setNewstitle:(NSString *)newstitle
{
    _newstitle = [newstitle copy];
    _newstitleLabel.text = [_newstitle copy];
}
-(void) setEdittime:(NSString *)edittime
{
    _edittime = [edittime copy];
    _edittimeLabel.text = [_edittime copy];
}
-(CGFloat) setTitleHeight:(NSString *)title
{
    CGRect frame = [self frame];
    
    UIFont *font = [UIFont systemFontOfSize:13];
    CGSize size = CGSizeMake(300,2000);
    CGRect titleLabelRect = [title boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    _newstitleLabel.frame = CGRectMake(_newstitleLabel.frame.origin.x, _newstitleLabel.frame.origin.y, _newstitleLabel.frame.size.width, titleLabelRect.size.height);
    _newstitleLabel.text = title;
    _newstitleLabel.font = [UIFont systemFontOfSize:13];
    _newstitleLabel.numberOfLines = 0;
  
    _edittimeLabel.frame = CGRectMake(_edittimeLabel.frame.origin.x, _newstitleLabel.frame.origin.y+_newstitleLabel.frame.size.height+8, _edittimeLabel.frame.size.width, _edittimeLabel.frame.size.height);
    _flagImage.frame= CGRectMake(_flagImage.frame.origin.x, _newstitleLabel.frame.origin.y+_newstitleLabel.frame.size.height+3, _flagImage.frame.size.width, _flagImage.frame.size.height);
    
    frame.size.height = _newstitleLabel.frame.size.height+_edittimeLabel.frame.size.height+20;
    return frame.size.height;
}
@end
