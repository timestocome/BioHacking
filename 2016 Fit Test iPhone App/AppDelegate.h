//
//  AppDelegate.h
//  Fitness
//
//  Created by Linda Cobb on 6/27/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//


// current update
// add 10k winning times to iPhone5 and iPad versions
// minor user interface tweaks


#import <UIKit/UIKit.h>
#import <HealthKit/HealthKit.h>
#import "HealthKitCommon.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *rootController;

@property (nonatomic, retain) HKHealthStore* healthStore;
@property (nonatomic, retain) HealthKitCommon* healthKitCommon;


@end
