//
//  ViewController.h
//  PulseReader
//
//  Created by Linda Cobb on 5/17/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
#import <AVFoundation/AVFoundation.h>
#import <Accelerate/Accelerate.h>

#import "PulseGraphView.h"
#import "HealthKitCommon.h"



#define WINDOW_SIZE             256                 // granularity of measurement
// hz * bin * 60 / window_size
// 15 * 1 * 60 / 256 ~+/- 3.5 bpm

#define PI                      3.1415926           // pi
#define WINDOW_SIZE_OVER_2      WINDOW_SIZE/2       // fft needs this



@interface PulseViewController : UIViewController <AVCaptureVideoDataOutputSampleBufferDelegate>
{
    int             dataCount;                  // tracks count of data points to stuff in array for fft
    int             fftLoopCount;               // count how many times we've grabbed data between FFT calls
    
    float           dataInR[WINDOW_SIZE];        // average brightness per frame per color
    
    double          powerR;                     // find most powerful frequency
    float           maxR;
    int             binR;
    
    
    int             r;                          // sums up raw color data
    double          averageR;                   // averaged raw color data
    double          totalPixels;                // double so we don't have to cast to double when we compute the avg
    
    
    COMPLEX_SPLIT   R;                          // FFT vars
    FFTSetup        setupFFTr;
    int             log2n;
    
    
    double              hz;                     // for this program hz == fps
    int                 fps;                    // default is about 15 fps with light on, 7 with light off
    // must be 2x highest frequency
    // 15 fps = 900/min = max heart rate of 450 bpm
    int                 bpmR;
    int                 lastBpmR;
    
    NSTimeInterval      totalTime;
    
    int healthKitStorePermission;

    
}


// video vars
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDevice *videoDevice;
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;
@property (nonatomic, strong) AVCaptureVideoDataOutput *dataOutput;


// graphs
@property (nonatomic, strong) IBOutlet PulseGraphView *dataGraph;
@property (strong, nonatomic) NSNumber *zero;


// user info
@property (nonatomic, strong) IBOutlet UILabel *pulseLabelR;
@property (nonatomic, strong) IBOutlet UILabel *fingerLabel;


// timer
@property (strong, nonatomic) NSDate *startTime;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;


// used to calculate fps
@property (nonatomic, strong) NSDate *old_date;
@property (nonatomic, strong) NSDate *lastReadingDate;

// camera controls
- (IBAction)start:(id)sender;
- (IBAction)stop:(id)sender;



// save data
@property (nonatomic, retain) HealthKitCommon *healthKitCommon;
@property (nonatomic, retain) NSNumber* heartRate;




@end
