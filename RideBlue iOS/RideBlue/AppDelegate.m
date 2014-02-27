//
//  AppDelegate.m
//  RideBlue
//
//  Created by Jackson on 10/17/13.
//  Copyright (c) 2013 RideBlue. All rights reserved.
//

#import "AppDelegate.h"
#import "frontScreen.h"
#import <Parse/Parse.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
    [Parse setApplicationId:@"d440K8yjX2gBrtz31Y4MDrNvnsqWQyIdbhjSEaTt"
                clientKey:@"nypI9QTwgEuO4gzeiiadb82dgJJXQ4Kudy4r90lC"];

    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge |
     UIRemoteNotificationTypeAlert |
     UIRemoteNotificationTypeSound];
  
    // light status bar.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
  
    // sets up title screens to open.
    frontScreen *titleScreen = [[frontScreen alloc] initWithNibName:@"frontScreen" bundle:nil];
    UINavigationController *masterNav = [[UINavigationController alloc] initWithRootViewController:titleScreen];
    [self.window setRootViewController:masterNav];
    [masterNav setNavigationBarHidden:YES];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {

  PFInstallation *currentInstallation = [PFInstallation currentInstallation];
  [currentInstallation setDeviceTokenFromData:newDeviceToken];
  [currentInstallation setChannels:[NSArray arrayWithObjects: nil]];
  [currentInstallation addUniqueObject:[NSString stringWithFormat:@"dev-id-%@", [[UIDevice currentDevice].identifierForVendor UUIDString]]
                                forKey:@"channels"];
  [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
  [PFPush handlePush:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
