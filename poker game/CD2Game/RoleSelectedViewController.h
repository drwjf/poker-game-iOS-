//
//  RoleSelectedViewController.h
//  CD2Game
//
//  Created by Xiaobo on 11-6-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    ImageIndexBinko =0,
    ImageIndexFenko,
    ImageIndexFenke,
    ImageIndexSanzhi,
    ImageIndexPush
} ImageIndex;


@interface RoleSelectedViewController : UIViewController {
    //NSMutableArray *_roles;
    
    UIImageView *_imageBinkoSelected;
    UIImageView *_imageFenkoSelected;
    UIImageView *_imageFenkeSelected;
    UIImageView *_imageSanzhiSelected;
    UIImageView *_imagePushSelected;
        //!!!!!!!!!!!!!!!!
    UIButton *_buttonBinko;
    UIButton *_buttonFenko;
    UIButton *_buttonFenke;
    UIButton *_buttonSanzhi;
    UIButton *_buttonpush;
    //!!!!!!!!!!!!!!!!

    
//    int winTurnNum;
//    int loseTurnNum;
}
@property (nonatomic, retain)IBOutlet UIImageView *imageBinkoSelected;
@property (nonatomic, retain)IBOutlet UIImageView *imageFenkoSelected;
@property (nonatomic, retain)IBOutlet UIImageView *imageFenkeSelected;
@property (nonatomic, retain)IBOutlet UIImageView *imageSanzhiSelected;
@property (nonatomic, retain)IBOutlet UIImageView *imagePushSelected;
//!!!!!!!!!!!!!!!!
@property (nonatomic, retain)IBOutlet UIButton *buttonBinko;
@property (nonatomic, retain)IBOutlet UIButton *buttonFenko;
@property (nonatomic, retain)IBOutlet UIButton *buttonFenke;
@property (nonatomic, retain)IBOutlet UIButton *buttonSanzhi;
@property (nonatomic, retain)IBOutlet UIButton *buttonPush;
//!!!!!!!!!!!!!!!!
- (IBAction)buttonClickedSelect:(id)sender;
- (IBAction)buttonClickedRight:(id)sender;
- (IBAction)buttonClickedClose:(id)sender;
- (void)setIcon:(ImageIndex)imageIndex;
- (IBAction)setButtonClicked:(id)sender;
+(void)upwinTurnNum;
+(void)uploseTurnNum;
+(int)getwinTurnNum;
+(int)getloseTurnNum;
+ (NSMutableArray *)returnRoles;
@end
