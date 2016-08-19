//
//  AppDelegate.m
//  购菜App-商家版
//
//  Created by 黄栋春 on 16/6/12.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "AppDelegate.h"
#import "UIWindow+Extension.h"
#import "ShopsUserInfoTool.h"
#import "ShopsUserInfo.h"
#import "HDCTabBarViewController.h"
#import "JPUSHService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ShopsUserInfo *userInfo = [ShopsUserInfoTool account];
    if (!userInfo)
    {
        [self.window switchRootViewController];
    }
    else
    {
        [self.window setRootViewController:[[HDCTabBarViewController alloc]  init]];
    }

    //    [self.window setRootViewController:[[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]]];
    [self.window makeKeyAndVisible];
    
    
    
    
    //极光推送
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    //JAppKey : 是你在极光推送申请下来的appKey Jchannel : 可以直接设置默认值即可 Publish channel
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel apsForProduction:NO]; //如果是生产环境应该设置为YES
    return YES;
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {    // Required
    [JPUSHService registerDeviceToken:deviceToken];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSString *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    if (application.applicationState == UIApplicationStateActive) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"推送消息"
                                                            message:alert
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    [application setApplicationIconBadgeNumber:0];
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    HDCLog(@"userInfouserInfouserInfouserInfo %@", [userInfo[@"aps"] objectForKey:@"sound"]);
    HDCLog(@"userInfouserInfouserInfouserInfo %@", [userInfo[@"aps"] objectForKey:@"alert"]);
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"新任务" message:@"你有一条新的可接单" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
              [self.window setRootViewController:[[HDCTabBarViewController alloc]  init]];
        }];
        
        [alertController addAction:cancelAction];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
      
        //此时app在前台运行，我的做法是弹出一个alert，告诉用户有一条推送，用户可以选择查看或者忽略
        //        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"您有一条新的可接单!"
        //                                                         message:@"请刷新列表查看"
        //                                                        delegate:self
        //                                               cancelButtonTitle:@"确定"
        //                                               otherButtonTitles:nil,nil];
        //        [alert show];
        
    }
    else {
        //这里是app未运行或者在后台，通过点击手机通知栏的推送消息打开app时可以在这里进行处理，比如，拿到推送里的内容或者附加      字段(假设，推送里附加了一个url为 www.baidu.com)，那么你就可以拿到这个url，然后进行跳转到相应店web页，当然，不一定必须是web页，也可以是你app里的任意一个controll，跳转的话用navigation或者模态视图都可以
        
        //这里设置app的图片的角标为0，红色但角标就会消失
        [UIApplication sharedApplication].applicationIconBadgeNumber  =  0;
        completionHandler(UIBackgroundFetchResultNewData);
        
       [self.window setRootViewController:[[HDCTabBarViewController alloc]  init]];
        
    }
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    // 清除图标数字
    application.applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
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

@end
