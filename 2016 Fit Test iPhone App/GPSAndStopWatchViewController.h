//
//  GPSAndStopWatchViewController.h
//  VO2Max
//
//  Created by Linda Cobb on 6/29/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Formulas.h"


@interface GPSAndStopWatchViewController : UIViewController <CLLocationManagerDelegate>
{
    
    int pace;
    int totalTime;
    
    double hDistance;
    double movingTime;
    double averageSpeed;
    
    double graphTimer, graphDistance;
    
    int gpsLock;
    
    int units;
    int accuracy;
    
    double buttonFade;
    

}





@property (retain, nonatomic) CLLocationManager *locationManager;

@property (retain, nonatomic) NSDate *timestamp;
@property (nonatomic, retain) NSDate *startTime;
@property (nonatomic, retain) NSDate *endTime;
@property (nonatomic, retain) NSDate *lastDetailRecordTimeStamp;


@property (nonatomic, retain) IBOutlet UILabel *distanceLabel;
@property (nonatomic, retain) IBOutlet UILabel *totalTimeLabel;
@property (nonatomic, retain) IBOutlet UILabel *gpsLockLongitudeLabel;
@property (nonatomic, retain) IBOutlet UILabel *gpsLockLatitudeLabel;

@property (nonatomic, retain) IBOutlet UIButton *startButton;
@property (nonatomic, retain) IBOutlet UIButton *stopButton;

@property (nonatomic, retain) NSUserDefaults *defaults;



- (IBAction)startTracking:(id)sender;
- (IBAction)stopTracking:(id)sender;

@end
