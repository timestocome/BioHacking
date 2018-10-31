//
//  StrengthViewController.h
//  Fitness
//
//  Created by Linda Cobb on 6/27/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StrengthViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    int pushups;
    int situps;
    int age;
    int sex;
    int units;
}


@property (nonatomic, retain) IBOutlet UILabel *pushupsResultsLabel;
@property (nonatomic, retain) IBOutlet UILabel *situpsResultsLabel;

@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;

@property (nonatomic, retain) NSArray *ageArray;
@property (nonatomic, retain) NSArray *situpsArray;
@property (nonatomic, retain) NSArray *pushupsArray;
@property (nonatomic, retain) NSArray *sexArray;

@property (nonatomic, retain) NSUserDefaults *defaults;

@property (nonatomic, retain) IBOutlet UIImageView *situpsImageView;
@property (nonatomic, retain) IBOutlet UIImageView *pushupsImageView;
@property (nonatomic, retain) IBOutlet UIImageView *situpsMark;
@property (nonatomic, retain) IBOutlet UIImageView *pushupsMark;


@end
