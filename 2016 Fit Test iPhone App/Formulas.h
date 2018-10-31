//
//  Formulas.h
//  bmicalories
//
//  Created by Linda Cobb on 6/25/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Formulas : NSObject



// Units not relevant
+ (NSNumber *)Estimated_VO2Max_age:(NSNumber *)age restingPulse:(NSNumber *)restingPulse;
+ (NSString *)EstimatedAerobicAgeFemale:(NSNumber *)vo2;
+ (NSString *)EstimatedAerobicAgeMale:(NSNumber *)vo2;


// Metric
+ (NSNumber *)Metric_BMI_height_cm:(NSNumber *)height weight_kgs:(NSNumber *)weight;
+ (NSNumber *)Metric_hipToWaist_waist_cm:(NSNumber *)waist hips_cm:(NSNumber *)hips;
+ (NSNumber *)Metric_bodyFat_sexMF:(NSNumber *)sex height_cm:(NSNumber *)height waist :(NSNumber *)waist weight_kg:(NSNumber *)weight;
+ (NSArray *)Metric_calories_height_cm:(NSNumber *)height weight_kgs:(NSNumber *)weight age_yrs:(NSNumber *)age sexMF:(NSNumber *)sex;
+ (NSArray *)Metric_dailyCaloriesToWeight_daily_calories: (NSNumber *)dailyCalories age_yrs:(NSNumber *)age sexMF :(NSNumber *)sex height_cm:(NSNumber *)height;
+ (NSNumber *)Metric_walkingCalories_minutes:(NSNumber *)minutes weight_kgs:(NSNumber *)weight;
+ (NSNumber *)Metric_runningCalories_minutes:(NSNumber *)minutes weight_kgs:(NSNumber *)weight;
+ (NSNumber *)Metric_caloriesDropped:(NSNumber *)calories;
+ (NSNumber *)Metric_bodySurfaceArea_height_cm:(NSNumber *)height weight_kgs:(NSNumber *)weight;
+ (NSNumber *)Metric_kilometersPer100Calories_weightKgs:(NSNumber *)weight;
+ (NSNumber *)Metric_daysToReachGoal_caloriesPerDay:(NSNumber *)caloriesPerDay currentWeight_kgs:(NSNumber *)currentWeight goalWeight_kgs:(NSNumber *)goalWeight;
+ (NSString *)Metric_dateReachGoal_daysUntilGoal:(NSNumber *)days;
+ (NSNumber *)Metric_CooperTest_12MinuteRun_kms:(NSNumber *)distance;
+ (NSString *)Metric_average10KWinningPace_sex:(NSNumber *)sex age:(NSNumber *)age;


// Imperial
+ (NSNumber *)US_BMI_height_in:(NSNumber *)height weight_lbs:(NSNumber *)weight;
+ (NSNumber *)US_hipToWaist_waist_in:(NSNumber *)waist hips_in:(NSNumber *)hips;
+ (NSNumber *)US_bodyFat_sexMF:(NSNumber *)sex height_in:(NSNumber *)height waist_in :(NSNumber *)waist weight_lbs:(NSNumber *)weight;
+ (NSArray *)US_calories_height_ins:(NSNumber *)height weight_lbs:(NSNumber *)weight age_yrs:(NSNumber *)age sexMF:(NSNumber *)sex;
+ (NSArray *)US_dailyCaloriesToWeight_daily_calories: (NSNumber *)dailyCalories age_yrs:(NSNumber *)age sexMF :(NSNumber *)sex height_ins:(NSNumber *)height;
+ (NSNumber *)US_walkingCalories_minutes:(NSNumber *)minutes weight_lbs:(NSNumber *)weight;
+ (NSNumber *)US_runningCalories_minutes:(NSNumber *)minutes weight_lbs:(NSNumber *)weight;
+ (NSNumber *)US_caloriesDropped:(NSNumber *)calories;
+ (NSNumber *)US_bodySurfaceArea_height_in:(NSNumber *)height weight_lbs:(NSNumber *)weight;
+ (NSNumber *)US_milesPer100Calories_weightLbs:(NSNumber *)weight;
+ (NSNumber *)US_daysToReachGoal_caloriesPerDay:(NSNumber *)caloriesPerDay currentWeight_lbs:(NSNumber *)currentWeight goalWeight_lbs:(NSNumber *)goalWeight;
+ (NSString *)US_dateReachGoal_daysUntilGoal:(NSNumber *)days;
+ (NSNumber *)US_CooperTest_12MinuteRun_miles:(NSNumber *)distance;
+ (NSString *)US_average10KWinningPace_sex:(NSNumber *)sex age:(NSNumber *)age;



// conversions
+ (NSNumber *)metersPerSecondToMilesPerHour:(NSNumber *)metersPerSecond;
+ (NSNumber *)metersPerSecondToKilometersPerHour:(NSNumber *)metersPerSecond;

+ (NSNumber *)metersToKilometers: (NSNumber *)meters;
+ (NSNumber *)metersToMiles:(NSNumber *)meters;

+ (NSNumber *)milesToMeters: (NSNumber *)miles;
+ (NSNumber *)kilometersToMeters: (NSNumber *)kilometers;

+ (NSArray *)secondsToHoursMinutesSeconds:(NSNumber *)seconds;

+ (NSArray *)metersPerSecondToMinutesAMile: (NSNumber *)metersPerSecond;
+ (NSArray *)metersPerSecondToMinutesAKilometer:(NSNumber *)metersPerSecond;

+ (NSNumber *)inchesToCm: (NSNumber *)inches;
+ (NSNumber *)cmToInches: (NSNumber *)cm;

+ (NSNumber *)inchesToMeters: (NSNumber *)inches;
+ (NSNumber *)metersToInches: (NSNumber *)meters;


+ (NSNumber *)poundsToKilograms: (NSNumber *)pounds;
+ (NSNumber *)kilogramsToPounds: (NSNumber *)kilograms;

+ (NSNumber *)secondsPerHour;
+ (NSNumber *)secondsPerMinute;

+ (NSNumber *)kilometersPerMeter;
+ (NSNumber *)milesPerMeter;

+ (NSNumber *)metsPerMetersPerSecond: (NSNumber *)mps;
+ (NSNumber *)kilometersToMiles: (NSNumber *)kilometers;


+ (NSNumber *)gradeDistance: (NSNumber *)distance climb: (NSNumber *)climb;



@end
