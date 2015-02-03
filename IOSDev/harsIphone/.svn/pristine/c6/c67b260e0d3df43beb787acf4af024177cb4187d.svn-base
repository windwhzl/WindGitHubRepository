//
//  PeopleTabBarControllerViewController.m
//  qiuzhidengji
//
//  Created by xiaomage on 14/11/21.
//  Copyright (c) 2014年 xiaomage. All rights reserved.
//

#import "PeopleTabBarControllerViewController.h"
#import "PeopleInfo2.h"

@interface PeopleTabBarControllerViewController ()

@end

@implementation PeopleTabBarControllerViewController
@synthesize name;
@synthesize sex;
@synthesize nation;
@synthesize birthday;

- (void)viewDidLoad {
    //坑爹啊！要设置代理了为自己，才能调用他的代理方法！
    self.delegate=self;
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}

//同志们，哈哈！这里为什么要禁用点击tabbaritem直接跳到item2呢？有显示的逻辑问题哦！
-(BOOL) tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)vc{
    if([vc isKindOfClass:[PeopleInfo2 class]]){
        return NO;
    }
    return YES;
}

@end
                            