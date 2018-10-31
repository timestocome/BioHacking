//
//  AreobicsViewController.h
//  Fitness
//
//  Created by Linda Cobb on 6/27/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreobicsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> 
{
    int                     units;
	int						age;
    int                     restingPulse;
	double					distance;
}


@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;

@property (nonatomic, retain) NSArray *ageArray;
@property (nonatomic, retain) NSArray *restingPulseArray;
@property (nonatomic, retain) NSArray *distanceArray;

@property (nonatomic, retain) NSUserDefaults *defaults;

@property (nonatomic, retain) IBOutlet UILabel *estimatedVO2maxLabel;
@property (nonatomic, retain) IBOutlet UILabel *cooperTestV02maxLabel;
@property (nonatomic, retain) IBOutlet UILabel *distanceIn12minutesLabel;
@property (nonatomic, retain) IBOutlet UILabel *maxSustainableSpeedLabel;
@property (nonatomic, retain) IBOutlet UILabel *estimatedAgeMaleLabel;
@property (nonatomic, retain) IBOutlet UILabel *testedMaleLabel;
@property (nonatomic, retain) IBOutlet UILabel *estimatedAgeFemaleLabel;
@property (nonatomic, retain) IBOutlet UILabel *testedFemaleLabel;

@property (nonatomic, retain) IBOutlet UILabel *runLabel;
@property (nonatomic, retain) IBOutlet UILabel *runTimeLabelM;
@property (nonatomic, retain) IBOutlet UILabel *runTimeLabelF;





@end
