//
//  NavigationLayer.m
//  coco
//
//  Created by 陈 奕龙 on 13-3-19.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "MainScene.h"
#import "CCUIViewWrapper.h"
#import "SWScrollView.h"
#import "MainView.h"

@implementation MainScene
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainScene *layer = [MainScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    
	if( (self=[super init])) {
        
        //添加右侧导航栏目
        MainView *mainView = [[MainView alloc]init];
        [mainView Navigation:self]; //self是CCNode
      
        
     
        militaryLayer = [MilitaryLayer node];
        [self addChild:militaryLayer z:1 tag:97];
        
        
       ;
    }
	return self;
    
}


-(void)sceneTransition:(int)sender
{
    //删除资源区
    [self removeChildByTag:98 cleanup:YES];
    //删除军事区底图层
    [self removeChildByTag:97 cleanup:YES];
    //删除军事区建筑层
    [self removeChildByTag:333 cleanup:YES];
    
    militaryLayer = [MilitaryLayer node];
    [self addChild:militaryLayer z:1 tag:97];
    
}


-(void)sceneTransition2:(int)sender  
{
    //删除资源区
    [self removeChildByTag:98 cleanup:YES];
    //删除军事区底图层
    [self removeChildByTag:97 cleanup:YES];
    //删除军事区建筑层
    [self removeChildByTag:333 cleanup:YES];
    
    resourceLayer = [ResourceLayer node];
    [self addChild:resourceLayer z:1 tag:98];
}



@end
