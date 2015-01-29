//
//  CardList.h
//  CD2Game
//
//  Created by Xiaobo on 11-7-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface CardList : NSObject {
    Card* max_card; 
    NSMutableArray* hand_card; 
}

@property (nonatomic, retain) Card* max_card; 
@property (nonatomic, retain) NSMutableArray* hand_card; 
-(id) init; 

+(void) add:(CardList**) cl c: (Card*) c;
@end
