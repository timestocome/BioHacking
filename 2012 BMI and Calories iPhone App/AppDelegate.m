//
//  AppDelegate.m
//  bmicalories
//
//  Created by Linda Cobb on 6/25/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    float iOSVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (iOSVersion < 7.0 ){
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            UIStoryboard *oldStoryboard = [UIStoryboard storyboardWithName:@"Main_iPad_6" bundle:nil];
            BMIViewController *bmiViewController = [oldStoryboard instantiateInitialViewController];
            self.window.rootViewController = bmiViewController;
        }else{
            UIStoryboard *oldStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone_6" bundle:nil];
            BMIViewController *bmiViewController = [oldStoryboard instantiateInitialViewController];
            self.window.rootViewController = bmiViewController;

        }
        
    }
    
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {}
- (void)applicationDidEnterBackground:(UIApplication *)application {}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationDidBecomeActive:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {}





@end
