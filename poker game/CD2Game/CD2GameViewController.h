//
//  CD2GameViewController.h
//  CD2Game
//
//  Created by Xiaobo on 11-6-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//!!!!!!!!!!!!!!!!
#import <AVFoundation/AVFoundation.h>
//!!!!!!!!!!!!!!!!
@interface CD2GameViewController : UIViewController {
    //!!!!!!!!!!!!!!!!
    //!!!!!!!!!!!!!!!!
}

+ (AVAudioPlayer *)returnPlayer;

- (IBAction)buttonClickedSingleGame:(id)sender;
- (IBAction)buttonClickedClose:(id)sender;
- (IBAction)setButtonClicked:(id)sender;

@end
