//
//  HealthKitCommon.h
//  Fitness
//
//  Created by Linda Cobb on 8/21/14.
//  Copyright (c) 2014 TimesToCome Mobile. All rights reserved.
//

#ifndef Fitness_HealthKit_Common_h
#define Fitness_HealthKit_Common_h

#import <HealthKit/HealthKit.h>



@interface HealthKitCommon : NSObject
{
    int     units;
}

@property HKHealthStore* healthStore;
@property NSUserDefaults* defaults;


- (NSSet *)dataTypesToWrite;
- (NSSet *)dataTypesToRead;



- (HKHealthStore *)getHealthKit;

- (void)saveWeightIntoHealthStore:(NSNumber *)weight;
- (void)saveBodyFatPercentageIntoHealthStore: (NSNumber *)bf;
- (void)saveBodyMassIndexIntoHealthStore: (NSNumber *)bmi;
- (void)saveLeanBodyMassIntoHealthStore :(NSNumber *)leanBodyMass;
- (void)savePulseRateIntoHealthStore: (NSNumber *)pulse;





@end


#endif
