//
//  CDDGameViewController.h
//  CD2Game
//
//  Created by Xiaobo on 11-6-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDDGame.h"
#import "CddData.h"

@class SetViewController;
@class CDDGame;
@class Player;
@class Card;
@class RoleSelectedViewController;
@class ScoreViewController;
@class PlayerInfo;


@interface CDDGameViewController : UIViewController {
    UIImageView *_player1Head;
    UIImageView *_player2Head;
    UIImageView *_player3Head;
    
    UILabel *_playerName;
    UILabel *_name1;
    UILabel *_name2;
    UILabel *_name3;
 
    UILabel *_passLabel;

    UILabel *_scoreLabel;
    UILabel *_cardsCountLabelUser;
    UILabel *_cardsCountLabel1;
    UILabel *_cardsCountLabel2;
    UILabel *_cardsCountLabel3;

    
    
    UILabel *_turnNumLabel;
    
    
    ScoreViewController *_scoreViewController;


    UIButton *_passButton;
    UIButton *_showButton;
     UIButton *_resetChooseButton;
    PlayerInfo *_playerInfo;
    UIButton *_button1;
    CDDGame *_cddGame;
    UILabel *_time;
    NSTimer *_timer;
    NSTimer *_timer2;
    NSTimer *_timer3;
    int _curTime;
    Boolean isChoosed[DotNum];
    Player **players;
    
    //sqlite数据库数据
    CddData *sqldata;

    
    NSMutableArray *cardsBenko, *cardsBenkoDot;
    
    int leftCardNumOnPlayer1Hand;
    
    int leftNumPlayer1;
    int leftNumPlayer2;
    int leftNumPlayer3;
    
    float adjustWid;
    float adjustHig;
    
    
    int l;    //用来控制upwinTurnNum和uploseTurnNum操作！！
    
}

@property (readwrite) float adjustWid;
@property (readwrite) float adjustHig;

@property (nonatomic, retain)IBOutlet UILabel *scoreLabel;
@property (nonatomic, retain)IBOutlet UILabel *cardsCountLabel1;
@property (nonatomic, retain)IBOutlet UILabel *cardsCountLabel2;
@property (nonatomic, retain)IBOutlet UILabel *cardsCountLabel3;
@property (nonatomic, retain)IBOutlet UILabel *cardsCountLabelUser;

//user的card
//用来装button的数组
@property (nonatomic,retain)  NSMutableArray *chooseCard;
@property (nonatomic, retain) NSMutableArray *cardOnHand;
@property (nonatomic, retain) NSMutableArray *cardLeftOnHand;

//用来装card类型的数组
@property (nonatomic, retain) NSMutableArray *chooseCards;

//管理已出的牌(button)
@property (nonatomic, retain) NSMutableArray *cardShowed;


//Computer1的card（包括储存button和card类型的数组）
@property (nonatomic, retain) NSMutableArray *cardsComputer1Owner;
@property (nonatomic, retain) NSMutableArray *cardsComputer1Retain;
@property (nonatomic, retain) NSMutableArray *buttonsComputer1Owner;
@property (nonatomic, retain) NSMutableArray *buttonsComputer1Retain;
@property (nonatomic, retain) NSMutableArray *player1CardsImageViews;

//Computer2的card（包括储存button和card类型的数组）
@property (nonatomic, retain) NSMutableArray *cardsComputer2Owner;
@property (nonatomic, retain) NSMutableArray *cardsComputer2Retain;
@property (nonatomic, retain) NSMutableArray *buttonsComputer2Owner;
@property (nonatomic, retain) NSMutableArray *buttonsComputer2Retain;
@property (nonatomic, retain) NSMutableArray *player2CardsImageViews;


//Computer3的card（包括储存button和card类型的数组）
@property (nonatomic, retain) NSMutableArray *cardsComputer3Owner;
@property (nonatomic, retain) NSMutableArray *cardsComputer3Retain;
@property (nonatomic, retain) NSMutableArray *buttonsComputer3Owner;
@property (nonatomic, retain) NSMutableArray *buttonsComputer3Retain;
@property (nonatomic, retain) NSMutableArray *player3CardsImageViews;



//管理computer出的牌（button）
@property (nonatomic, retain) NSMutableArray *buttonsComputer1Show;
@property (nonatomic, retain) NSMutableArray *buttonsComputer2Show;
@property (nonatomic, retain) NSMutableArray *buttonsComputer3Show;


@property (nonatomic, retain) IBOutlet UILabel *time;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) NSTimer *timer2;
@property (nonatomic, retain) NSTimer *timer3;
@property (nonatomic, retain) IBOutlet UIButton *passButton;
@property (nonatomic, retain) IBOutlet UIButton *showButton;
@property (nonatomic, retain) IBOutlet UIButton *resetChooseButton;

@property (nonatomic, retain) IBOutlet UIImageView *player1Head;
@property (nonatomic, retain) IBOutlet UIImageView *player2Head;
@property (nonatomic, retain) IBOutlet UIImageView *player3Head;

@property (nonatomic, retain) IBOutlet UILabel *playerName;
@property (nonatomic, retain) IBOutlet UILabel *name1;
@property (nonatomic, retain) IBOutlet UILabel *name2;
@property (nonatomic, retain) IBOutlet UILabel *name3;
@property (nonatomic, retain) IBOutlet UILabel *turnNumLabel;

@property (nonatomic, retain) UIViewController *ownerViewController;

- (IBAction)buttonClickedClose:(id)sender;
- (IBAction)rightButtonClicked:(id)sender;
- (IBAction)headButtonClicked:(id)sender;
- (IBAction)buttonCardChoose:(id)sender;
- (IBAction)buttonShowCards;
- (void)showTime;
- (void)showCard1:(NSMutableArray *) buttonsCard;
- (void)showCard2:(NSMutableArray *) buttonsCard;
- (void)showCard3:(NSMutableArray *) buttonsCard;
- (void)playCD2Game;
- (int)caculateCardPoint:(Card *)card;
- (void)setButtonUnused;
- (IBAction)menuButtonClicked;
- (IBAction)passButton:(id)sender;
- (void)player1Operate;
- (void)player2Operate;
- (void)player3Operate;
- (IBAction)sortButtonClicked:(id)sender;
- (void)showHeadAndName;
- (void)sortAndshowCardsOnUserHand;
- (Boolean)compareCardsOnUserAndLastPlayer;
- (void)dismissSelf;
//重选按钮函数
-(IBAction)resetChooseCards;

//各种数据库操作的函数
-(void) nextAction;
-(void) deleteAction;
-(void) updateAction;


@end
