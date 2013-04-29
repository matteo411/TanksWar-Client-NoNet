//
//  WorldLayer.m
//  coco
//
//  Created by guest on 13-4-24.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "WorldSence.h"


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
        
        
        [[CCTouchDispatcher sharedDispatcher] removeAllDelegates];
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-127 swallowsTouches:YES];
        //[[CCTouchDispatcher sharedDispatcher] addStandardDelegate:self priority:0];
//       [self registerWithTouchDispatcher];
        
        
        //设置背景
        CCSprite *BackGround=[CCSprite spriteWithFile:@"word_bkg.png" rect:CGRectMake(0, 0, 1024, 768)];
        BackGround.anchorPoint=ccp(0, 0);
        [self addChild:BackGround z:1   tag:0 ];
        

        //添加玩家
        CCSprite *player=[CCSprite spriteWithFile:@"myself_coco.png" ];
        player.position = ccp(81, 424);
        player.scale = 0.3;
        [self addChild:player z:2   tag:1 ];
        
        //添加机器人
        CCSprite *robot=[CCSprite spriteWithFile:@"robot.png" ];
        robot.position = ccp(830, 265);
        robot.scale = 0.3;
        [self addChild:robot z:2   tag:2 ];
	}
	return self;
    
}

//触摸方法
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint point;
    point=[self convertTouchToNodeSpace:touch];
    NSLog(@"word touch :%f,%f",point.x,point.y);
}

@end
