//
//  CardList.m
//  CD2Game
//
//  Created by Xiaobo on 11-7-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CardList.h"


@implementation CardList
@synthesize max_card;
@synthesize hand_card; 

-(id) init
{
    [super init];
    max_card = [[Card alloc] init]; 
    hand_card = [[NSMutableArray alloc] init]; 
    return self; 
}

+(void) add:(CardList**) cl c: (Card*) c
{
    [(*cl).hand_card addObject:c]; 
}

-(void) dealloc
{
    [max_card release];
    [hand_card release];
    [super dealloc]; 
}
@end
