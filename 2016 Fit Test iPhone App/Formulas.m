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

+ (NSNumber *)Estimated_VO2Max_age:(NSNumber *)age restingPulse:(NSNumber *)restingPulse
{
    double estimatedVO2 = 15 * ( 207 - (.7 * age.intValue) ) / restingPulse.intValue;
    return [NSNumber numberWithDouble:estimatedVO2];
}


+ (NSString *)EstimatedAerobicAgeFemale:(NSNumber *)vo2;
{
    int estimated = 0;
    double estimatedVO2 = vo2.doubleValue;

    if ( estimatedVO2 <= 27.0){ estimated = 70;
    }else if ( estimatedVO2 <= 27.8 ){ estimated = 69;
    }else if ( estimatedVO2 <= 28.6 ){ estimated = 68;
    }else if ( estimatedVO2 <= 29.4 ){ estimated = 67;
    }else if ( estimatedVO2 <= 30.2 ){ estimated = 66;
    }else if ( estimatedVO2 <= 31.0 ){ estimated = 65;
    }else if ( estimatedVO2 <= 31.3 ){ estimated = 64;
    }else if ( estimatedVO2 <= 31.6 ){ estimated = 63;
    }else if ( estimatedVO2 <= 31.9 ){ estimated = 62;
    }else if ( estimatedVO2 <= 32.2 ){ estimated = 61;
    }else if ( estimatedVO2 <= 32.5 ){ estimated = 60;
    }else if ( estimatedVO2 <= 32.8 ){ estimated = 59;
    }else if ( estimatedVO2 <= 33.1 ){ estimated = 58;
    }else if ( estimatedVO2 <= 33.4 ){ estimated = 57;
    }else if ( estimatedVO2 <= 33.7 ){ estimated = 56;
    }else if ( estimatedVO2 <= 34.0 ){ estimated = 55;
    }else if ( estimatedVO2 <= 34.4 ){ estimated = 54;
    }else if ( estimatedVO2 <= 34.8 ){ estimated = 53;
    }else if ( estimatedVO2 <= 35.2 ){ estimated = 52;
    }else if ( estimatedVO2 <= 35.6 ){ estimated = 51;
    }else if ( estimatedVO2 <= 36.0 ){ estimated = 50;
    }else if ( estimatedVO2 <= 36.4 ){ estimated = 49;
    }else if ( estimatedVO2 <= 36.8 ){ estimated = 48;
    }else if ( estimatedVO2 <= 37.2 ){ estimated = 47;
    }else if ( estimatedVO2 <= 37.6 ){ estimated = 46;
    }else if ( estimatedVO2 <= 38.0 ){ estimated = 45;
    }else if ( estimatedVO2 <= 38.2 ){ estimated = 44;
    }else if ( estimatedVO2 <= 38.4 ){ estimated = 43;
    }else if ( estimatedVO2 <= 38.6 ){ estimated = 42;
    }else if ( estimatedVO2 <= 38.8 ){ estimated = 41;
    }else if ( estimatedVO2 <= 39.0 ){ estimated = 40;
    }else if ( estimatedVO2 <= 39.2 ){ estimated = 39;
    }else if ( estimatedVO2 <= 39.4 ){ estimated = 38;
    }else if ( estimatedVO2 <= 39.6 ){ estimated = 37;
    }else if ( estimatedVO2 <= 39.8 ){ estimated = 36;
    }else if ( estimatedVO2 <= 40.0 ){ estimated = 35;
    }else if ( estimatedVO2 <= 40.3 ){ estimated = 34;
    }else if ( estimatedVO2 <= 40.6 ){ estimated = 33;
    }else if ( estimatedVO2 <= 40.9 ){ estimated = 32;
    }else if ( estimatedVO2 <= 41.2 ){ estimated = 31;
    }else if ( estimatedVO2 <= 41.5 ){ estimated = 30;
    }else if ( estimatedVO2 <= 41.8 ){ estimated = 29;
    }else if ( estimatedVO2 <= 42.1 ){ estimated = 28;
    }else if ( estimatedVO2 <= 42.4 ){ estimated = 27;
    }else if ( estimatedVO2 <= 42.7 ){ estimated = 26;
    }else{ estimated = 25; }
    
    
   
    
    return [NSString stringWithFormat:@"%d", estimated];
}






+ (NSString *)EstimatedAerobicAgeMale:(NSNumber *)vo2;
{
    int estimated = 0;
    double estimatedVO2 = vo2.doubleValue;
    
    if ( estimatedVO2 <= 34.0){ estimated = 70;
    }else if ( estimatedVO2 <= 35.0 ){ estimated = 69;
    }else if ( estimatedVO2 <= 36.0 ){ estimated = 68;
    }else if ( estimatedVO2 <= 37.0 ){ estimated = 67;
    }else if ( estimatedVO2 <= 38.0 ){ estimated = 66;
    }else if ( estimatedVO2 <= 39.0 ){ estimated = 65;
    }else if ( estimatedVO2 <= 39.3 ){ estimated = 64;
    }else if ( estimatedVO2 <= 39.6 ){ estimated = 63;
    }else if ( estimatedVO2 <= 39.9 ){ estimated = 62;
    }else if ( estimatedVO2 <= 40.2 ){ estimated = 61;
    }else if ( estimatedVO2 <= 40.5 ){ estimated = 60;
    }else if ( estimatedVO2 <= 30.8 ){ estimated = 59;
    }else if ( estimatedVO2 <= 41.1 ){ estimated = 58;
    }else if ( estimatedVO2 <= 41.4 ){ estimated = 57;
    }else if ( estimatedVO2 <= 41.7 ){ estimated = 56;
    }else if ( estimatedVO2 <= 42.0 ){ estimated = 55;
    }else if ( estimatedVO2 <= 42.5 ){ estimated = 54;
    }else if ( estimatedVO2 <= 43.0 ){ estimated = 53;
    }else if ( estimatedVO2 <= 44.0 ){ estimated = 52;
    }else if ( estimatedVO2 <= 44.5 ){ estimated = 51;
    }else if ( estimatedVO2 <= 45.0 ){ estimated = 50;
    }else if ( estimatedVO2 <= 45.5 ){ estimated = 49;
    }else if ( estimatedVO2 <= 46.0 ){ estimated = 48;
    }else if ( estimatedVO2 <= 46.0 ){ estimated = 47;
    }else if ( estimatedVO2 <= 46.5 ){ estimated = 46;
    }else if ( estimatedVO2 <= 47.0 ){ estimated = 45;
    }else if ( estimatedVO2 <= 38.2 ){ estimated = 44;
    }else if ( estimatedVO2 <= 38.4 ){ estimated = 43;
    }else if ( estimatedVO2 <= 38.6 ){ estimated = 42;
    }else if ( estimatedVO2 <= 38.8 ){ estimated = 41;
    }else if ( estimatedVO2 <= 48.0 ){ estimated = 40;
    }else if ( estimatedVO2 <= 48.0 ){ estimated = 39;
    }else if ( estimatedVO2 <= 48.2 ){ estimated = 38;
    }else if ( estimatedVO2 <= 48.4 ){ estimated = 37;
    }else if ( estimatedVO2 <= 48.6 ){ estimated = 36;
    }else if ( estimatedVO2 <= 48.8 ){ estimated = 35;
    }else if ( estimatedVO2 <= 49.0 ){ estimated = 34;
    }else if ( estimatedVO2 <= 49.5 ){ estimated = 33;
    }else if ( estimatedVO2 <= 50.0 ){ estimated = 32;
    }else if ( estimatedVO2 <= 50.5 ){ estimated = 31;
    }else if ( estimatedVO2 <= 51.0 ){ estimated = 30;
    }else if ( estimatedVO2 <= 51.5 ){ estimated = 29;
    }else if ( estimatedVO2 <= 52.0 ){ estimated = 28;
    }else if ( estimatedVO2 <= 52.5 ){ estimated = 27;
    }else if ( estimatedVO2 <= 53.5 ){ estimated = 26;
    }else { estimated = 25;
    }
    
    return [NSString stringWithFormat:@"%d", estimated];

}


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
    
    double heightInMeters = height.doubleValue/100.0;
    double bmi = weight.doubleValue / (heightInMeters * heightInMeters);
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
    double h = height.doubleValue * .3937;
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
    couch /= 2.205;
    walker /=2.205;
    athlete /= 2.205;
    office /= 2.205;


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



+ (NSNumber *)Metric_CooperTest_12MinuteRun_kms:(NSNumber *)distance
{
    double miles = [[Formulas kilometersToMiles:distance] doubleValue];
    double cooperTest = 35.97 * miles - 11.29;
    return [NSNumber numberWithDouble:cooperTest];
}








+ (NSString *)Metric_average10KWinningPace_sex:(NSNumber *)sex age:(NSNumber *)age
{
    // 0 for male, 1 for female
    if ( sex.intValue == 0 ){
        if ( age.intValue <= 20){
            return [NSString stringWithFormat:@"5:04"];
        }else if (age.intValue <=21){
            return [NSString stringWithFormat:@"5:05"];
        }else if (age.intValue <=22){
            return [NSString stringWithFormat:@"5:05"];
        }else if (age.intValue <=23){
            return [NSString stringWithFormat:@"5:06"];
        }else if (age.intValue <=24){
            return [NSString stringWithFormat:@"5:06"];
        }else if (age.intValue <=25){
            return [NSString stringWithFormat:@"5:07"];
        }else if (age.intValue <=26){
            return [NSString stringWithFormat:@"5:08"];
        }else if (age.intValue <=27){
            return [NSString stringWithFormat:@"5:09"];
        }else if (age.intValue <=28){
            return [NSString stringWithFormat:@"5:10"];
        }else if (age.intValue <=29){
            return [NSString stringWithFormat:@"5:11"];
        }else if (age.intValue <=30){
            return [NSString stringWithFormat:@"5:12"];
        }else if (age.intValue <=31){
            return [NSString stringWithFormat:@"5:13"];
        }else if (age.intValue <=32){
            return [NSString stringWithFormat:@"5:14"];
        }else if (age.intValue <=33){
            return [NSString stringWithFormat:@"5:15"];
        }else if (age.intValue <=34){
            return [NSString stringWithFormat:@"5:16"];
        }else if (age.intValue <=35){
            return [NSString stringWithFormat:@"5:17"];
        }else if (age.intValue <=36){
            return [NSString stringWithFormat:@"5:18"];
        }else if (age.intValue <=37){
            return [NSString stringWithFormat:@"5:18"];
        }else if (age.intValue <=38){
            return [NSString stringWithFormat:@"5:19"];
        }else if (age.intValue <=39){
            return [NSString stringWithFormat:@"5:19"];
        }else if (age.intValue <=40){
            return [NSString stringWithFormat:@"5:20"];
        }else if (age.intValue <=41){
            return [NSString stringWithFormat:@"5:23"];
        }else if (age.intValue <=42){
            return [NSString stringWithFormat:@"5:24"];
        }else if (age.intValue <=43){
            return [NSString stringWithFormat:@"5:26"];
        }else if (age.intValue <=44){
            return [NSString stringWithFormat:@"5:27"];
        }else if (age.intValue <=45){
            return [NSString stringWithFormat:@"5:28"];
        }else if (age.intValue <=46){
            return [NSString stringWithFormat:@"5:29"];
        }else if (age.intValue <=47){
            return [NSString stringWithFormat:@"5:30"];
        }else if (age.intValue <=48){
            return [NSString stringWithFormat:@"5:32"];
        }else if (age.intValue <=49){
            return [NSString stringWithFormat:@"5:33"];
        }else if (age.intValue <=50){
            return [NSString stringWithFormat:@"5:34"];
        }else if (age.intValue <=51){
            return [NSString stringWithFormat:@"5:35"];
        }else if (age.intValue <=52){
            return [NSString stringWithFormat:@"5:36"];
        }else if (age.intValue <=53){
            return [NSString stringWithFormat:@"5:38"];
        }else if (age.intValue <=54){
            return [NSString stringWithFormat:@"5:40"];
        }else if (age.intValue <=55){
            return [NSString stringWithFormat:@"5:42"];
        }else if (age.intValue <=56){
            return [NSString stringWithFormat:@"5:44"];
        }else if (age.intValue <=57){
            return [NSString stringWithFormat:@"5:48"];
        }else if (age.intValue <=58){
            return [NSString stringWithFormat:@"5:50"];
        }else if (age.intValue <=59){
            return [NSString stringWithFormat:@"5:52"];
        }else if (age.intValue <=60){
            return [NSString stringWithFormat:@"5:54"];
        }else if (age.intValue <=61){
            return [NSString stringWithFormat:@"5:57"];
        }else if (age.intValue <=62){
            return [NSString stringWithFormat:@"6:00"];
        }else if (age.intValue <=63){
            return [NSString stringWithFormat:@"6:03"];
        }else if (age.intValue <=64){
            return [NSString stringWithFormat:@"6:06"];
        }else if (age.intValue <=65){
            return [NSString stringWithFormat:@"6:09"];
        }else if (age.intValue <=66){
            return [NSString stringWithFormat:@"6:12"];
        }else if (age.intValue <=67){
            return [NSString stringWithFormat:@"6:18"];
        }else if (age.intValue <=68){
            return [NSString stringWithFormat:@"6:20"];
        }else if (age.intValue <=69){
            return [NSString stringWithFormat:@"6:24"];
        }else if (age.intValue <=70){
            return [NSString stringWithFormat:@"6:25"];
        }else{
            return [NSString stringWithFormat:@"I only have pace data for ages 20-70"];
        }
        
    }else{
        if ( age.intValue <= 20){
            return [NSString stringWithFormat:@"5:54"];
        }else if (age.intValue <=21){
            return [NSString stringWithFormat:@"5:56"];
        }else if (age.intValue <=22){
            return [NSString stringWithFormat:@"5:58"];
        }else if (age.intValue <=23){
            return [NSString stringWithFormat:@"6:00"];
        }else if (age.intValue <=24){
            return [NSString stringWithFormat:@"6:03"];
        }else if (age.intValue <=25){
            return [NSString stringWithFormat:@"6:06"];
        }else if (age.intValue <=26){
            return [NSString stringWithFormat:@"6:09"];
        }else if (age.intValue <=27){
            return [NSString stringWithFormat:@"6:12"];
        }else if (age.intValue <=28){
            return [NSString stringWithFormat:@"6:12"];
        }else if (age.intValue <=29){
            return [NSString stringWithFormat:@"6:13"];
        }else if (age.intValue <=30){
            return [NSString stringWithFormat:@"6:13"];
        }else if (age.intValue <=31){
            return [NSString stringWithFormat:@"6:14"];
        }else if (age.intValue <=32){
            return [NSString stringWithFormat:@"6:14"];
        }else if (age.intValue <=33){
            return [NSString stringWithFormat:@"6:15"];
        }else if (age.intValue <=34){
            return [NSString stringWithFormat:@"6:15"];
        }else if (age.intValue <=35){
            return [NSString stringWithFormat:@"6:16"];
        }else if (age.intValue <=36){
            return [NSString stringWithFormat:@"6:16"];
        }else if (age.intValue <=37){
            return [NSString stringWithFormat:@"6:16"];
        }else if (age.intValue <=38){
            return [NSString stringWithFormat:@"6:17"];
        }else if (age.intValue <=39){
            return [NSString stringWithFormat:@"6:17"];
        }else if (age.intValue <=40){
            return [NSString stringWithFormat:@"6:18"];
        }else if (age.intValue <=41){
            return [NSString stringWithFormat:@"6:18"];
        }else if (age.intValue <=42){
            return [NSString stringWithFormat:@"6:19"];
        }else if (age.intValue <=43){
            return [NSString stringWithFormat:@"6:20"];
        }else if (age.intValue <=44){
            return [NSString stringWithFormat:@"6:21"];
        }else if (age.intValue <=45){
            return [NSString stringWithFormat:@"6:22"];
        }else if (age.intValue <=46){
            return [NSString stringWithFormat:@"6:23"];
        }else if (age.intValue <=47){
            return [NSString stringWithFormat:@"6:24"];
        }else if (age.intValue <=48){
            return [NSString stringWithFormat:@"6:25"];
        }else if (age.intValue <=49){
            return [NSString stringWithFormat:@"6:26"];
        }else if (age.intValue <=50){
            return [NSString stringWithFormat:@"6:27"];
        }else if (age.intValue <=51){
            return [NSString stringWithFormat:@"6:27"];
        }else if (age.intValue <=52){
            return [NSString stringWithFormat:@"6:28"];
        }else if (age.intValue <=53){
            return [NSString stringWithFormat:@"6:29"];
        }else if (age.intValue <=54){
            return [NSString stringWithFormat:@"6:30"];
        }else if (age.intValue <=55){
            return [NSString stringWithFormat:@"6:36"];
        }else if (age.intValue <=56){
            return [NSString stringWithFormat:@"6:42"];
        }else if (age.intValue <=57){
            return [NSString stringWithFormat:@"6:48"];
        }else if (age.intValue <=58){
            return [NSString stringWithFormat:@"6:54"];
        }else if (age.intValue <=59){
            return [NSString stringWithFormat:@"7:00"];
        }else if (age.intValue <=60){
            return [NSString stringWithFormat:@"7:06"];
        }else if (age.intValue <=61){
            return [NSString stringWithFormat:@"7:12"];
        }else if (age.intValue <=62){
            return [NSString stringWithFormat:@"7:18"];
        }else if (age.intValue <=63){
            return [NSString stringWithFormat:@"7:20"];
        }else if (age.intValue <=64){
            return [NSString stringWithFormat:@"7:24"];
        }else if (age.intValue <=65){
            return [NSString stringWithFormat:@"7:30"];
        }else if (age.intValue <=66){
            return [NSString stringWithFormat:@"7:37"];
        }else if (age.intValue <=67){
            return [NSString stringWithFormat:@"7:49"];
        }else if (age.intValue <=68){
            return [NSString stringWithFormat:@"7:55"];
        }else if (age.intValue <=69){
            return [NSString stringWithFormat:@"8:01"];
        }else if (age.intValue <=70){
            return [NSString stringWithFormat:@"8:07"];
        }else{
            return [NSString stringWithFormat:@"I only have pace data for age 20-70"];
        }
        
    }
}




+ (NSString *)US_average10KWinningPace_sex:(NSNumber *)sex age:(NSNumber *)age
{
    // 0 for male, 1 for female
    if ( sex.intValue == 0 ){
        if ( age.intValue <= 20){
            return [NSString stringWithFormat:@"8:10"];
        }else if (age.intValue <=21){
            return [NSString stringWithFormat:@"8:12"];
        }else if (age.intValue <=22){
            return [NSString stringWithFormat:@"8:13"];
        }else if (age.intValue <=23){
            return [NSString stringWithFormat:@"8:14"];
        }else if (age.intValue <=24){
            return [NSString stringWithFormat:@"8:15"];
        }else if (age.intValue <=25){
            return [NSString stringWithFormat:@"8:16"];
        }else if (age.intValue <=26){
            return [NSString stringWithFormat:@"8:17"];
        }else if (age.intValue <=27){
            return [NSString stringWithFormat:@"8:18"];
        }else if (age.intValue <=28){
            return [NSString stringWithFormat:@"8:20"];
        }else if (age.intValue <=29){
            return [NSString stringWithFormat:@"8:21"];
        }else if (age.intValue <=30){
            return [NSString stringWithFormat:@"8:23"];
        }else if (age.intValue <=31){
            return [NSString stringWithFormat:@"8:24"];
        }else if (age.intValue <=32){
            return [NSString stringWithFormat:@"8:26"];
        }else if (age.intValue <=33){
            return [NSString stringWithFormat:@"8:27"];
        }else if (age.intValue <=34){
            return [NSString stringWithFormat:@"8:29"];
        }else if (age.intValue <=35){
            return [NSString stringWithFormat:@"8:30"];
        }else if (age.intValue <=36){
            return [NSString stringWithFormat:@"8:32"];
        }else if (age.intValue <=37){
            return [NSString stringWithFormat:@"8:34"];
        }else if (age.intValue <=38){
            return [NSString stringWithFormat:@"8:35"];
        }else if (age.intValue <=39){
            return [NSString stringWithFormat:@"8:37"];
        }else if (age.intValue <=40){
            return [NSString stringWithFormat:@"8:39"];
        }else if (age.intValue <=41){
            return [NSString stringWithFormat:@"8:41"];
        }else if (age.intValue <=42){
            return [NSString stringWithFormat:@"8:43"];
        }else if (age.intValue <=43){
            return [NSString stringWithFormat:@"8:45"];
        }else if (age.intValue <=44){
            return [NSString stringWithFormat:@"8:47"];
        }else if (age.intValue <=45){
            return [NSString stringWithFormat:@"8:48"];
        }else if (age.intValue <=46){
            return [NSString stringWithFormat:@"8:50"];
        }else if (age.intValue <=47){
            return [NSString stringWithFormat:@"8:52"];
        }else if (age.intValue <=48){
            return [NSString stringWithFormat:@"8:54"];
        }else if (age.intValue <=49){
            return [NSString stringWithFormat:@"8:55"];
        }else if (age.intValue <=50){
            return [NSString stringWithFormat:@"8:56"];
        }else if (age.intValue <=51){
            return [NSString stringWithFormat:@"8:58"];
        }else if (age.intValue <=52){
            return [NSString stringWithFormat:@"9:00"];
        }else if (age.intValue <=53){
            return [NSString stringWithFormat:@"9:04"];
        }else if (age.intValue <=54){
            return [NSString stringWithFormat:@"9:08"];
        }else if (age.intValue <=55){
            return [NSString stringWithFormat:@"9:12"];
        }else if (age.intValue <=56){
            return [NSString stringWithFormat:@"9:16"];
        }else if (age.intValue <=57){
            return [NSString stringWithFormat:@"9:20"];
        }else if (age.intValue <=58){
            return [NSString stringWithFormat:@"9:24"];
        }else if (age.intValue <=59){
            return [NSString stringWithFormat:@"9:28"];
        }else if (age.intValue <=60){
            return [NSString stringWithFormat:@"9:32"];
        }else if (age.intValue <=61){
            return [NSString stringWithFormat:@"9:37"];
        }else if (age.intValue <=62){
            return [NSString stringWithFormat:@"9:42"];
        }else if (age.intValue <=63){
            return [NSString stringWithFormat:@"9:47"];
        }else if (age.intValue <=64){
            return [NSString stringWithFormat:@"9:52"];
        }else if (age.intValue <=65){
            return [NSString stringWithFormat:@"9:57"];
        }else if (age.intValue <=66){
            return [NSString stringWithFormat:@"10:02"];
        }else if (age.intValue <=67){
            return [NSString stringWithFormat:@"10:07"];
        }else if (age.intValue <=68){
            return [NSString stringWithFormat:@"10:12"];
        }else if (age.intValue <=69){
            return [NSString stringWithFormat:@"10:17"];
        }else if (age.intValue <=70){
            return [NSString stringWithFormat:@"10:22"];
        }else{
            return [NSString stringWithFormat:@"I only have pace data for ages 20-70"];
        }
        
    }else{
        if ( age.intValue <= 20){
            return [NSString stringWithFormat:@"9:30"];
        }else if (age.intValue <=21){
            return [NSString stringWithFormat:@"9:34"];
        }else if (age.intValue <=22){
            return [NSString stringWithFormat:@"9:38"];
        }else if (age.intValue <=23){
            return [NSString stringWithFormat:@"9:42"];
        }else if (age.intValue <=24){
            return [NSString stringWithFormat:@"9:46"];
        }else if (age.intValue <=25){
            return [NSString stringWithFormat:@"9:50"];
        }else if (age.intValue <=26){
            return [NSString stringWithFormat:@"9:55"];
        }else if (age.intValue <=27){
            return [NSString stringWithFormat:@"10:00"];
        }else if (age.intValue <=28){
            return [NSString stringWithFormat:@"10:01"];
        }else if (age.intValue <=29){
            return [NSString stringWithFormat:@"10:02"];
        }else if (age.intValue <=30){
            return [NSString stringWithFormat:@"10:03"];
        }else if (age.intValue <=31){
            return [NSString stringWithFormat:@"10:04"];
        }else if (age.intValue <=32){
            return [NSString stringWithFormat:@"10:05"];
        }else if (age.intValue <=33){
            return [NSString stringWithFormat:@"10:05"];
        }else if (age.intValue <=34){
            return [NSString stringWithFormat:@"10:06"];
        }else if (age.intValue <=35){
            return [NSString stringWithFormat:@"10:06"];
        }else if (age.intValue <=36){
            return [NSString stringWithFormat:@"10:07"];
        }else if (age.intValue <=37){
            return [NSString stringWithFormat:@"10:07"];
        }else if (age.intValue <=38){
            return [NSString stringWithFormat:@"10:08"];
        }else if (age.intValue <=39){
            return [NSString stringWithFormat:@"10:08"];
        }else if (age.intValue <=40){
            return [NSString stringWithFormat:@"10:09"];
        }else if (age.intValue <=41){
            return [NSString stringWithFormat:@"10:09"];
        }else if (age.intValue <=42){
            return [NSString stringWithFormat:@"10:10"];
        }else if (age.intValue <=43){
            return [NSString stringWithFormat:@"10:12"];
        }else if (age.intValue <=44){
            return [NSString stringWithFormat:@"10:15"];
        }else if (age.intValue <=45){
            return [NSString stringWithFormat:@"10:16"];
        }else if (age.intValue <=46){
            return [NSString stringWithFormat:@"10:18"];
        }else if (age.intValue <=47){
            return [NSString stringWithFormat:@"10:20"];
        }else if (age.intValue <=48){
            return [NSString stringWithFormat:@"10:21"];
        }else if (age.intValue <=49){
            return [NSString stringWithFormat:@"10:22"];
        }else if (age.intValue <=50){
            return [NSString stringWithFormat:@"10:23"];
        }else if (age.intValue <=51){
            return [NSString stringWithFormat:@"10:24"];
        }else if (age.intValue <=52){
            return [NSString stringWithFormat:@"10:25"];
        }else if (age.intValue <=53){
            return [NSString stringWithFormat:@"10:27"];
        }else if (age.intValue <=54){
            return [NSString stringWithFormat:@"10:30"];
        }else if (age.intValue <=55){
            return [NSString stringWithFormat:@"10:40"];
        }else if (age.intValue <=56){
            return [NSString stringWithFormat:@"10:50"];
        }else if (age.intValue <=57){
            return [NSString stringWithFormat:@"11:00"];
        }else if (age.intValue <=58){
            return [NSString stringWithFormat:@"11:05"];
        }else if (age.intValue <=59){
            return [NSString stringWithFormat:@"11:15"];
        }else if (age.intValue <=60){
            return [NSString stringWithFormat:@"11:25"];
        }else if (age.intValue <=61){
            return [NSString stringWithFormat:@"11:35"];
        }else if (age.intValue <=62){
            return [NSString stringWithFormat:@"11:45"];
        }else if (age.intValue <=63){
            return [NSString stringWithFormat:@"11:50"];
        }else if (age.intValue <=64){
            return [NSString stringWithFormat:@"11:55"];
        }else if (age.intValue <=65){
            return [NSString stringWithFormat:@"12:00"];
        }else if (age.intValue <=66){
            return [NSString stringWithFormat:@"12:15"];
        }else if (age.intValue <=67){
            return [NSString stringWithFormat:@"12:30"];
        }else if (age.intValue <=68){
            return [NSString stringWithFormat:@"12:45"];
        }else if (age.intValue <=69){
            return [NSString stringWithFormat:@"12:52"];
        }else if (age.intValue <=70){
            return [NSString stringWithFormat:@"13:00"];
        }else{
            return [NSString stringWithFormat:@"I only have pace data for age 20-70"];
        }
        
    }
    
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


+ (NSNumber *)US_CooperTest_12MinuteRun_miles:(NSNumber *)distance
{
    double cooperTest = 35.97 * distance.doubleValue - 11.29;
    return [NSNumber numberWithDouble:cooperTest];
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


+ (NSNumber *)kilometersToMiles: (NSNumber *)kilometers { return [NSNumber numberWithDouble:(kilometers.doubleValue * 0.621371)]; }


@end
