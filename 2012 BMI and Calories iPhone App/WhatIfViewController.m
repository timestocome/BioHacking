//
//  WhatIfViewController.m
//  bmicalories
//
//  Created by Linda Cobb on 6/25/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import "WhatIfViewController.h"
#import "Formulas.h"
#import "PickerArrays.h"



@implementation WhatIfViewController

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
}




- (void)viewWillAppear:(BOOL)animated
{
    [self setupView];
}


- (void)setupView
{
    // get last known user values
    units = [[self.defaults objectForKey:@"units"] intValue];
    minutesWalking = [[self.defaults objectForKey:@"minutesWalking"] intValue];
    minutesJogging = [[self.defaults objectForKey:@"minutesJogging"] intValue];
    calorieReduction = [[self.defaults objectForKey:@"calorieReduction"] intValue];
    currentWeight = [[self.defaults objectForKey:@"currentWeight"] doubleValue];
    goalWeight  = [[self.defaults objectForKey:@"goalWeight"] doubleValue];
    
    // fatch arrays for picker
    if ( units == 0 ){ // US/Imperial units
        
        _walkingArray = [NSArray arrayWithArray:[PickerArrays minutesArray]];
        _joggingArray = [NSArray arrayWithArray:[PickerArrays minutesArray]];
        _caloriesArray = [NSArray arrayWithArray:[PickerArrays droppedCaloriesArray]];
        _currentWeightArray = [NSArray arrayWithArray:[PickerArrays imperialWeightArray]];
        _goalWeightArray = [NSArray arrayWithArray:[PickerArrays imperialWeightArray]];
        
        // set picker labels
        [self.currentWeightLabel setText:@"Wgt lbs"];
        [self.goalWeightLabel setText:@"Goal lbs"];
        
    }else{              // metric units
        _walkingArray = [NSArray arrayWithArray:[PickerArrays minutesArray]];
        _joggingArray = [NSArray arrayWithArray:[PickerArrays minutesArray]];
        _caloriesArray = [NSArray arrayWithArray:[PickerArrays droppedCaloriesArray]];
        _currentWeightArray = [NSArray arrayWithArray:[PickerArrays metricWeightArray]];
        _goalWeightArray = [NSArray arrayWithArray:[PickerArrays metricWeightArray]];
        
        // set picker labels
        [self.currentWeightLabel setText:@"Wgt kgs"];
        [self.goalWeightLabel setText:@"Goal kgs"];
    }
    
    
    
    // set picker view to user's last values
    //  - (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated
    int row = [self.walkingArray indexOfObject:[NSNumber numberWithInt:minutesWalking]];
    if ( row > 0 && row < self.walkingArray.count){ [self.pickerView selectRow:row inComponent:0 animated:YES]; }
    
    row = [self.joggingArray indexOfObject:[NSNumber numberWithInt:minutesJogging]];
    if ( (row > 0) && (row < self.joggingArray.count)  ){ [self.pickerView selectRow:row inComponent:1 animated:YES]; }
    
    row = [self.caloriesArray indexOfObject:[NSNumber numberWithInt:calorieReduction]];
    if ( (row > 0) && (row < self.caloriesArray.count))[self.pickerView selectRow:row inComponent:2 animated:YES];
    
    row = [self.currentWeightArray indexOfObject:[NSNumber numberWithDouble:currentWeight]];
    if ( (row > 0) && (row < self.currentWeightArray.count ) ){ [self.pickerView selectRow:row inComponent:3 animated:YES]; }
    
    row = [self.goalWeightArray indexOfObject:[NSNumber numberWithDouble:goalWeight]];
    if ( (row > 0) && (row < self.goalWeightArray.count) ){ [self.pickerView selectRow:row inComponent:4 animated:YES]; }
    
    [self calculate];
}




- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ( component == 0 ){
        minutesWalking = [[self.walkingArray objectAtIndex:row] intValue];
        [self.defaults setObject:[NSNumber numberWithInt:minutesWalking] forKey:@"minutesWalking"];
    }else if ( component == 1){
        minutesJogging = [[self.joggingArray objectAtIndex:row] intValue];
        [self.defaults setObject:[NSNumber numberWithInt:minutesJogging] forKey:@"minutesJogging"];
    }else if ( component == 2){
        calorieReduction = [[self.caloriesArray objectAtIndex:row] doubleValue];
        [self.defaults setObject:[NSNumber numberWithInt:calorieReduction] forKey:@"calorieReduction"];
    }else if ( component == 3){
        currentWeight = [[self.currentWeightArray objectAtIndex:row] doubleValue];
        [self.defaults setObject:[NSNumber numberWithDouble:currentWeight] forKey:@"currentWeight"];
    }else if ( component == 4){     
        goalWeight = [[self.goalWeightArray objectAtIndex:row] doubleValue];
        [self.defaults setObject:[NSNumber numberWithDouble:goalWeight] forKey:@"goalWeight"];
    }
    
    [self calculate];
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ( component == 0 ){
        return [NSString stringWithFormat:@"%@",[self.walkingArray objectAtIndex:row]];
    }else if ( component == 1 ){
        return [NSString stringWithFormat:@"%@", [self.joggingArray objectAtIndex:row]];
    }else if ( component == 2 ){
        return [NSString stringWithFormat:@"%@", [self.caloriesArray objectAtIndex:row]];
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
        width = 48.0;
    }else if ( component == 1 ){
        width = 48.0;
    }else if ( component == 2 ){
        width = 70.0;
    }else if ( component == 3 ){
        width = 70.0;
    }else{
        width = 70.0;
    }
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        width *= 1.5;
    }

    return width;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ( component == 0 ){
        return [self.walkingArray count];
    }else if ( component == 1 ){
        return [self.joggingArray count];
    }else if ( component == 2 ){
        return [self.caloriesArray count];
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
        
        // monthly weight lost by activity
        NSNumber *walkingPounds = [Formulas US_walkingCalories_minutes:[NSNumber numberWithInteger:minutesWalking] weight_lbs:[NSNumber numberWithDouble:currentWeight]];
        [self.poundsWalkingLabel setText:[NSString stringWithFormat:@"Daily walk: %.2lf lbs/mth", walkingPounds.doubleValue]];
        
        NSNumber *joggingPounds = [Formulas US_runningCalories_minutes:[NSNumber numberWithInteger:minutesJogging] weight_lbs:[NSNumber numberWithDouble:currentWeight]];
        [self.poundsJoggingLabel setText:[NSString stringWithFormat:@"Daily jog: %.2lf lbs/mth", joggingPounds.doubleValue]];
        
        NSNumber *droppedPounds = [Formulas US_caloriesDropped:[NSNumber numberWithInteger:calorieReduction]];
        [self.poundsCaloriesLabel setText:[NSString stringWithFormat:@"Daily calorie reduction: %.2lf lbs/mth", droppedPounds.doubleValue]];
        
        double totalPounds = walkingPounds.doubleValue + joggingPounds.doubleValue + droppedPounds.doubleValue;
        [self.totalLabel setText:[NSString stringWithFormat:@"Total: %.2lf lbs/mth", totalPounds]];
        
        
        // how long till we reach our goal
        double caloriesPerDay = totalPounds * 3500/30;
        NSNumber *daysToGoal = [Formulas US_daysToReachGoal_caloriesPerDay:[NSNumber numberWithDouble:caloriesPerDay] currentWeight_lbs:[NSNumber numberWithDouble:currentWeight] goalWeight_lbs:[NSNumber numberWithDouble:goalWeight]];
        
        NSString *dateReachGoal = [Formulas US_dateReachGoal_daysUntilGoal:daysToGoal];
        
        [self.goalDateLabel setText:[NSString stringWithFormat:@"Days to reach goal %d ~%@", daysToGoal.intValue, dateReachGoal]];
        
               
    }else{                  // metric
        
        // monthly weight lost by activity
        NSNumber *walkingKilograms = [Formulas Metric_walkingCalories_minutes:[NSNumber numberWithInteger:minutesWalking] weight_kgs:[NSNumber numberWithDouble:currentWeight]];
        [self.poundsWalkingLabel setText:[NSString stringWithFormat:@"Daily walk: %.2lf kgs/mth", walkingKilograms.doubleValue]];
        
        NSNumber *joggingKilograms = [Formulas Metric_runningCalories_minutes:[NSNumber numberWithInteger:minutesJogging] weight_kgs:[NSNumber numberWithDouble:currentWeight]];
        [self.poundsJoggingLabel setText:[NSString stringWithFormat:@"Daily jog: %.2lf kgs/mth", joggingKilograms.doubleValue]];
        
        NSNumber *droppedKilograms = [Formulas Metric_caloriesDropped:[NSNumber numberWithInteger:calorieReduction]];
        [self.poundsCaloriesLabel setText:[NSString stringWithFormat:@"Daily calorie reduction: %.2lf lbs/mth", droppedKilograms.doubleValue]];
        
        double totalKilograms = walkingKilograms.doubleValue + joggingKilograms.doubleValue + droppedKilograms.doubleValue;
        [self.totalLabel setText:[NSString stringWithFormat:@"Total: %.2lf lbs/mth", totalKilograms]];
        
        
        // how long till we reach our goal
        double caloriesPerDay = totalKilograms * 1588/30;
        NSNumber *daysToGoal = [Formulas Metric_daysToReachGoal_caloriesPerDay:[NSNumber numberWithDouble:caloriesPerDay] currentWeight_kgs:[NSNumber numberWithDouble:currentWeight] goalWeight_kgs:[NSNumber numberWithDouble:goalWeight]];
        
        NSString *dateReachGoal = [Formulas Metric_dateReachGoal_daysUntilGoal:daysToGoal];
        
        [self.goalDateLabel setText:[NSString stringWithFormat:@"Days to reach goal %d ~%@", daysToGoal.intValue, dateReachGoal]];
    
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
