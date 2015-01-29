//
//  PlayerInfo.h
//  CD2Game
//
//  Created by Xiaobo on 11-8-2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlayerInfo : NSObject {
    int _turns;
    int _allScore;
    NSString *_account;
}

@property (nonatomic, retain)NSString *account;
@property int turns, allScore;

- (id)initWithAccount:(NSString *)account allScore:(int)allScore turns:(int)turns;


@end
