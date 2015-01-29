//
//  CDDGameViewController.m
//  CD2Game
//
//  Created by Xiaobo on 11-6-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CDDGameViewController.h"
#import "MenuViewController.h"
#import "CDDGame.h"
#import "Player.h"
#import "CardType.h"
#import "RoleSelectedViewController.h"
#import "ScoreViewController.h"
#import "CardType.h"
#import "PlayerInfo.h"
#import "PlayerInfoDB.h"
#import "SetViewController.h"

@interface CDDGameViewController() 
    
- (void)showPassLabel:(CGRect)frame;
- (NSMutableArray *)score;
- (BOOL)ownDiamendThree:(NSMutableArray *)cards;
- (void)adjustCards;
- (void)showUserCards;
- (void)showInfoOfUser;

@end

BOOL ownDiamendThree;

@implementation CDDGameViewController

@synthesize adjustHig;
@synthesize adjustWid;


@synthesize passButton = _passButton;
@synthesize showButton = _showButton;
@synthesize resetChooseButton = _resetChooseButton;

@synthesize cardOnHand;
@synthesize chooseCard;
@synthesize chooseCards;
@synthesize cardLeftOnHand;
@synthesize cardShowed;

@synthesize cardsComputer1Owner;
@synthesize cardsComputer1Retain;
@synthesize buttonsComputer1Owner;
@synthesize buttonsComputer1Retain;

@synthesize cardsComputer2Owner;
@synthesize cardsComputer2Retain;
@synthesize buttonsComputer2Owner;
@synthesize buttonsComputer2Retain;

@synthesize cardsComputer3Owner;
@synthesize cardsComputer3Retain;
@synthesize buttonsComputer3Owner;
@synthesize buttonsComputer3Retain;

@synthesize player1Head = _player1Head;
@synthesize player2Head = _player2Head;
@synthesize player3Head = _player3Head;

@synthesize playerName = _playerName;
@synthesize name1 = _name1;
@synthesize name2 = _name2;
@synthesize name3 = _name3;

@synthesize buttonsComputer1Show;
@synthesize buttonsComputer2Show;
@synthesize buttonsComputer3Show;

@synthesize player1CardsImageViews;
@synthesize player2CardsImageViews;
@synthesize player3CardsImageViews;


@synthesize time = _time;
@synthesize timer = _timer;
@synthesize timer2 = _timer2;
@synthesize timer3 = _timer3;

@synthesize scoreLabel = _scoreLabel;
@synthesize cardsCountLabel1 = _cardsCountLabel1;
@synthesize cardsCountLabel2 = _cardsCountLabel2;
@synthesize cardsCountLabel3 = _cardsCountLabel3;
@synthesize cardsCountLabelUser = _cardsCountLabelUser;
@synthesize turnNumLabel = _turnNumLabel;

@synthesize ownerViewController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{ sqldata = [[CddData alloc]init];
    //打开数据库
    
    [sqldata openDB];
    [sqldata createTable];
    [sqldata createScorePlace];
    
    
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    adjustHig = 0.3;
    adjustWid = 480/1024;
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)buttonClickedClose:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]
                           initWithTitle:@"提示" 
                           message:@"真的要退出游戏吗?"
                           delegate:self                         
                           cancelButtonTitle:@"确定" 
                           otherButtonTitles: nil];
    [alert show];
    [alert release];
}


- (IBAction)rightButtonClicked:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];    
}

- (IBAction)headButtonClicked:(id)sender
{
}

- (IBAction)menuButtonClicked
{
    MenuViewController *menuViewController = [[MenuViewController alloc]init];
    menuViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:menuViewController animated:YES];
//    [self.view addSubview:menuViewController.view];
//    [self.view insertSubview:menuViewController.view atIndex:100];
//    [menuViewController release];
    
//    NSMutableArray *scoreArray = [self score];
//    ScoreViewController *scoreViewController = [[ScoreViewController alloc]initWithScoreArray:scoreArray playerInfo:_playerInfo];
//    scoreViewController.modalPresentationStyle = UIModalPresentationFormSheet;
//    [self presentModalViewController:scoreViewController animated:YES];
    
//    [self.view addSubview:scoreViewController.view];
//    [self.view insertSubview:scoreViewController.view atIndex:100];
//    [self release];
}

- (IBAction)passButton:(id)sender
{
    for (int i=0; i<[cardShowed count]; i++) {
        UIButton *_button = [cardShowed objectAtIndex:i];
        _button.hidden = YES;
    }
    if(([players[COMPUTER1].lastCard count] == 0)&&([players[COMPUTER2].lastCard count] == 0)&&([players[COMPUTER3].lastCard count] == 0)){
        [self adjustCards];
    }
    else{
    _cddGame.now = (_cddGame.now + 1) % PlayerNum;
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self selector:@selector(playCD2Game) userInfo:nil repeats:NO];
    [self setButtonUnused];
    //修改pass没有下去的bug!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    for (int i = 0; i<[chooseCard count]; i++) {
        [cardLeftOnHand addObject:[chooseCard objectAtIndex:i]];
    }
    [self sortAndshowCardsOnUserHand];                
    chooseCard = nil;
    chooseCards = nil;
    }
}

- (void)dealloc
{
    [_scoreLabel release];
    [_cardsCountLabel3 release];
    [_cardsCountLabel2 release];
    [_cardsCountLabel1 release];
    [_cardsCountLabelUser release];
    [_turnNumLabel release];
    
    
    [_passLabel release];
    [_playerName release];
    [_name1 release];
    [_name2 release];
    [_name3 release];
    
    player1CardsImageViews = nil;
    player2CardsImageViews = nil;
    player3CardsImageViews = nil;
    
    buttonsComputer1Show = nil;
    buttonsComputer2Show = nil;
    buttonsComputer3Show = nil;
    
    buttonsComputer1Retain = nil;
    buttonsComputer1Owner = nil;
    cardsComputer1Retain =nil;
    cardsComputer1Owner = nil;
    
    buttonsComputer2Retain = nil;
    buttonsComputer2Owner = nil;
    cardsComputer2Retain =nil;
    cardsComputer2Owner = nil;
    
    buttonsComputer3Retain = nil;
    buttonsComputer3Owner = nil;
    cardsComputer3Retain =nil;
    cardsComputer3Owner = nil;
    
   
    
    
    cardOnHand = nil;
    chooseCard = nil;
    cardsBenko = nil;
    cardLeftOnHand = nil;
    chooseCards = nil;
    cardShowed = nil;
    
    [_playerInfo release];
    [_cddGame release];
    [_time release];
    [_timer release];
    [_timer2 release];
    [_timer3 release];
    
    [_passButton release];
    [_showButton release];
    [_resetChooseButton release];//重选按钮！！！！！！！！！！！！！！！！！！！！！！！！！！！

   
    [_player1Head release];
    [_player2Head release];
    [_player3Head release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.player1Head = nil;
    self.player2Head = nil;
    self.player3Head = nil;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewWillDisappear:(BOOL)animated
{
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (_cddGame == nil) {
        _cddGame = [[CDDGame alloc]init];

    }
    if (cardOnHand == nil) {
        cardOnHand = [[NSMutableArray alloc]init];
    }
    if (buttonsComputer1Owner == nil) {
        buttonsComputer1Owner = [[NSMutableArray alloc]init];
    }
    if (buttonsComputer2Owner == nil) {
        buttonsComputer2Owner = [[NSMutableArray alloc]init];
    }
    if (buttonsComputer3Owner == nil) {
        buttonsComputer3Owner = [[NSMutableArray alloc]init];
    }
    if (cardLeftOnHand == nil) {
        cardLeftOnHand = [[NSMutableArray alloc]init];
    }
    if (player1CardsImageViews == nil) {
        player1CardsImageViews = [[NSMutableArray alloc]init];
    }
    if (player2CardsImageViews == nil) {
        player2CardsImageViews = [[NSMutableArray alloc]init];
    }
    if (player3CardsImageViews == nil) {
        player3CardsImageViews = [[NSMutableArray alloc]init];
    }
    if (cardsBenkoDot == nil) {
        cardsBenkoDot = [[NSMutableArray alloc]init];
    }
    
    for (int i = 0; i<DotNum; i++) {
        isChoosed[i] = NO;
    }
    
    _passButton.hidden = YES;
    _showButton.hidden = YES;
    _resetChooseButton.hidden = YES;
    _time.hidden = YES;
    leftNumPlayer1 = 13;
    leftNumPlayer2 = 13;
    leftNumPlayer3 = 13;
    

    int win = [RoleSelectedViewController getwinTurnNum];
    int lose = [RoleSelectedViewController getloseTurnNum];
    
    NSString *turnNum = [NSString stringWithFormat:@"胜%d/负%d", win, lose];
    _turnNumLabel.text = turnNum;
    l=0;

    
    [self showHeadAndName];
    
    NSMutableArray *roles = [[NSMutableArray alloc] init];//应该是一个角色的数组
    int i; 
    for(i = 0; i < 4; i++){
        Player* player = [[Player alloc] init];
        if (i == 0) {
            player.playerType = USER;
        }
        else{
            player.playerType = COMPUTER;
        }
        [roles addObject:player];
    }
    
    [_cddGame start:roles];
    
    [_cddGame playCDDGame];
    //生成四个玩家
    players = [_cddGame players];
    

    
    
    //sort,and "retain" is important 
//    cardsBenko = [[CardType sortCardsSuit:players[ME].cardsOnHand] retain];
    ownDiamendThree = [self ownDiamendThree:players[ME].cardsOnHand];
    NSLog(@"YOU WHETHER HAVE DIAMEND THREE:%d",ownDiamendThree);
    
    cardsBenko = [[CardType sortCards:players[ME].cardsOnHand]retain];
    
    for (int i = 0; i<13; i++) {
        Card* card = [cardsBenko objectAtIndex:i];
        int cardPoint = [self caculateCardPoint:card];
        
//        UIButton *_button = [[UIButton alloc]initWithFrame:CGRectMake((358 + 40*i)*0.35, 611*0.35, 85*0.45, 108*0.45)]
        
    UIButton *_button = [[UIButton alloc]initWithFrame:CGRectMake((230 + 75*i)*0.35, 600*0.35, 85*0.8, 108*0.8)];
        
        NSString *cardPointStr = [[NSString alloc]initWithFormat:@"%d.png",cardPoint];
        [_button setBackgroundImage:[UIImage imageNamed:cardPointStr] forState:UIControlStateNormal];
        [cardOnHand addObject:_button];
        
        [self.view addSubview:_button];
        _button.tag = i;
        [_button addTarget:self action:@selector(buttonCardChoose:) forControlEvents:UIControlEventTouchUpInside];
        
        //[_button release];
        [cardPointStr release];
        [card release];
    }
 
    
//    for (int i = 0; i<13; i++) {
//        Card* card = [cardsBenkoDot objectAtIndex:i];
//        int cardPoint = [self caculateCardPoint:card];
//        
//        UIButton *_button = [[UIButton alloc]initWithFrame:CGRectMake(328 + 35*i, 561, 85, 108)];
//        
//        NSString *cardPointStr = [[NSString alloc]initWithFormat:@"%d.png",cardPoint];
//        [_button setBackgroundImage:[UIImage imageNamed:cardPointStr] forState:UIControlStateNormal];
//        [cardOnHand addObject:_button];
//        
//        [self.view addSubview:_button];
//        _button.tag = i;
//        [_button addTarget:self action:@selector(buttonCardChoose:) forControlEvents:UIControlEventTouchUpInside];
//        
//        //[_button release];
//        [cardPointStr release];
//        [card release];
//    }

    
    for (int i = 0; i<DotNum; i++) {
        [cardLeftOnHand addObject:[cardOnHand objectAtIndex:i]];
    }
 
    
    cardsComputer1Owner = players[COMPUTER1].cardsOnHand;
    for (int i = 0; i<13; i++) {
        Card* card = [cardsComputer1Owner objectAtIndex:i];
        int cardPoint = [self caculateCardPoint:card];
        //NSLog(@"%d\n", cardPoint);
        UIButton *_button = [[UIButton alloc]initWithFrame:CGRectMake(1170*0.35, (260+35*i)*0.35, 108*0.45, 85*0.45)];
        _button.tag = cardPoint;
        [buttonsComputer1Owner addObject:_button];
        
        NSString *cardPointStr = [[NSString alloc]initWithFormat:@"%d.png",cardPoint];
        [_button setBackgroundImage:[UIImage imageNamed:cardPointStr] forState:UIControlStateNormal];
        
        UIImageView *_PlayercardImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cardback.png"]];
        [player1CardsImageViews addObject:_PlayercardImageView];
        _PlayercardImageView.frame = CGRectMake(435, 140, 30, 37);
        if(i==0)
        [self.view addSubview:_PlayercardImageView];
        
        [_PlayercardImageView release];
        [_button release];
        [cardPointStr release];
        [card release];
        
    }
   
    

    
    cardsComputer2Owner = players[COMPUTER2].cardsOnHand;
    for (int i = 0; i<13; i++) {
        Card* card = [cardsComputer2Owner objectAtIndex:i];
        int cardPoint = [self caculateCardPoint:card];
        //NSLog(@"%d\n", cardPoint);
        UIButton *_button = [[UIButton alloc]initWithFrame:CGRectMake((358 + 25*i)*0.35, 54*0.35, 85*0.45, 108*0.45)];
        _button.tag = cardPoint;
        [buttonsComputer2Owner addObject:_button];
        
        NSString *cardPointStr = [[NSString alloc]initWithFormat:@"%d.png",cardPoint];
       [_button setBackgroundImage:[UIImage imageNamed:cardPointStr] forState:UIControlStateNormal];
        UIImageView *_PlayercardImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cardback.png"]];
        _PlayercardImageView.frame = CGRectMake(230, 20, 30, 37);
        [player2CardsImageViews addObject:_PlayercardImageView];
        if(i==0)
        [self.view addSubview:_PlayercardImageView];
        [_PlayercardImageView release];
        [_button release];
        [cardPointStr release];
        [card release];

    }
    
    
   cardsComputer3Owner = players[COMPUTER3].cardsOnHand;
    for (int i = 0; i<13; i++) {
        Card* card = [cardsComputer3Owner objectAtIndex:i];
        int cardPoint = [self caculateCardPoint:card];
        //NSLog(@"%d\n", cardPoint);
        UIButton *_button = [[UIButton alloc]initWithFrame:CGRectMake(24*0.35, (260+30*i)*0.35, 108*0.45, 85*0.45)];
        _button.tag = cardPoint;
        [buttonsComputer3Owner addObject:_button];
        
        NSString *cardPointStr = [[NSString alloc]initWithFormat:@"%d.png",cardPoint];
        [_button setBackgroundImage:[UIImage imageNamed:cardPointStr] forState:UIControlStateNormal];
        UIImageView *_PlayercardImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cardback.png"]];
        _PlayercardImageView.frame = CGRectMake(10, 140, 30, 37);
        [player3CardsImageViews addObject:_PlayercardImageView];
        if(i==0)
        [self.view addSubview:_PlayercardImageView];
        [_PlayercardImageView release];
        
        [_button release];
        [cardPointStr release];
        [card release];
        
    }
    [self showInfoOfUser]; 
    [self playCD2Game];
 }

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];

}

- (void)showInfoOfUser
{
   
    NSString *name=[sqldata selectLastName];
    // NSString *name = [SetViewController returnName];
    NSMutableArray *playerInfos = [[PlayerInfoDB instance]getPlayerInfos];
    if (name == nil) 
    {
        if ([playerInfos count]>0) 
        {
            _playerInfo = [playerInfos objectAtIndex:0];        
            self.playerName.text = _playerInfo.account;
            NSString *scoreStr = [NSString stringWithFormat:@"%d",_playerInfo.allScore];
            self.scoreLabel.text = scoreStr;
            
//            [sqldata updateSelectUserScore:[sqldata selectLastName] score:_playerInfo.allScore];
//            [sqldata insertScoreName:[sqldata selectLastName] score:_playerInfo.allScore];
            
            
            
            
            
        }
    }
    else
    {
        self.playerName.text = name;
        for (PlayerInfo *playerInfo in playerInfos) 
        {
            if ([name isEqualToString:playerInfo.account]) 
            {
                _playerInfo = playerInfo;
                NSString *scoreStr = [NSString stringWithFormat:@"%d",playerInfo.allScore];
                self.scoreLabel.text = scoreStr;
                
                
                
//                [sqldata updateSelectUserScore:[sqldata selectLastName] score:_playerInfo.allScore];
//                [sqldata insertScoreName:[sqldata selectLastName] score:_playerInfo.allScore];
//                
                
                
                
                
            }
        }
    }
    [sqldata closeDB];
}


- (IBAction)buttonCardChoose:(id)sender
{
    if(chooseCard == nil) {
        chooseCard = [[NSMutableArray alloc]init];
    }
    if (chooseCards == nil) {
        chooseCards = [[NSMutableArray alloc]init];
    }
        
    UIButton *_button = (UIButton *)sender;
    CGRect buttonRectUp = CGRectMake(_button.frame.origin.x, _button.frame.origin.y-13, _button.frame.size.width, _button.frame.size.height);
    CGRect buttonRectDown = CGRectMake(_button.frame.origin.x, _button.frame.origin.y+13, _button.frame.size.width, _button.frame.size.height);
    if ((int)(_button.frame.origin.y)==(int)(600*0.35)) {
        _button.frame = buttonRectUp;
                isChoosed[_button.tag] = YES;
        //NSLog(@"yes tag: %d\n", _button.tag); 
    }
    else if((int)(_button.frame.origin.y)==(int)(600*0.35-13)){
        _button.frame = buttonRectDown;
               isChoosed[_button.tag] = NO;        
    }
}

- (IBAction)buttonShowCards
{ 
    int i; 
    for(i = 0; i < DotNum; i++){
        if(isChoosed[i]==YES){
          [chooseCard addObject:[cardOnHand objectAtIndex:i]];
          [chooseCards addObject:[cardsBenko objectAtIndex:i]];
          [cardLeftOnHand removeObject:[cardOnHand objectAtIndex:i]];
            
            isChoosed[i]=NO;
        }        
    }
     
    
    if (cardShowed == nil) {
        cardShowed = [[NSMutableArray alloc]init];
    }
    for (i=0; i<[cardShowed count]; i++) {
            UIButton *_button = [cardShowed objectAtIndex:i];
            _button.hidden = YES;
    }
    
    for (i = 0; i <[cardShowed count]; i++) {
        [cardShowed removeObjectAtIndex:i];
    }
    
    if (ownDiamendThree) 
    {
        if (![self ownDiamendThree:chooseCards]) 
        {
            [self adjustCards];
        }
        else
        {
            [self showUserCards];
        }
    }
    else
    {
        [self showUserCards];
    }     
     
}


-(IBAction)resetChooseCards{
    for (int i = 0; i<[chooseCard count]; i++) {
        [cardLeftOnHand addObject:[chooseCard objectAtIndex:i]];
    }
    [self sortAndshowCardsOnUserHand];                
    chooseCard = nil;
    chooseCards = nil;
}



- (void)adjustCards
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告！" message:@"不符合规则" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    [alert release];
    for (int i = 0; i<[chooseCard count]; i++) {
        [cardLeftOnHand addObject:[chooseCard objectAtIndex:i]];
    }
    [self sortAndshowCardsOnUserHand];                
    chooseCard = nil;
    chooseCards = nil;

}

- (void)showUserCards
{
    Boolean isValid = [self compareCardsOnUserAndLastPlayer];
    cardType cardChooseType = [CardType getCardType:chooseCards]; 
    NSLog(@"UserCardType:%d,isValid:%d",cardChooseType,isValid);

    int i;
    if (cardChooseType==INVALID||isValid==NO) 
    {
        [self adjustCards];       
    }
    else{                
        for (int i = 0; i<[chooseCard count]; i++) {
            UIButton *_button = [chooseCard objectAtIndex:i];
            [cardShowed addObject:_button];
        }
        [_cddGame takeTurnUser:chooseCards];
        players[ME].lastCard = chooseCards;
        if (chooseCards == nil) {
            NSLog(@"chooseCards is nil");
        }
        for (i =0; i<[cardShowed count]; i++) 
        {
            UIButton *_button = [cardShowed objectAtIndex:i];
            CGRect pointShowCard = CGRectMake((480+35*i)*0.35, 325*0.35, 100*0.45, 125*0.45);
            _button.frame = pointShowCard;
        } 
        
        
        for(i = 0; i < DotNum; i++){
            if(isChoosed[i]==YES){
                [cardLeftOnHand removeObject:[cardOnHand objectAtIndex:i]];
                isChoosed[i]=NO;
            }        
        }
        
        NSString *cardsCount = [NSString stringWithFormat:@"%d",[cardLeftOnHand count]];       
        self.cardsCountLabelUser.text = cardsCount;
        [self sortAndshowCardsOnUserHand];                
        
        chooseCard = nil;
        chooseCards = nil;
        [NSTimer scheduledTimerWithTimeInterval:1
                                         target:self selector:@selector(playCD2Game) userInfo:nil repeats:NO];
        _passButton.hidden = YES;
        _showButton.hidden = YES;
        _resetChooseButton.hidden = YES;
    }
    ownDiamendThree = NO;

}

- (Boolean)compareCardsOnUserAndLastPlayer
{
    if ([players[COMPUTER3].lastCard count]!=0) {
        return [CardType compareCards:chooseCards _tempCard:players[COMPUTER3].lastCard];     
    }
    else if([players[COMPUTER2].lastCard count]!=0)
    {
        return [CardType compareCards:chooseCards _tempCard:players[COMPUTER2].lastCard];
    }
    else if([players[COMPUTER1].lastCard count]!=0)
    {
        return [CardType compareCards:chooseCards _tempCard:players[COMPUTER1].lastCard];
    }
    else
    {
        return YES;
    }
}

- (void)sortAndshowCardsOnUserHand
{
    //冒泡排序
    for (int i = 0; i<[cardLeftOnHand count]; i++) {
        for (int j = 0; j<[cardLeftOnHand count]; j++) {
            UIButton *button_i = [cardLeftOnHand objectAtIndex:i];
            UIButton *button_j = [cardLeftOnHand objectAtIndex:j];
            if (button_i.tag<button_j.tag) {
                [cardLeftOnHand replaceObjectAtIndex:i withObject:button_j];
                [cardLeftOnHand replaceObjectAtIndex:j withObject:button_i];
            }
        }
        
    }
    
    for (int i = 0; i<[cardLeftOnHand count]; i++) {
        UIButton *_button = [cardLeftOnHand objectAtIndex:i];
        CGRect pointRetainCard = CGRectMake((230 + 75*i)*0.35, 600*0.35, _button.frame.size.width, _button.frame.size.height);
        _button.frame = pointRetainCard;
    }

}


//- (IBAction)sortButtonClicked:(id)sender
//{
//  [cardOnHand removeAllObjects];
//    
//   cardsBenko = [CardType sortCards:players[ME].cardsOnHand];
//    
//    for (int i = 0; i<13; i++) {
//        Card* card = [cardsBenko objectAtIndex:i];
//        int cardPoint = [self caculateCardPoint:card];
//        
//        UIButton *_button = [[UIButton alloc]initWithFrame:CGRectMake(328 + 35*i, 561, 85, 108)];
//        
//        NSString *cardPointStr = [[NSString alloc]initWithFormat:@"%d.png",cardPoint];
//        [_button setBackgroundImage:[UIImage imageNamed:cardPointStr] forState:UIControlStateNormal];
//        [cardOnHand addObject:_button];
//        
//        [self.view addSubview:_button];
//        _button.tag = i;
//        [_button addTarget:self action:@selector(buttonCardChoose:) forControlEvents:UIControlEventTouchUpInside];
//        
//        //[_button release];
//        [cardPointStr release];
//        [card release];
//    }
//    for (int i = 0; i<DotNum; i++) {
//        [cardLeftOnHand addObject:[cardOnHand objectAtIndex:i]];
//    }
//
//
////    NSLog(@"");
//}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if (interfaceOrientation == UIInterfaceOrientationPortrait||interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        return NO;
    }
	return YES;
}


//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0) {
//        exit(0);
//    }
//}

- (void)showTime
{
    _curTime = 15;
    [self.time setText:@"Time:15"];
    self.timer3 = [NSTimer scheduledTimerWithTimeInterval: 1
                                                 target: self
                                               selector: @selector(showTime2)
                                               userInfo: nil
                                                repeats: YES];
       
}

- (void)showTime2
{
    
    if (_curTime>0) {
        _curTime--;
    }
    else{
        [self.timer3 invalidate];    
    }
        
    NSString *curTime =[[NSString alloc]initWithFormat:@"Time:%d",_curTime];
    [self.time setText:curTime];

}


- (void)showCard1:(NSMutableArray *)buttonsCard
{
    for (int i =0; i <[buttonsCard count]; i++) {
        
        CGRect frame = CGRectMake((850+35*i)*0.35, 220*0.35, 100*0.45, 125*0.45);
        UIButton *_button = [buttonsCard objectAtIndex:i];
        NSLog(@"the point of buttonsComputer1 in showCards1:%d",_button.tag);
        _button.frame = frame;
        [self.view addSubview:_button];
    }

}

- (void)showCard2:(NSMutableArray *)buttonsCard
{
    for (int i =0; i <[buttonsCard count]; i++) {
        
        CGRect frame = CGRectMake((480+35*i)*0.35, 160*0.35, 100*0.45, 125*0.45);
        UIButton *_button = [buttonsCard objectAtIndex:i];
        NSLog(@"the point of buttonsComputer2 in showCards2:%d",_button.tag);
        _button.frame = frame;
        [self.view addSubview:_button];
    }

}

- (void)showCard3:(NSMutableArray *)buttonsCard
{
    for (int i =0; i <[buttonsCard count]; i++) {
        CGRect frame = CGRectMake((200+35*i)*0.35, 220*0.35, 100*0.45, 125*0.45);
        UIButton *_button = [buttonsCard objectAtIndex:i];
        NSLog(@"the point of buttonsComputer3 in showCards3:%d",_button.tag);
        _button.frame = frame;
        [self.view addSubview:_button];
    }
    

}

- (void)playCD2Game{
//    NSLog(@"n0:%d n1:%d n2:%d n3:%d last:%d  now:%d", [benko.lastCard count], [playerComputer1.lastCard count],[playerComputer2.lastCard count], [playerComputer3.lastCard count], _cddGame.last, _cddGame.now); 
    // NSLog(@"last:%d   now:%d",_cddGame.last,_cddGame.now);
//    if(_cddGame.last == _cddGame.now){
//        _cddGame.last = -1; 
//        [self playCD2Game]; 
//        return; 
//    }
    int now = [_cddGame getNow];
    
    if([cardLeftOnHand count]==0||[buttonsComputer1Owner count]==0||[buttonsComputer2Owner count]==0||[buttonsComputer3Owner count]==0)
    {
        if(l==0){
        if ([cardLeftOnHand count]==0) {
            [RoleSelectedViewController upwinTurnNum];
            l++;
        }else{
            [RoleSelectedViewController uploseTurnNum]; 
            l++;
        }
//        int win = [RoleSelectedViewController getwinTurnNum];//不知道为什么会执行两次，所以除以二
//        int lose = [RoleSelectedViewController getloseTurnNum];
//        
//        NSString *turnNum = [NSString stringWithFormat:@"胜%d/负%d", win, lose];
//        _turnNumLabel.text = turnNum;
        }
        
        
        NSMutableArray *scoreArray = [self score];
         ScoreViewController *scoreViewController = [[ScoreViewController alloc]initWithScoreArray:scoreArray playerInfo:_playerInfo];
        scoreViewController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentModalViewController:scoreViewController animated:YES];
        //[self.view insertSubview:scoreViewController.view atIndex:100];
//        return;
    }

    
    if (now==ME) {
        
        _passButton.hidden = NO;
        _showButton.hidden = NO;
        _resetChooseButton.hidden = NO;
        
        
//        self.timer = [NSTimer scheduledTimerWithTimeInterval: 0
//                                                      target: self
//                                                    selector: @selector(showTime)
//                                                    userInfo: nil
//                                                     repeats: NO];
//        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval: 15
//                                                          target: self
//                                                        selector: @selector(playCD2Game)
//                                                        userInfo: nil
//                                                         repeats: NO];
//        NSTimer *timer2 = [NSTimer scheduledTimerWithTimeInterval: 15
//                                                          target: self
//                                                        selector: @selector(setButtonUnused)
//                                                        userInfo: nil
//                                                         repeats: NO];
//        
        

            }
    
    else if(now==COMPUTER1){
    [self player1Operate];
                
    }
    else if(now==COMPUTER2)
   {
       [self player2Operate];
    }                       
    else if(now==COMPUTER3)
   {
       [self player3Operate];          
    }           

}

- (int)caculateCardPoint:(Card *)card
{
     int cardPoint = card.dotNum + card.suit*13;
    return cardPoint;
    
}

- (void)setButtonUnused{
    _passButton.hidden = YES;
    _showButton.hidden = YES;
    _resetChooseButton.hidden = YES;
}

- (void)player1Operate{
    
    [_cddGame takeTurn];
    
    NSMutableArray *cardsComputerShow= players[COMPUTER1].lastCard;
    
    for (int i = 0; i < [cardsComputerShow count]; i++) {
        Card *card = [cardsComputerShow objectAtIndex:i];
        int cardPoint = [self caculateCardPoint:card];
        NSLog(@"player1 lastcard is :%d",cardPoint);
    }
    NSLog(@"lastCard count:%d",[cardsComputerShow count]);
    for (int i = 0; i<[cardsComputerShow count]; i++) {
        Card *card = [cardsComputerShow objectAtIndex:i];
        NSLog(@"(%d,%d)",card.dotNum,card.suit);
    }
    if (buttonsComputer1Show == nil) {
        buttonsComputer1Show = [[NSMutableArray alloc]init];
    }
    
    for (int i=0; i<[buttonsComputer1Show count]; i++) {
        UIButton *_button = [buttonsComputer1Show objectAtIndex:i];
        _button.hidden = YES;
    }
    
//    for (int i = 0; i <[buttonsComputer1Show count]; i++) {
//        [buttonsComputer1Show removeObjectAtIndex:i];
//    }
    [buttonsComputer1Show removeAllObjects];
    //添加要出的牌（button）
    if ([cardsComputerShow count]!=0) {
        for (int i = 0; i<[cardsComputerShow count]; i++) {
            Card *card = [cardsComputerShow objectAtIndex:i];
            int point = [self caculateCardPoint:card];
            for (int i = 0; i<[buttonsComputer1Owner count]; i++) {
                UIButton *_button = [buttonsComputer1Owner objectAtIndex:i];
                if (point == _button.tag) {
                    [buttonsComputer1Show addObject:_button];
                    [buttonsComputer1Owner removeObject:_button];
                }
            }
        }
        NSLog(@"buttonsComputer1Show count is :%d",[buttonsComputer1Show count]);
        for (int i =0; i<[buttonsComputer1Show count]; i++) {
            UIButton *_button = [buttonsComputer1Show objectAtIndex:i];
            NSLog(@"the point of buttonsComputer1:%d",_button.tag);
        }

        if ([buttonsComputer1Show count]==0) {
            NSLog(@"buttonsComputer1Show is nil");
        }

        
        [self showCard1:buttonsComputer1Show];
        
//        for (int i = 0; i<[buttonsComputer1Show count]; i++) {
//            [buttonsComputer1Owner removeObject:[buttonsComputer1Show objectAtIndex:i]];
//        }
        
//        for (int i = 0; i<[buttonsComputer1Show count]; i++) {
//            UIButton *button1 = [buttonsComputer1Show objectAtIndex:i];
//            for (int i = 0; i <[buttonsComputer1Owner count]; i++) {
//                UIButton *button2 = [buttonsComputer1Owner objectAtIndex:i];
//                if (button1.tag == button2.tag) {
//                    [buttonsComputer1Owner removeObject:button2];
//                }
//            }
//        }

          
        //hide images from the last one
        int tempNum = [buttonsComputer1Owner count];
//        leftNumPlayer1 = leftNumPlayer1 -[buttonsComputer1Show count];
        NSLog(@"left number:%d", [buttonsComputer1Show count]);
//        NSLog(@"tempNum:%d",tempNum);
        for (int i = tempNum; i<13; i++) {
            UIImageView *_imageView = [player1CardsImageViews objectAtIndex:i];
            _imageView.hidden = YES;
        }
        
        NSString *cardsCount = [NSString stringWithFormat:@"%d",tempNum];       
        self.cardsCountLabel1.text = cardsCount;               
    
    }
    else
    {
        //pass
        CGRect frame = CGRectMake(380,90,50,30);
        [self showPassLabel:frame];
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval: 1
                                                      target: self
                                                    selector: @selector(playCD2Game)
                                                    userInfo: nil
                                                     repeats: NO];
    
    [cardsComputerShow release];
}

- (void)player2Operate{
    
    [_cddGame takeTurn];
    
    NSMutableArray *cardsComputerShow= players[2].lastCard;
    
    for (int i = 0; i < [cardsComputerShow count]; i++) {
        Card *card = [cardsComputerShow objectAtIndex:i];
        int cardPoint = [self caculateCardPoint:card];
        NSLog(@"player2 lastcard is :%d",cardPoint);
    }

    NSLog(@"lastCard count:%d",[cardsComputerShow count]);
    for (int i = 0; i<[cardsComputerShow count]; i++) {
        Card *card = [cardsComputerShow objectAtIndex:i];
        NSLog(@"(%d,%d)",card.dotNum,card.suit);
    }
    
    if (buttonsComputer2Show == nil) {
        buttonsComputer2Show = [[NSMutableArray alloc]init];
    }
    
    for (int i=0; i<[buttonsComputer2Show count]; i++) {
        UIButton *_button = [buttonsComputer2Show objectAtIndex:i];
        _button.hidden = YES;
    }
    
    for (int i = 0; i <[buttonsComputer2Show count]; i++) {
        [buttonsComputer2Show removeObjectAtIndex:i];
    }
    [buttonsComputer2Show removeAllObjects];

    //添加要出的牌（button）
    if ([cardsComputerShow count]!=0) {
        for (int i = 0; i<[cardsComputerShow count]; i++) {
            Card *card = [cardsComputerShow objectAtIndex:i];
            int point = [self caculateCardPoint:card];
            for (int i = 0; i<[buttonsComputer2Owner count]; i++) {
                UIButton *_button = [buttonsComputer2Owner objectAtIndex:i];
                if (point == _button.tag) {
                    [buttonsComputer2Show addObject:_button];
                    [buttonsComputer2Owner removeObject:_button];
                }
            }
        }
        NSLog(@"buttonsComputer2Show count is :%d",[buttonsComputer2Show count]);
        for (int i =0; i<[buttonsComputer2Show count]; i++) {
            UIButton *_button = [buttonsComputer2Show objectAtIndex:i];
            NSLog(@"the point of buttonsComputer2:%d",_button.tag);
        }


        if ([buttonsComputer2Show count]==0) {
            NSLog(@"buttonsComputer2Show is nil");
        }

        [self showCard2:buttonsComputer2Show];
        
//        for (int i = 0; i<[buttonsComputer2Show count]; i++) {
//            UIButton *button1 = [buttonsComputer2Show objectAtIndex:i];
//            for (int i = 0; i <[buttonsComputer2Owner count]; i++) {
//                UIButton *button2 = [buttonsComputer2Owner objectAtIndex:i];
//                if (button1.tag == button2.tag) {
//                    [buttonsComputer2Owner removeObject:button2];
//                }
//            }
//        }
//        
//        //对剩下的牌重排列
//        for (int i = 0; i<[buttonsComputer2Owner count]; i++) {
//            UIButton *_button = [buttonsComputer2Owner objectAtIndex:i];
//            CGRect pointShowCard = CGRectMake(328 + 35*i, 20, _button.frame.size.width, _button.frame.size.height);
//            _button.frame = pointShowCard;
//
//        }
        //hide images from the last one
        int tempNum = [buttonsComputer2Owner count];
//        leftNumPlayer2 = leftNumPlayer2 -[buttonsComputer2Show count];
        for (int i = tempNum; i<13; i++) {
            UIImageView *_imageView = [player2CardsImageViews objectAtIndex:i];
            _imageView.hidden = YES;
        }
 
        NSString *cardsCount = [NSString stringWithFormat:@"%d",tempNum];       
        self.cardsCountLabel2.text = cardsCount;                  
        
    }
    else
    {
        //pass
        CGRect frame = CGRectMake(180,50,50,30);
        [self showPassLabel:frame];
    }
    
    _timer2 = [NSTimer scheduledTimerWithTimeInterval: 1
                                                      target: self
                                                    selector: @selector(playCD2Game)
                                                    userInfo: nil
                                                     repeats: NO];
    
    [cardsComputerShow release];
 
}

- (void)player3Operate{
    
    [_cddGame takeTurn];
    
    NSMutableArray *cardsComputerShow= players[COMPUTER3].lastCard;
    
    for (int i = 0; i < [cardsComputerShow count]; i++) {
        Card *card = [cardsComputerShow objectAtIndex:i];
        int cardPoint = [self caculateCardPoint:card];
        NSLog(@"player3 lastcard is :%d",cardPoint);
    }

    
    NSLog(@"lastCard count:%d",[cardsComputerShow count]);
    for (int i = 0; i<[cardsComputerShow count]; i++) {
        Card *card = [cardsComputerShow objectAtIndex:i];
        NSLog(@"(%d,%d)",card.dotNum,card.suit);
    }
    
    if (buttonsComputer3Show == nil) {
        buttonsComputer3Show = [[NSMutableArray alloc]init];
    }
    
    for (int i=0; i<[buttonsComputer3Show count]; i++) {
        UIButton *_button = [buttonsComputer3Show objectAtIndex:i];
        _button.hidden = YES;
    }
    
    for (int i = 0; i <[buttonsComputer3Show count]; i++) {
        [buttonsComputer3Show removeObjectAtIndex:i];
    }
    [buttonsComputer3Show removeAllObjects];

    //添加要出的牌（button）
    if ([cardsComputerShow count]!=0) {
        for (int i = 0; i<[cardsComputerShow count]; i++) {
            Card *card = [cardsComputerShow objectAtIndex:i];
            int point = [self caculateCardPoint:card];
            for (int i = 0; i<[buttonsComputer3Owner count]; i++) {
                UIButton *_button = [buttonsComputer3Owner objectAtIndex:i];
                if (point == _button.tag) {
                    [buttonsComputer3Show addObject:_button];
                    [buttonsComputer3Owner removeObject:_button];
                }
            }
        }
        NSLog(@"buttonsComputer3Show count is :%d",[buttonsComputer3Show count]);
        
        for (int i =0; i<[buttonsComputer3Show count]; i++) {
            UIButton *_button = [buttonsComputer3Show objectAtIndex:i];
            NSLog(@"the point of buttonsComputer3:%d",_button.tag);
        }

        if ([buttonsComputer3Show count]==0) {
            NSLog(@"buttonsComputer3Show is nil");
        }
        [self showCard3:buttonsComputer3Show];
        
//        for (int i = 0; i<[buttonsComputer3Show count]; i++) {
//            [buttonsComputer3Owner removeObject:[buttonsComputer3Show objectAtIndex:i]];
//        }
//        
//        for (int i = 0; i<[buttonsComputer3Show count]; i++) {
//            UIButton *button1 = [buttonsComputer3Show objectAtIndex:i];
//            for (int i = 0; i <[buttonsComputer3Owner count]; i++) {
//                UIButton *button2 = [buttonsComputer3Owner objectAtIndex:i];
//                if (button1.tag == button2.tag) {
//                    [buttonsComputer3Owner removeObject:button2];
//                }
//            }
//        }

//           
//        //对剩下的牌重排列
//        for (int i = 0; i<[buttonsComputer3Owner count]; i++) {
//            UIButton *_button = [buttonsComputer3Owner objectAtIndex:i];
//            CGRect pointShowCard = CGRectMake(20, 213+35*i, _button.frame.size.width, _button.frame.size.height);
//            _button.  = pointShowCard;
//
//        }
        //hide images from the last one
        int tempNum = [buttonsComputer3Owner count];
//        leftNumPlayer3 = leftNumPlayer3 -[buttonsComputer3Show count];
        for (int i = tempNum; i<13; i++) {
            UIImageView *_imageView = [player3CardsImageViews objectAtIndex:i];
            _imageView.hidden = YES;
        }

        NSString *cardsCount = [NSString stringWithFormat:@"%d",tempNum];       
        self.cardsCountLabel3.text = cardsCount;               

    }
    else
    {
        //pass
        CGRect frame = CGRectMake(70,90,50,30);
        [self showPassLabel:frame];
    }
    
    _timer3 = [NSTimer scheduledTimerWithTimeInterval: 1
                                                      target: self
                                                    selector: @selector(playCD2Game)
                                                    userInfo: nil
                                                     repeats: NO];

    [cardsComputerShow release];

}

- (void)showPassLabel:(CGRect)frame
{
    _passLabel = [[UILabel alloc]init];
    _passLabel.text =@"pass";
    _passLabel.textColor = [UIColor redColor];
    [_passLabel setBackgroundColor:[UIColor clearColor]];
    [_passLabel setFont:[UIFont italicSystemFontOfSize:14]];
    _passLabel.frame = frame;
    [self.view addSubview:_passLabel];
    [NSTimer scheduledTimerWithTimeInterval:1 
                                     target:self
                                   selector:@selector(dismissPassLabel)
                                   userInfo:nil 
                                    repeats:NO];

}

- (void)dismissPassLabel
{
    [_passLabel removeFromSuperview];
}

- (NSMutableArray *)score
{
    NSMutableArray *scoreArray = [[NSMutableArray alloc]init];
    
    int numLeft = [cardLeftOnHand count] + [buttonsComputer1Owner count] + [buttonsComputer2Owner count] + [buttonsComputer3Owner count] ;
    int winnerScore = numLeft * 10;

    if ([cardLeftOnHand count] == 0) 
    {
        NSString *scoreUser = [NSString stringWithFormat:@"%@：%d",self.playerName.text,winnerScore];
        [scoreArray addObject:scoreUser];
        
        _playerInfo.allScore = _playerInfo.allScore + winnerScore;
        _playerInfo.turns = _playerInfo.turns + 1;
        [[PlayerInfoDB instance]addPlayerInfo:_playerInfo.account allScore:_playerInfo.allScore turns:_playerInfo.turns];
    }
    else
    {
        int lostScore = -10 * [cardLeftOnHand count];
        NSString *score = [NSString stringWithFormat:@"%@：%d",self.playerName.text,lostScore];
        [scoreArray addObject:score];
        
        _playerInfo.allScore = _playerInfo.allScore + lostScore;
        _playerInfo.turns = _playerInfo.turns + 1;
        
        [[PlayerInfoDB instance]addPlayerInfo:_playerInfo.account allScore:_playerInfo.allScore turns:_playerInfo.turns];
    }
    
    if ([buttonsComputer1Owner count] == 0) 
    {
        NSString *score = [NSString stringWithFormat:@"%@：%d",_name1.text,winnerScore];
        [scoreArray addObject:score];
    }
    else
    {
        int lostScore = -10 * [buttonsComputer1Owner count];
        NSString *score = [NSString stringWithFormat:@"%@：%d",_name1.text,lostScore];
        [scoreArray addObject:score];

    }
    
    if ([buttonsComputer2Owner count] == 0) 
    {
        NSString *score = [NSString stringWithFormat:@"%@：%d",_name2.text,winnerScore];
        [scoreArray addObject:score];
    }
    else
    {
        int lostScore = -10 * [buttonsComputer2Owner count];
        NSString *score = [NSString stringWithFormat:@"%@：%d",_name2.text,lostScore];
        [scoreArray addObject:score];
        
    }

    if ([buttonsComputer3Owner count] == 0) 
    {
        NSString *score = [NSString stringWithFormat:@"%@：%d",_name3.text,winnerScore];
        [scoreArray addObject:score];
    }
    else
    {
        int lostScore = -10 * [buttonsComputer3Owner count];
        NSString *score = [NSString stringWithFormat:@"%@：%d",_name3.text,lostScore];
        [scoreArray addObject:score];
        
    }
    return [scoreArray autorelease];
}

 - (void)showHeadAndName
{
    NSMutableArray *_rolesHeads = [RoleSelectedViewController returnRoles];

    NSString *_headNunString1 = [_rolesHeads objectAtIndex:0];
    if ([_headNunString1 isEqualToString:@"1"]){
        _player1Head.image =[UIImage imageNamed:@"头像其他缤果.png"];
        _name1.text = @"缤果";
        
        
    }
    else if([_headNunString1 isEqualToString:@"2"])
    {
        _player1Head.image = [UIImage imageNamed:@"头像其他纷果.png"];
        _name1.text = @"纷果";
        
    }
    else if([_headNunString1 isEqualToString:@"3"])
    {
        _player1Head.image = [UIImage imageNamed:@"头像其他纷可.png"];
        _name1.text = @"纷可";
    }
    else if([_headNunString1 isEqualToString:@"4"])
    {
        _player1Head.image = [UIImage imageNamed:@"头像其他伞志.png"];
        _name1.text = @"伞志";
        
    }
    else if([_headNunString1 isEqualToString:@"5"])
    {
        _player1Head.image = [UIImage imageNamed:@"头像其他朴薯.png"];
        _name1.text = @"朴薯";
        
    }
    [_headNunString1 release];
    
    NSString *_headNunString2 = [_rolesHeads objectAtIndex:1];
    if ([_headNunString2 isEqualToString:@"1"]){
        _player2Head.image =[UIImage imageNamed:@"头像其他缤果.png"];
        _name2.text = @"缤果";
    }
    else if([_headNunString2 isEqualToString:@"2"])
    {
        _player2Head.image = [UIImage imageNamed:@"头像其他纷果.png"];
        _name2.text = @"纷果";
        
    }
    else if([_headNunString2 isEqualToString:@"3"])
    {
        _player2Head.image = [UIImage imageNamed:@"头像其他纷可.png"];
        _name2.text = @"纷可";
        
    }
    else if([_headNunString2 isEqualToString:@"4"])
    {
        _player2Head.image = [UIImage imageNamed:@"头像其他伞志.png"];
        _name2.text = @"伞志";
        
    }
    else if([_headNunString2 isEqualToString:@"5"])
    {
        _player2Head.image = [UIImage imageNamed:@"头像其他朴薯.png"];
        _name2.text = @"朴薯";
        
        
    }
    [_headNunString2 release];
    
    
    NSString *_headNunString3 = [_rolesHeads objectAtIndex:2];
    if ([_headNunString3 isEqualToString:@"1"]){
        _player3Head.image =[UIImage imageNamed:@"头像其他缤果.png"];
        _name3.text = @"缤果";
    }
    else if([_headNunString3 isEqualToString:@"2"])
    {
        _player3Head.image = [UIImage imageNamed:@"头像其他纷果.png"];
        _name3.text = @"纷果";
        
    }
    else if([_headNunString3 isEqualToString:@"3"])
    {
        _player3Head.image = [UIImage imageNamed:@"头像其他纷可.png"];
        _name3.text = @"纷可";
        
        
    }
    else if([_headNunString3 isEqualToString:@"4"])
    {
        _player3Head.image = [UIImage imageNamed:@"头像其他伞志.png"];
        _name3.text = @"伞志";
        
        
    }
    else if([_headNunString3 isEqualToString:@"5"])
    {
        _player3Head.image = [UIImage imageNamed:@"头像其他朴薯.png"];
        _name3.text = @"朴薯";
        
        
    }
    [_headNunString3 release];

}
//- (void)showPointsLayout

- (void)dismissSelf
{
    [self dismissModalViewControllerAnimated:NO];
}

- (BOOL)ownDiamendThree:(NSMutableArray *)cards
{
    for (int i = 0; i < [cards count]; i++) 
    {
        Card *card = [cards objectAtIndex:i];
        if (card.dotNum == 3&&card.suit == 0) 
        {
            return YES;
        }        
    }
    return NO;
}

@end
