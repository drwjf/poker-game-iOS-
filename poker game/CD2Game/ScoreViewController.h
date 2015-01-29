//
//  ScoreViewController.h
//  CD2Game
//
//  Created by Xiaobo on 11-7-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"CddData.h"

@class PlayerInfo;

@interface ScoreViewController : UIViewController {
    NSMutableArray *_scoreArray;
    UILabel *_userLabel;
    UILabel *_player1Label;
    UILabel *_player2Label;
    UILabel *_player3Label;
    UILabel *_turnsLabel;
    UILabel *_allScoreLabel;
    NSString *_turnsStr;
    NSString *_allScoreStr;
    
    
    //sqlite数据库数据
    CddData *sqldata;
    
}

@property (nonatomic, retain)IBOutlet UILabel *userLabel;
@property (nonatomic, retain)IBOutlet UILabel *player1Label;
@property (nonatomic, retain)IBOutlet UILabel *player2Label;
@property (nonatomic, retain)IBOutlet UILabel *player3Label;

@property (nonatomic, retain)IBOutlet UILabel *turnsLabel;
@property (nonatomic, retain)IBOutlet UILabel *allScoreLabel;



- (id)initWithScoreArray:(NSMutableArray *)scoreArray playerInfo:(PlayerInfo *)playerInfo;
- (IBAction)restartButtonClicked:(id)sender;
- (IBAction)returnButtonClicked:(id)sender;

//各种数据库操作的函数
-(void) nextAction;
-(void) deleteAction;
-(void) updateAction;
@end
