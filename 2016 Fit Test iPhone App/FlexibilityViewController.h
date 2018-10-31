//
//  FlexibilityViewController.h
//  Fitness
//
//  Created by Linda Cobb on 6/27/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlexibilityViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    int age;
    int reachRow;
}


@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;
@property (nonatomic, retain) NSArray *reachArray;
@property (nonatomic, retain) NSArray *ageArray;

@property (nonatomic, weak) IBOutlet UILabel *resultsLabel;

@property (nonatomic, retain) NSUserDefaults *defaults;

@property (nonatomic, weak) IBOutlet UIImageView *scoreImageView;
@property (nonatomic, strong) IBOutlet UIImageView *markImageView;

@property (nonatomic, retain) NSString *reach;

@end
