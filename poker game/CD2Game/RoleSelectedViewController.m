//
//  RoleSelectedViewController.m
//  CD2Game
//
//  Created by Xiaobo on 11-6-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RoleSelectedViewController.h"
#import "CDDGameViewController.h"
#import "CD2GameViewController.h"
#import "SetViewController.h"
#import "CDDGameViewController.h"
#import "MenuViewController.h"
#import "CDDGame.h"
#import "Player.h"
#import "CardType.h"
#import "RoleSelectedViewController.h"
#import "ScoreViewController.h"
#import "CardType.h"
#import "PlayerInfo.h"
#import "PlayerInfoDB.h"
#import "SetViewController.h"


static NSMutableArray *_roles;
static int winTurnNum;
static int loseTurnNum;

@implementation RoleSelectedViewController

@synthesize imageBinkoSelected = _imageBinkoSelected;
@synthesize imageFenkoSelected = _imageFenkoSelected;
@synthesize imageFenkeSelected = _imageFenkeSelected;
@synthesize imageSanzhiSelected = _imageSanzhiSelected;
@synthesize imagePushSelected = _imagePushSelected;
//!!!!!!!!!!!!!!!!
@synthesize buttonPush=_buttonpush;
@synthesize buttonBinko=_buttonBinko;
@synthesize buttonFenke=_buttonFenke;
@synthesize buttonSanzhi=_buttonSanzhi;
@synthesize buttonFenko=_buttonFenko;
//!!!!!!!!!!!!!!!!

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    
    
    
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _roles = [[NSMutableArray alloc]init];
        //[_roles removeObject];
    }
    return self;
}

- (IBAction)buttonClickedSelect:(id)sender
{
    UIControl* control = (UIControl*)sender;
    [self setIcon:control.tag];
    
}

- (IBAction)buttonClickedRight:(id)sender
{
    CD2GameViewController *gameStartController = [[CD2GameViewController alloc]init];
    [self presentModalViewController:gameStartController animated:YES];
    [gameStartController release];
    [self dismissModalViewControllerAnimated:YES];  
}

- (IBAction)setButtonClicked:(id)sender
{
    SetViewController *_setViewController = [[SetViewController alloc]init];
    [self presentModalViewController:_setViewController animated:YES];
    [_setViewController release];
}

- (IBAction)buttonClickedClose:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc
{
    [_imageBinkoSelected release];
    [_imageFenkoSelected release];
    [_imageFenkeSelected release];
    [_imageSanzhiSelected release];
    [_imagePushSelected release];
    [_buttonBinko release];
    [_buttonFenke release];
    [_buttonFenko release];
    [_buttonpush release];
    [_buttonSanzhi release];
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
//     _roles=[[NSMutableArray alloc]init];
//    CDDGameViewController *cddGameViewController = [[CDDGameViewController alloc]init];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (_roles == nil) {
        _roles = [[NSMutableArray alloc]init];
    }
    winTurnNum = 0;
    loseTurnNum = 0;
}

- (void)viewDidUnload
{
    self.imageBinkoSelected = nil;
    self.imageFenkoSelected = nil;
    self.imageFenkeSelected = nil;
    self.imageSanzhiSelected = nil;
    self.imagePushSelected = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if (interfaceOrientation == UIInterfaceOrientationPortrait||interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        return NO;
    }
	return YES;
}

- (void)setIcon:(ImageIndex)imageIndex
{
    //!!!!!!!!!!!!!!!!
    switch (imageIndex) {
        case ImageIndexBinko:
            if(_buttonBinko.selected==NO){
                //[_buttonBinko setAlpha:0.5];
                [_buttonBinko setSelected:YES];
                [_imageBinkoSelected setImage:[UIImage imageNamed:@"benko选择了的.png"]];
                [_roles addObject:@"1"];
            }
            else
            {
                [_buttonBinko setAlpha:0.05];
                [_buttonBinko setSelected:NO];
                [_imageBinkoSelected setImage:[UIImage imageNamed:@""]];
                [_roles removeObject:@"1"];
            }
            break;
        case ImageIndexFenko:
            if(_buttonFenko.selected==NO){
                //[_buttonFenko setAlpha:0.5];
                [_buttonFenko setSelected:YES];
                [_imageFenkoSelected setImage:[UIImage imageNamed:@"fenko选择的.png"]];
                [_roles addObject:@"2"];
            }
            else
            {
                [_buttonFenko setAlpha:0.05];
                [_buttonFenko setSelected:NO];
                [_imageFenkoSelected setImage:[UIImage imageNamed:@""]];
                [_roles removeObject:@"2"];
            }
            
            break;
        case ImageIndexFenke:
            
            if(_buttonFenke.selected==NO){
                //[_buttonFenke setAlpha:0.5];
                [_buttonFenke setSelected:YES];
                [_imageFenkeSelected setImage:[UIImage imageNamed:@"fenke.png"]];
                [_roles addObject:@"3"];
            }
            else
            {
                [_buttonFenke setAlpha:0.05];
                [_buttonFenke setSelected:NO];
                [_imageFenkeSelected setImage:[UIImage imageNamed:@""]];
                [_roles removeObject:@"3"];
            }
            
            break;
        case ImageIndexSanzhi:
            
            if(_buttonSanzhi.selected==NO){
                //[_buttonSanzhi setAlpha:0.5];
                [_buttonSanzhi setSelected:YES];
                [_imageSanzhiSelected setImage:[UIImage imageNamed:@"sanzhi.png"]];
                [_roles addObject:@"4"];
            }
            else
            {
                [_buttonSanzhi setAlpha:0.05];
                [_buttonSanzhi setSelected:NO];
                [_imageSanzhiSelected setImage:[UIImage imageNamed:@""]];
                [_roles removeObject:@"4"];
            }
            break;
        case ImageIndexPush:
            if(_buttonpush.selected==NO){
                //[_buttonpush setAlpha:0.5];
                [_buttonpush setSelected:YES];
                [_imagePushSelected setImage:[UIImage imageNamed:@"push选择的.png"]];
                [_roles addObject:@"5"];
            }
            else
            {
                [_buttonpush setAlpha:0.05];
                [_buttonpush setSelected:NO];
                [_imagePushSelected setImage:[UIImage imageNamed:@""]];
                [_roles removeObject:@"5"];
            }
            
            break;
        default:
            break;
    }
    //NSLog(@"%d",[_roles count]);
    if ([_roles count]==3) {
        CDDGameViewController *gameController = [[CDDGameViewController alloc]init];
        [self presentModalViewController:gameController animated:YES];
        [gameController release];
    }
    //!!!!!!!!!!!!!!!!
}
+ (NSMutableArray *)returnRoles
{
    return _roles;
}
+(void)upwinTurnNum
{
    winTurnNum++;
}
+(void)uploseTurnNum
{
    loseTurnNum++;
}
+(int)getwinTurnNum
{
    return  winTurnNum;
}
+(int)getloseTurnNum
{
   return  loseTurnNum;
}
@end
