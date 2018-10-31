//
//  FutureWeightViewController.h
//  bmicalories
//
//  Created by Linda Cobb on 6/25/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FutureWeightViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    int units;
    int sex;
    int dailyCalories;
    int age;
    double height;
}


@property (nonatomic, strong) IBOutlet UIPickerView *pickerView;

@property (nonatomic, strong) NSUserDefaults *defaults;

@property (nonatomic, strong) NSArray *sexArray;
@property (nonatomic, strong) NSArray *dailyCaloriesArray;
@property (nonatomic, strong) NSArray *ageArray;
@property (nonatomic, strong) NSArray *heightArray;


@property (nonatomic, weak) IBOutlet UILabel *couchPotatoLabel;
@property (nonatomic, weak) IBOutlet UILabel *officeWorkerLabel;
@property (nonatomic, weak) IBOutlet UILabel *dailyWalkerLabel;
@property (nonatomic, weak) IBOutlet UILabel *athleteLabel;

@property (nonatomic, weak) IBOutlet UILabel *heightLabel;



@end
