//
//  AppDelegate.m
//  HXTest
//
//  Created by 覃鹏成 on 16/5/19.
//  Copyright © 2016年 覃鹏成. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface AppDelegate () <EMClientDelegate>

@end

@implementation AppDelegate

+ (AppDelegate *)getAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSString *appKey = @"1102200326065464#hxtest";
    IQKeyboardManager.sharedManager.enable = YES;
    
    EMOptions *options = [EMOptions optionsWithAppkey:appKey];
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EMClient sharedClient] logout:YES completion:^(EMError *aError) {
            if (aError) {
                [EMAlertController showErrorAlert:aError.errorDescription];
            } else {
                EMDemoOptions *options = [EMDemoOptions sharedOptions];
                options.isAutoLogin = NO;
                options.loggedInUsername = @"";
                [options archive];
                
    //            [[ApplyViewController shareController] clear];
                [[NSNotificationCenter defaultCenter] postNotificationName:ACCOUNT_LOGIN_CHANGED object:@NO];
            }
    }];
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark  -- 环信delegate
/*
 *  自动登录返回结果
 *
 *  @param aError 错误信息
 */
- (void)didAutoLoginWithError:(EMError *)aError{
    NSLog(@"error   %@",aError);
}


@end
