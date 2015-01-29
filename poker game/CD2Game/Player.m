//
//  Player.m
//  CD2Game
//
//  Created by Xiaobo on 11-6-29.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
/*
 下一步的事：
 四带一 那里有问题 
*/ 

#import "Player.h"
#import "CardList.h"
#import "CardType.h"
#import "CardGroup.h"

@implementation Player


@synthesize  score;
@synthesize userID; 
@synthesize playerType;
@synthesize cardsOnHand; 
@synthesize lastCard; 
@synthesize lastCardType; 
// @synthesize cardhash; 

- (NSMutableArray**) cardhash
{
    return cardhash; 
}
-(id) init
{
    cardsOnHand = [[NSMutableArray alloc] init];
    lastCard = [[NSMutableArray alloc]init];
    int i; 
    for(i = 0; i < 9; i++){
        cardhash[i] = [[NSMutableArray alloc] init];
    }
    return self; 
}
- (void) initCardsOnHand: (NSMutableArray*) _cardsOnHand
{
    
}
- (void) initPlayer: (NSString*) _userID
{}
- (BOOL) useTrick
{
    return NO; 
}
- (NSMutableArray*)selectCards: (BOOL) needDiamondThree nowCards: (NSMutableArray*) nowCards lastCards:(NSMutableArray*)lastCards isFisrt:(Boolean) isFirst
{
    if (nowCards == nil) {
        NSLog(@"now2Cards is nil");
    }

    NSMutableArray* ans = nowCards; 
    if(isFirst){
        if([CardType getCardType:ans] != INVALID){
            if(needDiamondThree){
                int i; 
                Card* diaThree = [[Card alloc] init];
                [diaThree setValue:3 _suit:0];
                for(i = 0; i < [ans count]; i++){
                    Card* tmp = [ans objectAtIndex:i];
                    if([tmp isEqual:diaThree]) break; 
                }
                if(i >= [ans count]){
                    ans = nil; 
                }
            }
        }else{
            ans = nil; 
        }
    }else{
        if([CardType compareCards:ans _tempCard:lastCards] == NO){
            ans = nil; 
        }
    }
    return ans; 
}
- (void) showCards
{}
- (BOOL) timeOout
{
    return NO; 
}
- (BOOL) leave
{
    return NO; 
}

- (void) clearCardsOnHand
{
    [self.cardsOnHand removeAllObjects];
}

- (void) addCard:(Card*) card
{
    [cardsOnHand addObject:card]; 
    
}
- (void) dealloc
{
    [cardsOnHand release];
    [lastCard release];
    [super dealloc];
    
}

-(Boolean) hasCard:(Card*) card
{
    int i;
    for(i = 0; i < [cardsOnHand count]; i++){
        Card* tmp = [cardsOnHand objectAtIndex:i];
        if(tmp.dotNum == card.dotNum && tmp.dotNum == card.dotNum){
            return YES; 
        }
        [tmp release];
    }
    return NO; 
}


//AI




-(void) add_hand_card: (Card*) _card cl_node:(NSMutableArray*) cl_node
{
    Card* card = [[Card alloc] init];
    [card setValue:_card];
    int count = [cl_node count];
    CardList* cl = [cl_node objectAtIndex: count-1];
    [cl.hand_card addObject: card];
    
    [card release];
    [cl release];
}



-(void) add_cl:(NSMutableArray*)cl_root card:(Card*) _card
{
    
    CardList* cl = [[CardList alloc] init];
    Card* card = [[Card alloc] init];
    [card setValue: _card];
    [cl.hand_card addObject: card]; 
    [cl_root addObject: cl];
    
    [cl release];
    [card release];
}



-(void) add_into_hash:(cardType) ct _card:(NSMutableArray*) _card
{
    CardList* cl = [[CardList alloc] init];
    int i; 
    for(i = 0; i < [_card count]; i++){
        Card* card = [[Card alloc] init];
        [card setValue:[_card objectAtIndex:i]];
        [cl.hand_card addObject:card];
        [card release];
    }
    cl.max_card = [CardType getMaxCard:cl.hand_card];
    [cardhash[ct] addObject:cl]; 
    
    [cl release];
}

-(Boolean) comp_card: (Card*) owncard othercard:(Card*)othercard;
{
    if(owncard.dotNum > othercard.dotNum){
        return  YES; 
    }
    else if((owncard.suit > othercard.suit) && (owncard.dotNum == othercard.dotNum)){
        return YES; 
    }else return NO; 
}

-(Boolean) comp_vector: (NSMutableArray*) oldcard newcard:(NSMutableArray*) newcard
{
    if([newcard count] != [oldcard count]){
        return NO; 
    }
    for(int i = 0; i < [oldcard count]; i++){
        Card* co = [oldcard objectAtIndex:i];
        Card* cn = [newcard objectAtIndex:i];
        if(!(co.dotNum == cn.dotNum && co.suit == cn.suit)){
            return NO; 
        }
    }
    return YES; 
}

-(void) copyCards:(NSMutableArray*) des src: (NSMutableArray*) src
{
    int i; 
    for(i = 0; i < [src count]; i++){
        Card* tc = [[Card alloc] init];
        [tc setValue:[src objectAtIndex:i]];
        [des addObject:tc];
        
        [tc release];
    }
}

-(NSMutableArray*) del_card:(NSMutableArray*) cl_root delcard:(NSMutableArray*) delcard
{
    NSMutableArray* ans = [[NSMutableArray alloc] init];
    int i;
    for(i = 0; i < [cl_root count]; i++){
        CardList* cl = [cl_root objectAtIndex:i];
        if([self comp_vector:cl.hand_card newcard:delcard]){
            [cl_root removeObjectAtIndex:i]; 
            break; 
        }
    }
    [self copyCards:ans src:delcard];
    return ans; 
}

-(NSMutableArray*) getCard_larger:(cardType) ct other_maxcard:(Card*)other_maxcard
{
    NSMutableArray* cur_cl = nil; 
    cur_cl = cardhash[ct]; 
    NSMutableArray* selectCard = nil;
    int i, k = -1;
    for(i = 0; i < [cur_cl count]; i++){
        CardList* cl = [cur_cl objectAtIndex:i];
        if([self comp_card:cl.max_card othercard:other_maxcard]){
//            if([selectCard count] == 0){
                selectCard = cl.hand_card; 
                k = i; 
            break;
//            }else if([self comp_card:[CardType getMaxCard:selectCard] othercard:cl.max_card]){
//                selectCard = cl.hand_card; 
//                k = -1; 
//            }
        }
    }
    if(selectCard == nil) return nil; 
    NSMutableArray* ans = [[NSMutableArray alloc] init];
    for(i = 0; i < [selectCard count]; i++){
        Card* card = [[Card alloc] init];
        [card setValue:[selectCard objectAtIndex:i]];
        [ans addObject:card];
        [card release];
    }
    if(k >= 0 && k < [cur_cl count]){
        [cur_cl removeObjectAtIndex:k];
    }
    return ans; 
}

-(NSMutableArray*) card_max: (cardType) ct   //?? 
{
    NSMutableArray* _selectcard = nil; 
    NSMutableArray* cur_cl = nil; 
    CardList* cl; 
    cur_cl = cardhash[ct]; 
    cl = [cur_cl objectAtIndex:0];
    _selectcard = cl.hand_card; 
    int i; 
    for(i = 1; i < [cur_cl count]; i++){
        cl = [cur_cl objectAtIndex:i];
        if([self comp_card:cl.max_card othercard:[CardType getMaxCard:_selectcard]]){
            _selectcard = cl.hand_card; 
        }
    }
    return _selectcard; 
}

-(NSMutableArray*) getCard_max: (cardType) ct
{
    NSMutableArray* _selectcard; 
    NSMutableArray* cur_cl;
    cur_cl = cardhash[ct]; 
    CardList* cl = [cur_cl objectAtIndex:0]; 
    _selectcard = cl.hand_card; 
    int i, k;
    k = 0; 
    for(i = 1; i < [cur_cl count]; i++){
        cl = [cur_cl objectAtIndex:i];
        if([self comp_card:cl.max_card othercard:[CardType getMaxCard:_selectcard]]){
            _selectcard = cl.hand_card; 
            k = i; 
        }
    }
    NSMutableArray* ans = [[NSMutableArray alloc] init];
    for(i = 0; i < [_selectcard count]; i++){
        Card* card = [[Card alloc] init];
        [card setValue:[_selectcard objectAtIndex:i]];
        [ans addObject:card];
        [card release];
    }
    [cur_cl removeObjectAtIndex:k];
    
    return ans; 
}

-(NSMutableArray*) getCard_min: (cardType) ct
{
    NSMutableArray* _selectcard = nil; 
    NSMutableArray* cur_cl = nil;
    cur_cl = cardhash[ct]; 
    if([cur_cl count] == 0) return nil; 
    CardList* cl = [cur_cl objectAtIndex:0];        //这里也有问题 
    _selectcard = cl.hand_card; 
    int i, k;
    k = 0; 
    for(i = 1; i < [cur_cl count]; i++){
        cl = [cur_cl objectAtIndex:i];
        if([self comp_card:cl.max_card othercard:[CardType getMaxCard:_selectcard]] == NO){
            _selectcard = cl.hand_card; 
            k = i; 
        }
    }
    if(_selectcard == nil) return nil; 
    NSMutableArray* ans = [[NSMutableArray alloc] init];
    for(i = 0; i < [_selectcard count]; i++){
        Card* card = [[Card alloc] init];
        [card setValue:[_selectcard objectAtIndex:i]];
        [ans addObject:card];
        [card release];
    }
    [cur_cl removeObjectAtIndex:k]; 
    
    return ans; 
}

-(int) getType_num: (cardType) ct
{
    int count = 0; 
    NSMutableArray* temp_cl; 
    temp_cl = cardhash[ct]; 
    count = [temp_cl count];
    return count; 
}

-(NSMutableArray*) getSquare3
{
    NSMutableArray* selectcard; 
    NSMutableArray* temp; 
    for(int i = 1; i < 9; i++){
        temp = cardhash[i]; 
        for(int j = 0; j < [temp count]; j++){
            CardList* cl = [temp objectAtIndex:j];
            for(int k = 0; k < [cl.hand_card count]; k++){
                Card* nc = [cl.hand_card objectAtIndex:k];
                if(nc.dotNum == 3 && nc.suit == 0){
                    selectcard = [[NSMutableArray alloc] init];
                    for(k = 0; k < [cl.hand_card count]; k++){
                        Card* tcard = [[Card alloc] init];
                        [tcard setValue:[cl.hand_card objectAtIndex:k]];
                        [selectcard addObject:tcard]; 
                        [tcard release];
                    }
                    [temp removeObjectAtIndex:j];
                    return selectcard; 
                }
            }
            
        }
    }
    return selectcard; 
}

-(void) del_flag: (NSMutableArray*) cg temp_card:(NSMutableArray*) temp_card
{
    for(int a = 0; a < 13; a++){
        CardGroup* cga = [cg objectAtIndex:a]; 
        if(cga.flag == 1){
            for(int t = 0; t < [temp_card count]; t++){
                Card* ct = [temp_card objectAtIndex:t]; 
                Card* cgac = cga.card; 
                if(cgac.dotNum == ct.dotNum && cgac.suit == ct.suit){
                    cga.flag = 0; 
                }
            }
        }
    }
}

-(void) init_card_hash: (NSMutableArray*) cg
{
    NSMutableArray* temp = [[NSMutableArray alloc]init]; 
    NSMutableArray* temp_card = [[NSMutableArray alloc]init]; 
//    NSMutableArray* temp = nil; 
//    NSMutableArray* temp_card = nil; 
    int count = 13; 
    for(int i = 0; (i < 4) && (count >= 5); i++){
        for(int j = 0; j < 13; j++){
            CardGroup *cgj;
            cgj = [cg objectAtIndex:j];
            if(cgj.flag == 1){
                Card *cgjc = [[Card alloc]init];
                 cgjc = cgj.card; 
                if(cgjc.suit == i){
                    [temp addObject:cgjc];
                }
              }
            }
        if([temp count] >= 5){
            temp = [CardType sortCards:temp];
            for(int k = 0; (k < [temp count]) && ([temp count] - k) > 4; ){
                for(int d = k; d < 5+k; d++){
                    [temp_card addObject:[temp objectAtIndex:d]]; 
                }
                if([CardType getCardType:temp_card] == STRAIGHTFLUSH){
                    [self add_into_hash:STRAIGHTFLUSH _card:temp_card];
                    [self del_flag:cg temp_card:temp_card];
                    [temp_card removeAllObjects]; 
                    k += 5; 
                    count -= 5; 
                }else k += 1; 
                [temp_card removeAllObjects]; 
            }
        }
        [temp removeAllObjects]; 
        
    }
   //[self print_hash];
    //同花顺结束***********************************************************************************************************************
	//寻找四个一样
    for(int i = 0; (i < 13) && (count >= 4); i++){
        CardGroup* cgi = [cg objectAtIndex:i];
        if(cgi.flag == 1){
            [temp addObject:cgi.card]; 
        }
    }
    temp = [CardType sortCards:temp];
    for(int j = 0; j < [temp count] && [temp count] - j >= 4; ){
        Card* tj = [temp objectAtIndex:j]; 
        Card* tj1 = [temp objectAtIndex:j+1];
        Card* tj2 = [temp objectAtIndex:j+2];
        Card* tj3 = [temp objectAtIndex:j+3];
        if(tj.dotNum != tj1.dotNum){
            j++; 
            continue; 
        }else if(tj1.dotNum != tj2.dotNum){
            j++; 
            continue; 
        }else if(tj2.dotNum != tj3.dotNum){
            j++; 
            continue; 
        }else{
            for(int k = j; k < j+4; k++){
                [temp_card addObject:([temp objectAtIndex:k])]; 
            }
            [self del_flag:cg temp_card:temp_card];
            j += 4; 
            count -= 4; 
            [self add_into_hash:KINGTONG _card:temp_card];
            [temp_card removeAllObjects];
        }
    }
    //[self print_hash];
    [temp removeAllObjects];
    
    
    //四个同结束*******************************************************************************************************************
    //三个相同开始寻找
    for(int i = 0; (i < 13) && (count >= 3); i++){
        CardGroup* cgi = [cg objectAtIndex:i];
        if(cgi.flag == 1){
            [temp addObject:cgi.card]; 
        }
    }
    if([temp count] >= 3){
        temp = [CardType sortCards:temp];
        for(int j = 0; j < [temp count] && [temp count] - j >= 3; ){
            Card *tj, *tj1, *tj2; 
            tj = [temp objectAtIndex:j]; 
            tj1 = [temp objectAtIndex:j+1]; 
            tj2 = [temp objectAtIndex:j+2];
            if(tj.dotNum != tj1.dotNum){
                j++; 
                continue; 
            }else if(tj1.dotNum != tj2.dotNum){
                j++; 
                continue; 
            }else{
                for(int k = j; k < j + 3; k++){
                    [temp_card addObject:([temp objectAtIndex:k])]; 
                }
                [self del_flag:cg temp_card:temp_card];
                j += 3; 
                count -= 3; 
                [self add_into_hash:THREE _card:temp_card];
                [temp_card removeAllObjects];
            }
        }
        
    }
    //[self print_hash];
    [temp removeAllObjects];
//    //三个同结束*******************************************************************************************************************
    //同花开始寻找
    for(int i = 0; (i < 4) && (count >= 5); i++){
        for(int j = 0; j < 13; j++){
            CardGroup* cgj = [cg objectAtIndex:j];
            if(cgj.flag == 1){
                Card* cgjc = cgj.card; 
                if(cgjc.suit == i){
                    [temp addObject:cgjc]; 
                }
            }
        }
        if([temp count] >= 5){
            temp = [CardType sortCards:temp];
            for(int k = 0; (k < [temp count]) && ([temp count] - k) >= 5; ){
                for(int a = k; a < k+5; a++){
                    [temp_card addObject:([temp objectAtIndex:a])]; 
                }
                [self add_into_hash:FLUSH _card:temp_card];
                [self del_flag:cg temp_card:temp_card];
                [temp_card removeAllObjects];
                k += 5; 
                count -= 5; 
            }
        }
        [temp removeAllObjects];
    }
//    //同花结束********************************************************************************************************************
    //杂顺开始 
    for(int i = 0; (i < 13) && (count >= 5); i++){
        CardGroup* cgi = [cg objectAtIndex:i];
        if(cgi.flag == 1){
            [temp addObject:cgi.card];  
        }
    }
    if([temp count] > 5){
        temp = [CardType sortCards:temp];
        for(int k = 0; (k < [temp count]) && ([temp count] - k) > 4; ){
            for(int d = k; d < 5+k; d++){
                [temp_card addObject:([temp objectAtIndex:d])];
            }
            if([CardType getCardType:temp_card] == MIXSEQ){
                [self add_into_hash:MIXSEQ _card:temp_card];
                [self del_flag:cg temp_card:temp_card];
                [temp_card removeAllObjects];
                k += 5; 
                count -= 5; 
            }else{
                k += 1; 
            }
            [temp_card removeAllObjects]; 
        }
    }
    //[self print_hash];
    [temp removeAllObjects];
    
    //杂顺结束**************
    //对开始寻找
    
    for(int i = 0; (i < 13) && (count >= 2); i++){
        CardGroup* cgi = [cg objectAtIndex:i];
        if(cgi.flag == 1){
            [temp addObject:cgi.card]; 
        }
    }
    
    if([temp count] >= 2){
        temp = [CardType sortCards:temp];
        for(int j = 0; j < [temp count] && [temp count] - j >= 2; ){
            Card *tj, *tj1; 
            tj = [temp objectAtIndex:j]; 
            tj1 = [temp objectAtIndex:j+1];
            if(tj.dotNum != tj1.dotNum){
                j++; 
                continue; 
            }else{
                for(int k = j; k < j + 2; k++){
                    [temp_card addObject:([temp objectAtIndex:k])]; 
                }
                [self del_flag:cg temp_card:temp_card];
                j += 2; 
                count -= 2; 
                [self add_into_hash:COUPLE _card:temp_card];
                [temp_card removeAllObjects];
            }
        }
        [temp removeAllObjects];
    }
    //[self print_hash];
//    //对结束*******
    
    
    //单张开始
    for(int i = 0; (i < 13) && (count >= 1); i++){
        CardGroup* cgi = [cg objectAtIndex:i];
        if(cgi.flag == 1){
            [temp addObject:cgi.card]; 
        }
    }
    if([temp count] >= 1){
        temp = [CardType sortCards:temp];
        for(int k = 0; k < [temp count]; k++){
            [temp_card addObject:([temp objectAtIndex:k])];
            [self add_into_hash:SINGLE _card:temp_card];
            [self del_flag:cg temp_card:temp_card];
            count -= 1; 
            [temp_card removeAllObjects];
        }
        [temp removeAllObjects];
    }
    //[self print_hash];
    
    
    
    /*四带一*****************************************/
    NSMutableArray* cc; 
    NSMutableArray* cc_temp; 
    CardList* temp_cl;
    //temp_cl = cardhash[KINGTONG]; 
    int num = [self getType_num:KINGTONG];

    for(int i = num-1; i >= 0; i--){
        temp_cl = [cardhash[KINGTONG] objectAtIndex:i];
        cc = nil; 
        cc_temp = nil; 
        
        if([self getType_num:SINGLE] != 0){
            NSMutableArray* tMin;
            tMin = [self getCard_min:SINGLE]; 
            [temp_cl.hand_card addObject:[tMin objectAtIndex:0]];
            
        }else if([self getType_num:COUPLE] != 0){
            cc = [self getCard_min:COUPLE];
            [temp_cl.hand_card addObject:[cc objectAtIndex:1]];
            [cc removeObjectAtIndex:1];
            [self add_into_hash:SINGLE _card:cc];
            //temp_cl = temp_cl.next; 
        }else if([self getType_num:THREE] != 0){
            cc = [self getCard_min:THREE];
            [temp_cl.hand_card addObject:[cc objectAtIndex:2]];
            [cc removeObjectAtIndex:2]; 
            [self add_into_hash:COUPLE _card:cc];
        }else{
            cc = temp_cl.hand_card;
            [cc_temp addObject:([cc objectAtIndex:3])];
            [cc_temp addObject:([cc objectAtIndex:2])];
            [self add_into_hash:COUPLE _card:cc_temp];
            [cc removeObjectAtIndex:3]; 
            [cc removeObjectAtIndex:2];
            
            [self add_into_hash:COUPLE _card:cc];
            cc_temp = temp_cl.hand_card; 
            [cardhash[KINGTONG] removeObjectAtIndex:i];
            [cc_temp removeAllObjects];
        }
        [cc removeAllObjects];//这里有时会报错
        [cc_temp removeAllObjects];
    }
    /*3+2 *****/
//   [cc removeAllObjects];
//   [cc_temp removeAllObjects];
    num = [self getType_num:THREE];
    for(int i = 0; i < num; i++){
        if([self getType_num:COUPLE] != 0){
            cc = [self getCard_max:THREE];
            cc_temp = [self getCard_min:COUPLE];
            [cc addObject:[cc_temp objectAtIndex:0]]; 
            [cc addObject:[cc_temp objectAtIndex:1]]; 
            [self add_into_hash:CAPTURE _card:cc];
        }else{
            break; 
        }
    }
//    [temp release];
//    [temp_card release];
    
      [self print_hash];
}

-(void) print_hash
{
    for (int i =0; i<9; i++) {
        NSLog(@"%d\n",i);
        NSMutableArray *temp = [[CardList alloc]init];
        temp = cardhash[i];
        for(int j = 0; j < [temp count]; j++){
            CardList* cl = [temp objectAtIndex:j];
            for(int k = 0; k < [cl.hand_card count]; k++){
                Card* card = [cl.hand_card objectAtIndex:k];
                NSLog(@"(%d, %d)", card.dotNum, card.suit); 
            }
        }
        NSLog(@"\n");
    }
}

-(NSMutableArray*) fllowCard: (NSMutableArray*) tempCard
{
    Card* maxCard = [CardType getMaxCard:tempCard];
    cardType type = [CardType getCardType:tempCard];
    NSMutableArray* temp; 
    switch (type) {
        case KINGTONG:
            temp = [self getCard_larger:type other_maxcard:maxCard];
            if([temp count] > 0) return temp; 
            else return [self getCard_min:STRAIGHTFLUSH];
            break;
        case CAPTURE:
            temp = [self getCard_larger:type other_maxcard:maxCard];
            if([temp count] > 0) return temp; 
            if([self getType_num:KINGTONG]) return [self getCard_min:KINGTONG];
            else return [self getCard_min:STRAIGHTFLUSH];
            break; 
        case FLUSH:
            temp = [self getCard_larger:type other_maxcard:maxCard];
            if([temp count] > 0) return temp; 
            if([self getType_num:CAPTURE]) return [self getCard_min:CAPTURE];
            if([self getType_num:KINGTONG]) return [self getCard_min:KINGTONG];
            
            break; 
        case MIXSEQ:
            temp = [self getCard_larger:type other_maxcard:maxCard];
            if([temp count] > 0) return temp; 
            if([self getType_num:FLUSH]) return [self getCard_min:FLUSH];
            if([self getType_num:CAPTURE]) return [self getCard_min:CAPTURE];
            if([self getType_num:KINGTONG]) return [self getCard_min:KINGTONG];
            else return [self getCard_min:STRAIGHTFLUSH];
            
            break; 
        default:
            temp = [self getCard_larger:type other_maxcard:maxCard];
            return temp; 
    }
    return nil; 
}

-(NSMutableArray*) outCard:(Boolean) needDiamondThree humanCardList:(NSMutableArray*) humanCardList
{
    //humanCardList是用户玩家手中的牌
    if(needDiamondThree){ //这一步判断是否要出包含方块3的牌，暂不能运行
        return [self getSquare3];
    }
    int num = [humanCardList count]; 
    if(num == 1){
        //当人类玩家手上只剩一张牌时，出牌按从多张到少 张出,
        //即先出杂顺，若无出同花，若无出3带2，若无出4带1，若无出同花顺
        //若无出三张，若无出一对，若无出最大的单张
        if([self getType_num:MIXSEQ]) return [self getCard_min:MIXSEQ];
        if([self getType_num:FLUSH]) return [self getCard_min:FLUSH];
        if([self getType_num:CAPTURE]) return [self getCard_min:CAPTURE];
        if([self getType_num:KINGTONG]) return [self getCard_min:KINGTONG];
        if([self getType_num:STRAIGHTFLUSH]) return [self getCard_min:STRAIGHTFLUSH];
        if([self getType_num:THREE]) return [self getCard_min:THREE];
        if([self getType_num:COUPLE]) return [self getCard_min:COUPLE];
        if([self getType_num:SINGLE]) return [self getCard_max:SINGLE];
    }else{
        if([self getType_num:SINGLE]){
            NSMutableArray* temp2= [[NSMutableArray alloc] init];
            [temp2 addObject:[CardType getMaxCard:humanCardList]];
            if([CardType compareCards:[self card_max:SINGLE] _tempCard:temp2]){
                return [self getCard_min:SINGLE];
            }
//            [temp2 release];
        }
        if([self getType_num:COUPLE]){
            NSMutableArray* temp = [[NSMutableArray alloc] init];
            Card *c0, *c1;
            c0 = [[Card alloc]init];
             c1 = [[Card alloc]init];
            
            [c0 setValue:10 _suit:0]; //有问题
            [c1 setValue:10 _suit:1];
            [temp addObject:c0];
            [temp addObject:c1];
            if([CardType compareCards:[self card_max:COUPLE] _tempCard:temp]){
                return [self getCard_min:COUPLE];
            }
//            [temp release];
        }
        if([self getType_num:MIXSEQ]) return [self getCard_max:MIXSEQ];
        if([self getType_num:FLUSH]) return [self getCard_max:FLUSH];
        if([self getType_num:CAPTURE]) return [self getCard_max:CAPTURE];
        if([self getType_num:KINGTONG]) return [self getCard_max:KINGTONG];
        if([self getType_num:STRAIGHTFLUSH]) return [self getCard_max:STRAIGHTFLUSH];
        if([self getType_num:THREE]) return [self getCard_max:THREE];
        if([self getType_num:COUPLE]) return [self getCard_max:COUPLE];
        if([self getType_num:SINGLE]) return [self getCard_max:SINGLE];
        
    }
    return nil; 
}


@end





































