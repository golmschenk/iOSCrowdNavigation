//
//  CrowdNavigationViewController.m
//  Crowd Navigation
//
//  Created by Gregory on 9/27/13.
//  Copyright (c) 2013 Greg Olmschenk. All rights reserved.
//

#import "CrowdNavigationViewController.h"

@interface CrowdNavigationViewController ()
- (IBAction)getDirection:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *displayDirection;

@end

@implementation CrowdNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getDirection:(id)sender {
}
@end
