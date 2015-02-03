//
//  ybcxDetailTableViewCell.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-11-4.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "ybcxDetailTableViewCell.h"

@implementation ybcxDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) setNf:(NSString *)nf
{
    _nf = [nf copy];
    _nfLabel.text = [_nf copy];
}
-(void) setSnzr:(NSString *)snzr
{
    _snzr = [snzr copy];
    _snzrLabel.text = [_snzr copy];
}
-(void) setZhye:(NSString *)zhye
{
    _zhye = [zhye copy];
    _zhyeLabel.text = [_zhye copy];
}
-(void) setJnys:(NSString *)jnys
{
    _jnys = [jnys copy];
    _jnysLabel.text = [_jnys copy];
}
-(void) setZchj:(NSString *)zchj
{
    _zchj =[zchj copy];
    _zchjLabel.text = [_zchj copy];
}
@end
