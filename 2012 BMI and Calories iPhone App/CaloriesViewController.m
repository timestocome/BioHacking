//
//  CaloriesViewController.m
//  bmicalories
//
//  Created by Linda Cobb on 6/25/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import "CaloriesViewController.h"
#import "Formulas.h"
#import "PickerArrays.h"



@implementation CaloriesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {}
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _defaults = [NSUserDefaults standardUserDefaults];
    [self setupView];
    [self calculate];
}



- (void)viewWillAppear:(BOOL)animated
{
    [self setupView];
    [self calculate];
}


- (void)setupView
{
    // get last known user values
    units = [[self.defaults objectForKey:@"units"] integerValue];
    sex = [[self.defaults objectForKey:@"sex"] integerValue];
    age = [[self.defaults objectForKey:@"age"] integerValue];
    height = [[self.defaults objectForKey:@"height"] doubleValue];
    goalWeight = [[self.defaults objectForKey:@"goalWeight"] doubleValue];
    currentWeight = [[self.defaults objectForKey:@"currentWeight"] doubleValue];
    
    // fatch arrays for picker
    if ( units == 0 ){ // US/Imperial units
        
        _sexArray = [NSArray arrayWithArray:[PickerArrays sexArray]];
        _ageArray = [NSArray arrayWithArray:[PickerArrays ageArray]];
        _heightArray = [NSArray arrayWithArray:[PickerArrays imperialHeightArray]];
        _currentWeightArray = [NSArray arrayWithArray:[PickerArrays imperialWeightArray]];
        _goalWeightArray = [NSArray arrayWithArray:[PickerArrays imperialWeightArray]];
        
        // set picker labels
        [self.heightLabel setText:@"Hght in"];
        [self.currentWeightLabel setText:@"Wgt lbs"];
        [self.goalWeightLabel setText:@"Goal lbs"];
        
    }else{              // metric units
        _sexArray = [NSArray arrayWithArray:[PickerArrays sexArray]];
        _ageArray = [NSArray arrayWithArray:[PickerArrays ageArray]];
        _heightArray = [NSArray arrayWithArray:[PickerArrays metricHeightArray]];
        _currentWeightArray = [NSArray arrayWithArray:[PickerArrays metricWeightArray]];
        _goalWeightArray = [NSArray arrayWithArray:[PickerArrays metricWeightArray]];
        
        // set picker labels
        [self.heightLabel setText:@"Hght cm"];
        [self.currentWeightLabel setText:@"Wgt kgs"];
        [self.goalWeightLabel setText:@"Goal kgs"];

    }
    
    // set picker view to user's last values
    //  - (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated
    [self.pickerView selectRow:sex inComponent:0 animated:YES];
    
    int row = [self.ageArray indexOfObject:[NSNumber numberWithInt:age]];
    if ( (row > 0) && (row < self.ageArray.count)  ){ [self.pickerView selectRow:row inComponent:1 animated:YES]; }
    
    row = [self.heightArray indexOfObject:[NSNumber numberWithDouble:height]];
    if ( (row > 0) && (row < self.heightArray.count))[self.pickerView selectRow:row inComponent:2 animated:YES];
    
    row = [self.currentWeightArray indexOfObject:[NSNumber numberWithDouble:currentWeight]];
    if ( (row > 0) && (row < self.currentWeightArray.count ) ){ [self.pickerView selectRow:row inComponent:3 animated:YES]; }
    
    row = [self.goalWeightArray indexOfObject:[NSNumber numberWithDouble:goalWeight]];
    if ( (row > 0) && (row < self.goalWeightArray.count) ){ [self.pickerView selectRow:row inComponent:4 animated:YES]; }
}




- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ( component == 0 ){          // sex
        sex = row;                  // 0 for M, 1 for F
        [self.defaults setObject:[NSNumber numberWithInt:sex] forKey:@"sex"];
    }else if ( component == 1){     // age
        age = [[self.ageArray objectAtIndex:row] intValue];
        [self.defaults setObject:[NSNumber numberWithInt:age] forKey:@"age"];
    }else if ( component == 2){     // height
        height = [[self.heightArray objectAtIndex:row] doubleValue];
        [self.defaults setObject:[NSNumber numberWithDouble:height] forKey:@"height"];
    }else if ( component == 3){     // current weight
        currentWeight = [[self.currentWeightArray objectAtIndex:row] doubleValue];
        [self.defaults setObject:[NSNumber numberWithDouble:currentWeight] forKey:@"currentWeight"];
    }else if ( component == 4){     // goal weight
        goalWeight = [[self.goalWeightArray objectAtIndex:row] doubleValue];
        [self.defaults setObject:[NSNumber numberWithDouble:goalWeight] forKey:@"goalWeight"];
    }
    
    [self calculate];
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ( component == 0 ){
        return [self.sexArray objectAtIndex:row];
    }else if ( component == 1 ){
        return [NSString stringWithFormat:@"%@", [self.ageArray objectAtIndex:row]];
    }else if ( component == 2 ){
        return [NSString stringWithFormat:@"%.1lf", [[self.heightArray objectAtIndex:row] doubleValue]];
    }else if ( component == 3 ){
        return [NSString stringWithFormat:@"%.1lf", [[self.currentWeightArray objectAtIndex:row] doubleValue]];
    }else{
        return [NSString stringWithFormat:@"%.1lf", [[self.goalWeightArray objectAtIndex:row] doubleValue]];
    }
}



- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    float width;
    
    if ( component == 0 ){
        width = 40.0;
    }else if ( component == 1 ){
        width = 40.0;
    }else if ( component == 2 ){
        width = 70.0;
    }else if ( component == 3 ){
        width = 80.0;
    }else{
        width = 80.0;
    }
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        width *= 1.5;
    }
    return width;
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ( component == 0 ){
        return [self.sexArray count];
    }else if ( component == 1 ){
        return [self.ageArray count];
    }else if ( component == 2 ){
        return [self.heightArray count];
    }else if ( component == 3 ){
        return [self.currentWeightArray count];
    }else{
        return [self.goalWeightArray count];
    }
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 5;
}


- (void)calculate
{
    
    if ( units == 0 ){      // imperial/US
        
        // get current calorie intake
        NSArray *currentCalories = [Formulas US_calories_height_ins:[NSNumber numberWithDouble:height] weight_lbs:[NSNumber numberWithDouble:currentWeight] age_yrs:[NSNumber numberWithInt:age] sexMF:[NSNumber numberWithInt:sex]];
        
        [self.currentCouchPotatoLabel setText:[NSString stringWithFormat:@"%.0lf", [[currentCalories objectAtIndex:0] doubleValue]]];
        [self.currentOfficeWorkerLabel setText:[NSString stringWithFormat:@"%.0lf", [[currentCalories objectAtIndex:1] doubleValue]]];
        [self.currentDailyWalkerLabel setText:[NSString stringWithFormat:@"%.0lf", [[currentCalories objectAtIndex:2] doubleValue]]];
        [self.currentAthleteLabel setText:[NSString stringWithFormat:@"%.0lf", [[currentCalories objectAtIndex:3] doubleValue]]];
        
        // get what calorie intake should be
        NSArray *goalCalories = [Formulas US_calories_height_ins:[NSNumber numberWithDouble:height] weight_lbs:[NSNumber numberWithDouble:goalWeight] age_yrs:[NSNumber numberWithInt:age] sexMF:[NSNumber numberWithInt:sex]];
        
        [self.goalCouchPotatoLabel setText:[NSString stringWithFormat:@"%.0lf", [[goalCalories objectAtIndex:0] doubleValue]]];
        [self.goalOfficeWorkerLabel setText:[NSString stringWithFormat:@"%.0lf", [[goalCalories objectAtIndex:1] doubleValue]]];
        [self.goalDailyWalkerLabel setText:[NSString stringWithFormat:@"%.0lf", [[goalCalories objectAtIndex:2] doubleValue]]];
        [self.goalAthleteLabel setText:[NSString stringWithFormat:@"%.0lf", [[goalCalories objectAtIndex:3] doubleValue]]];
        
        
        // calculate distance to walk off 100 calories
        NSNumber *distance = [Formulas US_milesPer100Calories_weightLbs:[NSNumber numberWithDouble:currentWeight]];
        if (( distance.doubleValue > 0 ) && ( distance.doubleValue < 100 )){
            [self.milesPerHundredCaloriesLabel setText:[NSString stringWithFormat:@"Miles to walk off 100 calories %.1lf", distance.doubleValue]];
        }
        
        
        // difference bewtween current calorie intake and goal
        double difference = ([[currentCalories objectAtIndex:0] doubleValue] - [[goalCalories objectAtIndex:0] doubleValue]
                            + [[currentCalories objectAtIndex:1] doubleValue] - [[goalCalories objectAtIndex:1] doubleValue]
                            + [[currentCalories objectAtIndex:2]doubleValue] - [[goalCalories objectAtIndex:2] doubleValue]
                            + [[currentCalories objectAtIndex:3] doubleValue] - [[goalCalories objectAtIndex:3] doubleValue]) /4;
        
        
        [self.differenceLabel setText:[NSString stringWithFormat:@"Daily calorie difference   ~%.0lf", difference]];
        
    }else{                  // metric
        
        // get current calorie intake
        NSArray *currentCalories = [Formulas Metric_calories_height_cm:[NSNumber numberWithDouble:height] weight_kgs:[NSNumber numberWithDouble:currentWeight] age_yrs:[NSNumber numberWithInt:age] sexMF:[NSNumber numberWithInt:sex]];

        [self.currentCouchPotatoLabel setText:[NSString stringWithFormat:@"%.0lf", [[currentCalories objectAtIndex:0] doubleValue]]];
        [self.currentOfficeWorkerLabel setText:[NSString stringWithFormat:@"%.0lf", [[currentCalories objectAtIndex:1] doubleValue]]];
        [self.currentDailyWalkerLabel setText:[NSString stringWithFormat:@"%.0lf", [[currentCalories objectAtIndex:2] doubleValue]]];
        [self.currentAthleteLabel setText:[NSString stringWithFormat:@"%.0lf", [[currentCalories objectAtIndex:3] doubleValue]]];
        

        // get what calorie intake should be
        NSArray *goalCalories = [Formulas Metric_calories_height_cm:[NSNumber numberWithDouble:height] weight_kgs:[NSNumber numberWithDouble:goalWeight] age_yrs:[NSNumber numberWithInt:age] sexMF:[NSNumber numberWithInt:sex]];
        
        [self.goalCouchPotatoLabel setText:[NSString stringWithFormat:@"%.0lf", [[goalCalories objectAtIndex:0] doubleValue]]];
        [self.goalOfficeWorkerLabel setText:[NSString stringWithFormat:@"%.0lf", [[goalCalories objectAtIndex:1] doubleValue]]];
        [self.goalDailyWalkerLabel setText:[NSString stringWithFormat:@"%.0lf", [[goalCalories objectAtIndex:2] doubleValue]]];
        [self.goalAthleteLabel setText:[NSString stringWithFormat:@"%.0lf", [[goalCalories objectAtIndex:3] doubleValue]]];
        
        
        // calculate distance to walk off 100 calories
        NSNumber *distance = [Formulas Metric_kilometersPer100Calories_weightKgs:[NSNumber numberWithDouble:currentWeight]];
        if (( distance.doubleValue > 0 ) && ( distance.doubleValue < 100 )){
            [self.milesPerHundredCaloriesLabel setText:[NSString stringWithFormat:@"Kilometers to walk off 100 calories: %.1lf", distance.doubleValue]];
        }
        
        // difference bewtween current calorie intake and goal
        double difference = ([[currentCalories objectAtIndex:0] doubleValue] - [[goalCalories objectAtIndex:0] doubleValue]
                             + [[currentCalories objectAtIndex:1] doubleValue] - [[goalCalories objectAtIndex:1] doubleValue]
                             + [[currentCalories objectAtIndex:2]doubleValue] - [[goalCalories objectAtIndex:2] doubleValue]
                             + [[currentCalories objectAtIndex:3] doubleValue] - [[goalCalories objectAtIndex:3] doubleValue]) /4;
        
        
        [self.differenceLabel setText:[NSString stringWithFormat:@"Daily calorie difference   ~%.0lf", difference]];

    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    [self.defaults synchronize];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
