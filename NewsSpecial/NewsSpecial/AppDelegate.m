//
//  AppDelegate.m
//  DiscountStore
//
//  Created by qianfeng on 16/4/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "YXYTabbarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    
    // NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    //    if ([user objectForKey:@"UseTimes"] == nil) {
    //        HelpViewController * helpVC = [[HelpViewController alloc]init];
    //        _window.rootViewController = helpVC;
    ////        [user setObject:@"NotFirstUser" forKey:@"UseTimes"];
    //    }else
    //    {
    //        YXYTabbarController * tab = [[YXYTabbarController alloc]init];
    //
    //        _window.rootViewController = tab;
    //    }
    
    YXYTabbarController * tab = [[YXYTabbarController alloc]init];
    
    _window.rootViewController = tab;
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:193 / 255.0 green:193 / 255.0 blue:193 / 255.0 alpha:1], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = MainColor;
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleHighlightedColor, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * dic = [userDefaults valueForKey:@"currentUser"];
    if (dic) {
        UserModel * user = [UserModel objectWithKeyValues:dic];
        [UserModel setCurrentUser:user];
    }else {
        UserModel * user = [UserModel new];
        user.nickName = @"默认用户";
        [UserModel setCurrentUser:user];
    }
    [userDefaults setObject:@"123" forKey:@"123"];
    
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

+ (NSString*) currentUserPath{
    static NSString *usersPath = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        NSString* docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        usersPath = [docPath stringByAppendingPathComponent:@"Users"];
    });
    NSString *path = [usersPath stringByAppendingPathComponent:@"tiyuzhimen"];
    [[NSFileManager defaultManager]createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    return path;
}

@end
