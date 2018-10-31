//
//  BodyViewController.h
//  Fitness
//
//  Created by Linda Cobb on 6/27/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthKitCommon.h"


@interface BodyViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    int sex;
    int units;
    int healthKitStorePermission;
    double waist;
    double height;
    double currentWeight;
    double hips;
}

@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;

@property (nonatomic, retain) NSUserDefaults *defaults;

@property (nonatomic, retain) NSArray *sexArray;
@property (nonatomic, retain) NSArray *waistArray;
@property (nonatomic, retain) NSArray *heightArray;
@property (nonatomic, retain) NSArray *currentWeightArray;
@property (nonatomic, retain) NSArray *hipsArray;


@property (nonatomic, weak) IBOutlet UILabel *waistLabel;
@property (nonatomic, weak) IBOutlet UILabel *heightLabel;
@property (nonatomic, weak) IBOutlet UILabel *currentWeightLabel;
@property (nonatomic, weak) IBOutlet UILabel *hipsLabel;


@property (nonatomic, weak) IBOutlet UILabel *BMILabel;
@property (nonatomic, weak) IBOutlet UILabel *bodyFatLabel;
@property (nonatomic, weak) IBOutlet UILabel *hipWaistLabel;
@property (nonatomic, weak) IBOutlet UILabel *surfaceAreaLabel;



@property (nonatomic, retain) IBOutlet UIImageView *waistHipsImageView;
@property (nonatomic, retain) IBOutlet UIImageView *bmiImageView;
@property (nonatomic, retain) IBOutlet UIImageView *bfImageView;

@property (nonatomic, retain) IBOutlet UIImageView *waistHipsMark;
@property (nonatomic, retain) IBOutlet UIImageView *bmiMark;
@property (nonatomic, retain) IBOutlet UIImageView *bfMark;

@property (nonatomic, retain) HealthKitCommon *healthKitCommon;
@property (nonatomic, retain) NSNumber* bf;
@property (nonatomic, retain) NSNumber* bmi;
@property (nonatomic, retain) NSNumber* leanBodyMass;
@property (nonatomic, retain) NSNumber* weightInPounds;


@end
