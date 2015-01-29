//
//  CardType.m
//  CD2Game
//
//  Created by Xiaobo on 11-6-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CardType.h"
#import "Card.h"
#import "Enumeration.h"
@implementation CardType

//char *typeStr[9] = {"INVALID", "SINGLE", "COUPLE", "THREE", "MIXSEQ", "FLUSH", "CAPTURE", "KINGTONG", "STRAIGHTFLUSH"};

+ (int) getNum:(cardType) type
{

    
    switch (type) {
        case INVALID:
            return 0; 
        case SINGLE:
            return 1; 
        case COUPLE:
            return 2; 
        case THREE:
            return 3; 
        default:  // MIXSEQ, FLUSH, CAPTURE, KINGTONG, STRAIGHTFLUSH
            return 5; 
    }
}
+ (cardType) getCardType: (NSMutableArray*) selectedCard
{
    //[selectedCard sortUsingComparator:opera];
    int count = [selectedCard count];
    cardType type;
    if(count == 1){
        type = SINGLE; 
    }else if(count == 2){
        Card *one = [selectedCard objectAtIndex:0];
        Card *two = [selectedCard objectAtIndex:1];
        if(one.dotNum== two.dotNum){
            type = COUPLE; 
        }else{
            type = INVALID; 
        }
    }else if(count == 3){
        if([[selectedCard objectAtIndex:0] dotNum] == [[selectedCard objectAtIndex:1] dotNum]
           && [[selectedCard objectAtIndex:1] dotNum] == [[selectedCard objectAtIndex:2] dotNum]){
            type = THREE; 
        }else{
            type = INVALID; 
        }
    }else if(count == 5){
        Boolean seq, flush; 
        seq = false; 
        flush = false; 
        //selectedCard = [selectedCard sortedArrayUsingSelector:@selector(cardCmp:)];
        //[selectedCard sortedArrayUsingSelector:@selector(cardCmp:)];
        
        selectedCard = [self sortCards:selectedCard];
        
        int i; 
        int tmpArray[] = {1, 10, 11, 12, 13};
        for(i = 0; i < count; i++){
            if([[selectedCard objectAtIndex:i] dotNum] != tmpArray[i]) break; 
        }
        if(i == count){
            seq = YES; 
        }
        for(i = 0; i < count-1; i++){
            tmpArray[i] = [[selectedCard objectAtIndex:i+1] dotNum] - 
            [[selectedCard objectAtIndex:i] dotNum]; 
        }
        if(tmpArray[0] == 1 && tmpArray[1] == 1 && tmpArray[2] == 1 && tmpArray[3] == 1){
            seq = YES; 
        }
        for(i = 1; i < count; i++){
            if([[selectedCard objectAtIndex:i] suit] != [[selectedCard objectAtIndex:0] suit]){
                break; 
            }
        }
        if(i == count){
            flush = true; 
        }
        if(seq && flush){
            type = STRAIGHTFLUSH; 
        }else if(seq){
            type = MIXSEQ; 
        }else if(flush){
            type = FLUSH; 
        }else{
            int s = 0; 
            for(i = 0; i < count-1; i++){
                if(tmpArray[i] == 0){
                    s++; 
                }
            }
            if(s == 3){
                if(tmpArray[0] == 0 && tmpArray[3] == 0){
                    type = CAPTURE; 
                }else{
                    type = KINGTONG; 
                }
            }else{
                type = INVALID; 
            }
        }
        
    }else{
        type = INVALID; 
    }
    return type; 
}

+ (Card*) allMaxCardGetMaxCard:(NSMutableArray*) cards
{
    Card* ans = [[cards objectAtIndex:0] maxCard];
    int i; 
    for(i = 1; i < [cards count]; i++){
        Card* tmp = [[cards objectAtIndex:i] maxCard];
        if([ans operatorLess:tmp]){
            ans = tmp; 
        }
    }
    return ans; 
}
+ (Card*) getMaxCard:(NSMutableArray*) cards
{    
    if (cards == nil) {
        NSLog(@"cards is nil");
    }
 
    cards = [self sortCards:cards];
    //NSLog(@"cards count :%d",[cards count]);
    cardType type = [self getCardType:cards];
    Card* card = [[Card alloc] init];
    switch (type) {
        case INVALID:
        case SINGLE:
        case COUPLE:
        case THREE:
        case FLUSH:
            //return [cards objectAtIndex:[cards count] - 1];
            return [CardType allMaxCardGetMaxCard:cards];
        case CAPTURE:
            if([[cards objectAtIndex:2] dotNum] == [[cards objectAtIndex:0] dotNum]){
                return [[cards objectAtIndex:2] maxCard]; 
            }
            return [[cards objectAtIndex:4] maxCard];
        case KINGTONG:
            if([[cards objectAtIndex:3] dotNum] == [[cards objectAtIndex:0] dotNum]){
                return [[cards objectAtIndex:3] maxCard]; 
            }
            return [[cards objectAtIndex:4] maxCard];
        case MIXSEQ:
        case STRAIGHTFLUSH:
            if([[cards objectAtIndex:0] dotNum] == 1 && [[cards objectAtIndex:4] dotNum] == 13){
                return [[cards objectAtIndex:0] maxCard]; 
            }
            return [cards objectAtIndex:4];
        default:
            [card setValue:1 _suit:0];
            return card; 
    }
}
//判断selectedCard是否能大过tempCard
+ (Boolean) compareCards:(NSMutableArray*) selectedCard _tempCard:(NSMutableArray*) tempCard
{
    if (selectedCard == nil) {
        NSLog(@"selectedCard is nil");
    }

    if([selectedCard count] != [tempCard count]) return  NO; 
    cardType t1, t2; 
    Card *maxCard1, *maxCard2; 
    t1 = [self getCardType:selectedCard];
    if(t1 == INVALID) return NO; 
    t2 = [self getCardType:tempCard];
    maxCard1 = [self getMaxCard:selectedCard];
    maxCard2 = [self getMaxCard:tempCard];
    if([selectedCard count] < 5){
        if(t1 == t2 && [maxCard2 operatorLess:maxCard1]) return YES; 
    }else{
        if(t2 < t1 || (t2 == t1 && [maxCard2 operatorLess:maxCard1])) return YES; 
    }
    return  NO; 
}


+ (NSComparisonResult) cardCmp:(Card*) card1 _card2:(Card*) card2
{
    if(card1.dotNum < card2.dotNum 
    || (card1.dotNum == card2.dotNum && card1.suit < card2.suit))
        return NSOrderedAscending;
    return NSOrderedDescending;
}

+ (BOOL) cardCmpSuit:(Card*) card1 _card2:(Card*) card2
{
    if(card1.suit < card2.suit 
       || (card1.suit == card2.suit && card1.dotNum < card2.dotNum))
        return YES;
    return NO;
}
 
 
+ (NSMutableArray*) sortCards: (NSMutableArray*) _cards
{
    NSMutableArray* cards = [NSMutableArray arrayWithArray:_cards];
    
    //对cards排序 
    int i, j, k, count;
    count =[cards count];
    for(i = 0; i < count; i++){
        for(k = j = i; j < count; j++){
            if([[cards objectAtIndex:j] operatorLess:[cards objectAtIndex:k]]){
                k = j; 
            }
        }
        if(k != i){
            Card* card_k = [cards objectAtIndex:k];
            Card* card_i = [cards objectAtIndex:i];
            [cards replaceObjectAtIndex:k withObject:card_i];
            [cards replaceObjectAtIndex:i withObject:card_k];
        }
    }
    
    return cards; 
}

+ (NSMutableArray*) sortCardsSuit: (NSMutableArray*) _cards
{
    NSMutableArray* cards = [NSMutableArray arrayWithArray:_cards];
    
    //对cards排序 
    int i, j, k, count;
    count =[cards count];
    for(i = 0; i < count; i++){
        for(k = j = i; j < count; j++){
            if([CardType cardCmpSuit:[cards objectAtIndex:j] _card2:[cards objectAtIndex:k]]){
                k = j; 
            }
        }
        if(k != i){
            Card* card_k = [cards objectAtIndex:k];
            Card* card_i = [cards objectAtIndex:i];
            [cards replaceObjectAtIndex:k withObject:card_i];
            [cards replaceObjectAtIndex:i withObject:card_k];
        }
    }
    return cards; 
}


+ (NSMutableArray*) sortCardsCombo: (NSMutableArray*) _cards
{
    NSMutableArray* cards = [NSMutableArray arrayWithArray:_cards];
    int num[14]; 
    //对cards排序 
    int i, j, k, count, dotk, dotj;
    count =[cards count];
    for(i = 1; i < 14; i++){
        num[i] = 0; 
    }
    for(i = 0; i < count; i++){
        Card* tmp = [_cards objectAtIndex:i]; 
        num[tmp.dotNum]++; 
    }
    for(i = 0; i < count; i++){
        Card* tmpi = [_cards objectAtIndex:i];
        dotk = tmpi.dotNum; 
        for(k = j = i; j < count; j++){
            Card* tmpj = [_cards objectAtIndex:j];
            dotj = tmpj.dotNum; 
            if(num[dotj] > num[dotk] || (num[dotj] == num[dotk] && [[cards objectAtIndex:j] operatorLess:[cards objectAtIndex:k]])){
                k = j; 
                dotk = dotj; 
            }
        }
        if(k != i){
            Card* card_k = [cards objectAtIndex:k];
            Card* card_i = [cards objectAtIndex:i];
            [cards replaceObjectAtIndex:k withObject:card_i];
            [cards replaceObjectAtIndex:i withObject:card_k];
        }
    }
    
    return cards; 
}


@end
