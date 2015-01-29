//
//  GameSet.m
//  CD2Game
//
//  Created by  on 12-1-4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameSet.h"
#import "CD2GameViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface GameSet() 
@end

float volumneValue;
BOOL isFirst1 = YES;

@implementation GameSet
@synthesize slider1 = _slider1;
@synthesize slider2 = _slider2;

@synthesize plusButton = _plusButton;
@synthesize minusButton = _minusButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_plusButton release];
    [_minusButton release];
    
    [_slider1 release];
    [_slider2 release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_slider1 addTarget:self action:@selector(volumeChange) forControlEvents:UIControlEventTouchDragInside];
    
    _player = [CD2GameViewController returnPlayer];

    if (isFirst1 == YES) {
        isFirst1 = NO;
        [_slider1 setValue:1.0];
        volumneValue = 1;
    }
    else
    {
        [_slider1 setValue:volumneValue];
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationPortrait||interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        return NO;
    }
    // Return YES for supported orientations
    return YES;
}
- (void)volumeChange
{
    volumneValue = _slider1.value;
    AVAudioPlayer *audioPlayer = [CD2GameViewController returnPlayer];
    [audioPlayer setVolume:volumneValue];
}

- (void)freshButtonClicked:(id)sender
{
    volumneValue = 0.5;
    [_slider1 setValue:volumneValue];
    AVAudioPlayer *audioPlayer = [CD2GameViewController returnPlayer];
    [audioPlayer setVolume:volumneValue];
    
    _slider2.value = 0.5;
    
}

- (IBAction)buttonClickedClose:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    [self.view removeFromSuperview];
}

@end
