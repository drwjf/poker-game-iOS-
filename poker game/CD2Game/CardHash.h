//
//  CardHash.h
//  CD2Game
//
//  Created by Xiaobo on 11-7-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardList.h"
#import "Card.h"

@interface CardHash : NSObject {
    NSMutableArray* card_list_root; 
}
@property (nonatomic, retain) NSMutableArray* card_list_root; 

-(id) init; 


@end
