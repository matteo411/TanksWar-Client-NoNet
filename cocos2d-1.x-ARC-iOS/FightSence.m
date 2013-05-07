//
//  FightSence.m
//  coco
//
//  Created by apple  on 13-5-5.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "FightSence.h"
#import "SimpleAudioEngine.h"

@implementation FightSence
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	FightSence *layer = [FightSence node];
    
    MainLayer *mainLayer = [MainLayer node];
    
	
	// add layer as a child to scene
	[scene addChild: layer];
    [scene addChild: mainLayer];
	
    //    MilitaryBuildingLayer* militaryBuildingLayer = [MilitaryBuildingLayer node];
    //    [scene addChild:militaryBuildingLayer z:4];
    
    
	// return the scene
	return scene;
}
-(id) init
{
	if( (self=[super init])){
       
        
        robotArmy=[RobotArmy getRobotArmy];
        playerArmy=[PlayerArmy getPlayerArmy];
        CCSprite *BackGround=[CCSprite spriteWithFile:@"word_bkg.png" rect:CGRectMake(0, 0, 1024, 768)];
        BackGround.anchorPoint=ccp(0, 0);
        [self addChild:BackGround z:1   tag:0 ];
        NSLog(@"fight");
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"back1.mp3" loop:NO];
        //sharedManager:Returns the shared singleton
        [[CDAudioManager sharedManager] setBackgroundMusicCompletionListener:self selector:@selector(soundFinish1)];
        [self numLabel];
        [self scheduleOnce:@selector(playerFight) delay:4];
        [self initRobotArmy];
        [self initArmyArray];
        [self initPlayerArmy];
        
        	}
	return self;
    
}

- (void)soundFinish1
{
    //pauseBackgroundMusic:Pauses the background music
	[[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
	[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"back2.mp3" loop:NO];
	[[CDAudioManager sharedManager] setBackgroundMusicCompletionListener:self selector:@selector(soundFinish2)];
}

- (void)soundFinish2
{
	[[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
	[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"back3.mp3" loop:NO];
	[[CDAudioManager sharedManager] setBackgroundMusicCompletionListener:self selector:@selector(soundFinish1)];
}

-(void)numLabel
{
    CGSize size=[[CCDirector sharedDirector] winSize];
    CCLabelTTF *labelnum1 = [CCLabelTTF labelWithString:@"1" fontName:@"Marker Felt" fontSize:64];
	labelnum1.position =  ccp( size.width /2 , size.height/2 );
	[self addChild: labelnum1 z:4];
	
	CCLabelTTF *labelnum2 = [CCLabelTTF labelWithString:@"2" fontName:@"Marker Felt" fontSize:64];
	labelnum2.position =  ccp( size.width /2 , size.height/2 );
	labelnum2.visible = NO;
	[self addChild: labelnum2 z:4];
	
	CCLabelTTF *labelnum3 = [CCLabelTTF labelWithString:@"3" fontName:@"Marker Felt" fontSize:64];
	labelnum3.position =  ccp( size.width /2 , size.height/2 );
	labelnum3.visible = NO;
	[self addChild: labelnum3 z:4];
	
	CCLabelTTF *labelnum4 = [CCLabelTTF labelWithString:@"GO" fontName:@"Marker Felt" fontSize:64];
	labelnum4.position =  ccp( size.width /2 , size.height/2 );
	labelnum4.visible = NO;
	[self addChild: labelnum4 z:4];
	//runAction：Executes an action, and returns the action that is executed. The node becomes the action’s target.
    //CCShow:Show the node
	id ac  = [labelnum1 runAction:[CCShow action]];
    //Scales a CCNode object a zoom factor by modifying its scale attribute.
	id ac0 = [labelnum1 runAction:[CCScaleBy actionWithDuration:0.5 scale:2]];
	id ac1 = [labelnum1 runAction:[CCHide action]];
	id ac2 = [labelnum2 runAction:[CCShow action]];
	id ac3 = [labelnum2 runAction:[CCScaleBy actionWithDuration:0.5 scale:2]];
	id ac4 = [labelnum2 runAction:[CCHide action]];
	id ac5 = [labelnum3 runAction:[CCShow action]];
	id ac6 = [labelnum3 runAction:[CCScaleBy actionWithDuration:0.5 scale:2]];
	id ac7 = [labelnum3 runAction:[CCHide action]];
	id ac8 = [labelnum4 runAction:[CCShow action]];
	id ac9 = [labelnum4 runAction:[CCScaleBy actionWithDuration:0.5 scale:2]];
	id ac10= [labelnum4 runAction:[CCHide action]];
    //CCSequence:Runs actions sequentially, one after another
    //Delays the action a certain amount of seconds
	[labelnum1 runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.5], ac , ac0, ac1, nil]];
	[labelnum2 runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.0], ac2, ac3, ac4, nil]];
	[labelnum3 runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.5], ac5, ac6, ac7, nil]];
	[labelnum4 runAction:[CCSequence actions:[CCDelayTime actionWithDuration:2.0], ac8, ac9, ac10, nil]];
    NSLog(@"hello numlabel");
}
-(void)initArmyArray
{
     playerArmyArray[0]=[playerArmy numOfArmyType1];
     playerArmyArray[1]=[playerArmy numOfArmyType2];
     playerArmyArray[2]=[playerArmy numOfArmyType3];
     playerArmyArray[3]=[playerArmy numOfArmyType4];
    
      robotArmyArray[0]=[robotArmy numOfArmyType1];
      robotArmyArray[1]=[robotArmy numOfArmyType2];
      robotArmyArray[2]=[robotArmy numOfArmyType3];
      robotArmyArray[3]=[robotArmy numOfArmyType4];
    
}
-(void)initPlayerArmy
{
    playerArmyImage[0]=[CCSprite spriteWithFile:@"a_d1.png"];
    playerArmyImage[0].position=ccp(400,480);
    [self addChild:playerArmyImage[0] z:3   ];
    
    playerArmyImage[1]=[CCSprite spriteWithFile:@"a_d2.png"];
    playerArmyImage[1].position=ccp(400, 420);
    [self addChild:playerArmyImage[1] z:3   ];
 
    playerArmyImage[2]=[CCSprite spriteWithFile:@"a_d3.png"];
    playerArmyImage[2].position=ccp(400, 360);
    [self addChild:playerArmyImage[2] z:3 ];
    
    playerArmyImage[3]=[CCSprite spriteWithFile:@"a_d4.png"];
    playerArmyImage[3].position=ccp(400, 300);
    [self addChild:playerArmyImage[3] z:3];
   
    
    playerArmyLabel[0]=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"步兵部队数量：%d",[playerArmy numOfArmyType1]] dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    playerArmyLabel[0].position=ccp(260, 480);
    [self addChild:playerArmyLabel[0] z:3];
    
    playerArmyLabel[1]=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"摩托部队数量：%d",[playerArmy numOfArmyType2]] dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    playerArmyLabel[1].position=ccp(260, 420);
    [self addChild:playerArmyLabel[1] z:3 ];
    
    playerArmyLabel[2]=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"坦克部队数量：%d",[playerArmy numOfArmyType3]] dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    playerArmyLabel[2].position=ccp(260, 360);
    [self addChild:playerArmyLabel[2] z:3];
    
    playerArmyLabel[3]=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"导弹部队数量：%d",[playerArmy numOfArmyType4]] dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    playerArmyLabel[3].position=ccp(260, 300);
    [self  addChild:playerArmyLabel[3] z:3];

}
-(void)initRobotArmy
{
    
    robotArmyImage[0]=[CCSprite spriteWithFile:@"a_d1.png"];
    robotArmyImage[0].position=ccp(550,480);
    [self addChild:robotArmyImage[0] z:3];
    robotArmyImage[1]=[CCSprite spriteWithFile:@"a_d2.png"];
    robotArmyImage[1].position=ccp(550, 420);
    [self addChild:robotArmyImage[1] z:3];
    robotArmyImage[2]=[CCSprite spriteWithFile:@"a_d3.png"];
    robotArmyImage[2].position=ccp(550, 360);
    [self addChild:robotArmyImage[2] z:3];
    robotArmyImage[3]=[CCSprite spriteWithFile:@"a_d4.png"];
    robotArmyImage[3].position=ccp(550, 300);
    [self addChild:robotArmyImage[3] z:3];
    
    
    robotArmyLabel[0]=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d:步兵部队数量",[robotArmy numOfArmyType1]] dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    robotArmyLabel[0].position=ccp(740, 480);
    [self addChild:robotArmyLabel[0] z:3];
    
    robotArmyLabel[1]=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d:摩托部队数量",[robotArmy numOfArmyType2]] dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    robotArmyLabel[1].position=ccp(740, 420);
    [self addChild:robotArmyLabel[1] z:3  ];
    
    robotArmyLabel[2]=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d:坦克部队数量",[robotArmy numOfArmyType3]] dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    robotArmyLabel[2].position=ccp(740, 360);
    [self   addChild:robotArmyLabel[2] z:3];
    
    robotArmyLabel[3]=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d:导弹部队数量",[robotArmy numOfArmyType4]] dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    robotArmyLabel[3].position=ccp(740, 300);
    [self addChild:robotArmyLabel[3] z:3];
   

}
-(void)playerFight
{
    CCAction *action1=[CCSequence actions:[CCMoveBy actionWithDuration:0.1 position:ccp(15, 0)],[CCMoveBy actionWithDuration:0.2 position:ccp(-15, 0)] ,nil];
    CCAction *action2=[CCSequence actions:[CCMoveBy actionWithDuration:0.1 position:ccp(-10, 0)],[CCMoveBy actionWithDuration:0.2 position:ccp(10, 0)] ,nil];
    if ([self victoryCheck])
    {
    
        int playerArmy=[self getPlayerArmy];
        int robotArmy=[self getRobotArmy];
        [playerArmyImage[playerArmy] runAction:[CCRepeat actionWithAction:action2 times:1]];
        [robotArmyImage[robotArmy] runAction:[CCRepeat actionWithAction:action1 times:4]];
        int attack=playerArmyArray[playerArmy]*(playerArmy+1)*(playerArmy+1);
        int defence=(robotArmy+1)*(robotArmy+1);
        robotArmyArray[robotArmy]-=(int)attack/defence+1;
        if (robotArmyArray[robotArmy]<=0) {
            robotArmyImage[robotArmy].color=ccRED;
            robotArmyArray[robotArmy]=0;
        }
        
    }
    [self upDateLabel];
    [self scheduleOnce:@selector(robotFight) delay:3];
}
-(void)robotFight
{
    CCAction *action1=[CCSequence actions:[CCMoveBy actionWithDuration:0.1 position:ccp(20, 0)],[CCMoveBy actionWithDuration:0.1 position:ccp(-20, 0)] ,nil];
    CCAction *action2=[CCSequence actions:[CCMoveBy actionWithDuration:0.1 position:ccp(-10, 0)],[CCMoveBy actionWithDuration:0.1 position:ccp(10, 0)] ,nil];
    if ([self victoryCheck])
    {
        
        int playerArmy=[self getPlayerArmy];
        int robotArmy=[self getRobotArmy];
        [playerArmyImage[playerArmy] runAction:[CCRepeat actionWithAction:action2 times:1]];
        [robotArmyImage[robotArmy] runAction:[CCRepeat actionWithAction:action1 times:4]];
    
        int defence=(playerArmy+1)*(playerArmy+1);
        int attack=robotArmyArray[robotArmy]*(robotArmy+1)*(robotArmy+1);
        playerArmyArray[playerArmy]-=(int)attack/defence+1;
        if (playerArmyArray[playerArmy]<=0) {
            playerArmyImage[playerArmy].color=ccRED;
            playerArmyArray[playerArmy]=0;
        }
        
    }
    [self upDateLabel];
    [self scheduleOnce:@selector(playerFight) delay:3];
}
-(void)upDateLabel
{
    [playerArmyLabel[0] setString:[NSString stringWithFormat:@"步兵部队数量:%d",playerArmyArray[0]]];
    [playerArmyLabel[1] setString:[NSString stringWithFormat:@"摩托部队数量:%d",playerArmyArray[1]]];
    [playerArmyLabel[2] setString:[NSString stringWithFormat:@"坦克部队数量:%d",playerArmyArray[2]]];
    [playerArmyLabel[3] setString:[NSString stringWithFormat:@"导弹部队数量:%d",playerArmyArray[3]]];
    [robotArmyLabel[0] setString:[NSString stringWithFormat:@"%d:步兵部队数量",robotArmyArray[0]]];
    [robotArmyLabel[1] setString:[NSString stringWithFormat:@"%d:摩托部队数量",robotArmyArray[1]]];
    [robotArmyLabel[2] setString:[NSString stringWithFormat:@"%d:坦克部队数量",robotArmyArray[2]]];
    [robotArmyLabel[3] setString:[NSString stringWithFormat:@"%d:导弹部队数量",robotArmyArray[3]]];
    
}
-(BOOL)victoryCheck
{
    for (int i=0; i<4; i++) {
        if (playerArmyArray[i]==0) {
            
            playerArmyImage[i].color=ccRED;

        }
        if (robotArmyArray[i]==0) {
           robotArmyImage[i].color=ccRED;
        }
    }
    if (playerArmyArray[0]==0&&playerArmyArray[1]==0&&playerArmyArray[2]==0&&playerArmyArray[3]==0)
    {
        return NO;
        [self playerWin];
    }
    else if (robotArmyArray[0]  ==0&&robotArmyArray[1]==0&&robotArmyArray[2]==0&&robotArmyArray[3]==0) {
        return NO;
        [self playerLose];
    }
    else
        return YES;
}
-(void)playerWin
{

}
-(void)playerLose
{
    
}
-(int)getARandomNumber
{
    int RandomNumber=CCRANDOM_0_1()*4-1;
    return RandomNumber;
}
-(int)getPlayerArmy
{
    int Army=CCRANDOM_0_1()*4;
    while (playerArmyArray[Army]==0) {
        Army=CCRANDOM_0_1()*4;
    }
    return Army;
}
-(int)getRobotArmy
{
    int Army=CCRANDOM_0_1()*4;
    while (robotArmyArray[Army]==0) {
        Army=CCRANDOM_0_1()*4;
    }
    return Army;
}
@end
