//
//  CardGroup.m
//  CD2Game
//
//  Created by Xiaobo on 11-7-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CardGroup.h"


@implementation CardGroup
@synthesize card; 
@synthesize flag; 

-(id) init: (Card*) _card _flag: (int) _flag
{
    [super init]; 
    card = _card; 
    flag = _flag; 
    
    return self; 
}

-(void) setValue: (Card*) _card _flag: (int) _flag
{
    card = _card; 
    flag = _flag; 
}

- (void)dealloc
{
    [card release];
    [super release];
}
@end
