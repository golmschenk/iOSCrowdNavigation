//
//  CrowdNavigationViewController.m
//  Crowd Navigation
//
//  Created by Gregory on 9/27/13.
//  Copyright (c) 2013 Greg Olmschenk. All rights reserved.
//

#import "CrowdNavigationViewController.h"
#import <AVFoundation/AVAudioPlayer.h>

@interface CrowdNavigationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *displayDirection;
@property NSString *direction;
@property AVAudioPlayer *leftPlayer;
@property AVAudioPlayer *rightPlayer;
@property AVAudioPlayer *forwardPlayer;
@property AVAudioPlayer *stopPlayer;

@end

@implementation CrowdNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self preparePlayers];
    //TODO Move this into its own function.
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(getDirection)
                                   userInfo:nil
                                    repeats:YES];
}

//Setup the audio players for the directions.
- (void)preparePlayers
{
    NSError *playerError;
    
    NSString *leftPath =
    [[NSBundle mainBundle] pathForResource: @"left"
                                    ofType: @"mp3"];
    
    NSURL *leftURL = [[NSURL alloc] initFileURLWithPath: leftPath];
    
    self.leftPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: leftURL
                                           error: &playerError];

    NSString *rightPath =
    [[NSBundle mainBundle] pathForResource: @"right"
                                    ofType: @"mp3"];
    
    NSURL *rightURL = [[NSURL alloc] initFileURLWithPath: rightPath];
    
    self.rightPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: rightURL
                                           error: &playerError];
    
    NSString *forwardPath =
    [[NSBundle mainBundle] pathForResource: @"forward"
                                    ofType: @"mp3"];
    
    NSURL *forwardURL = [[NSURL alloc] initFileURLWithPath: forwardPath];
    
    self.forwardPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: forwardURL
                                           error: &playerError];
    
    NSString *stopPath =
    [[NSBundle mainBundle] pathForResource: @"stop"
                                    ofType: @"mp3"];
    
    NSURL *stopURL = [[NSURL alloc] initFileURLWithPath: stopPath];
    
    self.stopPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: stopURL
                                           error: &playerError];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Play audio for left.
- (void) playLeft{
    [self.leftPlayer play];
}

//Play audio for right.
- (void) playRight{
    [self.rightPlayer play];
}

//Play audio for forward.
- (void) playForward{
    [self.forwardPlayer play];
}

//Play audio for stop.
- (void) playStop{
    [self.stopPlayer play];
}

//Get the current direction and play the sound for it. //TODO make more modular.
- (void)getDirection{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.7.102:8080/getdirection"]
    //NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://169.254.106.204:8080/getdirection"]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    NSString* responseString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    if(![self.direction isEqualToString:responseString]){
        self.direction = [NSString stringWithString:responseString];
        
        if([responseString  isEqual: @"Left"]){
            [self playLeft];
        }
        else if([responseString  isEqual: @"Right"]){
            [self playRight];
        }
        else if([responseString  isEqual: @"Forward"]){
            [self playForward];
        }
        else if([responseString  isEqual: @"Stop"]){
            [self playStop];
        }
    }
    
    self.displayDirection.text = responseString;
}
@end
