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
        
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
        
        CCSprite *BackGround=[CCSprite spriteWithFile:@"background.png" rect:CGRectMake(0, 0, 1024, 768)];
        BackGround.anchorPoint=ccp(0, 0);
        [self addChild:BackGround z:1   tag:0 ];    
	}
	return self;
    
}



@end
