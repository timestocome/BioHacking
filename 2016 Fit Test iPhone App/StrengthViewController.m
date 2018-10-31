//
//  StrengthViewController.m
//  Fitness
//
//  Created by Linda Cobb on 6/27/13.
//  Copyright (c) 2013 TimesToCome Mobile. All rights reserved.
//

#import "StrengthViewController.h"
#import "Formulas.h"
#import "PickerArrays.h"


@implementation StrengthViewController

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
    
    self.situpsMark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mark.png"]];
    self.situpsMark.center = CGPointMake(160.0, 5.0);
    [self.situpsImageView addSubview:self.situpsMark];
    
    self.pushupsMark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mark.png"]];
    self.pushupsMark.center = CGPointMake(160.0, 5.0);
    [self.pushupsImageView addSubview:self.pushupsMark];

    [self setupView];
}


- (void)setupView
{
    
    _defaults = [NSUserDefaults standardUserDefaults];

    units = [[self.defaults objectForKey:@"units"] intValue];
    sex = [[self.defaults objectForKey:@"sex"] intValue];
    age = [[self.defaults objectForKey:@"age"] intValue];
    situps = [[self.defaults objectForKey:@"situps"] intValue];
    pushups = [[self.defaults objectForKey:@"pushups"] intValue];
    
    self.ageArray = [NSArray arrayWithArray:[PickerArrays ageArray]];
    self.sexArray = [NSArray arrayWithArray:[PickerArrays sexArray]];
    self.situpsArray = [NSArray arrayWithArray:[PickerArrays ZeroToOneHundredArray]];
    self.pushupsArray = [NSArray arrayWithArray:[PickerArrays ZeroToOneHundredArray]];
    
   
    
    
    int row = (int)[self.ageArray indexOfObject:[NSNumber numberWithInt:age]];
    if ( (row > 0) && (row < self.ageArray.count)  ){ [self.pickerView selectRow:row inComponent:0 animated:YES]; }
    
    row = sex;
    if ( (row > 0) && (row < self.sexArray.count)  ){ [self.pickerView selectRow:row inComponent:1 animated:YES]; }
    
    row = (int)[self.situpsArray indexOfObject:[NSNumber numberWithInt:situps]];
    if ( (row > 0) && (row < self.situpsArray.count)  ){ [self.pickerView selectRow:row inComponent:2 animated:YES]; }
    
    row = (int)[self.pushupsArray indexOfObject:[NSNumber numberWithInt:pushups]];
    if ( (row > 0) && (row < self.pushupsArray.count)  ){ [self.pickerView selectRow:row inComponent:3 animated:YES]; }
    
    [self calculate];

}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ( component == 0 ){
        age = [[self.ageArray objectAtIndex:row] intValue];
        [self.defaults setObject:[NSNumber numberWithInt:age] forKey:@"age"];
    }else if ( component == 1){
        sex = (int)row;
        [self.defaults setObject:[NSNumber numberWithInt:sex] forKey:@"sex"];
    }else if ( component == 2){
        situps = [[self.situpsArray objectAtIndex:row] intValue];
        [self.defaults setObject:[NSNumber numberWithDouble:situps] forKey:@"situps"];
    }else if ( component == 3){
        pushups = [[self.pushupsArray objectAtIndex:row] intValue];
        [self.defaults setObject:[NSNumber numberWithDouble:pushups] forKey:@"pushups"];
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
    }else if ( component == 1 ){
        title.text = [NSString stringWithFormat:@"%@", [self.sexArray objectAtIndex:row]];
    }else if ( component == 2 ){
        title.text = [NSString stringWithFormat:@"%@", [self.situpsArray objectAtIndex:row]];
    }else{
        title.text = [NSString stringWithFormat:@"%@", [self.pushupsArray objectAtIndex:row]];
    }
    
    
	return title;
}




- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    float width;
    if ( component == 0 ){
        width = 50.0;
    }else if ( component == 1 ){
        width = 50.0;
    }else if ( component == 2 ){
        width = 60.0;
    }else{
        width = 60.0;
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
    }else if ( component == 1 ){
        return [self.sexArray count];
    }else if ( component == 2 ){
        return [self.situpsArray count];
    }else {
        return [self.pushupsArray count];
    }
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 4;
}


- (void)calculate
{
    
    CGPoint pointExcellent = CGPointMake(250.0, 5.0);
    CGPoint pointGood = CGPointMake(200.0, 5.0);
    CGPoint pointAverage = CGPointMake(125.0, 5.0);
    CGPoint pointBad = CGPointMake(75.0, 5.0);
    
    CGPoint markPointPushups;
    CGPoint markPointSitups;
    
    // pushups
	if ( age < 30 ){
		if ( sex == 1 ){		// female
			if ( pushups > 21 ){
                markPointPushups = pointExcellent;
				[self.pushupsResultsLabel setText:@"Pushups Excellent"];
			}else if ( pushups > 15 ){
				markPointPushups = pointGood;
				[self.pushupsResultsLabel setText:@"Pushups Good"];
			}else if ( pushups > 10 ){
				markPointPushups = pointAverage;
				[self.pushupsResultsLabel setText:@"Pushups Average"];
			}else{
				markPointPushups = pointBad;
				[self.pushupsResultsLabel setText:@"Pushups Below Average"];
			}
		}else {					// male
			if ( pushups > 29 ){
				markPointPushups = pointExcellent;
				[self.pushupsResultsLabel setText:@"Pushups Excellent"];
			}else if ( pushups > 23 ){
				markPointPushups = pointGood;
				[self.pushupsResultsLabel setText:@"Pushups Good"];
			}else if ( pushups > 17 ){
				markPointPushups = pointAverage;
				[self.pushupsResultsLabel setText:@"Pushups Average"];
			}else{
				markPointPushups = pointBad;
				[self.pushupsResultsLabel setText:@"Pushups Below Average"];
			}
		}
	}else if ( age < 40 ){
		if ( sex == 1 ){		// female
			if ( pushups > 20 ){
				markPointPushups = pointExcellent;
				[self.pushupsResultsLabel setText:@"Pushups Excellent"];
			}else if ( pushups > 13 ){
				markPointPushups = pointGood;
				[self.pushupsResultsLabel setText:@"Pushups Good"];
			}else if ( pushups > 9 ){
				markPointPushups = pointAverage;
				[self.pushupsResultsLabel setText:@"Pushups Average"];
			}else{
				markPointPushups = pointBad;
				[self.pushupsResultsLabel setText:@"Pushups Below Average"];
			}
		}else {					// male
			if ( pushups > 23 ){
				markPointPushups = pointExcellent;
				[self.pushupsResultsLabel setText:@"Pushups Excellent"];
			}else if ( pushups > 18 ){
				markPointPushups = pointGood;
				[self.pushupsResultsLabel setText:@"Pushups Good"];
			}else if ( pushups > 13 ){
				markPointPushups = pointAverage;
				[self.pushupsResultsLabel setText:@"Pushups Average"];
			}else{
				markPointPushups = pointBad;
				[self.pushupsResultsLabel setText:@"Pushups Below Average"];
			}
		}
	}else if ( age < 50 ){
		if ( sex == 1 ){		// female
			if ( pushups > 17 ){
				markPointPushups = pointExcellent;
				[self.pushupsResultsLabel setText:@"Pushups Excellent"];
			}else if ( pushups > 11 ){
				markPointPushups = pointGood;
				[self.pushupsResultsLabel setText:@"Pushups Good"];
			}else if ( pushups > 7 ){
				markPointPushups = pointAverage;
				[self.pushupsResultsLabel setText:@"Pushups Average"];
			}else{
				markPointPushups = pointBad;
				[self.pushupsResultsLabel setText:@"Pushups Below Average"];
			}
		}else {					// male
			if ( pushups > 18 ){
				markPointPushups = pointExcellent;
				[self.pushupsResultsLabel setText:@"Pushups Excellent"];
			}else if ( pushups > 12 ){
				markPointPushups = pointGood;
				[self.pushupsResultsLabel setText:@"Pushups Good"];
			}else if ( pushups > 9 ){
				markPointPushups = pointAverage;
				[self.pushupsResultsLabel setText:@"Pushups Average"];
			}else{
				markPointPushups = pointBad;
				[self.pushupsResultsLabel setText:@"Pushups Below Average"];
			}
		}
	}else if ( age < 60 ){
		if ( sex == 1 ){		// female
			if ( pushups > 12 ){
				markPointPushups = pointExcellent;
				[self.pushupsResultsLabel setText:@"Pushups Excellent"];
			}else if ( pushups > 8 ){
				markPointPushups = pointGood;
				[self.pushupsResultsLabel setText:@"Pushups Good"];
			}else if ( pushups > 2 ){
				markPointPushups = pointAverage;
				[self.pushupsResultsLabel setText:@"Pushups Average"];
			}else{
				markPointPushups = pointBad;
				[self.pushupsResultsLabel setText:@"Pushups Below Average"];
			}
		}else {					// male
			if ( pushups > 13 ){
				markPointPushups = pointExcellent;
				[self.pushupsResultsLabel setText:@"Pushups Excellent"];
			}else if ( pushups > 9 ){
				markPointPushups = pointGood;
				[self.pushupsResultsLabel setText:@"Pushups Good"];
			}else if ( pushups > 6 ){
				markPointPushups = pointAverage;
				[self.pushupsResultsLabel setText:@"Pushups Average"];
			}else{
				markPointPushups = pointBad;
				[self.pushupsResultsLabel setText:@"Pushups Below Average"];
			}
		}
	}else {
		if ( sex == 1 ){		// female
			if ( pushups > 12 ){
				markPointPushups = pointExcellent;
				[self.pushupsResultsLabel setText:@"Pushups Excellent"];
			}else if ( pushups > 5 ){
				markPointPushups = pointGood;
				[self.pushupsResultsLabel setText:@"Pushups Good"];
			}else if ( pushups > 1 ){
				markPointPushups = pointAverage;
				[self.pushupsResultsLabel setText:@"Pushups Average"];
			}else{
				markPointPushups = pointBad;
				[self.pushupsResultsLabel setText:@"Pushups Below Average"];
			}
		}else {					// male
			if ( pushups > 10 ){
				markPointPushups = pointExcellent;
				[self.pushupsResultsLabel setText:@"Pushups Excellent"];
			}else if ( pushups > 8 ){
				markPointPushups = pointGood;
				[self.pushupsResultsLabel setText:@"Pushups Good"];
			}else if ( pushups > 5 ){
				markPointPushups = pointAverage;
				[self.pushupsResultsLabel setText:@"Pushups Average"];
			}else{
				markPointPushups = pointBad;
				[self.pushupsResultsLabel setText:@"Pushups Below Average"];
			}
		}
	}
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){ markPointPushups.x *= 2; }
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [self.pushupsMark setCenter:markPointPushups];
                     } completion:nil];
	
	// situps
	if ( age < 30 ){
		if ( sex == 1 ){		// female
			if ( situps > 38 ){
				markPointSitups = pointExcellent;
				[self.situpsResultsLabel setText:@"Situps Excellent"];
			}else if ( situps > 24 ){
				markPointPushups = pointGood;
				[self.situpsResultsLabel setText:@"Situps Good"];
			}else if ( situps > 19 ){
				markPointSitups = pointAverage;
				[self.situpsResultsLabel setText:@"Situps Average"];
			}else{
				markPointSitups = pointBad;
				[self.situpsResultsLabel setText:@"Situps Below Average"];
			}
		}else {					// male
			if ( situps > 44 ){
				markPointSitups = pointExcellent;
				[self.situpsResultsLabel setText:@"Situps Excellent"];
			}else if ( situps > 30 ){
				markPointPushups = pointGood;
				[self.situpsResultsLabel setText:@"Situps Good"];
			}else if ( situps > 21 ){
				markPointSitups = pointAverage;
				[self.situpsResultsLabel setText:@"Situps Average"];
			}else{
				markPointSitups = pointBad;
				[self.situpsResultsLabel setText:@"Situps Below Average"];
			}
		}
	}else if ( age < 40 ){
		if ( sex == 1 ){		// female
			if ( situps > 32 ){
				markPointSitups = pointExcellent;
				[self.situpsResultsLabel setText:@"Situps Excellent"];
			}else if ( situps > 18 ){
                markPointSitups = pointGood;
				[self.situpsResultsLabel setText:@"Situps Good"];
			}else if ( situps > 6 ){
				markPointSitups = pointAverage;
				[self.situpsResultsLabel setText:@"Situps Average"];
			}else{
				markPointSitups = pointBad;
				[self.situpsResultsLabel setText:@"Situps Below Average"];
			}
        }else {					// male
            if ( situps > 40 ){
                markPointSitups = pointExcellent;
                [self.situpsResultsLabel setText:@"Situps Excellent"];
            }else if ( situps > 26 ){
                markPointSitups = pointGood;
                [self.situpsResultsLabel setText:@"Situps Good"];
            }else if ( situps > 16 ){
                markPointSitups = pointAverage;
                [self.situpsResultsLabel setText:@"Situps Average"];
            }else{
                markPointSitups = pointBad;
                [self.situpsResultsLabel setText:@"Situps Below Average"];
            }
        }
	}else if ( age < 50 ){
		if ( sex == 1 ){		// female
			if ( situps > 26 ){
				markPointSitups = pointExcellent;
				[self.situpsResultsLabel setText:@"Situps Excellent"];
			}else if ( situps > 13 ){
				markPointSitups = pointGood;
				[self.situpsResultsLabel setText:@"Situps Good"];
			}else if ( situps > 4 ){
				markPointSitups = pointAverage;
				[self.situpsResultsLabel setText:@"Situps Average"];
			}else{
				markPointSitups = pointBad;
				[self.situpsResultsLabel setText:@"Situps Below Average"];
			}
        }else {					// male
                if ( situps > 34 ){
                    markPointSitups = pointExcellent;
                    [self.situpsResultsLabel setText:@"Situps Excellent"];
                }else if ( situps > 21 ){
                    markPointSitups = pointGood;
                    [self.situpsResultsLabel setText:@"Situps Good"];
                }else if ( situps > 12 ){
                    markPointSitups = pointAverage;
                    [self.situpsResultsLabel setText:@"Situps Average"];
                }else{
                    markPointSitups = pointBad;
                    [self.situpsResultsLabel setText:@"Situps Below Average"];
                }
        }
	}else if ( age < 60 ){
		if ( sex == 1 ){		// female
			if ( situps > 23 ){
				markPointSitups = pointExcellent;
				[self.situpsResultsLabel setText:@"Situps Excellent"];
			}else if ( situps > 9 ){
				markPointSitups = pointGood;
				[self.situpsResultsLabel setText:@"Situps Good"];
			}else if ( situps > 2 ){
				markPointSitups = pointAverage;
                [self.situpsResultsLabel setText:@"Situps Average"];
			}else{
                markPointSitups = pointBad;
                [self.situpsResultsLabel setText:@"Situps Below Average"];
            }
		}else {					// male
			if ( situps > 30 ){
				markPointSitups = pointExcellent;
				[self.situpsResultsLabel setText:@"Situps Excellent"];
			}else if ( situps > 16 ){
				markPointSitups = pointGood;
				[self.situpsResultsLabel setText:@"Situps Good"];
			}else if ( situps > 8 ){
				markPointSitups = pointAverage;
				[self.situpsResultsLabel setText:@"Situps Average"];
			}else{
				markPointSitups = pointBad;
				[self.situpsResultsLabel setText:@"Situps Below Average"];
			}
        }
	}else {
		if ( sex == 1 ){		// female
			if ( situps > 22 ){
				markPointSitups = pointExcellent;
				[self.situpsResultsLabel setText:@"Situps Excellent"];
			}else if ( situps > 10 ){
				markPointSitups = pointGood;
				[self.situpsResultsLabel setText:@"Situps Good"];
			}else if ( situps > 1 ){
				markPointSitups = pointAverage;
				[self.situpsResultsLabel setText:@"Situps Average"];
			}else{
				markPointSitups = pointBad;
				[self.situpsResultsLabel setText:@"Situps Below Average"];
			}
        }else {					// male
            if ( situps > 28 ){
                    markPointSitups = pointExcellent;
                    [self.situpsResultsLabel setText:@"Situps Excellent"];
            }else if ( situps > 14 ){
                    markPointSitups = pointGood;
                    [self.situpsResultsLabel setText:@"Situps Good"];
            }else if ( situps > 6 ){
                    markPointSitups = pointAverage;
                    [self.situpsResultsLabel setText:@"Situps Average"];
            }else{
                    markPointSitups = pointBad;
                    [self.situpsResultsLabel setText:@"Situps Below Average"];
            }
        }
	}
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){ markPointSitups.x *= 2; }

    [UIView animateWithDuration:1.0
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [self.situpsMark setCenter:markPointSitups];
                     } completion:nil];

   
}


- (void)viewWillDisappear:(BOOL)animated
{
    [self.defaults synchronize];
    
    [self.pushupsMark removeFromSuperview];
    [self.situpsMark removeFromSuperview];
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
