//
//  MenuViewController.m
//  CD2Game
//
//  Created by Xiaobo on 11-7-7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import "SetViewController.h"
#import "CDDGameViewController.h"
#import "RankingViewController.h"
#import "GameSet.h"
#import "PlayerInfo.h"
#import "PlayerInfoDB.h"

@implementation MenuViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    // Return YES for supported orientations
	return YES;
}

- (IBAction)setButtonClicked:(id)sender
{
    GameSet *_gameSet = [[GameSet alloc]init];
    _gameSet.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentModalViewController:_gameSet animated:YES];
    //[self.view addSubview:_setViewController.view];
    //[self.view insertSubview:_setViewController.view atIndex:100];
    //[_setViewController release];
}

- (IBAction)goOnButtonCliced:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    //[self.view removeFromSuperview];
}

- (IBAction)returnButtonClicked:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示：" message:@"逃跑扣除200分！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert addButtonWithTitle:@"取消"];
    [alert show];
    [alert release];
       
    //exit(0);
//    if ([alert cancelButtonIndex] == -1){
//        RoleSelectedViewController *gameController = [[RoleSelectedViewController alloc]init];
//        [self presentModalViewController:gameController animated:YES];
//        [gameController release];
//        [self dismissModalViewControllerAnimated:YES];
//    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
       

       //数据库用户减少200分 
        NSMutableArray *playerInfos = [[PlayerInfoDB instance]getPlayerInfos];
        PlayerInfo * _playerInfo = [playerInfos objectAtIndex:0];
        
      
        
        [sqldata updateSelectUserScoreR:[sqldata selectLastName] score:_playerInfo.allScore-200];    
        NSLog(@"减分成功");
        
        
        
        
        
        RoleSelectedViewController *gameController = [[RoleSelectedViewController alloc]init];
        [self presentModalViewController:gameController animated:YES];
        [gameController release];
        [self dismissModalViewControllerAnimated:YES];
    }
}


- (IBAction)rankingButtonClicked:(id)sender
{
    RankingViewController *_rankingViewController = [[RankingViewController alloc]init];
    _rankingViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentModalViewController:_rankingViewController animated:YES];
    //[self.view addSubview:_setViewController.view];
    //[self.view insertSubview:_setViewController.view atIndex:100];
    //[_setViewController release];
     [self dismissModalViewControllerAnimated:YES];
}
@end
