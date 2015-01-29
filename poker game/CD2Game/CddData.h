//
//  CddData.h
//  CD2Game
//
//  Created by Kwan Terry on 12-1-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//




#import <Foundation/Foundation.h>
#include <sqlite3.h>

@interface CddData : NSObject {
    //数据库的名字
    sqlite3 * database;
    //存储用户列表
    sqlite3_stmt * nextStatement;
    //用户的表
    NSString * userTableName;
    float currentMvol;
    float currentEvol;
    int currentScore;
    
    //分数排名的表
    NSString * scorePlace;
}

-(void) openDB;
-(void) createTable;
-(void) createScorePlace;
-(void) insertScoreName:(NSString *) name score:(int)x;
-(sqlite3_stmt*) scoreStatement;
-(void) deleteScore:(int) x;
- (void) insertUserWithName:(NSString*) name;
-(NSString *) nextUser;
- (void) deleteUser:(NSString *) name;
- (void) updateUser:(NSString *) name withMvol:(float) mvol andEvol:(float) evol;
-(void) displayRecord;
-(void) closeDB;
-(float) gettingMvol;
-(float) gettingEvol;
-(int) gettingScore;
-(void) updateSelectUserScoreR:(NSString *)name score:(int) x;
-(void) useName:(NSString *)name;
-(NSString *) selectLastName;
-(void) updateSelectUserScore:(NSString *)name score:(int) x;

@end


