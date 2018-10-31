//
//  SettingsViewController.m
//  bmicalories
//
//  Created by Linda Cobb on 6/25/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import "SettingsViewController.h"



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
    

}


- (void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:YES];

    // draw a random quote
	NSArray *quotes = [[NSArray alloc] initWithObjects:
                       @"If you're walking to lose weight use an incline to speed things up.",
                       @"Use different speeds when you walk or run to help you go further.",
                       @"The first 30 minutes burns energy, longer burns fat.",
                       @"Find some cool podcasts or audio books to keep you company on your walks.",
                       @"Pay attention to your posture when you walk, keep those core muscles working too.",
                       @"Holding in your stomach while you walk, rapidly reduces your waisline.",
                       @"Walk on your toes a bit to shape those leg muscles.",
                       @"Move your arms while you walk to burn more calories.",
                       @"Track what you eat, often you can find one or two small things to change to reduce your daily calorie intake.",
                       @"Running burns about 30% more calories than walking.",
                       @"Treadmills are easier on the joints but you burn less calories on them.",
                       @"Set a goal for yourself each week.",
                       @"The average person needs to walk 45 miles a month at 3 mph to burn one pound.",
                       @"Bring a friend on a walk, talking makes the time go quickly.",
                       @"Walking and running improves your mood.",
                       @"You can do it.",
                       @"Just do it.",
                       @"You look marvelous.",
                       @"Keep on trucking.",
                       @"The biggest journey begins with one step.",
                       @"Walking and running reduce stress.",
                       @"Walking and running lowers blood pressure.",
                       @"A walk a day keeps the doctor away.",
                       @"A run a day keeps the grim reaper away.",
                       @"If I could not walk far and fast, I think I should just explode and perish. (Dickens)",
                       @"An early morning walk is a blessing for the whole day. (Thoreau)",
                       @"If you want to know if your brain is flabby, feel your thighs. (Barton)",
                       @"Of all the exercises walking is best. (Jefferson)",
                       @"Walking is man's best medicine. (Hippocrates)",
                       @"Every minute walking extends your life by 2 minutes, you're doubling your time",
                       @"Smile, smile, smile",
                       @"Learn a foreign language while you walk, there are plenty of free classes on iTunes",
                       @"Physical exercise improves brain functioning.",
                       @"Exercise reduces the risk of dementia by two thirds.",
                       @"Exercise greatly reduces the risk of cancer.",
                       @"Eat food, real food, mostly fruits and vegetables",
                       @"5 servings of fruits and vegetables a day is only 2.5 cups",
                       @"5 servings of fruits or vegetables and 30 mintues exercise keeps the doctor away",
                       @"Vegetables are a must on a diet.  I suggest carrot cake, zucchini bread, and pumpkin pie. Jim Davis",
                       @"It's so beautifully arranged on the plate - you know someone's fingers have been all over it. Julia Child",
                       @"Eat breakfast like a king, lunch like a prince, and dinner like a pauper.  Adelle Davis ",
                       nil];
    
	srand(time(NULL));
	long r = rand()%[quotes count];
	[self.quoteTextView setText:[quotes objectAtIndex:r]];
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
            
            [picker setSubject:[NSString stringWithFormat:@"BMI-Calories V 13.0 Request"]];
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



-(IBAction)unitsChanged:(id)sender
{
    units = [self.unitsSegmentedControl selectedSegmentIndex];
    [self.defaults setObject:[NSNumber numberWithInt:units] forKey:@"units"];
}


-(IBAction)FitTest:(id)sender
{
    [[UIApplication sharedApplication]
     openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/us/app/fit-test/id343404650?mt=8"]];
}


-(IBAction)HowMany:(id)sender
{
    [[UIApplication sharedApplication]
     openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/us/app/how-many-calories-calorie/id374205850?mt=8"]];
}



- (void)viewWillDisappear:(BOOL)animated
{
 //   [self.defaults synchronize];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
