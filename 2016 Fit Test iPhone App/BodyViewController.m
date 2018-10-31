//
//  BodyViewController.m
//  Fitness
//
//  Created by Linda Cobb on 6/27/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import "BodyViewController.h"
#import "Formulas.h"
#import "PickerArrays.h"


@implementation BodyViewController






- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}




- (void)viewWillAppear:(BOOL)animated
{
    
    self.waistHipsMark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mark.png"]];
    self.waistHipsMark.center = CGPointMake(160.0, 5.0);
    [self.waistHipsImageView addSubview:self.waistHipsMark];
    
    self.bmiMark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mark.png"]];
    self.bmiMark.center = CGPointMake(160.0, 5.0);
    [self.bmiImageView addSubview:self.bmiMark];
    
    self.bfMark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mark.png"]];
    self.bfMark.center = CGPointMake(160.0, 5.0);
    [self.bfImageView addSubview:self.bfMark];
    
   
    [self setupView];   
}




- (void)setupView
{
    _defaults = [NSUserDefaults standardUserDefaults];

    // get last known user values
    sex = [[self.defaults objectForKey:@"sex"] intValue];
    units = [[self.defaults objectForKey:@"units"] intValue];
    waist = [[self.defaults objectForKey:@"waist"] doubleValue];
    height = [[self.defaults objectForKey:@"height"] doubleValue];
    currentWeight = [[self.defaults objectForKey:@"currentWeight"] doubleValue];
    hips  = [[self.defaults objectForKey:@"hips"] doubleValue];
    
    
    // fatch arrays for picker
    if ( units == 0 ){ // US/Imperial units
        
        _sexArray = [NSArray arrayWithArray:[PickerArrays sexArray]];
        _waistArray = [NSArray arrayWithArray:[PickerArrays imperialWaistArray]];
        _heightArray = [NSArray arrayWithArray:[PickerArrays imperialHeightArray]];
        _currentWeightArray = [NSArray arrayWithArray:[PickerArrays imperialWeightArray]];
        _hipsArray = [NSArray arrayWithArray:[PickerArrays imperialHipsArray]];
        
        // set picker labels
        [self.heightLabel setText:@"Hght in"];
        [self.currentWeightLabel setText:@"Wgt lb"];
        [self.waistLabel setText:@"Waist in"];
        [self.hipsLabel setText:@"Hips in"];
        
    }else{              // metric units
        _sexArray = [NSArray arrayWithArray:[PickerArrays sexArray]];
        _waistArray = [NSArray arrayWithArray:[PickerArrays metricWaistArray]];
        _heightArray = [NSArray arrayWithArray:[PickerArrays metricHeightArray]];
        _currentWeightArray = [NSArray arrayWithArray:[PickerArrays metricWeightArray]];
        _hipsArray = [NSArray arrayWithArray:[PickerArrays metricHipsArray]];
        
        // set picker labels
        [self.heightLabel setText:@"Hght cm"];
        [self.currentWeightLabel setText:@"Wgt kg"];
        [self.waistLabel setText:@"Waist cm"];
        [self.hipsLabel setText:@"Hips cm"];
        
    }
    
    
    // set picker view to user's last values
    [self.pickerView selectRow:sex inComponent:0 animated:YES];
    
    int row = (int)[self.waistArray indexOfObject:[NSNumber numberWithDouble:waist]];
    if ( (row > 0) && (row < self.waistArray.count)  ){ [self.pickerView selectRow:row inComponent:1 animated:YES]; }
    
    row = (int)[self.heightArray indexOfObject:[NSNumber numberWithDouble:height]];
    if ( (row > 0) && (row < self.heightArray.count))[self.pickerView selectRow:row inComponent:2 animated:YES];
    
    row = (int)[self.currentWeightArray indexOfObject:[NSNumber numberWithDouble:currentWeight]];
    if ( (row > 0) && (row < self.currentWeightArray.count ) ){ [self.pickerView selectRow:row inComponent:3 animated:YES]; }
    
    row = (int)[self.hipsArray indexOfObject:[NSNumber numberWithDouble:hips]];
    if ( (row > 0) && (row < self.hipsArray.count) ){ [self.pickerView selectRow:row inComponent:4 animated:YES]; }
    
    
    [self calculate];
}




- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ( component == 0 ){          // sex
        sex = (int)row;                  // 0 for M, 1 for F
        [self.defaults setObject:[NSNumber numberWithInt:sex] forKey:@"sex"];
    }else if ( component == 1){     // waist
        waist = [[self.waistArray objectAtIndex:row] doubleValue];
        [self.defaults setObject:[NSNumber numberWithDouble:waist] forKey:@"waist"];
    }else if ( component == 2){     // height
        height = [[self.heightArray objectAtIndex:row] doubleValue];
        [self.defaults setObject:[NSNumber numberWithDouble:height] forKey:@"height"];
    }else if ( component == 3){     // current weight
        currentWeight = [[self.currentWeightArray objectAtIndex:row] doubleValue];
        [self.defaults setObject:[NSNumber numberWithDouble:currentWeight] forKey:@"currentWeight"];
    }else if ( component == 4){     // goal weight
        hips = [[self.hipsArray objectAtIndex:row] doubleValue];
        [self.defaults setObject:[NSNumber numberWithDouble:hips] forKey:@"hips"];
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
        title.text = [self.sexArray objectAtIndex:row];
    }else if ( component == 1 ){
        title.text = [NSString stringWithFormat:@"%.1lf", [[self.waistArray objectAtIndex:row] doubleValue]];
    }else if ( component == 2 ){
        title.text = [NSString stringWithFormat:@"%.1lf", [[self.heightArray objectAtIndex:row] doubleValue]];
    }else if ( component == 3 ){
        title.text = [NSString stringWithFormat:@"%.1lf", [[self.currentWeightArray objectAtIndex:row] doubleValue]];
    }else{
        title.text = [NSString stringWithFormat:@"%.1lf", [[self.hipsArray objectAtIndex:row] doubleValue]];
    }
    
    
	return title;
}






- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    float width;
    
    if ( component == 0 ){
        width = 30.0;
    }else if ( component == 1 ){
        width = 60.0;
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
        return [self.sexArray count];
    }else if ( component == 1 ){
        return [self.waistArray count];
    }else if ( component == 2 ){
        return [self.heightArray count];
    }else if ( component == 3 ){
        return [self.currentWeightArray count];
    }else{
        return [self.hipsArray count];
    }
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 5;
}


- (void)calculate
{
    
    
    
    if ( units == 0 ){      // imperial/US
        
        // BMI
        _bmi = [Formulas US_BMI_height_in:[NSNumber numberWithDouble:height] weight_lbs:[NSNumber numberWithDouble:currentWeight]];
        _weightInPounds = [NSNumber numberWithDouble:currentWeight];
        
        if ( (self.bmi.doubleValue < 0.0) || (self.bmi.doubleValue > 200.0) || (isnan(self.bmi.doubleValue)) ){
            self.bmi = [NSNumber numberWithDouble:0.0];
        }
        [self.BMILabel setText:[NSString stringWithFormat:@"BMI %.1lf  (18.5-25.0 optimum)", self.bmi.doubleValue]];
        
        double pts = 300.0/(40-18) * (self.bmi.doubleValue - 18.0);
        if (pts < 0.0 ){ pts = 0.0; }
        if (pts > 300.0 ){ pts = 300.0; }
        if ( isnan(pts)){ pts = 0.0; }

        

        CGPoint bmiPoint = CGPointMake(pts, 5.0);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){ bmiPoint.x *= 2; }
        
        
        [UIView animateWithDuration:1.0
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             [self.bmiMark setCenter:bmiPoint];
                         } completion:nil];


        [self.defaults setObject:self.bmi forKey:@"bmi"];

        
        
        
        // Body fat
        _bf = [Formulas US_bodyFat_sexMF:[NSNumber numberWithInt:sex] height_in:[NSNumber numberWithDouble:height] waist_in:[NSNumber numberWithDouble:waist] weight_lbs:[NSNumber numberWithDouble:currentWeight]];
        
        _bf = [NSNumber numberWithDouble:(self.bf.doubleValue * 100)];
        if ( (self.bf.doubleValue < 0.0) || (self.bf.doubleValue > 200.0)){ self.bf = [NSNumber numberWithDouble:0.0]; }
        
        double bfcenter;
        double poundsOfFat = currentWeight * self.bf.doubleValue / 100.0;
        
        
        if ( sex == 0 ){        // male
            if ( self.bf.doubleValue < 4 ){
                [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf%%, %.1lf lbs (low)", self.bf.doubleValue, poundsOfFat]];
                bfcenter = 150.0;
            }else if ( self.bf.doubleValue < 13 ) {
                [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf%%, %.1lf lbs (athletic)", self.bf.doubleValue, poundsOfFat]];
                bfcenter = 50.0;
            }else if ( self.bf.doubleValue < 17 ) {
                [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf%%, %.1lf lbs (fit)", self.bf.doubleValue, poundsOfFat]];
                bfcenter = 100.0;
            }else if ( self.bf.doubleValue < 25 ) {
                [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf%%, %.1lf lbs (acceptable)", self.bf.doubleValue, poundsOfFat]];
                bfcenter = 200.0;
            }else {
                [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf%%, %.1lf lbs (high)", self.bf.doubleValue, poundsOfFat]];
                bfcenter = 250.0;
            }
            
        }else{      // female
            if ( self.bf.doubleValue < 12 ){
                [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf%%, %.1lf lbs (low)", self.bf.doubleValue, poundsOfFat]];
                bfcenter = 150.0;
            }else if ( self.bf.doubleValue < 20 ) {
                [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf%%, %.1lf lbs (athletic)", self.bf.doubleValue, poundsOfFat]];
                bfcenter = 50.0;
            }else if ( self.bf.doubleValue < 24 ) {
                [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf%%, %.1lf lbs (fit)", self.bf.doubleValue, poundsOfFat]];
                bfcenter = 100.0;
            }else if ( self.bf.doubleValue < 31 ) {
                [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf%%, %.1lf lbs (acceptable)", self.bf.doubleValue, poundsOfFat]];
                bfcenter = 200.0;
            }else{
                [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf%%, %.1lf lbs (high)", self.bf.doubleValue, poundsOfFat]];
                bfcenter = 250.0;
            }
        }
        
        if (bfcenter < 0.0 ){ bfcenter = 0.0; }
        if (bfcenter > 300.0 ){ bfcenter = 300.0; }
        if ( isnan(bfcenter)){ bfcenter = 0.0; }
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){ bfcenter *= 2; }
        CGPoint bfPoint = CGPointMake(bfcenter, 5.0);
       
        
        [UIView animateWithDuration:1.0
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             [self.bfMark setCenter:bfPoint];
                         } completion:nil];


        [self.defaults setObject:self.bf forKey:@"bodyFat"];
        
        
        
        
        // hip to waist ratio
        NSNumber *hipWaist = [Formulas US_hipToWaist_waist_in:[NSNumber numberWithDouble:waist] hips_in:[NSNumber numberWithDouble:hips]];
        
        if (( hipWaist.doubleValue < 0.0 ) || (hipWaist.doubleValue > 200.0) || (isnan(hipWaist.doubleValue)) ){
            hipWaist = [NSNumber numberWithDouble:0.0];
        }
        
        
        double hwcenter;
        
        if ( sex == 0 ){        // male
            [self.hipWaistLabel setText:[NSString stringWithFormat:@"Waist to hips %.2lf  (.9 is optimum)", hipWaist.doubleValue]];
            hwcenter = 25.0 + ((hipWaist.doubleValue - 0.9)*(hipWaist.doubleValue - 0.9))*8000.0;
        }else{                  // female
            [self.hipWaistLabel setText:[NSString stringWithFormat:@"Waist to hips %.2lf  (.7 is optimum)", hipWaist.doubleValue]];
            hwcenter = 25.0 + ((hipWaist.doubleValue - 0.7)*(hipWaist.doubleValue - 0.7))*8000.0;
        }
        
        if (hwcenter < 0.0 ){ hwcenter = 0.0; }
        if (hwcenter > 300.0 ){ hwcenter = 300.0; }
        if ( isnan(hwcenter)){ hwcenter = 0.0; }
        

        CGPoint waistHipsPoint = CGPointMake(hwcenter, 5.0);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){ waistHipsPoint.x *= 2; }

       

        [UIView animateWithDuration:1.0
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             [self.waistHipsMark setCenter:waistHipsPoint];
                         } completion:nil];

        
        
        // body surface area
        NSNumber *surfaceArea = [Formulas US_bodySurfaceArea_height_in:[NSNumber numberWithDouble:height] weight_lbs:[NSNumber numberWithDouble:currentWeight]];
        
        [self.surfaceAreaLabel setText:[NSString stringWithFormat:@"Body surface area is %.2lf ft^2", surfaceArea.doubleValue]];
        
        
    }else{                  // metric
        // BMI
        
        _bmi = [Formulas Metric_BMI_height_cm:[NSNumber numberWithDouble:height] weight_kgs:[NSNumber numberWithDouble:currentWeight]];
        _weightInPounds = [Formulas kilogramsToPounds:[NSNumber numberWithDouble:currentWeight]];
        
        
        if ( (self.bmi.doubleValue < 0.0) || (self.bmi.doubleValue > 200.0) || (isnan(self.bmi.doubleValue)) ){
            self.bmi = [NSNumber numberWithDouble:0.0];
        }
        [self.BMILabel setText:[NSString stringWithFormat:@"BMI %.1lf  (18.5-25.0 optimum)", self.bmi.doubleValue]];
        
        double pts = 300.0/(40-18) * (self.bmi.doubleValue - 18.0);
        if (pts < 0.0 ){ pts = 0.0; }
        if (pts > 300.0 ){ pts = 300.0; }
        if ( isnan(pts)){ pts = 0.0; }
        

        CGPoint bmiPoint = CGPointMake(pts, 5.0);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){ bmiPoint.x *= 2; }

        
        
        [UIView animateWithDuration:1.0
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             [self.bmiMark setCenter:bmiPoint];
                         } completion:nil];

        
        [self.defaults setObject:self.bmi forKey:@"bmi"];

        
        
        
        // Body fat
        _bf = [Formulas Metric_bodyFat_sexMF:[NSNumber numberWithInt:sex] height_cm:[NSNumber numberWithDouble:height] waist:[NSNumber numberWithDouble:waist] weight_kg:[NSNumber numberWithDouble:currentWeight]];
        _bf = [NSNumber numberWithDouble:(self.bf.doubleValue * 100)];
        if ( (self.bf.doubleValue < 0.0) || (self.bf.doubleValue > 200.0)){ self.bf = [NSNumber numberWithDouble:0.0]; }

        
        double bfcenter;
        double kilogramsOfFat = self.bf.doubleValue * currentWeight /100.0;
        
        if ( sex == 0 ){        // male
            if ( self.bf.doubleValue < 4 ){
                [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf%%, %.1lf kg (low)", self.bf.doubleValue, kilogramsOfFat]];
                bfcenter = 150.0;
            }else if ( self.bf.doubleValue < 13 ) {
                [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf%%, %.1lf kg (athletic)", self.bf.doubleValue, kilogramsOfFat]];
                bfcenter = 50.0;
            }else if ( self.bf.doubleValue < 17 ) {
                [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf%%, %.1lf kg (fit)", self.bf.doubleValue, kilogramsOfFat]];
                bfcenter = 100.0;
            }else if ( self.bf.doubleValue < 25 ) {
                [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf%%, %.1lf kg (acceptable)", self.bf.doubleValue, kilogramsOfFat]];
                bfcenter = 200.0;
            }else {
                [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf%%, %.1lf kg (high)", self.bf.doubleValue, kilogramsOfFat]];
                bfcenter = 250.0;
            }
            
        }else{      // female
            if ( self.bf.doubleValue < 12 ){
                [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf%%, %.1lf kg (low)", self.bf.doubleValue, kilogramsOfFat]];
                bfcenter = 150.0;
            }else if ( self.bf.doubleValue < 20 ) {
                [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf%%, %.1lf kg (athletic)", self.bf.doubleValue, kilogramsOfFat]];
                bfcenter = 50.0;
            }else if ( self.bf.doubleValue < 24 ) {
                [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf%%, %.1lf kg (fit)", self.bf.doubleValue, kilogramsOfFat]];
                bfcenter = 100.0;
            }else if ( self.bf.doubleValue < 31 ) {
                [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf%%, %.1lf kg (acceptable)", self.bf.doubleValue, kilogramsOfFat]];
                bfcenter = 200.0;
            }else{
                [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf%%, %.1lf kg (high)", self.bf.doubleValue, kilogramsOfFat]];
                bfcenter = 250.0;
            }
        }
        
        if (bfcenter < 0.0 ){ bfcenter = 0.0; }
        if (bfcenter > 300.0 ){ bfcenter = 300.0; }
        if ( isnan(bfcenter)){ bfcenter = 0.0; }

        CGPoint bfPoint = CGPointMake(bfcenter, 5.0);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){ bmiPoint.x *= 2; }

        
        [UIView animateWithDuration:1.0
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             [self.bfMark setCenter:bfPoint];
                         } completion:nil];

        
        [self.defaults setObject:self.bf forKey:@"bodyFat"];

        
        
        
        // hip to waist ratio
        NSNumber *hipWaist = [Formulas Metric_hipToWaist_waist_cm:[NSNumber numberWithDouble:waist] hips_cm:[NSNumber numberWithDouble:hips]];
        
        if (( hipWaist.doubleValue < 0.0 ) || (hipWaist.doubleValue > 200.0) || (isnan(hipWaist.doubleValue)) ){
            hipWaist = [NSNumber numberWithDouble:0.0];
        }

        double hwcenter;
        
        if ( sex == 0 ){        // male
            [self.hipWaistLabel setText:[NSString stringWithFormat:@"Waist to Hips %.2lf  (.9 is optimum)", hipWaist.doubleValue]];
            hwcenter = 25.0 + ((hipWaist.doubleValue - 0.9)*(hipWaist.doubleValue - 0.9))*8000.0;
        }else{                  // female
            [self.hipWaistLabel setText:[NSString stringWithFormat:@"Waist to Hips %.2lf  (.7 is optimum)", hipWaist.doubleValue]];
            hwcenter = 25.0 + ((hipWaist.doubleValue - 0.7)*(hipWaist.doubleValue - 0.7))*8000.0;
        }
        
        
        if (hwcenter < 0.0 ){ hwcenter = 0.0; }
        if (hwcenter > 300.0 ){ hwcenter = 300.0; }
        if ( isnan(hwcenter)){ hwcenter = 0.0; }

        CGPoint waistHipsPoint = CGPointMake(hwcenter, 5.0);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){ waistHipsPoint.x *= 2; }

        
        [UIView animateWithDuration:1.0
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             [self.waistHipsMark setCenter:waistHipsPoint];
                         } completion:nil];

        
        
        // body surface area
        NSNumber *surfaceArea = [Formulas US_bodySurfaceArea_height_in:[NSNumber numberWithDouble:height] weight_lbs:[NSNumber numberWithDouble:currentWeight]];
        
        if ( units == 0 ){
            [self.surfaceAreaLabel setText:[NSString stringWithFormat:@"Body surface area is %.2lf ft^2", surfaceArea.doubleValue]];
        }else{
            surfaceArea = [NSNumber numberWithDouble:surfaceArea.doubleValue * 0.09290304];
            [self.surfaceAreaLabel setText:[NSString stringWithFormat:@"Body surface area is %.2lf m^2", surfaceArea.doubleValue]];
        }
        
        
    }
}






- (void)viewWillDisappear:(BOOL)animated
{
    [self.defaults synchronize];
    
    
    // health kit
    healthKitStorePermission = [[self.defaults objectForKey:@"healthStorePermission"] intValue];
    if ( healthKitStorePermission == 1 ){
        
        _healthKitCommon = [HealthKitCommon new];
        [self.healthKitCommon getHealthKit];
        
        
        [self.healthKitCommon saveBodyFatPercentageIntoHealthStore:self.bf];
        [self.healthKitCommon saveBodyMassIndexIntoHealthStore: self.bmi];
        
        
        _leanBodyMass = [NSNumber numberWithDouble:(currentWeight - currentWeight * self.bf.doubleValue/100.0)];
        if (units == 0){ _leanBodyMass = [Formulas poundsToKilograms:self.leanBodyMass]; }
        [self.healthKitCommon saveLeanBodyMassIntoHealthStore:self.leanBodyMass];
        
        [self.healthKitCommon saveWeightIntoHealthStore:self.weightInPounds];

    }

    
    [self.waistHipsMark removeFromSuperview];
    [self.bmiMark removeFromSuperview];
    [self.bfMark removeFromSuperview];
     

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
