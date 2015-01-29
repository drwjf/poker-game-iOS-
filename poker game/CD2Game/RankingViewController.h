//
//  RankingViewController.h
//  CD2Game
//
//  Created by Kwan Terry on 12-1-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDDGame.h"
#import"CddData.h"

@class SetViewController;
@class CDDGame;
@class Player;
@class Card;
@class RoleSelectedViewController;
@class ScoreViewController;
@class PlayerInfo;

@interface RankingViewController : UIViewController{
    
    IBOutlet UILabel *Nameone;
      
    IBOutlet UILabel *Nametwo;
   
    IBOutlet UILabel *Namethree;
    
    IBOutlet UILabel *Namefour;
    
    IBOutlet UILabel *Namefive;
    
    
    
    
    
    
    
    IBOutlet UILabel *Scoretwo;
    
    IBOutlet UILabel *Scoreone;
   
    IBOutlet UILabel *Scorethree;
    
    IBOutlet UILabel *Scorefour;
    
    IBOutlet UILabel *Scorefive;
    
    
    
    
    
    NSString *Allscoreone;
    NSMutableArray *_scoreArray;
    
  
    
    //sqlite数据库数据
    CddData *sqldata;
    
}

@property (nonatomic , retain)IBOutlet
 UILabel *Nameone;
@property (nonatomic , retain)IBOutlet
UILabel *Nametwo;
@property (nonatomic , retain)IBOutlet
UILabel *Namethree;
@property (nonatomic , retain)IBOutlet
UILabel *Namefour;
@property (nonatomic , retain)IBOutlet
UILabel *Namefive;






@property (nonatomic , retain)IBOutlet
UILabel *Scoreone;
@property (nonatomic , retain)IBOutlet
UILabel *Scoretwo;
@property (nonatomic , retain)IBOutlet
UILabel *Scorethree;
@property (nonatomic , retain)IBOutlet
UILabel *Scorefour;
@property (nonatomic , retain)IBOutlet
UILabel *Scorefive;







- (id)initWithScoreArray:(NSMutableArray *)scoreArray playerInfo:(PlayerInfo *)playerInfo;

- (IBAction)ExitButtonClicked:(id)sender;

//各种数据库操作的函数
-(void) nextAction;
-(void) deleteAction;
-(void) updateAction;

@end
