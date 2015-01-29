//
//  PlayerInfoDB.h
//  CD2Game
//
//  Created by Xiaobo on 11-8-2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlayerInfo;

@interface PlayerInfoDB : NSObject {
    
}

+ (PlayerInfoDB *)instance;

- (void)addPlayerInfo:(NSString *)account allScore:(int)allScore turns:(int)turns;
- (void)deletePlayerInfo:(PlayerInfo *)playerInfo;
- (NSMutableArray *)getPlayerInfos;


@end
