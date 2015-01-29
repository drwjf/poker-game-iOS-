//
//  GameSet.h
//  CD2Game
//
//  Created by  on 12-1-4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface GameSet : UIViewController <UIActionSheetDelegate>{
    UISlider *_slider1;
    UISlider *_slider2;
    AVAudioPlayer *_player;
    
    UIButton *_plusButton;
    UIButton *_minusButton;
    
}
@property (nonatomic, retain)IBOutlet UISlider *slider1;
@property (nonatomic, retain)IBOutlet UISlider *slider2;

@property (nonatomic, retain)IBOutlet UIButton *plusButton;
@property (nonatomic, retain)IBOutlet UIButton *minusButton;

- (IBAction)buttonClickedClose:(id)sender;

- (IBAction)freshButtonClicked:(id)sender;


@end
