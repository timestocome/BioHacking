//
//  PickerArrays.h
//  bmicalories
//
//  Created by Linda Cobb on 6/25/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PickerArrays : NSObject




+ (NSArray *)ageArray;
+ (NSArray *)sexArray;
+ (NSArray *)unitsArray;
+ (NSArray *)caloriesArray;
+ (NSArray *)minutesArray;
+ (NSArray *)droppedCaloriesArray;



// metric
+ (NSArray *)metricWeightArray;
+ (NSArray *)metricWaistArray;
+ (NSArray *)metricHipsArray;
+ (NSArray *)metricHeightArray;


// imperial
+ (NSArray *)imperialWeightArray;
+ (NSArray *)imperialWaistArray;
+ (NSArray *)imperialHipsArray;
+ (NSArray *)imperialHeightArray;



@end
