//
//  GPSAndStopWatchViewController.m
//  VO2Max
//
//  Created by Linda Cobb on 6/29/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import "GPSAndStopWatchViewController.h"
#import "Formulas.h"


dispatch_queue_t mainQueue;


@implementation GPSAndStopWatchViewController




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
    
    gpsLock = 0;
    
	buttonFade = 0.3;
	[UIView beginAnimations:@"buttonFades" context:nil];
	[UIView setAnimationDuration:buttonFade];
	[self.startButton setEnabled:YES];
	[self.startButton setAlpha:1.0];
	
	[self.stopButton setEnabled:NO];
	[self.stopButton setAlpha:buttonFade];
	
	[UIView commitAnimations];
    
    [self loadScreenData];
    
}



- (IBAction)startTracking:(id)sender
{
    //set location manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    // permission check
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }

    
    
    [self.locationManager startUpdatingLocation];
    
    
   // self.startTime = [NSDate date];
    
    hDistance = 0.0;
    
    graphTimer = 0.0;
    totalTime = 0.0;

    graphDistance = 0.0;
    graphTimer = 0.0;
    
    
    // let user know we're looking for gps lock and change color when lock is good
    [self.gpsLockLongitudeLabel setTextColor:[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.000]];
    [self.gpsLockLatitudeLabel setTextColor:[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.000]];
    
    [self.gpsLockLatitudeLabel performSelectorOnMainThread:@selector(setText:) withObject:@"locating" waitUntilDone:NO];
    [self.gpsLockLongitudeLabel performSelectorOnMainThread:@selector(setText:) withObject:@"locating" waitUntilDone:NO];
    
    
    
    [self.distanceLabel setText:@"0.00"];
    [self.totalTimeLabel setText:@"00:00"];
    
    [UIView beginAnimations:@"buttonFades" context:nil];
	[UIView setAnimationDuration:0.5];
	[self.startButton setEnabled:NO];
	[self.startButton setAlpha:buttonFade];
	
	[self.stopButton setEnabled:YES];
	[self.stopButton setAlpha:1.0];
    
	[UIView commitAnimations];
	
}



- (void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:NO];

    units = [[self.defaults objectForKey:@"units"] intValue];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
		
	[self loadScreenData];
}










- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"gps data %@", newLocation);

    
    [self.gpsLockLatitudeLabel setTextColor:[UIColor colorWithRed:0.0 green:0.7 blue:0.0 alpha:1.000]];
    [self.gpsLockLongitudeLabel setTextColor:[UIColor colorWithRed:0.0 green:0.7 blue:0.0 alpha:1.000]];
    
    
    double distanceH = [newLocation distanceFromLocation:oldLocation];
    double distanceV = newLocation.altitude - oldLocation.altitude;
    double timeDiff = [newLocation.timestamp timeIntervalSinceDate:oldLocation.timestamp];
    
    
    
    // check data is valid
    if (isnan(timeDiff)){ NSLog(@"bad time diff %lf ", timeDiff);
    }else if (newLocation.speed < 0.0) { NSLog(@"bad speed %lf", newLocation.speed);
    }else if (distanceH > 10.0){ NSLog(@"bad horizontal distance %lf", distanceH);
    }else if (distanceV > 10.0){ NSLog(@"bad vertical distance %lf", distanceV);
    }else{
        
        if ( gpsLock == 0 ){
            gpsLock = 1;
            self.startTime = [NSDate date];

        }
        
        hDistance += distanceH;
        movingTime += timeDiff;
        averageSpeed = hDistance/movingTime;

        
        [self.gpsLockLatitudeLabel performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.4lf\u00B0", newLocation.coordinate.latitude] waitUntilDone:NO];
        [self.gpsLockLongitudeLabel performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.4lf\u00B0", newLocation.coordinate.longitude] waitUntilDone:NO];
        
        
        // convert seconds to hours and mins
        totalTime = [[NSDate date] timeIntervalSinceDate:self.startTime];
        
        int hours = floor(totalTime/3600);
        int minutes = floor((totalTime - (hours * 3600)) / 60);
        int seconds = totalTime - (minutes*60) - (hours*3600);
        
        [self.totalTimeLabel performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%02d:%02d", minutes, seconds] waitUntilDone:NO];
        
        

        int twelveMinutes = 60 * 12;
        if ( totalTime >= twelveMinutes ){
            [self stopTracking:nil];
        }
        
        
        if ( units == 0 ){
            [self.distanceLabel setText: [NSString stringWithFormat:@"%.3lf m",
                                          [[Formulas metersToMiles:[NSNumber numberWithDouble:hDistance]]  doubleValue]]];
            
        }else{
            
            [self.distanceLabel setText:[NSString stringWithFormat:@"%.3lf km",
                                         [[Formulas metersToKilometers:[NSNumber numberWithDouble:hDistance]]  doubleValue]]];
            
        }
    }
    
}





- (IBAction)stopTracking:(id)sender
{
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
    gpsLock = 0;
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

    
    [self.gpsLockLatitudeLabel setTextColor:[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.000]];
    [self.gpsLockLongitudeLabel setTextColor:[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.000]];
    
    [self.gpsLockLongitudeLabel setText:@"off"];
    [self.gpsLockLatitudeLabel setText:@"off"];
    
    
	[UIView beginAnimations:@"buttonFades" context:nil];
	[UIView setAnimationDuration:0.5];
	[self.startButton setEnabled:YES];
	[self.startButton setAlpha:1.0];
	
	[self.stopButton setEnabled:NO];
	[self.stopButton setAlpha:buttonFade];
	
	[UIView commitAnimations];
    
    [self saveScreenData];
    
}








// save screen data so user sees last stats upon openning the application
-(void)saveScreenData
{
    [NSDateFormatter setDefaultFormatterBehavior:0];
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateStyle:NSDateFormatterShortStyle];
	
	NSDate *savedDate = [self.defaults objectForKey:@"date"];
	NSString *date = [df stringFromDate:savedDate];
    
    [self.defaults setObject:[self.distanceLabel text] forKey:@"lastDistance"];
    [self.defaults setObject:[self.totalTimeLabel text] forKey:@"lastTime"];
       [self.defaults setObject:date forKey:@"lastDate"];
    
}





// load screen data so user can see last run stats
-(void)loadScreenData
{
    [self.distanceLabel setText:[self.defaults objectForKey:@"lastDistance"]];
    if ( ![self.distanceLabel.text compare:@""] ){ self.distanceLabel.text = @"0.000"; }
    
    [self.totalTimeLabel setText:[self.defaults objectForKey:@"lastTime"]];
    if ( ![self.totalTimeLabel.text compare:@""] ){ self.totalTimeLabel.text = @"00:00"; }
    
    
}







- (void)viewDidUnload
{
    [super viewDidUnload];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
