//
//  CardGroup.h
//  CD2Game
//
//  Created by Xiaobo on 11-7-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface CardGroup : NSObject {
    Card* card; 
    int flag; 
}
@property (nonatomic, retain) Card* card; 
@property int flag; 
-(id) init: (Card*) _card _flag: (int) _flag; 
-(void) setValue: (Card*) _card _flag: (int) _flag; 
@end
