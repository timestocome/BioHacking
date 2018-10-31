//
//  SettingsViewController.h
//  bmicalories
//
//  Created by Linda Cobb on 6/25/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface SettingsViewController : UIViewController <MFMailComposeViewControllerDelegate>
{
    int units;
}

@property (nonatomic, weak) IBOutlet UISegmentedControl *unitsSegmentedControl;
@property (nonatomic, weak) IBOutlet UITextView *quoteTextView;

@property (nonatomic, strong) NSUserDefaults *defaults;

-(IBAction)emailTechSupport:(id)sender;
-(IBAction)unitsChanged:(id)sender;

-(IBAction)FitTest:(id)sender;
-(IBAction)HowMany:(id)sender;

@end
