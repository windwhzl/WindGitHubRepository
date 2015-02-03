//
//  dhjbTableViewCell.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-12-18.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "dhjbTableViewCell.h"

@implementation dhjbTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setName:(NSString *)name
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
    _telLabel.text = [_tel copy];
}
- (IBAction)callButtonClick:(id)sender {
    NSString *telString = _tel;
    NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",telString];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self addSubview:callWebview];
}
@end
