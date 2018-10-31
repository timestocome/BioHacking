//
//  CaloriesViewController.h
//  bmicalories
//
//  Created by Linda Cobb on 6/25/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaloriesViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    int sex;
    int units;
    int age;
    double height;
    double currentWeight;
    double goalWeight;
}

@property (nonatomic, strong) IBOutlet UIPickerView *pickerView;

@property (nonatomic, strong) NSUserDefaults *defaults;

@property (nonatomic, strong) NSArray *sexArray;
@property (nonatomic, strong) NSArray *heightArray;
@property (nonatomic, strong) NSArray *ageArray;
@property (nonatomic, strong) NSArray *currentWeightArray;
@property (nonatomic, strong) NSArray *goalWeightArray;

@property (nonatomic, weak) IBOutlet UILabel *heightLabel;
@property (nonatomic, weak) IBOutlet UILabel *currentWeightLabel;
@property (nonatomic, weak) IBOutlet UILabel *goalWeightLabel;

@property (nonatomic, weak) IBOutlet UILabel *goalCouchPotatoLabel;
@property (nonatomic, weak) IBOutlet UILabel *goalOfficeWorkerLabel;
@property (nonatomic, weak) IBOutlet UILabel *goalDailyWalkerLabel;
@property (nonatomic, weak) IBOutlet UILabel *goalAthleteLabel;

@property (nonatomic, weak) IBOutlet UILabel *currentCouchPotatoLabel;
@property (nonatomic, weak) IBOutlet UILabel *currentOfficeWorkerLabel;
@property (nonatomic, weak) IBOutlet UILabel *currentDailyWalkerLabel;
@property (nonatomic, weak) IBOutlet UILabel *currentAthleteLabel;

@property (nonatomic, weak) IBOutlet UILabel *differenceLabel;
@property (nonatomic, weak) IBOutlet UILabel *milesPerHundredCaloriesLabel;

@end
