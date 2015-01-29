//
//  CD2GameAppDelegate.h
//  CD2Game
//
//  Created by Xiaobo on 11-6-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CD2GameViewController;

@interface CD2GameAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet CD2GameViewController *viewController;

@end
