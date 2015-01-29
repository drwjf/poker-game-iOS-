//
//  SetViewController.h
//  CD2Game
//
//  Created by Xiaobo on 11-6-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import"CddData.h"


@interface SetViewController : UIViewController <UIActionSheetDelegate>{
    UISlider *_slider1;
    UISlider *_slider2;
    AVAudioPlayer *_player;
    
    UIButton *_plusButton;
    UIButton *_minusButton;
    
    UITextField *_nameTextField;
    //sqlite数据库数据
    CddData *sqldata;
}

@property (nonatomic, retain)IBOutlet UISlider *slider1;
@property (nonatomic, retain)IBOutlet UISlider *slider2;

@property (nonatomic, retain)IBOutlet UIButton *plusButton;
@property (nonatomic, retain)IBOutlet UIButton *minusButton;
@property (nonatomic, retain)IBOutlet UITextField *nameTextField;

- (IBAction)buttonClickedClose:(id)sender;
- (IBAction)plusButtonClicked:(id)sender;
- (IBAction)minusButtonClicked:(id)sender;
- (IBAction)freshButtonClicked:(id)sender;
- (IBAction)changeAccoutButonClicked:(id)sender;
- (IBAction)plusButtonClicked2:(id)sender;
- (IBAction)minusButtonClicked2:(id)sender;


+(NSString *)returnName;


//各种数据库操作的函数
-(void) nextAction;
-(void) deleteAction;
-(void) updateAction;

@end
