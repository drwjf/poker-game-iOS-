//
//  CDDGame.m
//  CD2Game
//
//  Created by Xiaobo on 11-6-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CDDGame.h"
#import "CardType.h"
#import "CardGroup.h"
#import "CardHash.h"
@implementation CDDGame
@synthesize last;
@synthesize now; 


-(id) init
{
    int i; 
    for(i = 0; i < PlayerNum; i++){
        players[i] = [[Player alloc] init];
    }
    return self; 
}

- (BOOL) start: (NSMutableArray*) _players
{
     // the game can't start 
    if([_players count] != PlayerNum) return FALSE;  
    int i; 
    for(i = 0; i < PlayerNum; i++){
        players[i] = [_players objectAtIndex:i];
        score[i] = 0; 
    }
    lastWinner = -1; 
    // the game can start
    //[self playCDDGame]; 
    NSLog(@"start is called\n");
    
    return YES;  
}

- (void)dealloc
{
    [tempCard release];
    [super dealloc];
}

- (void) playCDDGame
{
    
   [self distributeCards];
    
    //determine the first player in the first round 
    if(lastWinner >=0 ){
        now = lastWinner;
        needDiamondThree = NO; 
    }else{
        Card* diamondThree = [[Card alloc] init];
        [diamondThree setValue:3 _suit:0];
        int i, j; 
        for(i = 0; i < PlayerNum; i++){
            for(j = 0; j < DotNum; j++){
                Card* tmp = [players[i].cardsOnHand objectAtIndex:j]; 
                
                NSLog(@"(%d, %d): (%d, %d)", i, j, tmp.dotNum, tmp.suit); 
                if([[players[i].cardsOnHand objectAtIndex:j] isEqual:diamondThree]){
                    break;
                }
            }
            if(j < DotNum){
                break; 
            }
        }
        now = i; 
        needDiamondThree = YES; 
        
    }
    last = -1;   
    
}
- (BOOL) takeTurn
{
    NSMutableArray* cards = [[NSMutableArray alloc] init];
    BOOL flag; 
    if([players[now] playerType] == COMPUTER){  //computer player
        //NSLog(@"playerNowNum:%d", [players[now].cardsOnHand count]); 
        cards = [self selectCards: (last == -1 || last == now)];
        if(cards == nil){
            flag = NO; 
        }else{
            flag = YES; 
        }
    }else{  //user player
        //cards = [players[now] selectCards:needDiamondThree lastCards:tempCard];
        cards = nil; 
    }
    
    if(cards == nil){
        flag = NO; 
    }else{
        flag = YES; 
    }
    if(flag){
        last = now;  
    }
    if(players[now].lastCard){
        players[now].lastCard =nil;  
    }
    players[now].lastCard = cards; 
    
    //NSLog(@"last:%d  now: %d cardNum:%d", last, now, [cards count]); 
    now = (now+1)%PlayerNum; 
    needDiamondThree = NO; 
    return flag; 
    
}
- (BOOL) takeTurnUser: (NSMutableArray*) nowCards
{
    if (nowCards == nil) {
        NSLog(@"nowCards is nil");
    }

    NSMutableArray* cards = [[NSMutableArray alloc] init];
    BOOL flag; 
    if([players[now] playerType] == COMPUTER){  //computer player
        cards = nil; 
    }else{  //user player
        //cards = [players[now] selectCards:needDiamondThree lastCards:tempCard];
        if(last >= 0){
            cards = [players[now] selectCards:needDiamondThree nowCards:nowCards lastCards:players[last].lastCard isFisrt:NO];
        }else{
            cards = [players[now] selectCards:needDiamondThree nowCards:nowCards lastCards:nil isFisrt:YES];
        }
    }
    
    if(cards == nil){
        flag = NO; 
    }else{
        flag = YES; 
    }
    if(flag){
        last = now;  
    }
    if(players[now].lastCard){
        players[now].lastCard =nil;  
    }
    players[now].lastCard = cards; 
    
    //NSLog(@"last:%d  now: %d cardNum:%d", last, now, [cards count]); 
    now = (now+1)%PlayerNum; 
    needDiamondThree = NO; 
    return flag; 
    
}

- (BOOL) isOver
{
    if(last >= 0 && [players[last].cardsOnHand count] == 0) return  YES; 
    return NO; 
}
- (NSMutableArray *) calculateScore
{
    int s[PlayerNum], sum; 
    int i; 
    for(i = sum = 0; i < PlayerNum; i++){
        s[i] = [players[i].cardsOnHand count]; 
        if(8 <= s[i] && s[i] < 10){
            s[i] *= 2; 
        }else if(10 <= s[i] && s[i] < 13){
            s[i] *= 3; 
        }else if(s[i] == 13){
            s[i] *= 4; 
        }
        if(s[i] >= 8){
            Card* spaceTwo; 
            [spaceTwo setValue:2 _suit:3]; 
            if([players[i] hasCard:spaceTwo]){
                s[i] *= 2; 
            }
        }
        sum += s[i]; 
    }
    for(i = 0; i < PlayerNum; i++){
        s[i] = sum - s[i]*4; 
        score[i] += s[i]; 
    }
    //这时s数组记录的每个玩家再这一局的得分    
    
}

- (void) distributeCards
{
    
    int i, j, nowPos, num;  
    const static short Num = DotNum*SuitNum; 
    int v[Num]; 
    
    for(i = 0; i < PlayerNum; i++){
        [players[i] clearCardsOnHand]; 
    }
    
    //distribute cards to players 
    for(i = 0; i < Num; i++){
        v[i] = i; 
    }
    num = Num; 
    
    for(i = 0; i < DotNum; i++){
        for(j = 0; j < PlayerNum; j++){
            nowPos = arc4random() % num;
            Card* card = [[Card alloc] init];
            [card setValue:(v[nowPos] % DotNum) + 1 _suit:v[nowPos] / DotNum];
            [players[j] addCard:card];
            v[nowPos] = v[--num]; 
        }
    }

    
    //把方块三给user
//    int ii, jj; 
//    for(i = 0; i < DotNum; i++){
//        for(j = 0; j < PlayerNum; j++){
//            nowPos = arc4random() % num;
//            Card* card = [[Card alloc] init];
//            [card setValue:(v[nowPos] % DotNum) + 1 _suit:v[nowPos] / DotNum];
//            if(card.dotNum == 3 && card.suit == 0){
//                ii = i; 
//                jj = j; 
//            }
//            [players[j] addCard:card];
//            v[nowPos] = v[--num]; 
//        }
//    }
//
//    if(ii != 0){
//        Card* tmp0 = [[Card alloc] init];
//        [tmp0 setValue:3 _suit:0];
//        [players[0].cardsOnHand addObject:tmp0];
//        Card* tmp1 = [[Card alloc] init];
//        [tmp1 setValue:[players[0].cardsOnHand objectAtIndex:0]];
//        [players[0].cardsOnHand removeObjectAtIndex:0];
//        
//        
//        [players[ii].cardsOnHand removeObjectAtIndex:jj];
//        [players[ii].cardsOnHand addObject:tmp1];
//        
//        
//    }
//    
    
    
    for(i = 0; i < PlayerNum; i++){
        if(players[i].playerType == COMPUTER){
            NSMutableArray* cg = [[NSMutableArray alloc] init];
            for(j = 0; j < DotNum; j++){
                CardGroup* hc = [[CardGroup alloc] init];
                [hc setValue:[players[i].cardsOnHand objectAtIndex:j] _flag:1];
                [cg addObject:hc];
            }
            [players[i] init_card_hash:cg];//这里有时报错
            //[players[i] print_hash];
            //NSLog(@"shit");
        }
    }

    
}

-(NSMutableArray*) selectCards:(BOOL) isFirst
{
    if(last >=0 ){
        NSLog(@"type:%d", players[last].lastCardType);
    }
    else{
        NSLog(@"now:%d last is negative", now); 
    }
    NSMutableArray* cards = [[NSMutableArray alloc] init]; 
    NSLog(@"isFirst %d now is %d", isFirst, now); 
    if(isFirst){
        //NSLog(@"now is %d", now); 
//        NSLog(@"isFirst is selected "); 
        cards = [players[now] outCard:needDiamondThree humanCardList:(players[ME].cardsOnHand)];
//        NSLog(@"card num of %dth player:%d", now, [players[now].cardsOnHand count]); 
//        
//        int i; 
//        NSLog(@"card num: %d" , [cards count]); 
//        for(i = 0; i < [cards count]; i++){
//            Card* tmp = [cards objectAtIndex:i];
//            NSLog(@"(%d, %d)", tmp.dotNum, tmp.suit);
//        }
    }else{
        cards = [players[now] fllowCard:players[last].lastCard];
    }
    return cards; 
}

-(int) getNow
{
    return now; 
}

-(Player**) players
{
    return players; 
}

@end
