//
//  ViewController.m
//  PushCameraTest
//
//  Created by Breadfruit on 15/02/14.
//  Copyright (c) 2014 Breadfruit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController()
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set labels
    [self.durationLabel setText:@"0.00s"];
    [self.recordButton setTitle:@"Record" forState:UIControlStateNormal];
    [self.finishedButton setTitle:@"Finished" forState:UIControlStateNormal];
    
    // Get capture devices
    NSArray *devices = [AVCaptureDevice devices];
    
    // We're only really interested in the back camera and microphone
    for (AVCaptureDevice *device in devices) {
        if ([device hasMediaType:AVMediaTypeVideo] && [device position] == AVCaptureDevicePositionBack) {
            self.camera = device;
        }
        if ([device hasMediaType:AVMediaTypeAudio]) {
            self.microphone = device;
        }
    }
    
    // Hook up device inputs
    self.videoInput = [AVCaptureDeviceInput deviceInputWithDevice:self.camera error:nil];
    self.audioInput = [AVCaptureDeviceInput deviceInputWithDevice:self.microphone error:nil];
}

- (IBAction)pressedRecord:(id)sender
{
    NSLog(@"Start");
    
    // Create new session
    self.session = [AVCaptureSession alloc];
    
    // Add input devices
    [self.session addInput:self.videoInput];
    [self.session addInput:self.audioInput];
    
    // Start session
    [self.session startRunning];
    
    // Get timestamp in seconds since 1970
    double timestamp = [[NSDate date] timeIntervalSince1970];
    
    // Convert into number object
    NSNumber *timestampNumber = [NSNumber numberWithDouble:timestamp];
    
    // Convert number object into string
    NSString *timestampString = [NSString stringWithFormat:@"%@", [timestampNumber stringValue]];
    
    // Get directory to store video
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    // Get path to store video
    NSURL *videoURL = [[NSURL alloc] initFileURLWithPath:[NSString stringWithFormat:@"%@/pushvid_%@.mov", directory, timestampString]];
    
    // Save path
    [self.videos addObject:videoURL];
    
    // Save video to path
    [self.output startRecordingToOutputFileURL:videoURL recordingDelegate:self];
}

- (IBAction)releasedRecord:(id)sender
{
    NSLog(@"Stop");
    
    // Stop recording
    [self.output stopRecording];
    
    // Stop session
    [self.session stopRunning];
    
}

- (IBAction)pressedFinished:(id)sender
{
    NSLog(@"Finished");
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections
{
    
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
    
}

@end
