//
//  SettingsViewController.h
//  Fitness
//
//  Created by Linda Cobb on 6/27/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <HealthKit/HealthKit.h>



@interface SettingsViewController : UIViewController <MFMailComposeViewControllerDelegate, UIPopoverPresentationControllerDelegate>
{
    int     units;
    int     healthKitStorePermission;
}


@property (nonatomic, weak) IBOutlet UISegmentedControl *unitsSegmentedControl;

@property (nonatomic, retain) HKHealthStore* healthStore;
@property (nonatomic, weak) IBOutlet UISwitch* healthKitSwitch;
@property (nonatomic, weak) IBOutlet UILabel* healthKitLabel;

@property (nonatomic, strong) NSString *messageString;

@property (nonatomic, retain) NSUserDefaults *defaults;


@property (nonatomic, retain) IBOutlet UILabel *bmiLabel;
@property (nonatomic, retain) IBOutlet UILabel *bodyFatLabel;
@property (nonatomic, retain) IBOutlet UILabel *rockportLabel;
@property (nonatomic, retain) IBOutlet UILabel *runLabel;
@property (nonatomic, retain) IBOutlet UILabel *situpsLabel;
@property (nonatomic, retain) IBOutlet UILabel *pushupsLabel;
@property (nonatomic, retain) IBOutlet UILabel *flexibilityLabel;

@property( nonatomic, weak) IBOutlet UIView *shareView;

- (IBAction)units:(id)sender;
- (IBAction)health:(id)sender;

- (IBAction)emailTechSupport:(id)sender;
- (IBAction)shareAlert:(id)sender;

-(IBAction)share:(id)sender;
-(IBAction)rate:(id)sender;



@end
