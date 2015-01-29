//
//  CDDGame.h
//  CD2Game
//
//  Created by Xiaobo on 11-6-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
/*
 CDDGame 函数调用顺序：
 每次进入牌桌，先调用start。每开始一局游戏，调用playCDDGame，每次出牌调用takeTurn函数 
*/ 

#import <Foundation/Foundation.h>
#import "Enumeration.h"
#import "Player.h"


//the number of the players 
#define  PlayerNum 4

//the number of different dots
#define DotNum 13

//the number of different suits
#define SuitNum 4





@interface CDDGame : NSObject {
    enum GameState gameState; 
    
    // Record the index of last winner.
    // The value is -1 indicates the first inning of the 
    // game, or the diamond three is needed.
    int lastWinner;  
    int last;
    int now; 
    BOOL needDiamondThree; 
    Player* players[PlayerNum]; 
    int score[PlayerNum];  //每个玩家的总的积分
    
    //the card type of the current round 
    cardType tempCardType;  
    
    NSMutableArray* tempCard; 
    // the cards the last player played 
}

@property int last;
@property int now; 
//@property Player** players; 

//Start the game. Initialize informationsdel_card of the players.
//Call the function named playCDDGame to start a new game.
//If the game cann't start, then return false 
- (BOOL) start: (NSMutableArray*) _players;

//Call function named distributeCards to distribute cards 
//to players. Call function named takeTrun
//to start a new round . Determine the player who muast 
//begin the game
- (void) playCDDGame; 


- (BOOL) takeTurn; 

// Check if the game is over !
- (BOOL) isOver;

// Calculate the score of each player 
- (NSMutableArray *) calculateScore;

//Distribute cards to players.
- (void) distributeCards;

// AI select cards for computer player . If the return variable is nil, then now player pass. 
-(NSMutableArray*) selectCards:(BOOL) isFirst; 

- (BOOL) takeTurnUser: (NSMutableArray*) nowCards; 

-(int) getNow;

-(Player**) players; 


@end
