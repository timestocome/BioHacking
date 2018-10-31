//
//  ViewController.m
//  PulseReader
//
//  Created by Linda Cobb on 5/17/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import "PulseViewController.h"







@implementation PulseViewController

dispatch_queue_t mainQueue;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // guess 15fps light off to start things
    fps = 15;
    hz = fps;
    
    [self setupGraphs];
    [self setupFFT];
}



- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];

}


// set up the camera and start taking video
-(IBAction)start:(id)sender
{
    // init global vars
    self.zero = [[NSNumber alloc] initWithDouble:0.0];
    fftLoopCount = 0;
    dataCount = 0;
    
    // find and use back facing camera
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    if ( videoDevices.count < 1 ){
        
        [self.fingerLabel setText:@"No rear facing camera found"];
        return;
    }
    
    
    for ( AVCaptureDevice *device in videoDevices){
        if ( device.position == AVCaptureDevicePositionBack){
            self.videoDevice = device;
        }
    }
    
    
    // set up video input
    NSError *error = nil;
    self.session = [AVCaptureSession new];
    
    // measure pulse from 40-230bpm = ~.5 - 4bps * 2 to remove aliasing need 8 frames/sec minimum
    // presetLow captures 15 fps with light on, 7 with light off
    [self.session setSessionPreset:AVCaptureSessionPresetLow];
    
    
    [self.session beginConfiguration];
    [self.videoDevice lockForConfiguration:&error];
    [self.videoDevice setTorchMode:AVCaptureTorchModeOn];
    [self.videoDevice unlockForConfiguration];
    [self.session commitConfiguration];
    
    
    self.videoInput = [AVCaptureDeviceInput deviceInputWithDevice:self.videoDevice error:&error];
    self.dataOutput = [[AVCaptureVideoDataOutput alloc] init];
    self.dataOutput.videoSettings = [NSDictionary dictionaryWithObject:
                                     [NSNumber numberWithInt:kCVPixelFormatType_32BGRA]
                                                                forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    
    [self.session addInput:self.videoInput];
    [self.session addOutput:self.dataOutput];
    
    [self.dataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    [self.session startRunning];
    
    
    // get total pixels per frame
    AVCaptureInput *input = [self.session.inputs objectAtIndex:0]; // maybe search the input in array
    AVCaptureInputPort *port = [input.ports objectAtIndex:0];
    CMFormatDescriptionRef formatDescription = port.formatDescription;
    CMVideoDimensions dimensions = CMVideoFormatDescriptionGetDimensions(formatDescription);
    totalPixels = dimensions.height * dimensions.width;
    
    [self.fingerLabel setText:@"Hold your finger lightly on the rear camera"];
    
    [self.pulseLabelR setText:@"?"];
    
    self.startTime = [NSDate date];
}





// grab the images from the camera and process
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    // calculate our actual fps
    NSDate* new_date = [NSDate date];
    hz = 1.0/[new_date timeIntervalSinceDate: self.old_date];
    fps = hz;
    self.old_date = new_date;
    
    
    // get the image from the camera
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    // lock buffer
    CVPixelBufferLockBaseAddress(pixelBuffer, 0);
    
    // grab image info
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    uint8_t *src_buff = (uint8_t*)CVPixelBufferGetBaseAddress(imageBuffer);
    
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    int numberOfPixels = (int)(width * height);
    int perColorPixels = numberOfPixels/4;
    
    
    // compute the brightness for reg, green, blue and total
    
    // separate image into colors
    float redVector[numberOfPixels];
    
    
    vDSP_vfltu8(src_buff+2, 4, redVector, 1, perColorPixels);
    
    
    
    // compute average per color
    float redAverage = 0;
    float blueAverage = 0;
    
    vDSP_meamgv(redVector, 1, &redAverage, perColorPixels);
    
    
    
    
    
    // check to see if there is a finger over the camera lens
    if (  redAverage < 100 ){
        
        [self.fingerLabel setText:@"Place your finger lightly over back lens"];
        
    }else{
        [self.fingerLabel setText:@""];
        
        
        // update graph and timer
        totalTime = [[NSDate date] timeIntervalSinceDate:self.startTime];
        int minutes = floor(totalTime/60);
        int seconds = totalTime - minutes * 60;
        
        
        
        // draw graph
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.dataGraph addR:[NSNumber numberWithDouble:redAverage]];
            [self.timeLabel setText:[NSString stringWithFormat:@"%02d:%02d", minutes, seconds ]];
        });
        
        
        // store input data in arrays to send to fft and bar graph
        dispatch_async(dispatch_get_main_queue(), ^{
            [self storeDataForFFT:redAverage green:0.0 blue:blueAverage];
        });
    }
    
}





// stuffs raw data (average brightness) in to an array the size of fft window
// then calls fft to calculate signal hz and update bar graph
- (void)storeDataForFFT:(float)red green:(float)green blue:(float)blue
{
    // save data
    // first fill up array
    if ( dataCount < WINDOW_SIZE ){
        dataInR[dataCount] = red;
        dataCount++;
        
        // then pop oldest off top push newest onto end
    }else{
        for(int i=0; i<(WINDOW_SIZE-1); i++){
            dataInR[i] = dataInR[i+1];
        }
        
        // put the newest data point on the end
        dataInR[WINDOW_SIZE-1] = red;
    }
    
    
    // calls FFT if new data > LOOP_COUNT
    //  fps = fft call once per second
    // tried calling it once every 2 or 3 seconds but still
    // takes about 20 seconds to get a good reading
    // calling it more than once a second slightly speeds up reading but
    // initial reads not as stable
    
    if ( fftLoopCount >= fps  ){
        
        fftLoopCount = 0;
        [self realFFT:dataInR];
        
    }else{ fftLoopCount++; }
}





- (void) realFFT:(float *)dataR
{
    // cast each color brightness to a complex vector and divide into odd/even
    vDSP_ctoz((COMPLEX *)dataR, 2, &R, 1, WINDOW_SIZE_OVER_2);
    
    // carry out the FFT on scaled avg brightness
    vDSP_fft_zrip (setupFFTr, &R, 1, log2n, FFT_FORWARD);
    
    
    // clear out previous peaks
    maxR = 0.0;         powerR = 0.0;
    
    
    // BPM likely between 30-240 trim off extra frequencies to save time
    // trim edge, peak search is time consuming
    int maxSearch = WINDOW_SIZE_OVER_2;     // maximum data available
    maxSearch /= 2.0;                       // remove frequencies that map to > 240bpm
    int minSearch = 10;                      // ~30 bpm
    
    
    // find the peaks
    for ( int i=minSearch; i<maxSearch; i++){
        
        // calculate power
        powerR = sqrtf(R.realp[i] * R.realp[i] + R.imagp[i] * R.imagp[i]);
        
        // find the peak power
        if ( powerR > maxR){
            maxR = powerR;
            binR = i;
        }
        
    }
    
    
    // calculate strongest frequency and convert to BPM ( hz * bin * 60 )/Window_size
    // check to be sure we're not still bounncing around and we've settled on a pulse rate
    double error = (hz * 60)/(WINDOW_SIZE * 2.0);
    
    
    // blue usually settles first followed by red followed by green
    bpmR = (hz * binR * 60)/WINDOW_SIZE;
    
    
    
    if ( totalTime > 15.0){     // give us time to get a good measurement
        if ( binR > minSearch ){
            
            // update the screen numbers
            if (( bpmR < (lastBpmR + error)) && (bpmR > (lastBpmR - error))) {
                float rate = 120.0/bpmR;
                self.heartRate = [NSNumber numberWithDouble:bpmR];

                
                [UIView animateWithDuration:rate animations:^{
                    [self.pulseLabelR setText:[NSString stringWithFormat:@"%d", bpmR]];
                    self.pulseLabelR.transform = CGAffineTransformMakeScale(1.2,1.2);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:rate animations:^{
                        self.pulseLabelR.transform = CGAffineTransformIdentity;
                    }];
                }];
                [self.fingerLabel setText:@""];
                
            }else{
                [self.pulseLabelR setText:@"?"];
            }
            lastBpmR = bpmR;
        }
    }
    
}




- (void)setupGraphs
{
    // set up graphs
    [self.dataGraph setupGraph:self.dataGraph.bounds.size.width*2];
    
    
    // set input data arrays to zero it'll take time to fill them
    for (int i=0; i<WINDOW_SIZE; i++){
        dataInR[i] = 0.0;
    }
    
}





-(void)setupFFT
{
    // set up fft
    log2n = log2(WINDOW_SIZE);
    
    R.realp = (float *)malloc(WINDOW_SIZE_OVER_2 * sizeof(float));
    R.imagp = (float *)malloc(WINDOW_SIZE_OVER_2 * sizeof(float));
    
    // set up memory for FFT
    setupFFTr = vDSP_create_fftsetup (log2n, FFT_RADIX2);
    
}









- (IBAction)stop:(id)sender
{
    [self.session stopRunning];
    [self.fingerLabel setText:@""];
}





- (void)viewWillDisappear:(BOOL)animated
{
    
    // health kit
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    healthKitStorePermission = [[defaults objectForKey:@"healthStorePermission"] intValue];
    if ( healthKitStorePermission == 1 ){
        
        _healthKitCommon = [HealthKitCommon new];
        [self.healthKitCommon getHealthKit];
        [self.healthKitCommon savePulseRateIntoHealthStore:self.heartRate];
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
