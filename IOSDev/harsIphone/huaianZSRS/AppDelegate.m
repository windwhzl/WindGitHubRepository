//
//  AppDelegate.m
//  huaianZSRS
//
//  Created by Kyo-PC on 14-10-9.
//  Copyright (c) 2014年 Kyo-PC. All rights reserved.
//

#import "AppDelegate.h"
#import "ShouyeViewController.h"
#import "LaunchScreenViewController.h"
#import "jbjhViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    LaunchScreenViewController *launchScreen=[[LaunchScreenViewController alloc] init];
    //貌似上面是在面板中的定义的视图，因此通过这样初始化会出现黑屏，唉。。。我真是太菜了！
    
    UIStoryboard *launchScreen=[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil];
    LaunchScreenViewController *launchScreenViewController=[launchScreen instantiateViewControllerWithIdentifier:@"launchScreenView"];
    [self.window setRootViewController:launchScreenViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) changeRootViewController{
    //改变根viewController
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"MainStory" bundle:nil];
    ShouyeViewController *shouye=[mainStory instantiateViewControllerWithIdentifier:@"ShouyeView"];
    shouye.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.window setRootViewController:shouye];
    [self.window makeKeyAndVisible];
}
- (NSUInteger) application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskAll;
}
@end
