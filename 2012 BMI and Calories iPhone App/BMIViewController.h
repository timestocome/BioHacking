//
//  BMIViewController.h
//  bmicalories
//
//  Created by Linda Cobb on 6/25/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMIViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    int sex;
    int units;
    double waist;
    double height;
    double currentWeight;
    double hips;
}

@property (nonatomic, strong) IBOutlet UIPickerView *pickerView;

@property (nonatomic, strong) NSUserDefaults *defaults;

@property (nonatomic, strong) NSArray *sexArray;
@property (nonatomic, strong) NSArray *waistArray;
@property (nonatomic, strong) NSArray *heightArray;
@property (nonatomic, strong) NSArray *currentWeightArray;
@property (nonatomic, strong) NSArray *hipsArray;


@property (nonatomic, weak) IBOutlet UILabel *waistLabel;
@property (nonatomic, weak) IBOutlet UILabel *heightLabel;
@property (nonatomic, weak) IBOutlet UILabel *currentWeightLabel;
@property (nonatomic, weak) IBOutlet UILabel *hipsLabel;


@property (nonatomic, weak) IBOutlet UILabel *BMILabel;
@property (nonatomic, weak) IBOutlet UILabel *bodyFatLabel;
@property (nonatomic, weak) IBOutlet UILabel *hipWaistLabel;
@property (nonatomic, weak) IBOutlet UILabel *surfaceAreaLabel;



@end
