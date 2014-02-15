//
//  ViewController.h
//  PushCameraTest
//
//  Created by Breadfruit on 15/02/14.
//  Copyright (c) 2014 Breadfruit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<AVCaptureFileOutputRecordingDelegate>

/**
 * Device properties
 */
@property AVCaptureDevice *camera;
@property AVCaptureDevice *microphone;
@property AVCaptureSession *session;
@property AVCaptureDeviceInput *videoInput;
@property AVCaptureDeviceInput *audioInput;
@property AVCaptureMovieFileOutput *output;

/**
 * Video paths
 */
@property NSMutableArray *videos;

/**
 * View properties
 */
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UIButton *finishedButton;

/**
 * Button listeners
 */
- (IBAction)pressedRecord:(id)sender;
- (IBAction)releasedRecord:(id)sender;
- (IBAction)pressedFinished:(id)sender;

@end
