//
//  SetViewController.m
//  CD2Game
//
//  Created by Xiaobo on 11-6-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SetViewController.h"
#import "CD2GameViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PlayerInfo.h"
#import "PlayerInfoDB.h"
#import "RoleSelectedViewController.h"

@interface SetViewController() 

- (void)showNameIntextField;

@end

float volumneValue;
BOOL isFirst = YES;
NSString *name;

@implementation SetViewController
@synthesize slider1 = _slider1;
@synthesize slider2 = _slider2;

@synthesize plusButton = _plusButton;
@synthesize minusButton = _minusButton;
@synthesize nameTextField = _nameTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
        sqldata = [[CddData alloc]init];
       //打开数据库
        
        [sqldata openDB];
        [sqldata createTable];
    
    
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
    [_nameTextField release];
    
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
    
    // UIControl *_back = [[UIControl alloc] initWithFrame:self.view.frame];
    //  _back.backgroundColor = [UIColor grayColor];
    //  self.view = _back;
    //  [_back release];
    //  [(UIControl *)self.view addTarget:self action:@selector(backgroundTap:) forControlEvents:UIControlEventTouchDown];
    
    
    
    
    
    _nameTextField.delegate = self;
    // [self.view addSubview:_nameTextField];
    
    
    
    
    
    
//    [_slider1 setThumbImage:[UIImage imageNamed:@"volumn_set_icon.png"] forState:UIControlStateNormal];
//    [_slider1 setMinimumTrackImage:[UIImage imageNamed:@"transparent_graphic.png"] forState:UIControlStateNormal];
//    [_slider1 setMaximumTrackImage:[UIImage imageNamed:@"transparent_graphic.png"] forState:UIControlStateNormal];
//    
//    [_slider2 setThumbImage:[UIImage imageNamed:@"volumn_set_icon.png"] forState:UIControlStateNormal];
//    [_slider2 setMinimumTrackImage:[UIImage imageNamed:@"transparent_graphic.png"] forState:UIControlStateNormal];
//    [_slider2 setMaximumTrackImage:[UIImage imageNamed:@"transparent_graphic.png"] forState:UIControlStateNormal];
    
    
    
    
    
    [_slider1 addTarget:self action:@selector(volumeChange) forControlEvents:UIControlEventTouchDragInside];
    
    _player = [CD2GameViewController returnPlayer];
    
    if (isFirst == YES) {
        isFirst = NO;
        [_slider1 setValue:1.0];
        volumneValue = 1;
    }
    else
    {
        [_slider1 setValue:volumneValue];
    }
    
    //    [_slider2 setThumbImage:[UIImage imageNamed:@"volumn_set_icon.png"] forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    [self showNameIntextField];
    
}
- (IBAction)buttonClickedClose:(id)sender
{
    //    PlayerInfo *playerInfo = [[PlayerInfo alloc]initWithAccount:self.nameTextField.text allScore:0 turns:0];
    [[PlayerInfoDB instance]addPlayerInfo:self.nameTextField.text allScore:0 turns:0]; 
    NSString* nameStr;
    name = self.nameTextField.text;
    nameStr = name;
        [sqldata insertUserWithName:self.nameTextField.text];
        [sqldata useName:self.nameTextField.text];
        [sqldata closeDB];
    
    // RoleSelectedViewController *roleSelectedViewController = [[RoleSelectedViewController alloc]init];
    //  [self presentModalViewController:roleSelectedViewController animated:YES];
    // [roleSelectedViewController release];
    [self dismissModalViewControllerAnimated:YES];
    [self.view removeFromSuperview];
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


- (void)keyboardWillShow:(NSNotification *)noti
{       
    //键盘输入的界面调整       
    //键盘的高度
    float height = 216.0;               
    CGRect frame = self.view.frame;       
    frame.size = CGSizeMake(frame.size.width, frame.size.height - height);       
    [UIView beginAnimations:@"Curl"context:nil];//动画开始         
    [UIView setAnimationDuration:0.30];          
    [UIView setAnimationDelegate:self];         
    [self.view setFrame:frame];        
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextField *)_nameTextField1
{      
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.       
    name = _nameTextField.text;
    NSTimeInterval animationDuration = 0.30f;       
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];       
    [UIView setAnimationDuration:animationDuration];       
    //    CGRect rect = CGRectMake(0.0f, 20.0f, self.view.frame.size.width, self.view.frame.size.height);       
    //    self.view.frame = rect;
    [UIView commitAnimations];
    [_nameTextField resignFirstResponder];
    return YES;       
}

- (void)textFieldDidBeginEditing:(UITextField *)_nameTextField
{       
    CGRect frame = _nameTextField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;               
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];               
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;               
    float height = self.view.frame.size.height;       
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);               
        self.view.frame = rect;       
    }       
    [UIView commitAnimations];               
}












- (void)volumeChange
{
    volumneValue = _slider1.value;
    AVAudioPlayer *audioPlayer = [CD2GameViewController returnPlayer];
    [audioPlayer setVolume:volumneValue];
}

- (void)plusButtonClicked:(id)sender
{
    if (volumneValue < 1) 
    {
        volumneValue = volumneValue + 0.1;
    }
    [_slider1 setValue:volumneValue];
    AVAudioPlayer *audioPlayer = [CD2GameViewController returnPlayer];
    [audioPlayer setVolume:volumneValue];
}

- (void)plusButtonClicked2:(id)sender
{
    _slider2.value = _slider2.value + 0.1;    
}

- (void)minusButtonClicked:(id)sender
{
    if (volumneValue > 0) 
    {
        volumneValue = volumneValue - 0.1;
    }
    [_slider1 setValue:volumneValue];
    AVAudioPlayer *audioPlayer = [CD2GameViewController returnPlayer];
    [audioPlayer setVolume:volumneValue];
    
}

- (void)minusButtonClicked2:(id)sender
{
    _slider2.value = _slider2.value - 0.1;
}

- (void)freshButtonClicked:(id)sender
{
    volumneValue = 0.5;
    [_slider1 setValue:volumneValue];
    AVAudioPlayer *audioPlayer = [CD2GameViewController returnPlayer];
    [audioPlayer setVolume:volumneValue];
    
    _slider2.value = 0.5;
    
}

- (void)changeAccoutButonClicked:(id)sender
{

    NSMutableArray *playerInfos = [[PlayerInfoDB instance]getPlayerInfos];
//    if([[[playerInfos index:0]account]!=NULL){
    if([playerInfos count]!=0){
        UIActionSheet *menu = [[UIActionSheet alloc]initWithTitle:nil
                                                         delegate:self
                                                cancelButtonTitle:nil
                                           destructiveButtonTitle:nil
                                                otherButtonTitles:nil];
    for (PlayerInfo *playerInfo in playerInfos) 
    {
        [menu addButtonWithTitle:playerInfo.account];    
    }
    
    UIButton *button = (UIButton *)sender;
    [menu showFromRect:button.frame  inView:self.view animated:YES];
       [menu release];
    }
 
//    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex < 0) 
    {
        return;
    }
    NSMutableArray *playerInfos = [[PlayerInfoDB instance]getPlayerInfos];
    PlayerInfo *playerInfo = [playerInfos objectAtIndex:buttonIndex];
    self.nameTextField.text = playerInfo.account;
    
}

- (void)showNameIntextField
{
    NSMutableArray *playerInfos = [[PlayerInfoDB instance]getPlayerInfos];
    if ([playerInfos count] > 0) {
        PlayerInfo *playerInfo = [playerInfos objectAtIndex:0];
        self.nameTextField.text = playerInfo.account;
    }
    
}

+ (NSString *)returnName 
{
    return name;
}


@end
