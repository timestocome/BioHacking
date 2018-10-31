//
//  WhatIfViewController.h
//  bmicalories
//
//  Created by Linda Cobb on 6/25/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WhatIfViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    
    int units;
    int minutesWalking;
    int minutesJogging;
    int calorieReduction;
    
    double currentWeight;
    double goalWeight;
}





@property (nonatomic, strong) IBOutlet UIPickerView *pickerView;

@property (nonatomic, strong) NSUserDefaults *defaults;

@property (nonatomic, strong) NSArray *walkingArray;
@property (nonatomic, strong) NSArray *joggingArray;
@property (nonatomic, strong) NSArray *caloriesArray;
@property (nonatomic, strong) NSArray *currentWeightArray;
@property (nonatomic, strong) NSArray *goalWeightArray;

@property (nonatomic, weak) IBOutlet UILabel *currentWeightLabel;
@property (nonatomic, weak) IBOutlet UILabel *goalWeightLabel;

@property (nonatomic, weak) IBOutlet UILabel *poundsWalkingLabel;
@property (nonatomic, weak) IBOutlet UILabel *poundsJoggingLabel;
@property (nonatomic, weak) IBOutlet UILabel *poundsCaloriesLabel;
@property (nonatomic, weak) IBOutlet UILabel *totalLabel;
@property (nonatomic, weak) IBOutlet UILabel *goalDateLabel;

@end
