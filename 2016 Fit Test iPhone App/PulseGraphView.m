//
//  SimpleGraphView.m
//  TestHardware
//
//  Created by Linda Cobb on 3/19/13.
//  Copyright (c) 2013 Linda Cobb. All rights reserved.
//

#import "PulseGraphView.h"

@implementation PulseGraphView




- (void)setupGraph:(int)pts
{
    area = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
    
    // colors
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    
    CGFloat red[4] = { 0.8, 0.0, 0.0, 1.0};
    rColor = CGColorCreate(rgb, red);
    
    CGFloat white[4] = { 1.0, 1.0, 1.0, 1.0 };
    backgroundColor = CGColorCreate(rgb, white);
    
    CGColorSpaceRelease(rgb);
    
    
    // scale in x direction
    pixelsXDirection = (int)area.size.width * 2;
    numberOfPoints = pts;
    width = self.bounds.size.width;
    
    
    // big scale up so we can see tiny differences
    height = self.bounds.size.height;           // height of graph
    middle = height/2.0;
    yScale = 10.0;                              // tiny changes need very large scale to see them
    
    
    // set up storage for data
    self.dataArrayR = [[NSMutableArray alloc] initWithCapacity:numberOfPoints];
    for( int i=0; i<numberOfPoints; i++){
        [self.dataArrayR insertObject:[NSNumber numberWithDouble:0.0] atIndex:i];
    }
    
    
    // slow graph down
    loopCount = 0;
    averagePerSecond = 0.0;
    fps = 5;       // incoming data is fps
    xScale = (int)(fps/2.0);
    
    
    // draw background
    [self setNeedsDisplay];
}








// FIFO stack of data points
-(void)addR:(NSNumber *)red
{
    loopCount++;
    
    if ( loopCount >= fps ){
        averagePerSecond = averagePerSecond / xScale;
        
        [self.dataArrayR insertObject:[NSNumber numberWithDouble:averagePerSecond] atIndex:0];
        [self.dataArrayR removeObjectAtIndex:numberOfPoints - 1];
        
        [self setNeedsDisplay];
        averagePerSecond = 0.0;
        loopCount = 0;
        
    }else{
        averagePerSecond += red.doubleValue;
        loopCount++;
    }
    
}






// draw the points and connect them with lines
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set up background
    CGContextSetFillColorWithColor(context, backgroundColor);
    CGContextFillRect(context, self.bounds);
    CGContextSetStrokeColorWithColor(context, rColor);
    
    x = 0;
    
    // plot points
    for (int i=0; i<numberOfPoints; i++){
        
        // plot data
        r = ([(NSNumber *)self.dataArrayR[i] doubleValue]) * yScale;        // scale so small diffs visible
        x += xScale;
        
        while ( r > height ){ r -= height; }                                // recenter oh graph
        
        
        if ( r > 0 ){
            CGContextMoveToPoint(context, previousX, previousR);
            CGContextAddLineToPoint(context, x, r);
            
            CGContextSetLineWidth(context, 3.0);
            CGContextStrokePath(context);
            
            previousR = r;
            previousX = x;
        }else{
            x = 0.0;
            previousX = 0.0;
        }
        
    }
}








@end