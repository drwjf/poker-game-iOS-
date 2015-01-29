//
//  User.h
//  CD2Game
//
//  Created by Xiaobo on 11-6-29.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enumeration.h"

@interface User : NSObject {
    NSString* ID; 
    NSString* userName; 
    enum UserCatalog rank; 
    int totalScore; 
    
}


@property(copy) NSString* ID; 
@property(copy) NSString* userName; 
@property enum UserCatalog rank; 
@property int totalScore; 


 
@end
