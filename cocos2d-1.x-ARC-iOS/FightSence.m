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
    playerArmyImage[0].position=ccp(400,550);
    [self addChild:playerArmyImage[0] z:3   ];
    
    playerArmyImage[1]=[CCSprite spriteWithFile:@"a_d2.png"];
    playerArmyImage[1].position=ccp(400, 470);
    [self addChild:playerArmyImage[1] z:3   ];
 
    playerArmyImage[2]=[CCSprite spriteWithFile:@"a_d3.png"];
    playerArmyImage[2].position=ccp(400, 390);
    [self addChild:playerArmyImage[2] z:3 ];
    
    playerArmyImage[3]=[CCSprite spriteWithFile:@"a_d4.png"];
    playerArmyImage[3].position=ccp(400, 310);
    [self addChild:playerArmyImage[3] z:3];
    CCLabelTTF *playerArmy1,*playerArmy2,*playerArmy3,*playerArmy4;
    playerArmy1=[CCLabelTTF labelWithString:@"步兵部队" dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    playerArmy1.position=ccp(360, 550);
    [self addChild:playerArmy1 z:3];
    
    playerArmy2=[CCLabelTTF labelWithString:@"摩托部队" dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    playerArmy2.position=ccp(360, 470);
    [self addChild:playerArmy2 z:3];
    
    playerArmy3=[CCLabelTTF labelWithString:@"坦克部队" dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    playerArmy3.position=ccp(360, 390);
    [self addChild:playerArmy3 z:3];
    
    playerArmy4=[CCLabelTTF labelWithString:@"导弹部队" dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    playerArmy4.position=ccp(360, 310);
    [self addChild:playerArmy4 z:3];
    
    playerArmyLabel[0]=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[playerArmy numOfArmyType1]] dimensions:CGSizeMake(30,30) alignment:UITextAlignmentCenter fontName:@"Helvetica-Bold" fontSize:15];
    playerArmyLabel[0].position=ccp(400, 510);
    [self addChild:playerArmyLabel[0] z:3];
    
    playerArmyLabel[1]=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[playerArmy numOfArmyType2]] dimensions:CGSizeMake(30,30) alignment:UITextAlignmentCenter fontName:@"Helvetica-Bold" fontSize:15];
    playerArmyLabel[1].position=ccp(400, 430);
    [self addChild:playerArmyLabel[1] z:3 ];
    
    playerArmyLabel[2]=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[playerArmy numOfArmyType3]] dimensions:CGSizeMake(30,30) alignment:UITextAlignmentCenter fontName:@"Helvetica-Bold" fontSize:15];
    playerArmyLabel[2].position=ccp(400, 350);
    [self addChild:playerArmyLabel[2] z:3];
    
    playerArmyLabel[3]=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[playerArmy numOfArmyType4]] dimensions:CGSizeMake(30,30) alignment:UITextAlignmentCenter fontName:@"Helvetica-Bold" fontSize:15];
    playerArmyLabel[3].position=ccp(400, 270);
    [self  addChild:playerArmyLabel[3] z:3];

}
-(void)initRobotArmy
{
    
    robotArmyImage[0]=[CCSprite spriteWithFile:@"a_d1.png"];
    robotArmyImage[0].position=ccp(550,550);
    [self addChild:robotArmyImage[0] z:3];
    robotArmyImage[1]=[CCSprite spriteWithFile:@"a_d2.png"];
    robotArmyImage[1].position=ccp(550, 470);
    [self addChild:robotArmyImage[1] z:3];
    robotArmyImage[2]=[CCSprite spriteWithFile:@"a_d3.png"];
    robotArmyImage[2].position=ccp(550, 390);
    [self addChild:robotArmyImage[2] z:3];
    robotArmyImage[3]=[CCSprite spriteWithFile:@"a_d4.png"];
    robotArmyImage[3].position=ccp(550, 310);
    [self addChild:robotArmyImage[3] z:3];
    
    CCLabelTTF *playerArmy1,*playerArmy2,*playerArmy3,*playerArmy4;
    
    playerArmy1=[CCLabelTTF labelWithString:@"步兵部队" dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    playerArmy1.position=ccp(740, 550);
    [self addChild:playerArmy1 z:3];
    
    playerArmy2=[CCLabelTTF labelWithString:@"摩托部队" dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    playerArmy2.position=ccp(740, 470);
    [self addChild:playerArmy2 z:3];
    
    playerArmy3=[CCLabelTTF labelWithString:@"坦克部队" dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    playerArmy3.position=ccp(740, 390);
    [self addChild:playerArmy3 z:3];
    
    playerArmy4=[CCLabelTTF labelWithString:@"导弹部队" dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    playerArmy4.position=ccp(740, 310);
    [self addChild:playerArmy4 z:3];
    
    
    robotArmyLabel[0]=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[robotArmy numOfArmyType1]] dimensions:CGSizeMake(200,30) alignment:UITextAlignmentCenter  fontName:@"Helvetica-Bold" fontSize:15];
    robotArmyLabel[0].position=ccp(550, 510);
    [self addChild:robotArmyLabel[0] z:3];
    
    robotArmyLabel[1]=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[robotArmy numOfArmyType2]] dimensions:CGSizeMake(200,30) alignment:UITextAlignmentCenter  fontName:@"Helvetica-Bold" fontSize:15];
    robotArmyLabel[1].position=ccp(550, 430);
    [self addChild:robotArmyLabel[1] z:3  ];
    
    robotArmyLabel[2]=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[robotArmy numOfArmyType3]] dimensions:CGSizeMake(200,30) alignment:UITextAlignmentCenter  fontName:@"Helvetica-Bold" fontSize:15];
    robotArmyLabel[2].position=ccp(550, 350);
    [self   addChild:robotArmyLabel[2] z:3];
    
    robotArmyLabel[3]=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[robotArmy numOfArmyType4]] dimensions:CGSizeMake(200,30) alignment:UITextAlignmentCenter  fontName:@"Helvetica-Bold" fontSize:15];
    robotArmyLabel[3].position=ccp(550, 270);
    [self addChild:robotArmyLabel[3] z:3];
   

}
-(void)playerFight
{
    CCAction *action1=[CCSequence actions:[CCDelayTime actionWithDuration:0.3],[CCMoveBy actionWithDuration:0.1 position:ccp(-25, 0)],[CCMoveBy actionWithDuration:0.1 position:ccp(25, 0)] ,[CCMoveBy actionWithDuration:0.1 position:ccp(-25, 0)],[CCMoveBy actionWithDuration:0.1 position:ccp(25, 0)] ,[CCMoveBy actionWithDuration:0.1 position:ccp(-25, 0)],[CCMoveBy actionWithDuration:0.1 position:ccp(25, 0)] ,[CCMoveBy actionWithDuration:0.1 position:ccp(-25, 0)],[CCMoveBy actionWithDuration:0.1 position:ccp(25, 0)] ,[CCMoveBy actionWithDuration:0.1 position:ccp(-25, 0)],[CCMoveBy actionWithDuration:0.1 position:ccp(25, 0)] ,[CCMoveBy actionWithDuration:0.1 position:ccp(-25, 0)],[CCMoveBy actionWithDuration:0.1 position:ccp(25, 0)] ,nil];
    CCAction *action2=[CCSequence actions:[CCMoveBy actionWithDuration:0.1 position:ccp(25, 0)],[CCDelayTime actionWithDuration:1.8],[CCMoveBy actionWithDuration:0.1 position:ccp(-25, 0)] ,nil];
    if ([self victoryCheck]==YES)
    {
    
        int playerArmy=[self getPlayerArmy];
        int robotArmy=[self getRobotArmy];
        [playerArmyImage[playerArmy] runAction:[CCRepeat actionWithAction:action2 times:1]];
        [robotArmyImage[robotArmy] runAction:[CCRepeat actionWithAction:action1 times:1]];
        int attack=playerArmyArray[playerArmy]*(playerArmy+1)*(playerArmy+1);
        int defence=(robotArmy+1)*(robotArmy+1);
        robotArmyArray[robotArmy]-=(int)attack/defence+1;
        if (robotArmyArray[robotArmy]<=0) {
            robotArmyImage[robotArmy].color=ccRED;
            robotArmyArray[robotArmy]=0;
        }
        [self upDateLabel];
    [self scheduleOnce:@selector(robotFight) delay:4];
    }
    
}
-(void)robotFight
{
    CCAction *action2=[CCSequence actions:[CCDelayTime actionWithDuration:0.3],[CCMoveBy actionWithDuration:0.1 position:ccp(25, 0)],[CCMoveBy actionWithDuration:0.1 position:ccp(-25, 0)] ,[CCMoveBy actionWithDuration:0.1 position:ccp(25, 0)],[CCMoveBy actionWithDuration:0.1 position:ccp(-25, 0)] ,[CCMoveBy actionWithDuration:0.1 position:ccp(25, 0)],[CCMoveBy actionWithDuration:0.1 position:ccp(-25, 0)] ,[CCMoveBy actionWithDuration:0.1 position:ccp(25, 0)],[CCMoveBy actionWithDuration:0.1 position:ccp(-25, 0)] ,[CCMoveBy actionWithDuration:0.1 position:ccp(25, 0)],[CCMoveBy actionWithDuration:0.1 position:ccp(-25, 0)] ,[CCMoveBy actionWithDuration:0.1 position:ccp(25, 0)],[CCMoveBy actionWithDuration:0.1 position:ccp(-25, 0)] ,nil];
    CCAction *action1=[CCSequence actions:[CCMoveBy actionWithDuration:0.1 position:ccp(-25, 0)],[CCDelayTime actionWithDuration:1.8],[CCMoveBy actionWithDuration:0.1 position:ccp(25, 0)] ,nil];
    if ([self victoryCheck]==YES)
    {
        
        int playerArmy=[self getPlayerArmy];
        int robotArmy=[self getRobotArmy];
        [playerArmyImage[playerArmy] runAction:[CCRepeat actionWithAction:action2 times:1]];
        [robotArmyImage[robotArmy] runAction:[CCRepeat actionWithAction:action1 times:1]];
    
        int defence=(playerArmy+1)*(playerArmy+1);
        int attack=robotArmyArray[robotArmy]*(robotArmy+1)*(robotArmy+1);
        playerArmyArray[playerArmy]-=(int)attack/defence+1;
        if (playerArmyArray[playerArmy]<=0) {
            playerArmyImage[playerArmy].color=ccRED;
            playerArmyArray[playerArmy]=0;
        }
        [self upDateLabel];
    [self scheduleOnce:@selector(playerFight) delay:4];
    }
    
}
-(void)upDateLabel
{
    [playerArmyLabel[0] setString:[NSString stringWithFormat:@"%d",playerArmyArray[0]]];
    [playerArmyLabel[1] setString:[NSString stringWithFormat:@"%d",playerArmyArray[1]]];
    [playerArmyLabel[2] setString:[NSString stringWithFormat:@"%d",playerArmyArray[2]]];
    [playerArmyLabel[3] setString:[NSString stringWithFormat:@"%d",playerArmyArray[3]]];
    [robotArmyLabel[0] setString:[NSString stringWithFormat:@"%d",robotArmyArray[0]]];
    [robotArmyLabel[1] setString:[NSString stringWithFormat:@"%d",robotArmyArray[1]]];
    [robotArmyLabel[2] setString:[NSString stringWithFormat:@"%d",robotArmyArray[2]]];
    [robotArmyLabel[3] setString:[NSString stringWithFormat:@"%d",robotArmyArray[3]]];
    
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
        [self playerWin];
        return false;
        
    }
    else if (robotArmyArray[0]  ==0&&robotArmyArray[1]==0&&robotArmyArray[2]==0&&robotArmyArray[3]==0) {
       
        [self playerLose];
        return false;
        
    }
    else
        
    {
       return YES; 
    }
}
-(void)armyLose
{
    CCLabelTTF *playerLabel1,*playerLabel2,*playerLabel3,*playerLabel4;
    playerLabel1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"步兵部队损失：%d",(playerArmyArray[0]-[playerArmy numOfArmyType1]) ]dimensions:CGSizeMake(150,30)  alignment:UITextAlignmentCenter  fontName:@"Helvetica-Bold" fontSize:15];
    playerLabel1.position=ccp(350, 400);
    [self addChild:playerLabel1 z:6];
    playerLabel2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"摩托部队损失：%d",(playerArmyArray[1]-[playerArmy numOfArmyType2]) ]dimensions:CGSizeMake(150,30)  alignment:UITextAlignmentCenter  fontName:@"Helvetica-Bold" fontSize:15];
    playerLabel2.position=ccp(350, 370);
    [self addChild:playerLabel2 z:6];
    playerLabel3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"坦克部队损失：%d",(playerArmyArray[2]-[playerArmy numOfArmyType3]) ]dimensions:CGSizeMake(150,30)  alignment:UITextAlignmentCenter  fontName:@"Helvetica-Bold" fontSize:15];
    playerLabel3.position=ccp(350, 340);
    [self addChild:playerLabel3 z:6];
    playerLabel4=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"导弹部队损失：%d",(playerArmyArray[3]-[playerArmy numOfArmyType4]) ]dimensions:CGSizeMake(150,30)  alignment:UITextAlignmentCenter  fontName:@"Helvetica-Bold" fontSize:15];
    playerLabel4.position=ccp(350, 310);
    [self addChild:playerLabel4 z:6];
    
    CCLabelTTF *robotLabel1,*robotLabel2,*robotLabel3,*robotLabel4;
    robotLabel1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"步兵部队损失：%d",(robotArmyArray[0]-[robotArmy numOfArmyType1]) ]dimensions:CGSizeMake(150,30)  alignment:UITextAlignmentCenter  fontName:@"Helvetica-Bold" fontSize:15];
    robotLabel1.position=ccp(650, 400);
    [self addChild:robotLabel1 z:6];
    robotLabel2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"摩托部队损失：%d",(robotArmyArray[1]-[robotArmy numOfArmyType2]) ]dimensions:CGSizeMake(150,30)  alignment:UITextAlignmentCenter  fontName:@"Helvetica-Bold" fontSize:15];
    robotLabel2.position=ccp(650, 370);
    [self addChild:robotLabel2 z:6];
    robotLabel3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"坦克部队损失：%d",(robotArmyArray[2]-[robotArmy numOfArmyType3]) ]dimensions:CGSizeMake(150,30)  alignment:UITextAlignmentCenter  fontName:@"Helvetica-Bold" fontSize:15];
    robotLabel3.position=ccp(650, 340);
    [self addChild:robotLabel3 z:6];
    robotLabel4=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"导弹部队损失：%d",(robotArmyArray[3]-[robotArmy numOfArmyType4]) ]dimensions:CGSizeMake(150,30)  alignment:UITextAlignmentCenter  fontName:@"Helvetica-Bold" fontSize:15];
    robotLabel4.position=ccp(650, 310);
    [self addChild:robotLabel4 z:6];
    

}
-(void)playerWin
{
    CCSprite *winPanel=[CCSprite spriteWithFile:@"winPanel.png"];
    winPanel.position=ccp(512,384);
    [self addChild:winPanel z:5];
    CCMenuItemImage *confirm=[CCMenuItemImage itemFromNormalImage:@"确定btn.png" selectedImage:nil target:self selector:@selector(sceneTransition)];
    CCMenu *menu=[CCMenu menuWithItems:confirm, nil];
    menu.position=ccp(512, 250);
    [self armyLose];
    [self addChild:menu z:6 ];

}
-(void)playerLose
{
    CCSprite *losePanel=[CCSprite spriteWithFile:@"losePanel.png"];
    losePanel.position=ccp(512, 384);
    [self addChild:losePanel z:5];
    CCMenuItemImage *confirm=[CCMenuItemImage itemFromNormalImage:@"确定btn.png" selectedImage:nil target:self selector:@selector(sceneTransition)];
    CCMenu *menu=[CCMenu menuWithItems:confirm, nil];
    menu.position=ccp(512, 250);
     [self armyLose];
    [self addChild:menu z:6 ];
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
-(void)sceneTransition
{
    
    [Util playClickSound];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[MilitarySence scene] ]];
    

}
@end
