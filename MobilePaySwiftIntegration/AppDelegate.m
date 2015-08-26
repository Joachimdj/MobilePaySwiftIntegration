//
//  AppDelegate.m
//  MobilePayFruitshop
//
//  Created by Troels Richter on 18/09/14.
//  Copyright (c) 2014 DanskeBank A/S. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewHelper.h"
#import "MobilePayManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*
     * INFO!!! See the example app for more details on how to use the SDK.
     */
    [[MobilePayManager sharedInstance] setupWithMerchantId:@"APPDK0000000000" merchantUrlScheme:@"fruitshop"];
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

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    [[MobilePayManager sharedInstance] handleMobilePayCallbacksWithUrl:url success:^(NSString *orderId, NSString *transactionId, NSString *signature) {
        NSLog(@"MobilePay payment succeeded: Your have now payed for order with id '%@' and MobilePay transaction id '%@'", orderId, transactionId);
        //todo here is where you deliver the product
    } error:^(NSString *orderId, int errorCode, NSString *errorMessage) {
        NSLog(@"MobilePay payment failed:  Error code '%i' and message '%@'",errorCode,errorMessage);
        //todo show an appropriate error message to the user. Check MobilePayManager.h for a complete description of the error codes
        /*
         * An example of using the ErrorCode enum
         * if (errorCode == ErrorCodeUpdateApp) {
         *     NSLog(@"You must update your MobilePay app");
         * }
         */
    } cancel:^(NSString *orderId) {
        NSLog(@"MobilePay payment with order id '%@' canceled by user", orderId);
        //todo maybe your app should enter a certain state when the user cancels the payment flow in MobilePay?
    }];
    
    return YES;
}

@end
