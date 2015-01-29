//
//  RankingViewController.m
//  CD2Game
//
//  Created by Kwan Terry on 12-1-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "RankingViewController.h"
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
#import"CD2GameViewController.h"

@implementation RankingViewController

@synthesize Nameone ;
@synthesize Nametwo;
@synthesize Namethree;
@synthesize Namefour; 
@synthesize Namefive;






@synthesize Scoreone ;
@synthesize Scoretwo;
@synthesize Scorethree;
@synthesize Scorefour; 
@synthesize Scorefive;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
   
    
    return self;
}




- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



- (void)viewDidLoad
{
    NSMutableArray  *arrayName;
    arrayName = [NSMutableArray arrayWithCapacity: 10];
    
    NSMutableArray *arrayScore;
    arrayScore = [NSMutableArray arrayWithCapacity: 10];
    
    
    
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    sqldata = [[CddData alloc]init];
    //打开数据库
    
    [sqldata openDB];
    [sqldata createTable];
    [sqldata createScorePlace];
    sqlite3_stmt *statement = [sqldata scoreStatement];
    
    
    int count = 0;
   
    while (count <= 4&& sqlite3_step(statement) == SQLITE_ROW) {
       // count ++;
       
       
        [arrayName addObject:[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding]];
    
        [arrayScore addObject:[NSString stringWithFormat:@"%d", sqlite3_column_int(statement, 1)]];
        
        
     /*   
        
        self.Nameone.text = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
     
        
        
        
        self.Scoreone.text= [NSString stringWithFormat:@"%d", sqlite3_column_int(statement, 1)];
        
*/
    }
    
//    if([arrayName objectAtIndex:0] != NULL)
//    self.Nameone.text = [arrayName objectAtIndex:0];
//    if([arrayName objectAtIndex:1] !=NULL )
//    self.Nametwo.text = [arrayName objectAtIndex:1];
//    if([arrayName objectAtIndex:2] !=NULL )
//    self.Namethree.text = [arrayName objectAtIndex:2];
//     if([arrayName objectAtIndex:3] !=NULL )
//    self.Namefour.text = [arrayName objectAtIndex:3];
//      if([arrayName objectAtIndex:4] !=NULL )
//    self.Namefive.text = [arrayName objectAtIndex:4];
    
    for(int i=0; i<[arrayName count]; i++)
    {
        switch(i)
        {
        case 0:
                self.Nameone.text = [arrayName objectAtIndex:0];
                self.Scoreone.text=[arrayScore objectAtIndex:0];
                break;
        case 1:
                self.Nametwo.text = [arrayName objectAtIndex:1];
                self.Scoretwo.text= [arrayScore objectAtIndex:1];
                break;
        case 2:
                self.Namethree.text = [arrayName objectAtIndex:2];
                self.Scorethree.text= [arrayScore objectAtIndex:2];
                break;
        case 3:
                self.Namefour.text = [arrayName objectAtIndex:3];
                self.Scorefour.text= [arrayScore objectAtIndex:3];
                
        case 4:
                self.Namefive.text = [arrayName objectAtIndex:4];
                self.Scorefive.text= [arrayScore objectAtIndex:4];
                
        }
    }
    
//     if( [arrayScore objectAtIndex:0] !=NULL )
//    self.Scoreone.text=[arrayScore objectAtIndex:0];
//    if( [arrayScore objectAtIndex:1] !=NULL )
//    self.Scoretwo.text= [arrayScore objectAtIndex:1];
//    if( [arrayScore objectAtIndex:2] !=NULL )
//    self.Scorethree.text= [arrayScore objectAtIndex:2];
//    if( [arrayScore objectAtIndex:3] !=NULL )
//    self.Scorefour.text= [arrayScore objectAtIndex:3];
//    if( [arrayScore objectAtIndex:4] !=NULL )
//    self.Scorefive.text= [arrayScore objectAtIndex:4];
    
    
    
    
    
    
    [sqldata closeDB];
    
    
}





    - (void) dealloc
    {
        //这里添加需要释放的对象
        [sqldata release];
        // don't forget to call "super dealloc"
        [Nameone release];
        [Nametwo release];
        [Namethree release];
        [Namefour release];
        [Namefive release];
       
        [Scoreone release];
        [Scoretwo release];
        [Scorethree release];
        [Scorefour release];
        [Scorefive release];
        [super dealloc];
    }

- (void)viewDidUnload
{
    [Nameone release];
    Nameone = nil;
    [Scoreone release];
    Scoreone = nil;
    [Nametwo release];
    Nametwo = nil;
    [Scoretwo release];
    Scoretwo = nil;
    [Namethree release];
    Namethree = nil;
    [Namefour release];
    Namefour = nil;
    [Namefive release];
    Namefive = nil;
    [Scorethree release];
    Scorethree = nil;
    [Scorefour release];
    Scorefour = nil;
    [Scorefive release];
    Scorefive = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


- (IBAction)ExitButtonClicked:(id)sender
{
    //exit(0);
//    MenuViewController *gameController = [[MenuViewController alloc]init];
//    [self presentModalViewController:gameController animated:YES];
//    [gameController release];
    [self dismissModalViewControllerAnimated:YES];
      [self.view removeFromSuperview];
    
    
    
    //    PlayerInfo *playerInfo = [[PlayerInfo alloc]initWithAccount:self.nameTextField.text allScore:0 turns:0];
//    [[PlayerInfoDB instance]addPlayerInfo:self.nameTextField.text allScore:0 turns:0]; 
//    NSString* nameStr;
//    name = self.nameTextField.text;
//    nameStr = name;
    //    [sqldata insertUserWithName:self.nameTextField.text];
    //    [sqldata useName:self.nameTextField.text];
    //    [sqldata closeDB];
    
    // RoleSelectedViewController *roleSelectedViewController = [[RoleSelectedViewController alloc]init];
    //  [self presentModalViewController:roleSelectedViewController animated:YES];
    // [roleSelectedViewController release];
//    [self dismissModalViewControllerAnimated:YES];
//    [self.view removeFromSuperview];
}



@end
