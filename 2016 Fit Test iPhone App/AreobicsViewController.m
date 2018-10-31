//
//  AreobicsViewController.m
//  Fitness
//
//  Created by Linda Cobb on 6/27/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import "AreobicsViewController.h"
#import "Formulas.h"
#import "PickerArrays.h"



@implementation AreobicsViewController




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
    age = [[self.defaults objectForKey:@"age"] intValue];
    restingPulse = [[self.defaults objectForKey:@"restingPulse"] intValue];
    distance = [[self.defaults objectForKey:@"distance"] doubleValue];
    
    
    // fatch arrays for picker
    if ( units == 0 ){ // US/Imperial units
        
        _ageArray = [NSArray arrayWithArray:[PickerArrays ageArray]];
        _restingPulseArray = [NSArray arrayWithArray:[PickerArrays restingPulseArray]];
        _distanceArray = [NSArray arrayWithArray:[PickerArrays imperial12MinuteDistanceArray]];
        
        // set picker labels
        [self.runLabel setText:@"12 min run miles"];
                
    }else{              // metric units
        _ageArray = [NSArray arrayWithArray:[PickerArrays ageArray]];
        _restingPulseArray = [NSArray arrayWithArray:[PickerArrays restingPulseArray]];
        _distanceArray = [NSArray arrayWithArray:[PickerArrays metric12MinuteDistanceArray]];
        
        // set picker labels
        [self.runLabel setText:@"12 min run km"];
       
    }
    
    
    // set picker view to user's last values    
    int row = (int)[self.ageArray indexOfObject:[NSNumber numberWithInt:age]];
    if ( (row > 0) && (row < self.ageArray.count)  ){ [self.pickerView selectRow:row inComponent:0 animated:YES]; }
    
    row = (int)[self.restingPulseArray indexOfObject:[NSNumber numberWithInt:restingPulse]];
    if ( (row > 0) && (row < self.restingPulseArray.count))[self.pickerView selectRow:row inComponent:1 animated:YES];
    
    row = (int)[self.distanceArray indexOfObject:[NSNumber numberWithDouble:distance]];
    if ( (row > 0) && (row < self.distanceArray.count ) ){ [self.pickerView selectRow:row inComponent:2 animated:YES]; }
    
    [self calculate];
}




- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ( component == 0 ){          // sex
        age = [[self.ageArray objectAtIndex:row] intValue];
        [self.defaults setObject:[NSNumber numberWithInt:age] forKey:@"age"];
    }else if ( component == 1){     // waist
        restingPulse = [[self.restingPulseArray objectAtIndex:row] intValue];
        [self.defaults setObject:[NSNumber numberWithInt:restingPulse] forKey:@"restingPulse"];
    }else if ( component == 2){     // height
        distance = [[self.distanceArray objectAtIndex:row] doubleValue];
        [self.defaults setObject:[NSNumber numberWithDouble:distance] forKey:@"distance"];
    }
    
    [self calculate];
}





- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
	UILabel *title = (id)view;
	if (!title) {
		title= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
		title.backgroundColor = [UIColor clearColor];
		title.textAlignment = NSTextAlignmentCenter;
		title.shadowColor = [UIColor whiteColor];
		title.shadowOffset = CGSizeMake(0, 1);
        title.font = [UIFont boldSystemFontOfSize:16];
        
	}
	
    
    
    if ( component == 0 ){
        title.text =  [NSString stringWithFormat:@"%@", [self.ageArray objectAtIndex:row]];
    }else if ( component == 1 ){
        title.text = [NSString stringWithFormat:@"%@", [self.restingPulseArray objectAtIndex:row]];
    }else{
        title.text = [NSString stringWithFormat:@"%@", [self.distanceArray objectAtIndex:row]];
    }
    
    
	return title;
}




- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    float width;
    if ( component == 0 ){
        width = 100.0;
    }else if ( component == 1 ){
        width = 100.0;
    }else{
        width = 100.0;
    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        width *= 1.5;
    }
    return width;

}





- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ( component == 0 ){
        return [self.ageArray count];
    }else if ( component == 1 ){
        return [self.restingPulseArray count];
    }else{
        return [self.distanceArray count];
    }
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 3;
}





- (void)calculate
{
    
    NSNumber *cooperTest, *estimatedVO2;
    
    if ( units == 0 ){
        // VO2Max
        cooperTest = [Formulas US_CooperTest_12MinuteRun_miles:[NSNumber numberWithDouble:distance]];
        estimatedVO2 = [Formulas Estimated_VO2Max_age:[NSNumber numberWithInt:age] restingPulse:[NSNumber numberWithInt:restingPulse]];
        
        if ( (estimatedVO2.doubleValue < 0.0) || (estimatedVO2.doubleValue > 100.0) ){ estimatedVO2 = [NSNumber numberWithDouble:0.0]; }
                
        double maxSpeed;
        double vo2max;
        
        if ( cooperTest.doubleValue < 0.0 ){ cooperTest = [NSNumber numberWithDouble:0.0]; }
		if ( cooperTest.doubleValue > 0.0 ) vo2max = cooperTest.doubleValue;
		else vo2max = estimatedVO2.doubleValue;

        if ( vo2max > 65 ) { maxSpeed = 13.0; }
		else if ( vo2max > 60 ) { maxSpeed = 12.0; }
		else if ( vo2max > 55 ) { maxSpeed = 11.0; }
		else if ( vo2max > 50 ) { maxSpeed = 10.0; }
		else if ( vo2max > 45 ) { maxSpeed = 9.0; }
		else if ( vo2max > 40 ) { maxSpeed = 8.0; }
		else if ( vo2max > 35 ) { maxSpeed = 7.0; }
		else if ( vo2max > 30 ) { maxSpeed = 6.0; }
		else if ( vo2max > 25 ) { maxSpeed = 5.0; }
		else if ( vo2max > 20 ) { maxSpeed = 4.0; }
		else { maxSpeed = 3.0; }

        double maxDistance = (estimatedVO2.doubleValue + 11.29)/35.97;
        
        [self.estimatedVO2maxLabel setText:[NSString stringWithFormat:@"%.1lf", estimatedVO2.doubleValue]];
        [self.cooperTestV02maxLabel setText:[NSString stringWithFormat:@"%.1lf", cooperTest.doubleValue]];
        [self.distanceIn12minutesLabel setText:[NSString stringWithFormat:@"%.1lf miles", maxDistance]];
        [self.maxSustainableSpeedLabel setText:[NSString stringWithFormat:@"%.1lf mph", maxSpeed]];
        
        
        [self.defaults setObject:cooperTest forKey:@"vo2max"];
        
        
        
        
    }else{
        // VO2Max
        cooperTest = [Formulas Metric_CooperTest_12MinuteRun_kms:[NSNumber numberWithDouble:distance]];
        estimatedVO2 = [Formulas Estimated_VO2Max_age:[NSNumber numberWithInt:age] restingPulse:[NSNumber numberWithInt:restingPulse]];
       
        double maxSpeed;
        double vo2max;

        if ( cooperTest.doubleValue < 0.0 ){ cooperTest = [NSNumber numberWithDouble:0.0]; }
		if ( cooperTest.doubleValue > 0.0 ) vo2max = cooperTest.doubleValue;
		else vo2max = estimatedVO2.doubleValue;
        
        double milesToKm = 1.60344;
        if ( vo2max > 65 ) { maxSpeed = 13.0*milesToKm; }
		else if ( vo2max > 60 ) { maxSpeed = 12.0*milesToKm; }
		else if ( vo2max > 55 ) { maxSpeed = 11.0*milesToKm; }
		else if ( vo2max > 50 ) { maxSpeed = 10.0*milesToKm; }
		else if ( vo2max > 45 ) { maxSpeed = 9.0*milesToKm; }
		else if ( vo2max > 40 ) { maxSpeed = 8.0*milesToKm; }
		else if ( vo2max > 35 ) { maxSpeed = 7.0*milesToKm; }
		else if ( vo2max > 30 ) { maxSpeed = 6.0*milesToKm; }
		else if ( vo2max > 25 ) { maxSpeed = 5.0*milesToKm; }
		else if ( vo2max > 20 ) { maxSpeed = 4.0*milesToKm; }
		else { maxSpeed = 3.0*milesToKm; }
        
        
        double maxDistance = ((estimatedVO2.doubleValue + 11.29)/35.97) * milesToKm;
        
        [self.estimatedVO2maxLabel setText:[NSString stringWithFormat:@"%.1lf", estimatedVO2.doubleValue]];
        [self.cooperTestV02maxLabel setText:[NSString stringWithFormat:@"%.1lf", cooperTest.doubleValue]];
        [self.distanceIn12minutesLabel setText:[NSString stringWithFormat:@"%.1lf km", maxDistance]];
        [self.maxSustainableSpeedLabel setText:[NSString stringWithFormat:@"%.1lf km/h", maxSpeed]];

        
        [self.defaults setObject:cooperTest forKey:@"vo2max"];
    }
    
    [self averageRunTime];
    
    [self.estimatedAgeFemaleLabel setText:[Formulas EstimatedAerobicAgeFemale:estimatedVO2]];
    [self.testedFemaleLabel setText:[Formulas EstimatedAerobicAgeFemale:cooperTest]];
    
    [self.estimatedAgeMaleLabel setText:[Formulas EstimatedAerobicAgeMale:estimatedVO2]];
    [self.testedMaleLabel setText:[Formulas EstimatedAerobicAgeMale:cooperTest]];
    
}



- (void)averageRunTime
{
    if ( units == 0 ){
        NSString *m = [Formulas US_average10KWinningPace_sex:[NSNumber numberWithInt:0] age:[NSNumber numberWithInt:age]];
        [self.runTimeLabelM setText:[NSString stringWithFormat:@"%@", m]];

        NSString *f = [Formulas US_average10KWinningPace_sex:[NSNumber numberWithInt:1] age:[NSNumber numberWithInt:age]];
        [self.runTimeLabelF setText:[NSString stringWithFormat:@"%@", f]];
    }else{
        NSString *m = [Formulas Metric_average10KWinningPace_sex:[NSNumber numberWithInt:0] age:[NSNumber numberWithInt:age]];
        [self.runTimeLabelM setText:[NSString stringWithFormat:@"%@", m]];

        NSString *f = [Formulas Metric_average10KWinningPace_sex:[NSNumber numberWithInt:1] age:[NSNumber numberWithInt:age]];
        [self.runTimeLabelF setText:[NSString stringWithFormat:@"%@", f]];

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
