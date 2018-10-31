//
//  SimpleGraphView.h
//  TestHardware
//
//  Created by Linda Cobb on 3/19/13.
//  Copyright (c) 2013 Linda Cobb. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface PulseGraphView : UIView
{
    CGRect          area;
    int             numberOfPoints;
    int             pixelsXDirection;
    
    float           r, x;
    float           previousR;
    float           previousX;
    CGPoint         px;
    
    float           width, height, middle;
    
    CGColorRef      rColor;
    CGColorRef      backgroundColor;
    
    float           yScale;
    float           scale;
    
    int             loopCount;
    float           averagePerSecond;
    int             fps;    // incoming data is 15fps, set this to 15 to draw once per second
    int             xScale;
    
}



@property (nonatomic, strong) NSMutableArray *dataArrayR;



-(void)addR:(NSNumber *)r;
-(void)setupGraph:(int)numberOfPoints;



@end
