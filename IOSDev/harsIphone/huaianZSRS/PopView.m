//
//  PopView.m
//  qiuzhidengji
//
//  Created by xiaomage on 14/11/25.
//  Copyright (c) 2014年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "PopView.h"

@implementation PopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent: 0.75f];
        self.layer.cornerRadius = 5.0f;
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 10)];
        _textLabel.numberOfLines = 0;
        _textLabel.font = [UIFont systemFontOfSize:17];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
        _queueCount = 0;
    }
    return self;
}

- (void) setText:(NSString *) text
{
    _textLabel.frame = CGRectMake(0, 0, 100, 10);
    _queueCount ++;
    self.alpha = 1.0f;
    _textLabel.text = text;
    [_textLabel sizeToFit];
    CGRect frame = CGRectMake(5, 2, _textLabel.frame.size.width, _textLabel.frame.size.height);
    _textLabel.frame = frame;
    frame =  CGRectMake(self.frame.origin.x, self.frame.origin.y, _textLabel.frame.size.width+10, _textLabel.frame.size.height+4);
    self.frame = frame;
    [UIView animateWithDuration:3.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         if (_queueCount == 1) {
                             [self removeFromSuperview];
                         }
                         _queueCount--;
                         
                     }
     ];
    
}


@end