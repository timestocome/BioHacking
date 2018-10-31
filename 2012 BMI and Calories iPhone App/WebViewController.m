//
//  WebViewController.m
//  AlertMe
//
//  Created by Linda Cobb on 4/1/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import "WebViewController.h"



@implementation WebViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];

    [self.webView setScalesPageToFit:YES];
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://timestocomemobile.com/apps/"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:urlRequest];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




@end
