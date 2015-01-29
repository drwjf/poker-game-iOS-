//
//  Card.m
//  CD2Game
//
//  Created by Xiaobo on 11-6-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Card.h"


@implementation Card


@synthesize dotNum;
@synthesize suit;

//@synthesize nxt; 


- (id) setValue:(int) _dotNum _suit:(int) _suit
{
    self.dotNum = _dotNum; 
    self.suit = _suit;
    return self;
}

- (void) setValue:(Card*) card
{
    self.dotNum = card.dotNum; 
    self.suit = card.suit; 
}


- (Boolean)operatorLess:(Card *)card
{
    return self.dotNum < card.dotNum ||(self.dotNum == card.dotNum && self.suit < card.suit);
}

- (Card*)maxCard
{
    Card* ans = [Card new];
    int num = self.dotNum; 
    if(num <= 2) num += 13; 
    [ans setValue:num _suit:self.suit]; 
    return  ans; 
    
}

- (BOOL) isEqual: (Card* ) card
{
    return dotNum == card.dotNum && suit == card.suit; 
}
- (void) dealloc
{
    [super dealloc];
    
}




@end
