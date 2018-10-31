//
//  FlexibilityViewController.m
//  Fitness
//
//  Created by Linda Cobb on 6/27/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import "FlexibilityViewController.h"
#import "Formulas.h"
#import "PickerArrays.h"

@implementation FlexibilityViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {}
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    [self setupView];
}


- (void)viewWillAppear:(BOOL)animated
{
    self.markImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mark.png"]];
    self.markImageView.center = CGPointMake(160.0, 5.0);
    [self.scoreImageView addSubview:self.markImageView];

    [self setupView];
}

-(void)setupView
{
    _defaults = [NSUserDefaults standardUserDefaults];
    
    
    age = [[self.defaults objectForKey:@"age"] intValue];
    _reach = [self.defaults objectForKey:@"reach"];
    
    self.ageArray = [NSArray arrayWithArray:[PickerArrays ageArray]];
    self.reachArray = @[@"knees", @"mid calf", @"my ankle", @"my toes", @"palms flat on the floor"];
    
    int row = (int)[self.ageArray indexOfObject:[NSNumber numberWithInt:age]];
    if ( (row > 0) && (row < self.ageArray.count)  ){ [self.pickerView selectRow:row inComponent:0 animated:YES]; }
    
    row = (int)[self.reachArray indexOfObject:self.reach];
    if ( (row > 0) && (row < self.reachArray.count)  ){ [self.pickerView selectRow:row inComponent:1 animated:YES]; }
    reachRow = row;
    
    [self calculate];

}



- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ( component == 0 ){
        age = [[self.ageArray objectAtIndex:row] intValue];
        [self.defaults setObject:[NSNumber numberWithInt:age] forKey:@"age"];
    }else if ( component == 1){
        self.reach = [self.reachArray objectAtIndex:row];
        reachRow = (int)row;
        [self.defaults setObject:self.reach forKey:@"reach"];
    }
    
    [self calculate];
}




- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
	UILabel *title = (id)view;
	if (!title) {
		title= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
		title.backgroundColor = [UIColor clearColor];
		title.textAlignment = NSTextAlignmentCenter;
		title.shadowColor = [UIColor whiteColor];
		title.shadowOffset = CGSizeMake(0, 1);
        title.font = [UIFont boldSystemFontOfSize:16];
        
	}
	
    
    
    if ( component == 0 ){
        title.text = [NSString stringWithFormat:@"%@", [self.ageArray objectAtIndex:row]];
    }else {
        title.text = [self.reachArray objectAtIndex:row];
    }
    
    
	return title;
}




- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    float width;
    if ( component == 0 ){
        width = 50.0;
    }else{
        width = 250.0;
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        width *= 1.5;
    }
    return width;

    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ( component == 0 ){
        return [self.ageArray count];
    }else{
        return [self.reachArray count];
    }
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 2;
}


- (void)calculate
{
    CGPoint markPoint;
    
	if ( age < 35 ){
		if ( reachRow == 0 ){
			markPoint = CGPointMake(270.0, 5.0);
			[self.resultsLabel setText:@"Poor"];
            [self.defaults setObject:[NSNumber numberWithInt:20] forKey:@"flexibility"];
		}else if ( reachRow == 1 ){
			markPoint = CGPointMake(210.0, 5.0);
			[self.resultsLabel setText:@"Below Average"];
            [self.defaults setObject:[NSNumber numberWithInt:40] forKey:@"flexibility"];
		}else if ( reachRow == 2 ){
			markPoint = CGPointMake(150.0, 5.0);
			[self.resultsLabel setText:@"Average"];
            [self.defaults setObject:[NSNumber numberWithInt:60] forKey:@"flexibility"];
		}else if ( reachRow == 3 ){
			markPoint = CGPointMake(90.0, 5.0);
			[self.resultsLabel setText:@"Very Good" ];
            [self.defaults setObject:[NSNumber numberWithInt:80] forKey:@"flexibility"];
		}else {
			markPoint = CGPointMake(30.0, 5.0);
			[self.resultsLabel setText:@"Excellent"];
            [self.defaults setObject:[NSNumber numberWithInt:100] forKey:@"flexibility"];
		}
	}else if ( age < 55 ){
		if ( reachRow == 0 ){
			markPoint = CGPointMake(270.0, 5.0);
			[self.resultsLabel setText:@"Below Average"];
            [self.defaults setObject:[NSNumber numberWithInt:40] forKey:@"flexibility"];
		}else if ( reachRow == 1 ){
			markPoint = CGPointMake(200.0, 5.0);
			[self.resultsLabel setText:@"Average"];
            [self.defaults setObject:[NSNumber numberWithInt:60] forKey:@"flexibility"];
		}else if ( reachRow == 2 ){
			markPoint = CGPointMake(100.0, 5.0);
			[self.resultsLabel setText:@"Very Good"];
            [self.defaults setObject:[NSNumber numberWithInt:80] forKey:@"flexibility"];
		}else {
			markPoint = CGPointMake(30.0, 5.0);
			[self.resultsLabel setText:@"Excellent"];
            [self.defaults setObject:[NSNumber numberWithInt:100] forKey:@"flexibility"];
		}
	}else if ( age > 54 ){
		if ( reachRow == 0 ){
			markPoint = CGPointMake(270.0, 5.0);
			[self.resultsLabel setText:@"Average"];
            [self.defaults setObject:[NSNumber numberWithInt:60] forKey:@"flexibility"];
		}else if ( reachRow == 1 ){
			markPoint = CGPointMake(150.0, 5.0);
			[self.resultsLabel setText:@"Very good"];
            [self.defaults setObject:[NSNumber numberWithInt:80] forKey:@"flexibility"];
		}else {
			markPoint = CGPointMake(30.0, 5.0);
			[self.resultsLabel setText:@"Excellent" ];
            [self.defaults setObject:[NSNumber numberWithInt:100] forKey:@"flexibility"];

		}
	}

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){ markPoint.x *= 2; }

    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [self.markImageView setCenter:markPoint];
                     } completion:nil];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [self.defaults synchronize];
    [self.markImageView removeFromSuperview];
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
