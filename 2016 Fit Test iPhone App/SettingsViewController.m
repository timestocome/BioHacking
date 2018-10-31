//
//  SettingsViewController.m
//  Fitness
//
//  Created by Linda Cobb on 6/27/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"
#import "HealthKitCommon.h"







@implementation SettingsViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {}
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _defaults = [NSUserDefaults standardUserDefaults];
    units = [[self.defaults objectForKey:@"units"] intValue];
    [self.unitsSegmentedControl setSelectedSegmentIndex:units];
    
    healthKitStorePermission = [[self.defaults objectForKey:@"healthStorePermission"] intValue];
    [self.healthKitSwitch setOn:healthKitStorePermission];
    NSLog(@"health permission? %d",  healthKitStorePermission);
    
    if ([HKHealthStore isHealthDataAvailable]){
        self.healthKitSwitch.hidden = NO;
        self.healthKitLabel.hidden = NO;
    }else{
        self.healthKitSwitch.hidden = YES;
        self.healthKitLabel.hidden = YES;
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        _healthStore = [appDelegate healthStore];
    }
}



- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    
    double bmi = [[self.defaults objectForKey:@"bmi"]doubleValue];
    double bf = [[self.defaults objectForKey:@"bodyFat"] doubleValue];
    int pushups = [[self.defaults objectForKey:@"pushups"]doubleValue];
    int situps = [[self.defaults objectForKey:@"situps"]doubleValue];
    double vo2max = [[self.defaults objectForKey:@"vo2max"]doubleValue];
    double twelveMinuteRun = [[self.defaults objectForKey:@"distance"]doubleValue];
    int flexibility = [[self.defaults objectForKey:@"flexibility"] doubleValue];
    
    [self.bmiLabel setText:[NSString stringWithFormat:@"%.2lf", bmi]];
    [self.bodyFatLabel setText:[NSString stringWithFormat:@"%.2lf", bf]];
    [self.rockportLabel setText:[NSString stringWithFormat:@"%.2lf", vo2max]];
    [self.runLabel setText:[NSString stringWithFormat:@"%.2lf", twelveMinuteRun]];
    [self.pushupsLabel setText:[NSString stringWithFormat:@"%d", pushups]];
    [self.situpsLabel setText:[NSString stringWithFormat:@"%d", situps]];
    [self.flexibilityLabel setText:[NSString stringWithFormat:@"%d%%", flexibility]];
     
    self.messageString = [NSString stringWithFormat:@"BMI: %.2lf\n BodyFat: %.2lf\n VO2Max: %.2lf\n 12 minute run: %.1lf\n Pushups: %d\n Situps: %d\n Flexibility: %d%%", bmi, bf, vo2max, twelveMinuteRun, pushups, situps, flexibility];
    
}







- (IBAction)health:(id)sender
{
    // if health kit available and user switches to yes pop up view asking for various permissions and store them
    if ( [HKHealthStore isHealthDataAvailable]){
        NSLog(@"save health store permission %d", [self.healthKitSwitch isOn]);
        
        [self.defaults setObject:[NSNumber numberWithInt:[self.healthKitSwitch isOn]] forKey:@"healthStorePermission"];
        [self.defaults synchronize];
        
        if ( !self.healthStore ){
            self.healthStore = [[HKHealthStore alloc] init];
            
        }
    }
}








- (IBAction)units:(id)sender
{
    units = (int)[self.unitsSegmentedControl selectedSegmentIndex];
    [self.defaults setObject:[NSNumber numberWithInt:units] forKey:@"units"];
}



- (IBAction)shareAlert:(id)sender
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterShortStyle];
    NSString *dateString = [df stringFromDate:[NSDate date]];
    
    NSArray *shareItem = @[self.messageString, dateString];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:shareItem applicationActivities:nil];
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
            
            float osVersion = [[[UIDevice currentDevice]systemVersion]floatValue];
            if ( osVersion >= 8 ){

                activityController.popoverPresentationController.sourceView = self.shareView;
                [self presentViewController:activityController animated:YES completion:nil];
            }else{
                [self presentViewController:activityController animated:YES completion:nil];

            }
            
    }else{
        
        [self presentViewController:activityController animated:YES completion:nil];
    }
    

    
}








-(IBAction)emailTechSupport:(id)sender
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (mailClass != nil)
    {
        // We must always check whether the current device is configured for sending emails
        if ([mailClass canSendMail])
        {
            // send the email
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = self;
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
                [picker setSubject:[NSString stringWithFormat:@"Fit test V 12.0 iPad Request"]];
            }else{
                [picker setSubject:[NSString stringWithFormat:@"Fit test V 12.0 iPhone Request"]];
            }
            [picker setToRecipients:[NSArray arrayWithObject:@"timestocome@gmail.com"]];
            
            [self presentViewController:picker animated:YES completion:NULL];
            
        }else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mail Failed" message:@"Device unable to send email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mail Failed" message:@"Device unable to send email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}



// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}







-(IBAction)share:(id)sender
{
    NSString *messageString = @"FitTest Link: itms-apps://itunes.apple.com/us/app/fit-test/id343404650?mt=8";
    NSArray *shareItem = @[messageString];
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:shareItem applicationActivities:nil];
    
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        
        float osVersion = [[[UIDevice currentDevice]systemVersion]floatValue];
        if ( osVersion >= 8 ){
            
            activityController.popoverPresentationController.sourceView = self.shareView;
            [self presentViewController:activityController animated:YES completion:nil];
        }else{
            [self presentViewController:activityController animated:YES completion:nil];
            
        }
        
    }else{
        
        [self presentViewController:activityController animated:YES completion:nil];
    }
    


  
}




-(IBAction)rate:(id)sender
{
    [[UIApplication sharedApplication]
     openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id343404650"]];
    
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
