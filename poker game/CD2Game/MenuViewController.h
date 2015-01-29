//
//  MenuViewController.h
//  CD2Game
//
//  Created by Xiaobo on 11-7-7.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"CddData.h"


@interface MenuViewController : UIViewController {
    
    
    //sqlite数据库数据
    CddData *sqldata;

    
    
    
    
}
- (IBAction)goOnButtonCliced:(id)sender;
- (IBAction)setButtonClicked:(id)sender;
- (IBAction)returnButtonClicked:(id)sender;

//returnButtonClicked操作后，生成“逃跑提示”alertview，点“确定”按钮跳转到RoleSelectedView
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;

//各种数据库操作的函数
-(void) nextAction;
-(void) deleteAction;
-(void) updateAction;




@end
