//
//  BMIViewController.m
//  bmicalories
//
//  Created by Linda Cobb on 6/25/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import "BMIViewController.h"
#import "Formulas.h"
#import "PickerArrays.h"


@implementation BMIViewController



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
    sex = [[self.defaults objectForKey:@"sex"] integerValue];
    units = [[self.defaults objectForKey:@"units"] integerValue];
    waist = [[self.defaults objectForKey:@"waist"] integerValue];
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
        [self.currentWeightLabel setText:@"Wgt lbs"];
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
        [self.currentWeightLabel setText:@"Wgt kgs"];
        [self.waistLabel setText:@"Waist cm"];
        [self.hipsLabel setText:@"Hips cm"];
        
    }
    
    
    // set picker view to user's last values
    [self.pickerView selectRow:sex inComponent:0 animated:YES];
    
    int row = [self.waistArray indexOfObject:[NSNumber numberWithInt:waist]];
    if ( (row > 0) && (row < self.waistArray.count)  ){ [self.pickerView selectRow:row inComponent:1 animated:YES]; }
    
    row = [self.heightArray indexOfObject:[NSNumber numberWithDouble:height]];
    if ( (row > 0) && (row < self.heightArray.count))[self.pickerView selectRow:row inComponent:2 animated:YES];
    
    row = [self.currentWeightArray indexOfObject:[NSNumber numberWithDouble:currentWeight]];
    if ( (row > 0) && (row < self.currentWeightArray.count ) ){ [self.pickerView selectRow:row inComponent:3 animated:YES]; }
    
    row = [self.hipsArray indexOfObject:[NSNumber numberWithDouble:hips]];
    if ( (row > 0) && (row < self.hipsArray.count) ){ [self.pickerView selectRow:row inComponent:4 animated:YES]; }
    
}




- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ( component == 0 ){          // sex
        sex = row;                  // 0 for M, 1 for F
        [self.defaults setObject:[NSNumber numberWithInt:sex] forKey:@"sex"];
    }else if ( component == 1){     // waist
        waist = [[self.waistArray objectAtIndex:row] intValue];
        [self.defaults setObject:[NSNumber numberWithInt:waist] forKey:@"waist"];
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


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ( component == 0 ){
        return [self.sexArray objectAtIndex:row];
    }else if ( component == 1 ){
        return [NSString stringWithFormat:@"%.1lf", [[self.waistArray objectAtIndex:row]doubleValue]];
    }else if ( component == 2 ){
        return [NSString stringWithFormat:@"%.1lf", [[self.heightArray objectAtIndex:row]doubleValue]];
    }else if ( component == 3 ){
        return [NSString stringWithFormat:@"%.1lf", [[self.currentWeightArray objectAtIndex:row] doubleValue]];
    }else{
        return [NSString stringWithFormat:@"%.1lf", [[self.hipsArray objectAtIndex:row]doubleValue]];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    float width;
    
    if ( component == 0 ){
        width = 27.0;
    }else if ( component == 1 ){
        width = 70.0;
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
        NSNumber *bmi = [Formulas US_BMI_height_in:[NSNumber numberWithDouble:height] weight_lbs:[NSNumber numberWithDouble:currentWeight]];
        
        if (( bmi.doubleValue > 0 ) && ( bmi.doubleValue < 100  )){
            [self.BMILabel setText:[NSString stringWithFormat:@"BMI %.1lf  (18.5-25.0 optimum)", bmi.doubleValue]];
        }
        
        
        // Body fat
        NSNumber *bf = [Formulas US_bodyFat_sexMF:[NSNumber numberWithInt:sex] height_in:[NSNumber numberWithDouble:height] waist_in:[NSNumber numberWithDouble:waist] weight_lbs:[NSNumber numberWithDouble:currentWeight]];
        bf = [NSNumber numberWithDouble:(bf.doubleValue * 100)];
        
    
        if (( bf.doubleValue > 0 ) && (bf.doubleValue < 100 )){
            if ( sex == 0 ){        // male
                if ( bf.doubleValue < 4 ){ [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf  (low)", bf.doubleValue]]; }
                else if ( bf.doubleValue < 13 ) { [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf  (athletic)", bf.doubleValue]]; }
                else if ( bf.doubleValue < 17 ) { [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf (fit)", bf.doubleValue]]; }
                else if ( bf.doubleValue < 25 ) { [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf (acceptable)", bf.doubleValue]]; }
                else { [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf  (high)", bf.doubleValue]]; }
            
            }else if ( sex == 1 ){      // female
                if ( bf.doubleValue < 12 ){ [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf  (low)", bf.doubleValue]]; }
                else if ( bf.doubleValue < 20 ) { [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf   (athletic)", bf.doubleValue]]; }
                else if ( bf.doubleValue < 24 ) { [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf   (fit)", bf.doubleValue]]; }
                else if ( bf.doubleValue < 31 ) { [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf   (acceptable)", bf.doubleValue]]; }
                else { [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf   (high)", bf.doubleValue]]; }
            }
        }
        
        
        // hip to waist ratio
        NSNumber *hipWaist = [Formulas US_hipToWaist_waist_in:[NSNumber numberWithDouble:waist] hips_in:[NSNumber numberWithDouble:hips]];
        
        if (( hipWaist.doubleValue > 0 ) && ( hipWaist.doubleValue < 200)){
            if ( sex == 0 ){        // male
                [self.hipWaistLabel setText:[NSString stringWithFormat:@"Waist to Hips %.2lf  (.9 is optimum)", hipWaist.doubleValue]];
            }else{                  // female
                [self.hipWaistLabel setText:[NSString stringWithFormat:@"Waist to Hips %.2lf  (.7 is optimum)", hipWaist.doubleValue]];
            }
        }
        
        
        // body surface area
        NSNumber *surfaceArea = [Formulas US_bodySurfaceArea_height_in:[NSNumber numberWithDouble:height] weight_lbs:[NSNumber numberWithDouble:currentWeight]];
        
        [self.surfaceAreaLabel setText:[NSString stringWithFormat:@"Body surface area is %.2lf ft^2", surfaceArea.doubleValue]];
        
              
    }else{                  // metric
        // BMI
        NSNumber *bmi = [Formulas Metric_BMI_height_cm:[NSNumber numberWithDouble:height] weight_kgs:[NSNumber numberWithDouble:currentWeight]];
        
        if (( bmi.doubleValue > 0 ) && ( bmi.doubleValue < 100  )){
            [self.BMILabel setText:[NSString stringWithFormat:@"BMI %.1lf  (18.5-25.0 optimum)", bmi.doubleValue]];
        }
        
        
        // Body fat
        NSNumber *bf = [Formulas Metric_bodyFat_sexMF:[NSNumber numberWithInt:sex] height_cm:[NSNumber numberWithDouble:height] waist:[NSNumber numberWithDouble:waist] weight_kg:[NSNumber numberWithDouble:currentWeight]];
        bf = [NSNumber numberWithDouble:(bf.doubleValue * 100)];
        
        
        if (( bf.doubleValue > 0 ) && (bf.doubleValue < 100 )){

            if ( sex == 0 ){        // male
                if ( bf.doubleValue < 4 ){ [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf  (low)", bf.doubleValue]]; }
                else if ( bf.doubleValue < 13 ) { [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf  (athletic)", bf.doubleValue]]; }
                else if ( bf.doubleValue < 17 ) { [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf (fit)", bf.doubleValue]]; }
                else if ( bf.doubleValue < 25 ) { [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf (acceptable)", bf.doubleValue]]; }
                else { [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf  (high)", bf.doubleValue]]; }
            
            }else if ( sex == 1 ){      // female
                if ( bf.doubleValue < 12 ){ [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf  (low)", bf.doubleValue]]; }
                else if ( bf.doubleValue < 20 ) { [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf   (athletic)", bf.doubleValue]]; }
                else if ( bf.doubleValue < 24 ) { [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf   (fit)", bf.doubleValue]]; }
                else if ( bf.doubleValue < 31 ) { [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf   (acceptable)", bf.doubleValue]]; }
                else { [self.bodyFatLabel setText:[NSString stringWithFormat:@"Body fat %.1lf   (high)", bf.doubleValue]]; }
            }
        }
        
        
        // hip to waist ratio
        NSNumber *hipWaist = [Formulas Metric_hipToWaist_waist_cm:[NSNumber numberWithDouble:waist] hips_cm:[NSNumber numberWithDouble:hips]];
        
        if (( hipWaist.doubleValue > 0 ) && ( hipWaist.doubleValue < 200)){
            if ( sex == 0 ){        // male
                [self.hipWaistLabel setText:[NSString stringWithFormat:@"Waist to Hips %.2lf  (.9 is optimum)", hipWaist.doubleValue]];
            }else{                  // female
                [self.hipWaistLabel setText:[NSString stringWithFormat:@"Waist to Hips %.2lf  (.7 is optimum)", hipWaist.doubleValue]];
            }
        }
        
        
        // body surface area
        NSNumber *surfaceArea = [Formulas Metric_bodySurfaceArea_height_cm:[NSNumber numberWithDouble:height] weight_kgs:[NSNumber numberWithDouble:currentWeight]];
        
        [self.surfaceAreaLabel setText:[NSString stringWithFormat:@"Body surface area is %.2lf m^2", surfaceArea.doubleValue]];

               
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
