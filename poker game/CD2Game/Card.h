//
//  Card.h
//  CD2Game
//
//  Created by Xiaobo on 11-6-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Card : NSObject {
    
    //Card* nxt; 
    int dotNum;  //start from 1
    int suit;     //start from 0
}


@property int dotNum;
@property int suit;
//@property Card* nxt; 

- (Boolean) operatorLess:(Card *) card;
- (Card*) maxCard;
- (id) setValue:(int) _dotNum _suit:(int) _suit;
- (void) setValue:(Card*) card;
- (BOOL) isEqual: (Card* ) card; 


@end
