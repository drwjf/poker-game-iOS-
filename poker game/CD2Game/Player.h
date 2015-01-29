//
//  Player.h
//  CD2Game
//
//  Created by Xiaobo on 11-6-29.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Enumeration.h"
#import "Card.h"
#import "CardHash.h"
#import "CardList.h"

@interface Player : User {
    int score; 
    NSString* userID; 
    enum PlayerType playerType; 
    //short trickNum; 
    //short maxTrickNum;
    //playerState playerState; 
    
    
    NSMutableArray* cardsOnHand; 
    NSMutableArray* lastCard;
    cardType lastCardType;  
    
    //AI part
    
    NSMutableArray* cardhash[9]; 
}


@property int score;
@property(nonatomic,retain) NSString* userID; 
@property enum PlayerType playerType;
@property(nonatomic,retain) NSMutableArray* cardsOnHand; 
@property(nonatomic,retain) NSMutableArray* lastCard; 
@property cardType lastCardType; 


- (NSMutableArray**) cardhash; 
- (void) initCardsOnHand: (NSMutableArray*) _cardsOnHand;
- (void) initPlayer: (NSString*) _userID; 
- (BOOL) useTrick;

//choose cards for a user player, lastCards is the cards played by the last player.
//If lastCards is nil, then this player is the first 
- (NSMutableArray*)selectCards: (BOOL) needDiamondThree nowCards: (NSMutableArray*) nowCards lastCards:(NSMutableArray*)lastCards isFisrt:(Boolean) nowCards; 
- (void) showCards;
- (BOOL) timeOout;
- (BOOL) leave; 

//clear the cards of the player 
- (void) clearCardsOnHand;

//distribute a card to the player 
- (void) addCard:(Card*) card;
- (Boolean) hasCard:(Card*) card;

// AI part
-(void) add_hand_card: (Card*) _card cl_node:(NSMutableArray*) cl_node;


-(void) add_cl:(NSMutableArray*)cl_root card:(Card*) card; 

-(void) add_into_hash:(cardType) ct _card:(NSMutableArray*) _card; 

-(Boolean) comp_card: (Card*) owncard othercard:(Card*)othercard;

-(Boolean) comp_vector: (NSMutableArray*) oldcard newcard:(NSMutableArray*) newcard;

-(NSMutableArray*) del_card:(NSMutableArray*) cl_root delcard:(NSMutableArray*) delcard; 

-(NSMutableArray*) getCard_larger:(cardType) ct other_maxcard:(Card*)other_maxcard;

-(NSMutableArray*) card_max: (cardType) ct;

-(NSMutableArray*) getCard_max: (cardType) ct;


-(NSMutableArray*) getCard_min: (cardType) ct;

-(int) getType_num: (cardType) ct;

-(NSMutableArray*) getSquare3;

-(void) del_flag: (NSMutableArray*) cg temp_card:(NSMutableArray*) temp_card;

-(void) init_card_hash: (NSMutableArray*) cg;

-(void) print_hash;

-(NSMutableArray*) fllowCard: (NSMutableArray*) tempCard;

-(NSMutableArray*) outCard:(Boolean) needDiamondThree humanCardList:(NSMutableArray*) humanCardList; 

@end
