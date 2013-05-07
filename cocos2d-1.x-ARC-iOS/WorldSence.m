//
//  WorldLayer.m
//  coco
//
//  Created by guest on 13-4-24.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "WorldSence.h"
#import "SimpleAudioEngine.h"
#import "Util.h"
@implementation WorldSence

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	WorldSence *layer = [WorldSence node];
    
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
        [Util playBkgSound];
        playerArmy=[PlayerArmy getPlayerArmy ];
        robotArmy=[RobotArmy getRobotArmy];
        [[CCTouchDispatcher sharedDispatcher] removeAllDelegates];
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-127 swallowsTouches:YES];
        //[[CCTouchDispatcher sharedDispatcher] addStandardDelegate:self priority:0];
//       [self registerWithTouchDispatcher];
        
        
        //设置背景
        CCSprite *BackGround=[CCSprite spriteWithFile:@"word_bkg.png" rect:CGRectMake(0, 0, 1024, 768)];
        BackGround.anchorPoint=ccp(0, 0);
        [self addChild:BackGround z:1   tag:0 ];
        [robotArmy setNumOfArmyType1:300];

        //添加玩家
        player=[CCSprite spriteWithFile:@"myself_coco.png" ];
        player.position = ccp(81, 320);
        player.scale = 0.3;
        [self addChild:player z:2   tag:1 ];
        //添加机器人
        robot=[CCSprite spriteWithFile:@"robot.png" ];
        robot.position = ccp(830, 200);
        robot.scale = 0.3;
        [self addChild:robot z:2   tag:2 ];
	}
	return self;
    
}

//触摸方法
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"building touch");
    
    CGPoint point;
    point=[self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:point];
    return TRUE;//
}

-(void)selectSpriteForTouch:(CGPoint) point//选择触摸点
{
    if (CGRectContainsPoint(robot.boundingBox, point)) {
        [self choicePanelRobot];
    }
   else if (CGRectContainsPoint(player.boundingBox, point)) {
        [self choicePanelPlayer];
    }
    else
        [self backToWorldSence];

}
-(void)choicePanelRobot
{
//    CCLabelTTF *Back=[CCLabelTTF labelWithString:@"查看" dimensions:CGSizeMake(100, 50) alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:20];
//    CCLabelTTF *Confirm=[CCLabelTTF labelWithString:@"进攻" dimensions:CGSizeMake(100, 50) alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:20];
    CCMenuItemImage *Back=[CCMenuItemImage itemFromNormalImage:@"查看btn.png" selectedImage:nil target:self selector:@selector(checkRobot)];
    CCMenuItemImage *Confirm=[CCMenuItemImage itemFromNormalImage:@"进攻btn.png" selectedImage:nil target:self selector:@selector(attackRobot)];
//    CCMenuItemLabel *menu10=[CCMenuItemLabel itemWithLabel:Back target:self selector:@selector(checkRobot)];
//    CCMenuItemLabel *menu11=[CCMenuItemLabel itemWithLabel:Confirm target:self selector:@selector(attackRobot)];
    CCMenu *menu=[CCMenu menuWithItems:Back,Confirm,nil];
    [menu alignItemsHorizontallyWithPadding:10];
    [menu setPosition:ccp(robot.position.x, robot.position.y+70)];

    [self addChild:menu z:3 tag:202 ];
}
-(void)backToWorldSence
{
    [self removeChildByTag:202 cleanup:YES];
    [self removeChildByTag:203 cleanup:YES];
    [self removeChildByTag:204 cleanup:YES];
    [self removeChildByTag:205 cleanup:YES];
}
-(void)goToMilitaryScence
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[MilitarySence scene] ]];
}


-(void)choicePanelPlayer
{
//    CCLabelTTF *Back=[CCLabelTTF labelWithString:@"查看" dimensions:CGSizeMake(100, 50) alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:20];
//    CCLabelTTF *Confirm=[CCLabelTTF labelWithString:@"进入" dimensions:CGSizeMake(100, 50) alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:20];
//    CCMenuItemLabel *menu10=[CCMenuItemLabel itemWithLabel:Back target:self selector:@selector(checkPlayer)];
//    CCMenuItemLabel *menu11=[CCMenuItemLabel itemWithLabel:Confirm target:self selector:@selector(goToMilitaryScence)];
    CCMenuItemImage *Back=[CCMenuItemImage itemFromNormalImage:@"查看btn.png" selectedImage:nil target:self selector:@selector(checkPlayer)];
    CCMenuItemImage *Confirm=[CCMenuItemImage itemFromNormalImage:@"进入btn.png" selectedImage:nil target:self selector:@selector(goToMilitaryScence)];
    CCMenu *menu=[CCMenu menuWithItems:Back,Confirm,nil];
    [menu alignItemsHorizontallyWithPadding:10];
    [menu setPosition:ccp(player.position.x, player.position.y+70)];
    
    [self addChild:menu z:3 tag:202 ];
}
-(void)attackRobot
{
       [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[FightSence scene] ]];
}
-(void)checkPlayer
{
    [self removeChildByTag:202 cleanup:YES];
    CCNode *nodeOfPlayer=[[CCNode alloc]init];
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *Panel=[CCSprite spriteWithFile:@"panel.png"];
    Panel.position=ccp(size.width/2, size.height/2);
    [self addChild:Panel z:3 tag:205];
    NSLog(@"hello worldsence1");
    CCSprite *ArmyImage1,*ArmyImage2,*ArmyImage3,*ArmyImage4;
    ArmyImage1=[CCSprite spriteWithFile:@"a_d1.png"];
    ArmyImage1.position=ccp(280,480);
    [nodeOfPlayer addChild:ArmyImage1];
    ArmyImage2=[CCSprite spriteWithFile:@"a_d2.png"];
    ArmyImage2.position=ccp(280, 420);
    [nodeOfPlayer addChild:ArmyImage2];
    ArmyImage3=[CCSprite spriteWithFile:@"a_d3.png"];
    ArmyImage3.position=ccp(280, 360);
    [nodeOfPlayer addChild:ArmyImage3];
    ArmyImage4=[CCSprite spriteWithFile:@"a_d4.png"];
    ArmyImage4.position=ccp(280, 300);
    [nodeOfPlayer addChild:ArmyImage4];
    NSLog(@"hello worldsence2");
    
    CCLabelTTF * ArmyLabel1,*ArmyLabel2,*ArmyLabel3,*ArmyLabel4;
    ArmyLabel1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"步兵部队数量：%d",[playerArmy numOfArmyType1]] dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    ArmyLabel1.position=ccp(420, 480);
    [nodeOfPlayer addChild:ArmyLabel1];
    
    ArmyLabel2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"摩托部队数量：%d",[playerArmy numOfArmyType2]] dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    ArmyLabel2.position=ccp(420, 420);
    [nodeOfPlayer addChild:ArmyLabel2];
    
    ArmyLabel3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"坦克部队数量：%d",[playerArmy numOfArmyType3]] dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    ArmyLabel3.position=ccp(420, 360);
    [nodeOfPlayer addChild:ArmyLabel3];
    
    ArmyLabel4=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"导弹部队数量：%d",[playerArmy numOfArmyType4]] dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    ArmyLabel4.position=ccp(420, 300);
    [nodeOfPlayer addChild:ArmyLabel4];
    NSLog(@"hello worldsence3");
    [self addChild:nodeOfPlayer z:4 tag:203];
    NSLog(@"hello worldsence4");
    CCLabelTTF *Confirm=[CCLabelTTF labelWithString:@"返回" dimensions:CGSizeMake(100, 50) alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:20];
    
    CCMenuItemLabel *menu11=[CCMenuItemLabel itemWithLabel:Confirm target:self selector:@selector(backToWorldSence)];
    
    CCMenu *menuBack=[CCMenu menuWithItems:menu11, nil];
    
    [menuBack setPosition:ccp(810, 540)];
    [menuBack setOpacity:0];
    [self addChild:menuBack z:3 tag:204];
    
}
-(void)checkRobot
{
    [self removeChildByTag:202 cleanup:YES];
    CCNode *nodeOfPlayer=[[CCNode alloc]init];
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *Panel=[CCSprite spriteWithFile:@"panel.png"];
    Panel.position=ccp(size.width/2, size.height/2);
    [self addChild:Panel z:3 tag:205];
    NSLog(@"hello worldsence1");
    CCSprite *ArmyImage1,*ArmyImage2,*ArmyImage3,*ArmyImage4;
    ArmyImage1=[CCSprite spriteWithFile:@"a_d1.png"];
    ArmyImage1.position=ccp(280,480);
    [nodeOfPlayer addChild:ArmyImage1];
    ArmyImage2=[CCSprite spriteWithFile:@"a_d2.png"];
    ArmyImage2.position=ccp(280, 420);
    [nodeOfPlayer addChild:ArmyImage2];
    ArmyImage3=[CCSprite spriteWithFile:@"a_d3.png"];
    ArmyImage3.position=ccp(280, 360);
    [nodeOfPlayer addChild:ArmyImage3];
    ArmyImage4=[CCSprite spriteWithFile:@"a_d4.png"];
    ArmyImage4.position=ccp(280, 300);
    [nodeOfPlayer addChild:ArmyImage4];
    NSLog(@"hello worldsence2");
    
    CCLabelTTF * ArmyLabel1,*ArmyLabel2,*ArmyLabel3,*ArmyLabel4;
    ArmyLabel1=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"步兵部队数量：%d",[robotArmy numOfArmyType1]] dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    ArmyLabel1.position=ccp(420, 480);
    [nodeOfPlayer addChild:ArmyLabel1];
    
    ArmyLabel2=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"摩托部队数量：%d",[robotArmy numOfArmyType2]] dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    ArmyLabel2.position=ccp(420, 420);
    [nodeOfPlayer addChild:ArmyLabel2];
    
    ArmyLabel3=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"坦克部队数量：%d",[robotArmy numOfArmyType3]] dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    ArmyLabel3.position=ccp(420, 360);
    [nodeOfPlayer addChild:ArmyLabel3];
    
    ArmyLabel4=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"导弹部队数量：%d",[robotArmy numOfArmyType4]] dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
    ArmyLabel4.position=ccp(420, 300);
    [nodeOfPlayer addChild:ArmyLabel4];
    NSLog(@"hello worldsence3");
    [self addChild:nodeOfPlayer z:4 tag:203];
    NSLog(@"hello worldsence4");
    CCLabelTTF *Confirm=[CCLabelTTF labelWithString:@"返回" dimensions:CGSizeMake(100, 50) alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:20];

    CCMenuItemLabel *menu11=[CCMenuItemLabel itemWithLabel:Confirm target:self selector:@selector(backToWorldSence)];
  
    CCMenu *menuBack=[CCMenu menuWithItems:menu11, nil];
    
    [menuBack setPosition:ccp(810, 540)];
    [menuBack setOpacity:0];
    [self addChild:menuBack z:3 tag:204];


    
}
-(void) onExit
{
//    [SimpleAudioEngine sharedEngine] 
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super onExit];
    NSLog(@"invoke onExit4");
    
}
@end