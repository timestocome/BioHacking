//
//  Formulas.m
//  bmicalories
//
//  Created by Linda Cobb on 6/25/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import "Formulas.h"

@implementation Formulas


// irrelivant units

+ (NSNumber *)metsPerMetersPerSecond: (NSNumber *)mps
{
    if ( mps.doubleValue <= 0.89408 ) { return [NSNumber numberWithDouble:2.0]; }       // 2.0 mph
    else if ( mps.doubleValue <= 1.1176 ) { return [NSNumber numberWithDouble:3.0]; }   // 2.5 mph
    else if ( mps.doubleValue <= 1.34112 ) { return [NSNumber numberWithDouble:3.5]; }   // 3.0 mph
    else if ( mps.doubleValue <= 1.56464 ) { return [NSNumber numberWithDouble:4.0]; }   // 3.5
    else if ( mps.doubleValue <= 1.78816 ) { return [NSNumber numberWithDouble:5.0]; }   // 4.0
    else if ( mps.doubleValue <= 2.01168 ) { return [NSNumber numberWithDouble:7.0]; }   // 4.5
    else if ( mps.doubleValue <= 2.23520 ) { return [NSNumber numberWithDouble:8.0]; }   // 5.0
    else if ( mps.doubleValue <= 2.45872 ) { return [NSNumber numberWithDouble:9.0]; }   // 5.5
    else if ( mps.doubleValue <= 2.68224 ) { return [NSNumber numberWithDouble:10.0]; }   // 6.0
    else if ( mps.doubleValue <= 2.90576 ) { return [NSNumber numberWithDouble:11.0]; }   // 6.5
    else if ( mps.doubleValue <= 3.12928 ) { return [NSNumber numberWithDouble:11.5]; }   // 7.0
    else if ( mps.doubleValue <= 3.35280 ) { return [NSNumber numberWithDouble:12.5]; }   // 7.5
    else if ( mps.doubleValue <= 3.57632 ) { return [NSNumber numberWithDouble:13.5]; }   // 8.0
    else if ( mps.doubleValue <= 3.79984 ) { return [NSNumber numberWithDouble:14.0]; }   // 8.5
    else if ( mps.doubleValue <= 4.02336 ) { return [NSNumber numberWithDouble:15.0]; }   // 9.0
    else if ( mps.doubleValue <= 4.24688 ) { return [NSNumber numberWithDouble:15.5]; }   // 9.5
    else if ( mps.doubleValue <= 4.47040 ) { return [NSNumber numberWithDouble:16.0]; }   // 10.0
    else if ( mps.doubleValue <= 4.69392 ) { return [NSNumber numberWithDouble:17.0]; }   // 10.5
    else if ( mps.doubleValue <= 4.91744 ) { return [NSNumber numberWithDouble:18.0]; }   // 11.0
    else { return [NSNumber numberWithInt:(-1)]; }
}


+ (NSNumber *)gradeDistance: (NSNumber *)distance climb: (NSNumber *)climb
{
    double incline = climb.doubleValue/distance.doubleValue * 100.0;
    return [NSNumber numberWithDouble:incline];
}



// Metric
+ (NSNumber *)Metric_BMI_height_cm:(NSNumber *)height weight_kgs:(NSNumber *)weight
{
    double bmi = weight.doubleValue / ((height.doubleValue * height.doubleValue)/100.0);
    return [NSNumber numberWithDouble:bmi];
}



+ (NSNumber *)Metric_hipToWaist_waist_cm:(NSNumber *)waist hips_cm:(NSNumber *)hips
{
    double hw = waist.doubleValue/hips.doubleValue;
    return [NSNumber numberWithDouble:hw];
}



+ (NSNumber *)Metric_bodyFat_sexMF:(NSNumber *)sex height_cm:(NSNumber *)height waist :(NSNumber *)waist weight_kg:(NSNumber *)weight
{
    double bf;
    
    double wgt = weight.doubleValue * 2.204;
    double wst = waist.doubleValue * .3937;
    
    if ( sex == 0 ){        // male
        bf = ( (4.15*wst) - (0.082*wgt) - 98.42 )/wgt;
    }else{                  // female
        bf = ( (4.15*wst) - (0.082*wgt) - 76.76 )/wgt;
    }
    
    return [NSNumber numberWithDouble:bf];
}



+ (NSArray *)Metric_calories_height_cm:(NSNumber *)height weight_kgs:(NSNumber *)weight age_yrs:(NSNumber *)age sexMF:(NSNumber *)sex
{
    // calculate calories needed to reach goal weight
	int calories_needed;
    
    // convert to inches and pounds
    double mg = weight.doubleValue * 2.205;
    double mh = height.doubleValue * .3937;
		
    if ( sex.intValue == 0 ){			// male
        calories_needed = 66 + (6.23 * mg) + (12.7 * mh) - (6.8 * age.intValue);
    }else{					// female
        calories_needed = 655 + (4.35 * mg) + (4.7 * mh) - (4.7 * age.intValue);
    }
	
    
    NSArray *array = @[[NSNumber numberWithDouble:calories_needed * 1.2],   // couch potato
                       [NSNumber numberWithDouble:calories_needed * 1.375], // office worker
                       [NSNumber numberWithDouble:calories_needed * 1.55],  // walker
                       [NSNumber numberWithDouble:calories_needed * 1.725]]; // athelete
    
    return  array;
}



+ (NSNumber *)Metric_bodySurfaceArea_height_cm:(NSNumber *)height weight_kgs:(NSNumber *)weight
{
       
    // DuBois and DuBois
    double bsa1 = 0.007184 * pow(height.doubleValue, 0.725) * pow(weight.doubleValue, 0.425);
    
    // Gehan and George
    double bsa2 = 0.0235 * pow(height.doubleValue, 0.42246) * pow(weight.doubleValue, 0.51456);
    
    // Haycock
    double bsa3 = 0.024265 * pow(height.doubleValue, 0.3964) * pow(weight.doubleValue, 0.5378);
    
    // Mosteller
    double bsa4 = sqrt( (height.doubleValue * weight.doubleValue)/3600.0);
    
    // calculate ave guess and return in meters squared
    double bodySurfaceArea = (bsa1 + bsa2 + bsa3 + bsa4)/4.0;
    
    return [NSNumber numberWithDouble:bodySurfaceArea];
}



+ (NSArray *)Metric_dailyCaloriesToWeight_daily_calories: (NSNumber *)dailyCalories age_yrs:(NSNumber *)age sexMF :(NSNumber *)sex height_cm:(NSNumber *)height
{
    // height inches or cm?  it's all inches now :D
    double h = height.doubleValue * .393701;
	double couch, office, walker, athlete;
    
	
	// estimated weight based on activity and sex
	if ( sex.integerValue == 0 ) {		// male
		couch =		( dailyCalories.doubleValue / 1.2 - 66 - 12.7 * h + 6.8 * age.integerValue )/6.23;
		office =	( dailyCalories.doubleValue / 1.375 - 66 - 12.7 * h + 6.8 * age.integerValue )/6.23;
		walker =	( dailyCalories.doubleValue / 1.55 - 66 - 12.7 * h + 6.8 * age.integerValue )/6.23;
		athlete =	( dailyCalories.doubleValue / 1.725 - 66 - 12.7 * h + 6.8 * age.integerValue )/6.23;
		
	}else{				// female
		couch =		( dailyCalories.doubleValue / 1.2 - 655 - 4.7 * h + 4.7 * age.integerValue)/4.35;
		office =	( dailyCalories.doubleValue / 1.375 - 655 - 4.7 * h + 4.7 * age.integerValue)/4.35;
		walker =	( dailyCalories.doubleValue / 1.55 - 655 - 4.7 * h + 4.7 * age.integerValue )/4.35;
		athlete =	( dailyCalories.doubleValue / 1.725 - 655 - 4.7 * h + 4.7 * age.integerValue )/4.35;
	}
    
    // convert back to kgs
    couch *= 0.45392;
    walker *=0.45392;
    athlete *= 0.45392;
    office *= 0.45392;


    NSArray *array = @[[NSNumber numberWithDouble:couch],
                       [NSNumber numberWithDouble:office],
                       [NSNumber numberWithDouble:walker],
                       [NSNumber numberWithDouble:athlete]];
    
    return array;
}




+ (NSNumber *)Metric_walkingCalories_minutes:(NSNumber *)minutes weight_kgs:(NSNumber *)weight
{
    // convert kgs to lbs
	double w = weight.doubleValue * 2.2046;
	
    double changeDay = ( 1.05 * w * minutes.doubleValue / 60.0 );
    double poundsPerMonth = (changeDay * 30)/3500;
	double kilogramsPerMonth = poundsPerMonth * 0.452592;
    
    return [NSNumber numberWithDouble:kilogramsPerMonth];
}



+ (NSNumber *)Metric_runningCalories_minutes:(NSNumber *)minutes weight_kgs:(NSNumber *)weight
{
    // convert kgs to lbs
	double w = weight.doubleValue * 2.2046;

    double changeDay = ( 1.5 * w * minutes.doubleValue / 60.0);
    double poundsPerMonth = ( changeDay * 30)/3500;
    double kilogramsPerMonth = poundsPerMonth * 0.452592;
    
    return [NSNumber numberWithDouble:kilogramsPerMonth];
}



+ (NSNumber *)Metric_caloriesDropped:(NSNumber *)calories
{
	double poundsPerDay = calories.doubleValue / 3500.0;
    double poundsPerMonth = poundsPerDay * 30;
    double kilogramsPerMonth = poundsPerMonth * 0.452592;
    
    return [NSNumber numberWithDouble:kilogramsPerMonth];
}



+ (NSNumber *)Metric_kilometersPer100Calories_weightKgs:(NSNumber *)weight
{
    
    double milesToACookie = 1.60934 * (100/(.5556 * weight.doubleValue));
    double milesToKilometers = milesToACookie * .60934;
    
    return [NSNumber numberWithDouble:milesToKilometers];
}



+ (NSNumber *)Metric_daysToReachGoal_caloriesPerDay:(NSNumber *)caloriesPerDay currentWeight_kgs:(NSNumber *)currentWeight goalWeight_kgs:(NSNumber *)goalWeight
{
    double weightChange = currentWeight.doubleValue - goalWeight.doubleValue;
    double calorieChange = weightChange * 1588;
    double daysToGoal = calorieChange/caloriesPerDay.doubleValue;
    
    return [NSNumber numberWithInt:(int)daysToGoal];
}

+ (NSString *)Metric_dateReachGoal_daysUntilGoal:(NSNumber *)days
{
	// calculate date from today + days to reach goal
	NSDate *today = [NSDate date];
	NSTimeInterval interval = 60 * 60 * 24 * days.intValue;
	NSDate *gd = [today dateByAddingTimeInterval:interval];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
   return [NSString stringWithFormat:@"%@",  [dateFormatter stringFromDate:gd]];
}



// Imperial
+ (NSNumber *)US_BMI_height_in:(NSNumber *)height weight_lbs:(NSNumber *)weight
{
    double bmi = (weight.doubleValue * 703) / (height.doubleValue * height.doubleValue);
    return [NSNumber numberWithDouble:bmi];
}


+ (NSNumber *)US_hipToWaist_waist_in:(NSNumber *)waist hips_in:(NSNumber *)hips
{
    double hw = waist.doubleValue/hips.doubleValue;
    return [NSNumber numberWithDouble:hw];
}



+ (NSNumber *)US_bodyFat_sexMF:(NSNumber *)sex height_in:(NSNumber *)height waist_in :(NSNumber *)waist weight_lbs:(NSNumber *)weight
{
    
    double bf;
    if ( sex == 0 ){        // male
        bf = ( (4.15 * waist.doubleValue) - (0.082 * weight.doubleValue) - 98.42 )/weight.doubleValue;
        
    }else{                  // female
        bf = ( (4.15 * waist.doubleValue) - (0.082 * weight.doubleValue) - 76.76 )/weight.doubleValue;
    }
    
    return [NSNumber numberWithDouble:bf];
}


+ (NSNumber *)US_bodySurfaceArea_height_in:(NSNumber *)height weight_lbs:(NSNumber *)weight
{
    double h = height.doubleValue * 2.54;
    double w = weight.doubleValue * 0.453592;
    
    // DuBois and DuBois
    double bsa1 = 0.007184 * pow(h, 0.725) * pow(w, 0.425);
    
    // Gehan and George
    double bsa2 = 0.0235 * pow(h, 0.42246) * pow(w, 0.51456);
    
    // Haycock
    double bsa3 = 0.024265 * pow(h, 0.3964) * pow(w, 0.5378);
    
    // Mosteller
    double bsa4 = sqrt( (h * w)/3600.0);
    
    // calculate ave guess and return in meters squared
    double bodySurfaceArea = (bsa1 + bsa2 + bsa3 + bsa4)/4.0;
    
    // convert meters squared to feet squared
    bodySurfaceArea *= 10.7639;
    
    return [NSNumber numberWithDouble:bodySurfaceArea];
}

+ (NSArray *)US_calories_height_ins:(NSNumber *)height weight_lbs:(NSNumber *)weight age_yrs:(NSNumber *)age sexMF:(NSNumber *)sex
{
    // calculate calories needed to reach goal weight
	int calories_needed;
    
    if ( sex.intValue == 0 ){			// male
        calories_needed = 66 + (6.23 * weight.doubleValue) + (12.7 * height.doubleValue) - (6.8 * age.intValue);
    }else{                              // female
        calories_needed = 655 + (4.35 * weight.doubleValue) + (4.7 * height.doubleValue) - (4.7 * age.intValue);
    }
    
    
    NSArray *array = @[[NSNumber numberWithDouble:calories_needed * 1.2],   // couch potato
                       [NSNumber numberWithDouble:calories_needed * 1.375], // office worker
                       [NSNumber numberWithDouble:calories_needed * 1.55],  // walker
                       [NSNumber numberWithDouble:calories_needed * 1.725]]; // athelete
    
    return  array;

}




+ (NSArray *)US_dailyCaloriesToWeight_daily_calories: (NSNumber *)dailyCalories age_yrs:(NSNumber *)age sexMF :(NSNumber *)sex height_ins:(NSNumber *)height
{
    
    double couch, office, walker, athlete;
    
    
	// estimated weight based on activity and sex
	if ( sex.integerValue == 0 ) {		// male
		couch =		( dailyCalories.doubleValue / 1.2 - 66 - 12.7 * height.doubleValue + 6.8 * age.integerValue )/6.23;
		office =	( dailyCalories.doubleValue / 1.375 - 66 - 12.7 * height.doubleValue + 6.8 * age.integerValue )/6.23;
		walker =	( dailyCalories.doubleValue / 1.55 - 66 - 12.7 * height.doubleValue + 6.8 * age.integerValue )/6.23;
		athlete =	( dailyCalories.doubleValue / 1.725 - 66 - 12.7 * height.doubleValue + 6.8 * age.integerValue )/6.23;
		
	}else{				// female
		couch =		( dailyCalories.doubleValue / 1.2 - 655 - 4.7 * height.doubleValue + 4.7 * age.integerValue)/4.35;
		office =	( dailyCalories.doubleValue / 1.375 - 655 - 4.7 * height.doubleValue + 4.7 * age.integerValue)/4.35;
		walker =	( dailyCalories.doubleValue / 1.55 - 655 - 4.7 * height.doubleValue + 4.7 * age.integerValue )/4.35;
		athlete =	( dailyCalories.doubleValue / 1.725 - 655 - 4.7 * height.doubleValue + 4.7 * age.integerValue )/4.35;
	}

    NSArray *array = @[[NSNumber numberWithDouble:couch],
                       [NSNumber numberWithDouble:office],
                       [NSNumber numberWithDouble:walker],
                       [NSNumber numberWithDouble:athlete]];
    
    return array;
}


+ (NSNumber *)US_milesPer100Calories_weightLbs:(NSNumber *)weight
{
    double milesToACookie = (100/(.5556 * weight.doubleValue));

    return [NSNumber numberWithDouble:milesToACookie];
}



+ (NSNumber *)US_walkingCalories_minutes:(NSNumber *)minutes weight_lbs:(NSNumber *)weight
{
    double changeDay = ( 1.05 * weight.doubleValue * minutes.doubleValue / 60.0 );
    double caloriesPerMonth = (changeDay * 30)/3500;
	
    return [NSNumber numberWithDouble:caloriesPerMonth];
}




+ (NSNumber *)US_runningCalories_minutes:(NSNumber *)minutes weight_lbs:(NSNumber *)weight
{
	double changeDay = ( 1.5 * weight.doubleValue * minutes.doubleValue / 60.0);
    double monthlyPounds = ( changeDay * 30)/3500;

    return [NSNumber numberWithDouble:monthlyPounds];
}





+ (NSNumber *)US_caloriesDropped:(NSNumber *)calories
{
    double changeDay = calories.doubleValue / 3500.0;
    double monthlyPounds = changeDay * 30;
    
    return [NSNumber numberWithDouble:monthlyPounds];
}



+ (NSNumber *)US_daysToReachGoal_caloriesPerDay:(NSNumber *)caloriesPerDay currentWeight_lbs:(NSNumber *)currentWeight goalWeight_lbs:(NSNumber *)goalWeight
{
    double weightChange = currentWeight.doubleValue - goalWeight.doubleValue;
    double calorieChange = weightChange * 3500;
    double daysToGoal = calorieChange/caloriesPerDay.doubleValue;
    
    return [NSNumber numberWithInt:(int)daysToGoal];
}



+ (NSString *)US_dateReachGoal_daysUntilGoal:(NSNumber *)days
{
	// calculate date from today + days to reach goal
	NSDate *today = [NSDate date];
	NSTimeInterval interval = 60 * 60 * 24 * days.intValue;
	NSDate *gd = [today dateByAddingTimeInterval:interval];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
    return [NSString stringWithFormat:@"%@",  [dateFormatter stringFromDate:gd]];
}

// conversions

+ (NSNumber *)metersPerSecondToMilesPerHour:(NSNumber *)metersPerSecond
{
    double mph = metersPerSecond.doubleValue * 2.23694;
    return [NSNumber numberWithDouble:mph];
}



+ (NSNumber *)metersPerSecondToKilometersPerHour:(NSNumber *)metersPerSecond
{
    double kph = metersPerSecond.doubleValue * 3.6;
    return [NSNumber numberWithDouble:kph];
}



+ (NSNumber *)metersToKilometers: (NSNumber *)meters
{
    double km = meters.doubleValue * 0.001;
    return [NSNumber numberWithDouble:km];
}


+ (NSNumber *)metersToMiles:(NSNumber *)meters
{
    double m = meters.doubleValue * 0.000621371;
    return [NSNumber numberWithDouble:m];
}




+ (NSNumber *)milesToMeters: (NSNumber *)miles
{
    double m = miles.doubleValue * 1609.34;
    return [NSNumber numberWithDouble:m];
}



+ (NSNumber *)kilometersToMeters: (NSNumber *)kilometers
{
    double k = kilometers.doubleValue * 1000.0;
    return [NSNumber numberWithDouble:k];
}





+ (NSArray *)secondsToHoursMinutesSeconds:(NSNumber *)s
{
    int hours = floor(s.intValue/3600);
    int minutes = floor((s.intValue - (hours * 3600)) / 60);
    int seconds = s.intValue - (minutes*60) - (hours*3600);
    
    return [NSArray arrayWithObjects:[NSNumber numberWithInt:hours],
            [NSNumber numberWithInt:minutes],
            [NSNumber numberWithInt:seconds], nil];
    
}



+ (NSArray *)metersPerSecondToMinutesAMile: (NSNumber *)metersPerSecond
{
    double pace = metersPerSecond.doubleValue * [self secondsPerMinute].doubleValue * [self milesPerMeter].doubleValue;
    NSNumber *seconds = [NSNumber numberWithDouble:(1.0/pace * 60.0)];
    
    return [self secondsToHoursMinutesSeconds:seconds];
}


+ (NSArray *)metersPerSecondToMinutesAKilometer:(NSNumber *)metersPerSecond
{
    double pace =  metersPerSecond.doubleValue * [self secondsPerMinute].doubleValue * [self kilometersPerMeter].doubleValue;
    NSNumber *seconds = [NSNumber numberWithDouble:(1.0/pace * 60.0)];
    
    return [self secondsToHoursMinutesSeconds:seconds];
}


+ (NSNumber *)inchesToCm: (NSNumber *)inches { return [NSNumber numberWithDouble:(inches.doubleValue * 2.54)]; }
+ (NSNumber *)cmToInches: (NSNumber *)cm {return [NSNumber numberWithDouble:(cm.doubleValue * 0.393701)];  }

+ (NSNumber *)poundsToKilograms: (NSNumber *)pounds { return [NSNumber numberWithDouble:(pounds.doubleValue * .4539)]; }
+ (NSNumber *)kilogramsToPounds: (NSNumber *)kilograms { return [NSNumber numberWithDouble:(kilograms.doubleValue * 2.205)]; }

+ (NSNumber *)secondsPerHour { return [NSNumber numberWithDouble:(60.0 * 60.0)]; }
+ (NSNumber *)secondsPerMinute { return [NSNumber numberWithDouble:60.0]; }

+ (NSNumber *)kilometersPerMeter { return [NSNumber numberWithDouble:(1.0/1000.0)]; }
+ (NSNumber *)milesPerMeter { return [NSNumber numberWithDouble:(1.0/1609.34)]; }

+ (NSNumber *)inchesToMeters: (NSNumber *)inches { return [NSNumber numberWithDouble:(inches.doubleValue * 0.0254)]; }
+ (NSNumber *)metersToInches: (NSNumber *)meters { return [NSNumber numberWithDouble:(meters.doubleValue * 39.3701)]; }




@end
