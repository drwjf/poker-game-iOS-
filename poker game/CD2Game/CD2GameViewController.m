//
//  CD2GameViewController.m
//  CD2Game
//
//  Created by Xiaobo on 11-6-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CD2GameViewController.h"
#import "RoleSelectedViewController.h"
#import "Card.h"
#import "CardType.h"
#import "AudioToolbox/AudioToolbox.h"
#import "Player.h"
#import "CardGroup.h"
#import "SetViewController.h"

AVAudioPlayer *_player;

@implementation CD2GameViewController


char *typeStr[9] = {"INVALID", "SINGLE", "COUPLE", "THREE", "MIXSEQ", "FLUSH", "CAPTURE", "KINGTONG", "STRAIGHTFLUSH"};

- (IBAction)buttonClickedSingleGame:(id)sender
{
    RoleSelectedViewController *roleSelectedViewController = [[RoleSelectedViewController alloc]init];
    [self presentModalViewController:roleSelectedViewController animated:YES];
    [roleSelectedViewController release];
}

- (IBAction)buttonClickedClose:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"提示" 
                          message:@"真的要退出游戏吗？"
                          delegate:self                         
                          cancelButtonTitle:@"确定" 
                          otherButtonTitles: nil];
    [alert show];
    [alert release];

}

- (IBAction)setButtonClicked:(id)sender
{
    SetViewController *_setViewController = [[SetViewController alloc]init];
    [self presentModalViewController:_setViewController animated:YES];
    [_setViewController release];
}
- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
//    Database *database = [[Database alloc]init];
//    [database openDB];
//    [database createTableNamed:@"PlayerInfo" 
//                    withField1:@"id" withField2:@"role" withField3:@"level" withField4:@"points" withField5:@"nickname" withField6:@"win%" withField7:@"game_count"];
//    [database insertRecordIntoTableNamed:@"PlayerInfo" withField1:@"id" field1Value:1 
//                               andField2:@"role" field2Value:@"benko"
//                               andField3:@"level" field3Value:@"No.1" 
//                               andField4:@"points" field4Value:@"100"
//                               andField5:@"nickname" field5Value:@"bobo" 
//                               andField6:@"win%" field6Value:@"50%" 
//                               andField7:@"game_count" field7Value:@"5"];
//    [database getAllRowsFromTableNamed:@"PlayerInfo"];
//    [database closeDB];
//    [database release];
   
    
    ///* // test code 

//    CardHash* ch = [[CardHash alloc] init];
//    NSMutableArray* r =  ch.card_list_root; 
//    
//    
//    //test 1
//    Player* p = [[Player alloc] init];
//    NSMutableArray* cs = [[NSMutableArray alloc] init];
//    int n = 13; 
//    int i; 
//    for(i = 0; i < n; i++){
//        Card* tc = [[Card alloc] init];
//        CardGroup* cg = [[CardGroup alloc] init];
//        [tc setValue:i _suit:(i+1)%4];
//        [cg setValue:tc _flag:1];
//        [cs addObject:cg];
//    }
//    
//    
//    [p init_card_hash:cs]; 
    
    
    //test2
//    CardHash* ch = [[CardHash alloc] init];
//    Card* card = [[Card alloc] init];
//    [card setValue:1 _suit:0]; 
//    
//    NSMutableArray* cArray = [[NSMutableArray alloc] init];
//    CardList* cl = [[CardList alloc] init];
//    cl.max_card = card; 
//    cl.hand_card = cArray; 
//    ch.card_list_root = cl; 
//    
//    Card* card1 = [[Card alloc] init];
//    [card1 setValue:2 _suit:0]; 
//    CardList* r = ch.card_list_root; 
//    //[r.hand_card addObject:card1]; 
//    
//    [CardList add:&r c:card1];
    // */ 
    
    
    if (_player) { 
        [_player release]; 
    } 
    NSString *soundPath=[[NSBundle mainBundle] pathForResource:@"target" ofType:@"mp3"]; 
    NSURL *soundUrl=[[NSURL alloc] initFileURLWithPath:soundPath]; 
    _player=[[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    [_player setNumberOfLoops:9999];
    [_player prepareToPlay]; 
    [soundUrl release]; 
    
    [_player play];
    [super viewDidLoad];
}


+(AVAudioPlayer *)returnPlayer
{
    return _player;
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        exit(0);
    }
}


@end
