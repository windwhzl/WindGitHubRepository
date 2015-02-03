//
//  AlertDialogWhenFunctionNotComplete.m
//  huaianZSRS
//
//  Created by xiaomage on 14/12/6.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "AlertDialogWhenFunctionNotComplete.h"

@implementation AlertDialogWhenFunctionNotComplete


-(id) initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if(self){
        self.layer.cornerRadius=10.0f;
        image=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        UIImage *alertImg=[UIImage imageNamed:@"system_alert_body1.9.png"];
        image.image=alertImg;
        image.contentMode=UIViewContentModeScaleToFill;
        
        button=[[UIButton alloc] initWithFrame:CGRectMake(130, 20, 50, 30)];
        [button setTitle:@"关 闭" forState:UIControlStateNormal];
        button.font=[UIFont systemFontOfSize:14.0];
        [button addTarget:self action:@selector(closeSelf) forControlEvents:(UIControlEventTouchUpInside)];
        [button.titleLabel setTextAlignment:UITextAlignmentCenter];
//        button.backgroundColor=[UIColor blackColor];
        
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSelf)];
        tapGesture.numberOfTapsRequired=1;
        [self addGestureRecognizer:tapGesture];
        
        [self addSubview:image];
        [self addSubview:button];
    }
    return self;
}

-(void) show{
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(closeSelf) userInfo:nil repeats:NO];
}

-(void) closeSelf{
    [self removeFromSuperview];
}

@end
