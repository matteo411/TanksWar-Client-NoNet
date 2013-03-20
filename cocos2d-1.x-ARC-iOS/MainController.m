//
//  NavigationLayer.m
//  coco
//
//  Created by 陈 奕龙 on 13-3-19.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "MainController.h"
#import "CCUIViewWrapper.h"
#import "SWScrollView.h"
#import "NavigationView.h"

@implementation MainController
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainController *layer = [MainController node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    
	if( (self=[super init])) {
        //添加右侧导航栏目
        NavigationView *navigationView = [[NavigationView alloc]init];
        CCUIViewWrapper *wrapper = [navigationView Navigation];
      
        [self addChild:wrapper z:4 tag:99];
     
        militaryController = [[MilitaryController alloc]init];
        [self addChild:militaryController z:3 tag:97];
    }
	return self;
    
}

-(void)sceneTransition:(int)sender  //转换到军事区
{
    [self removeChildByTag:98 cleanup:NO];
    resourceController = [[ResourceController alloc]init];
    [self addChild:resourceController z:3 tag:98];
}

-(void)sceneTransition2:(int)sender
{
    [self removeChildByTag:97 cleanup:NO];
    militaryController = [[MilitaryController alloc]init];
    [self addChild:militaryController z:3 tag:97];

}

@end
