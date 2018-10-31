//
//  HealthKitCommon.m
//  Fitness
//
//  Created by Linda Cobb on 8/21/14.
//  Copyright (c) 2014 TimesToCome Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HealthKitCommon.h"
#import "AppDelegate.h"
#import "Formulas.h"




@implementation HealthKitCommon




- (HKHealthStore *)getHealthKit
{
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    _healthStore = appDelegate.healthStore;
    
    _defaults = [NSUserDefaults standardUserDefaults];
    units = [[self.defaults objectForKey:@"units"] intValue];
    
    return self.healthStore;
}







#pragma mark - HealthKit Permissions

// Returns the types of data that Fit wishes to write to HealthKit.
- (NSSet *)dataTypesToWrite
{
    HKQuantityType *bodyFatPercentType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyFatPercentage];
    HKQuantityType *bodyMassIndexType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex];
    HKQuantityType *leanBodyMassType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierLeanBodyMass];
    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKQuantityType *heartRateType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];

    
    return [NSSet setWithObjects: bodyFatPercentType, bodyMassIndexType, leanBodyMassType, weightType, heartRateType, nil];
}




// Returns the types of data that Fit wishes to read from HealthKit.
- (NSSet *)dataTypesToRead
{
    return [NSSet setWithObjects: nil];
}






- (void)saveWeightIntoHealthStore:(NSNumber *)weight
{
    HKQuantity *weightQuantity = [HKQuantity quantityWithUnit:[HKUnit poundUnit] doubleValue:weight.doubleValue];
    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    NSDate *now = [NSDate date];
    HKQuantitySample *weightSample = [HKQuantitySample quantitySampleWithType:weightType quantity:weightQuantity startDate:now endDate:now];
    
    [self.healthStore saveObject:weightSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the weight sample %@. In your app, try to handle this gracefully. The error was: %@.", weightSample, error);
        }
    }];
    
}




- (void)saveBodyFatPercentageIntoHealthStore: (NSNumber *)bf
{
    
    HKQuantity *bodyFatPercentQuantity = [HKQuantity quantityWithUnit:[HKUnit percentUnit] doubleValue:bf.doubleValue/100.0];
    HKQuantityType *bodyFatPercentType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyFatPercentage];
    NSDate *now = [NSDate date];
    HKQuantitySample *bodyFatSample = [HKQuantitySample quantitySampleWithType:bodyFatPercentType quantity:bodyFatPercentQuantity startDate:now endDate:now];
    
    [self.healthStore saveObject:bodyFatSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the weight sample %@. In your app, try to handle this gracefully. The error was: %@.", bodyFatSample, error);
        }
    }];
    
}


     
- (void)saveBodyMassIndexIntoHealthStore: (NSNumber *)bmi
{
   
    HKQuantity *bmiQuantity = [HKQuantity quantityWithUnit:[HKUnit countUnit] doubleValue:bmi.doubleValue];
    HKQuantityType *bmiType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex];
    NSDate *now = [NSDate date];
    HKQuantitySample *bmiSample = [HKQuantitySample quantitySampleWithType:bmiType quantity:bmiQuantity startDate:now endDate:now];
    
    [self.healthStore saveObject:bmiSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the weight sample %@. In your app, try to handle this gracefully. The error was: %@.", bmiSample, error);
        }
    }];
    

}



// weight - weight * bodyFatPercent
- (void)saveLeanBodyMassIntoHealthStore :(NSNumber *)leanBodyMass
{
    
    HKQuantity *leanBodyMassQuantity = [HKQuantity quantityWithUnit:[HKUnit gramUnitWithMetricPrefix:HKMetricPrefixKilo] doubleValue:leanBodyMass.doubleValue];
    HKQuantityType *leanBodyMassType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierLeanBodyMass];
    NSDate *now = [NSDate date];
    HKQuantitySample *leanBodyMassSample = [HKQuantitySample quantitySampleWithType:leanBodyMassType quantity:leanBodyMassQuantity startDate:now endDate:now];
    
    
    [self.healthStore saveObject:leanBodyMassSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the weight sample %@. In your app, try to handle this gracefully. The error was: %@.", leanBodyMassSample, error);
        }else{
            NSLog(@"saved lean body mass to health kit");
        }
    }];
    
}





- (void)savePulseRateIntoHealthStore: (NSNumber *)pulse
{
    NSLog(@"pulse recieved %@", pulse);
    HKUnit *bpmUnit = [[HKUnit countUnit] unitDividedByUnit:[HKUnit minuteUnit]];
    
    HKQuantity *heartRateQuantity = [HKQuantity quantityWithUnit:bpmUnit doubleValue:pulse.intValue];
    HKQuantityType *heartRateType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    NSDate *now = [NSDate date];
    HKQuantitySample *heartRateSample = [HKQuantitySample quantitySampleWithType:heartRateType quantity:heartRateQuantity startDate:now endDate:now];
    
    
    
    [self.healthStore saveObject:heartRateSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the pulse sample %@. In your app, try to handle this gracefully. The error was: %@.", heartRateSample, error);
        }
    }];
    
}






#pragma mark - Convenience

- (NSNumberFormatter *)numberFormatter {
    static NSNumberFormatter *numberFormatter;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        numberFormatter = [[NSNumberFormatter alloc] init];
    });
    
    return numberFormatter;
}







@end




