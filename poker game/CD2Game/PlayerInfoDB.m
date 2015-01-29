//
//  PlayerInfoDB.m
//  CD2Game
//
//  Created by Xiaobo on 11-8-2.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PlayerInfoDB.h"
#import "PlayerInfo.h"
#include <sqlite3.h>

#define DATABASE @"PlayerInfos.db"

static PlayerInfoDB *_instance;

@interface PlayerInfoDB()

- (sqlite3 *)openDB;
- (void)createTable:(sqlite3 *)db;
- (void)insertPlayerInfoIntoTable:(NSString *)account allScore:(int)allScore turns:(int)turns db:(sqlite3 *)db;
- (void)deletePlayerInfo:(PlayerInfo *)playerInfo db:(sqlite3 *)db;
- (NSMutableArray *)getPlayerInfos:(sqlite3 *)db;

    
@end

@implementation PlayerInfoDB


+ (PlayerInfoDB *)instance
{
    if (_instance == nil)
    {
        _instance = [[PlayerInfoDB alloc]init];
    }
    return _instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)addPlayerInfo:(NSString *)account allScore:(int)allScore turns:(int)turns
{
    sqlite3 *db = [self openDB];
    [self insertPlayerInfoIntoTable:account allScore:allScore turns:turns db:db];
    sqlite3_close(db);    
}

- (void)deletePlayerInfo:(PlayerInfo *)playerInfo
{
    sqlite3 *db = [self openDB];
    [self deletePlayerInfo:playerInfo db:db];
    sqlite3_close(db);
}

- (NSMutableArray *)getPlayerInfos
{
    sqlite3 *db = [self openDB];
    NSMutableArray *result = [self getPlayerInfos:db];
    sqlite3_close(db);
    return [result autorelease];
}


- (sqlite3 *)openDB
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    NSString *path = [documentsDir stringByAppendingPathComponent:DATABASE];
    
    sqlite3* db;
    if (sqlite3_open([path UTF8String], &db) != SQLITE_OK )
    {
        sqlite3_close(db);
        NSLog(@"db failed to open.");
    }
    [self createTable:db];
    return db;
}

- (void)createTable:(sqlite3 *)db
{
    NSString *sql = @"CREATE TABLE IF NOT EXISTS PlayerInfos ( account TEXT PRIMARY KEY, allScore INTEGER, turns INTEGER);";
    
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) 
    {
        sqlite3_close(db);
        NSLog(@" table failed to create.");
	}
}

- (void)insertPlayerInfoIntoTable:(NSString *)account allScore:(int)allScore turns:(int)turns db:(sqlite3 *)db
{
    NSString *sql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO PlayerInfos (account, allScore, turns) VALUES ('%@','%d','%d')", account, allScore, turns];
//    NSLog(@"shit");
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) 
    {
        sqlite3_close(db);
        NSLog(@"PlayerInfo failed to insert.");
	}
}

- (void)deletePlayerInfo:(PlayerInfo *)playerInfo db:(sqlite3 *)db
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM PlayerInfos WHERE account == %@",playerInfo.account];
    
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) 
    {
        sqlite3_close(db);
        NSLog(@"PlayerInfo failed to delete.");
	}
    
}


- (NSMutableArray *)getPlayerInfos:(sqlite3 *)db
{
    NSMutableArray *result = [[NSMutableArray alloc]initWithCapacity:100];
    
    NSString *sql = @"SELECT account, allScore, turns FROM PlayerInfos";
    sqlite3_stmt *statement;
	if (sqlite3_prepare_v2( db, [sql UTF8String], -1, &statement, nil) ==
		SQLITE_OK) {
		
        while (sqlite3_step(statement) == SQLITE_ROW)
        {           
            NSString *account = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 0)];
            int allScore = sqlite3_column_int(statement, 1);
            int turns = sqlite3_column_int(statement, 2);
            
            PlayerInfo *playerInfo = [[PlayerInfo alloc] initWithAccount:account allScore:allScore turns:turns];
            
            [result addObject:playerInfo];
            [playerInfo release];
        }
        
        sqlite3_finalize(statement);
    }
    return [result retain];
    
}


@end
