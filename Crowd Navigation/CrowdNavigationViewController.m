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
- (IBAction)getDirection:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *displayDirection;

@end

@implementation CrowdNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) playLeft{
    NSString *soundFilePath =
    [[NSBundle mainBundle] pathForResource: @"left"
                                    ofType: @"mp3"];
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    NSError *requestError;
    
    AVAudioPlayer *newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                           error: &requestError];
    
    [newPlayer play];
}

- (void) playRight{
    NSString *soundFilePath =
    [[NSBundle mainBundle] pathForResource: @"right"
                                    ofType: @"mp3"];
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    AVAudioPlayer *newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                           error: nil];
    [newPlayer play];
}

- (void) playForward{
    NSString *soundFilePath =
    [[NSBundle mainBundle] pathForResource: @"forward"
                                    ofType: @"mp3"];
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    AVAudioPlayer *newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                           error: nil];
    [newPlayer play];
}

- (void) playStop{
    NSString *soundFilePath =
    [[NSBundle mainBundle] pathForResource: @"stop"
                                    ofType: @"mp3"];
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    AVAudioPlayer *newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                           error: nil];
    [newPlayer play];
}

- (IBAction)getDirection:(id)sender {
    //NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.15:8080/getdirection"]
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://169.254.106.204:8080/getdirection"]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    NSString* responseString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    if([responseString  isEqual: @"Left"]){
        [self playLeft];
    }
    
    
    self.displayDirection.text = responseString;
}
@end
