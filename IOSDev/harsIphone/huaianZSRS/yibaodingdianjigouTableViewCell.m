//
//  yibaodingdianjigouTableViewCell.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-27.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "yibaodingdianjigouTableViewCell.h"

@implementation yibaodingdianjigouTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setName:(NSString *)name
{
    _name = [name copy];
    _nameLabel.text = [_name copy];
    
}
-(void) setAddress:(NSString *)address
{
    _address = [address copy];
    _addressLabel.text = [_address copy];
  
}
-(void) setTel:(NSString *)tel
{
    _tel = [tel copy];
    _telLable.text = [_tel copy];
}
-(void) setPost:(NSString *)post
{
    _post = [post copy];
    _postLabel.text = [_post copy];
}
-(CGFloat) setNameHeight:(NSString*)nameText
        setAddressHeight:(NSString*)addressText
{
    CGRect frame = [self frame];
    
    UIFont *font = [UIFont systemFontOfSize:13];
    CGSize size = CGSizeMake(180,200);
    CGRect nameLabelRect = [nameText boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGRect addressLabelRect = [addressText boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    
    _nameLabel.frame = CGRectMake(_nameLabel.frame.origin.x, _nameLabel.frame.origin.y, _nameLabel.frame.size.width, nameLabelRect.size.height);
    _nameLabel.text = nameText;
    _nameLabel.font = [UIFont systemFontOfSize:13];
    _nameLabel.numberOfLines = 0;
    _DwmcLabel.frame = CGRectMake(_DwmcLabel.frame.origin.x, _nameLabel.frame.origin.y, _DwmcLabel.frame.size.width, _DwmcLabel.frame.size.height);
    
    _addressLabel.frame = CGRectMake(_addressLabel.frame.origin.x, _nameLabel.frame.origin.y+_nameLabel.frame.size.height,_addressLabel.frame.size.width, addressLabelRect.size.height);
    _addressLabel.text = addressText;
    _addressLabel.font = [UIFont systemFontOfSize:13];
    _addressLabel.numberOfLines = 0;
    [_addressLabel sizeToFit];
    _DwdzLabel.frame = CGRectMake(_DwdzLabel.frame.origin.x,_nameLabel.frame.origin.y+_nameLabel.frame.size.height, _DwdzLabel.frame.size.width, _DwdzLabel.frame.size.height);
    
    _telLable.frame = CGRectMake(_telLable.frame.origin.x, _addressLabel.frame.origin.y+_addressLabel.frame.size.height, _telLable.frame.size.width, _telLable.frame.size.height);
    _LxdhLabel.frame = CGRectMake(_LxdhLabel.frame.origin.x, _addressLabel.frame.origin.y+_addressLabel.frame.size.height, _LxdhLabel.frame.size.width, _LxdhLabel.frame.size.height);
    
    _postLabel.frame = CGRectMake(_postLabel.frame.origin.x, _telLable.frame.origin.y+_telLable.frame.size.height, _postLabel.frame.size.width, _postLabel.frame.size.height);
    _YbLabel.frame = CGRectMake(_YbLabel.frame.origin.x, _telLable.frame.origin.y+_telLable.frame.size.height, _YbLabel.frame.size.width, _YbLabel.frame.size.height);
    
    frame.size.height = _nameLabel.frame.size.height+_addressLabel.frame.size.height+_telLable.frame.size.height+_postLabel.frame.size.height+10;
    return frame.size.height;
}
@end
