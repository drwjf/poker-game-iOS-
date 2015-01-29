//
//  Enumeration.h
//  CD2Game
//
//  Created by Xiaobo on 11-6-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

/*
 
 下一步：设计CDDGame的takeTurn函数 
 */ 
#import <Foundation/Foundation.h>

enum GameState {
    START = 0, 
    SUSPEND,
    END
}; 


enum PlayerState{
    TAKETURN = 0,
    OFFLINE
};

enum Suit{
    DIAMONDS = 0,
    CLOB,
    HEARTS,
    SPACE
};


enum UserCatalog{
    u1 = 0
};

enum TheOneTakeTurn {
    ME = 0,
    COMPUTER1,
    COMPUTER2,
    COMPUTER3
};

typedef enum {
    INVALID = 0,  //非法
    SINGLE,       //单张
    COUPLE,       //一对
    THREE,        //三张
    MIXSEQ,       //杂顺
    FLUSH,        //同花
    CAPTURE,      //三带二
    KINGTONG,     //四带一
    STRAIGHTFLUSH //同花顺
} cardType;

enum PlayerType {
    USER = 0,  //user player
    COMPUTER//computer player
};

#define CatalogNum 10

@interface Enumeration : NSObject {
    
}

@end
