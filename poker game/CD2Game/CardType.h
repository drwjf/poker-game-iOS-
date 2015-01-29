//
//  CardType.h
//  CD2Game
//
//  Created by Xiaobo on 11-6-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Enumeration.h"

 

@interface CardType : NSObject {

    
    
}
+ (int) getNum:(cardType) type; 
+ (cardType) getCardType: (NSMutableArray*) selectedCard; 
+ (Card*) getMaxCard:(NSMutableArray*) cards; 
+ (Boolean) compareCards:(NSMutableArray*) selectedCard _tempCard:(NSMutableArray*) tempCard;
+ (NSComparisonResult) cardCmp:(Card*) card1 _card2:(Card*) card2; 
+ (BOOL) cardCmpSuit:(Card*) card1 _card2:(Card*) card2;
+ (NSMutableArray*) sortCards: (NSMutableArray*) cards;
+ (NSMutableArray*) sortCardsSuit: (NSMutableArray*) _cards;

+ (NSMutableArray*) sortCardsCombo: (NSMutableArray*) _cards; 
@end
