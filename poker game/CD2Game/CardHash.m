//
//  CardHash.m
//  CD2Game
//
//  Created by Xiaobo on 11-7-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CardHash.h"
#import "CardList.h"
#import "CardType.h"
@implementation CardHash
@synthesize card_list_root; 

-(id) init
{
    [super init]; 
    card_list_root = [[NSMutableArray alloc] init]; 
        //NSLog(@"cardHash function"); 
    return self; 
}


- (void)dealloc
{
    [card_list_root release];
    [super dealloc];
}

@end
