//
//  AppDelegate.m
//  Fitness
//
//  Created by Linda Cobb on 6/27/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // icon travels across tab view
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"exercise.png"]];
    //[[UITabBar appearance] setTintColor:[UIColor blackColor]];

    
    self.rootController.view.frame = [UIScreen mainScreen].applicationFrame;
    [self.window addSubview:[self.rootController view]];
    [self.window makeKeyAndVisible];
    
    [self getHealthStore];
    
    return YES;
}



- (HKHealthStore *) getHealthStore
{
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    int healthKitStorePermission = [[defaults objectForKey:@"healthStorePermission"] intValue];
    if ( healthKitStorePermission == 1 ){

        // health kit
        _healthStore = [[HKHealthStore alloc] init];
        _healthKitCommon = [HealthKitCommon new];
    
    
        NSSet *writeDataTypes = [self.healthKitCommon dataTypesToWrite];
    
        [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:nil completion:^(BOOL success, NSError *error) {
            if (!success) {
                NSLog(@"You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: %@. If you're using a simulator, try it on a device.", error);
                return;
            }
        }];
    
        self.healthKitCommon.healthStore = self.healthStore;
    }
    
    return self.healthStore;

}





- (void)applicationWillResignActive:(UIApplication *)application {}
- (void)applicationDidEnterBackground:(UIApplication *)application {}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationDidBecomeActive:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {}

@end
