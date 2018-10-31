//
//  FutureWeightViewController.m
//  bmicalories
//
//  Created by Linda Cobb on 6/25/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import "FutureWeightViewController.h"
#import "Formulas.h"
#import "PickerArrays.h"



@implementation FutureWeightViewController

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
    units = [[self.defaults objectForKey:@"units"] intValue];
    sex = [[self.defaults objectForKey:@"sex"] intValue];
    dailyCalories = [[self.defaults objectForKey:@"dailyCalories"] intValue];
    age = [[self.defaults objectForKey:@"age"] intValue];
    height = [[self.defaults objectForKey:@"height"] doubleValue];
    
    
    // fatch arrays for picker
    if ( units == 0 ){ // US/Imperial units
        
        _sexArray = [NSArray arrayWithArray:[PickerArrays sexArray]];
        _dailyCaloriesArray = [NSArray arrayWithArray:[PickerArrays caloriesArray]];
        _ageArray = [NSArray arrayWithArray:[PickerArrays ageArray]];
        _heightArray = [NSArray arrayWithArray:[PickerArrays imperialHeightArray]];
                
        // set picker labels
        [self.heightLabel setText:@"Height in"];
                
    }else{              // metric units
        _sexArray = [NSArray arrayWithArray:[PickerArrays sexArray]];
        _dailyCaloriesArray = [NSArray arrayWithArray:[PickerArrays caloriesArray]];
        _ageArray = [NSArray arrayWithArray:[PickerArrays ageArray]];
        _heightArray = [NSArray arrayWithArray:[PickerArrays metricHeightArray]];
        
        // set picker labels
        [self.heightLabel setText:@"Height cm"];
    }
    
    // set picker view to user's last values
    //  - (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated
    int row = [self.sexArray indexOfObject:[NSNumber numberWithInt:sex]];
    if ( row > 0 && row < self.sexArray.count ){ [self.pickerView selectRow:row inComponent:0 animated:YES]; }
    
    row = [self.dailyCaloriesArray indexOfObject:[NSNumber numberWithInt:dailyCalories]];
    if ( row > 0 && row < self.dailyCaloriesArray.count){ [self.pickerView selectRow:row inComponent:1 animated:YES];
    
    row = [self.ageArray indexOfObject:[NSNumber numberWithInt:age]];
    if ( (row > 0) && (row < self.ageArray.count)  ){ [self.pickerView selectRow:row inComponent:1 animated:YES]; }
    
    row = [self.heightArray indexOfObject:[NSNumber numberWithDouble:height]];
        if ( (row > 0) && (row < self.heightArray.count))[self.pickerView selectRow:row inComponent:2 animated:YES]; }
    
}




- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if ( component == 0 ){
        sex = row;
        [self.defaults setObject:[NSNumber numberWithInt:sex] forKey:@"sex"];
    }else if ( component == 1 ){
        dailyCalories = [[self.dailyCaloriesArray objectAtIndex:row] intValue];
        [self.defaults setObject:[NSNumber numberWithInt:dailyCalories] forKey:@"dailyCalories"];
        NSLog(@"save calories %d", dailyCalories );
    }else if ( component == 2){
        age = [[self.ageArray objectAtIndex:row] intValue];
        [self.defaults setObject:[NSNumber numberWithInt:age] forKey:@"age"];
    }else if ( component == 3){
        height = [[self.heightArray objectAtIndex:row] doubleValue];
        [self.defaults setObject:[NSNumber numberWithDouble:height] forKey:@"height"];
    }
    
    [self calculate];
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ( component == 0 ){
        return [self.sexArray objectAtIndex:row];
    }else if ( component == 1){
        return [NSString stringWithFormat:@"%@", [self.dailyCaloriesArray objectAtIndex:row]];
    }else if ( component == 2 ){
        return [NSString stringWithFormat:@"%@", [self.ageArray objectAtIndex:row]];
    }else{
        return [NSString stringWithFormat:@"%.1lf", [[self.heightArray objectAtIndex:row] doubleValue]];
    }
}



- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    float width;
    
    if ( component == 0 ){
        width = 30.0;
    }else if ( component == 1 ){
        width = 100.0;
    }else if ( component == 2 ){
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
        return [self.dailyCaloriesArray count];
    }else if ( component == 2 ){
        return [self.ageArray count];
    }else{
        return [self.heightArray count];
    }
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 4;
}


- (void)calculate
{
    if ( units == 0 ){      // imperial/US
        NSArray *weightArray = [Formulas US_dailyCaloriesToWeight_daily_calories:[NSNumber numberWithInt:dailyCalories] age_yrs:[NSNumber numberWithInt:age] sexMF:[NSNumber numberWithInt:sex] height_ins:[NSNumber numberWithDouble:height]];
        
        [self.couchPotatoLabel setText:[NSString stringWithFormat:@"%.0lf", [[weightArray objectAtIndex:0] doubleValue]]];
        [self.officeWorkerLabel setText:[NSString stringWithFormat:@"%.0lf", [[weightArray objectAtIndex:1] doubleValue]]];
        [self.dailyWalkerLabel setText:[NSString stringWithFormat:@"%.0lf", [[weightArray objectAtIndex:2] doubleValue]]];
        [self.athleteLabel setText:[NSString stringWithFormat:@"%.0lf", [[weightArray objectAtIndex:3] doubleValue]]];
              
    }else{                  // metric
        
        NSArray *weightArray = [Formulas Metric_dailyCaloriesToWeight_daily_calories:[NSNumber numberWithInt:dailyCalories] age_yrs:[NSNumber numberWithInt:age] sexMF:[NSNumber numberWithInt:sex] height_cm:[NSNumber numberWithDouble:height]];
        
        [self.couchPotatoLabel setText:[NSString stringWithFormat:@"%.0lf", [[weightArray objectAtIndex:0] doubleValue]]];
        [self.officeWorkerLabel setText:[NSString stringWithFormat:@"%.0lf", [[weightArray objectAtIndex:1] doubleValue]]];
        [self.dailyWalkerLabel setText:[NSString stringWithFormat:@"%.0lf", [[weightArray objectAtIndex:2] doubleValue]]];
        [self.athleteLabel setText:[NSString stringWithFormat:@"%.0lf", [[weightArray objectAtIndex:3] doubleValue]]];
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
