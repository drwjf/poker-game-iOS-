//
//  ScoreViewController.m
//  CD2Game
//
//  Created by Xiaobo on 11-7-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ScoreViewController.h"
#import "CDDGameViewController.h"
#import "PlayerInfo.h"
#import "RoleSelectedViewController.h"


@implementation ScoreViewController

@synthesize  userLabel = _userLabel;
@synthesize player1Label = _player1Label;
@synthesize player2Label = _player2Label;
@synthesize player3Label = _player3Label;
@synthesize turnsLabel = _turnsLabel;
@synthesize allScoreLabel = _allScoreLabel;

//防止插入3次分数
int ii = 0;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    
    sqldata = [[CddData alloc]init];
    //打开数据库
    
    [sqldata openDB];
    [sqldata createTable];
    [sqldata createScorePlace];
    
    
    return self;
}

- (id)initWithScoreArray:(NSMutableArray *)scoreArray playerInfo:(PlayerInfo *)playerInfo
    
{
    
    
    self = [super init];
    if (self)
    {
        _scoreArray = [[NSMutableArray alloc]init];
        _scoreArray = scoreArray;
        NSLog(@"turns and allScore are:%d, %d",playerInfo.turns, playerInfo.allScore);
        _turnsStr = [NSString stringWithFormat:@"总局数:%d",playerInfo.turns];
        _allScoreStr = [NSString stringWithFormat:@"总得分:%d",playerInfo.allScore];
       if(ii ==0)
       {
       
       
        //记录数据库通过
        [sqldata updateSelectUserScore:[sqldata selectLastName] score:playerInfo.allScore];
        [sqldata insertScoreName:[sqldata selectLastName] score:playerInfo.allScore];
        NSLog(@"记录总分分数通过");
        [sqldata closeDB];
           ii++;
       }

    }
    NSLog(@"array count is :%d", [_scoreArray count]);
    return self;
}

- (void)dealloc
{
    
    
    
    
    
    [_allScoreLabel release];
    [_turnsLabel release];
    [_player3Label release];
    [_player2Label release];
    [_player1Label release];
    [_scoreArray release];
    [super dealloc];
}

- (IBAction)restartButtonClicked:(id)sender
{
    CDDGameViewController *cddGameViewController = [[CDDGameViewController alloc]init];
    [self presentModalViewController:cddGameViewController animated:YES];
    //[self.view insertSubview:cddGameViewController.view atIndex:100];
    //[cddGameViewController release];
}

- (IBAction)returnButtonClicked:(id)sender
{
    RoleSelectedViewController *gameController = [[RoleSelectedViewController alloc]init];
    [self presentModalViewController:gameController animated:YES];
    [gameController release];
    [self dismissModalViewControllerAnimated:YES];
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
    // Do any additional setup after loading the view from its nib.
    
    self.userLabel.text = [_scoreArray objectAtIndex:0];
    self.player1Label.text = [_scoreArray objectAtIndex:1];
    self.player2Label.text = [_scoreArray objectAtIndex:2];
    self.player3Label.text = [_scoreArray objectAtIndex:3];
    self.turnsLabel.text = _turnsStr;
    self.allScoreLabel.text = _allScoreStr;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
