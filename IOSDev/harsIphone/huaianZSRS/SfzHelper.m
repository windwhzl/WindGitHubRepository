//
//  SfzHelper.m
//  qiuzhidengji
//
//  Created by xiaomage on 14/11/24.
//  Copyright (c) 2014年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SfzHelper.h"
//加权因子
static int Wi[18] = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1 };
//身份证验证位,10代表x
static int ValideCode[] = { 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 };

@implementation SfzHelper

+(BOOL) IdCardValidate:(NSString *)sfzh{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];

    //15位身份证号，现在基本上不用了
    if(sfzh.length==18){
        NSString *year=[sfzh substringWithRange:NSMakeRange(6, 4)];
        NSString *month=[sfzh substringWithRange:NSMakeRange(10, 2)];
        NSString *day=[sfzh substringWithRange:NSMakeRange(12, 2)];
        NSString *dateStr=[[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%@/%@",year,month,day]];
        @try{
            [dateFormatter dateFromString:dateStr];
        }
        @catch(NSException *exception){
            return NO;
        }
        
        NSMutableArray *a_idCard=[[NSMutableArray alloc] init];
        [a_idCard addObject:@" "];
        for(int i=0;i<18;i++){
            [a_idCard addObject:[sfzh substringWithRange:NSMakeRange(i, 1)]];
        }
        int sum=0;
        
//        NSLog(@"%d",a_idCard.count);
        
        // 将最后位为x的验证码替换为10方便后续操作
        if([[a_idCard objectAtIndex:18] isEqualToString:@"x"]||[[a_idCard objectAtIndex:18] isEqualToString:@"X"]){
            [a_idCard replaceObjectAtIndex:18 withObject:@"10"];
        }
        for ( int i = 1; i < 18; i++) {
            // 加权求和
            sum += Wi[i-1] * [(NSString *)[a_idCard objectAtIndex:i] intValue];
        }
        // 得到验证码所位置
        int valCodePosition = sum % 11;
        if ([(NSString *)[a_idCard objectAtIndex:18] intValue] == ValideCode[valCodePosition]) {
            return YES;
        } else {
            return NO;
        }
        
    }else{
        //提醒用户输入正确的18为身份证号
        return NO;
    }
}

@end


