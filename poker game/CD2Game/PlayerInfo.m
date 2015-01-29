//
//  PlayerInfo.m
//  CD2Game
//
//  Created by Xiaobo on 11-8-2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PlayerInfo.h"


@implementation PlayerInfo

@synthesize turns = _turns, allScore = _allScore;
@synthesize account = _account;

- (id)initWithAccount:(NSString *)account allScore:(int)allScore turns:(int)turns
{
    self = [super init];
    if (self) 
    {
        self.turns = turns;
        self.allScore = allScore;
        self.account = account;
    }
    return self;
}


- (void)dealloc
{
    [_account release];
    [super dealloc];
}

@end
