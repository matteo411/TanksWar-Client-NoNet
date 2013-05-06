//
//  HelloWorldLayer.m
//  War
//
//  Created by mq on 13-1-4.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//


// Import the interfaces
#import "SlidingMenuGrid.h"
#import "MilitaryBkgLayer.h"
#import <math.h>
#import "CCUIViewWrapper.h"
#import "SWScrollView.h"

// HelloWorldLayer implementation
@implementation MilitaryBkgLayer
@synthesize pomelo;
@synthesize name;
@synthesize channel;



+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MilitarySence *layer = [MilitarySence node];
    
    MainLayer *mainLayer = [MainLayer node];
    
    MilitaryBuildingLayer* militaryBuildingLayer = [MilitaryBuildingLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    [scene addChild: mainLayer];
	[scene addChild:militaryBuildingLayer z:4 tag:333];
    
    
    
    //    MilitaryBuildingLayer* militaryBuildingLayer = [MilitaryBuildingLayer node];
    //    [scene addChild:militaryBuildingLayer z:4];
    
    
	// return the scene
	return scene;
}

-(void) onExit
{
   
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super onExit];
    NSLog(@"invoke onExit4");
    
}

-(id) init
{
	if( (self=[super init])){
        
        
        //初始化视图
        MilitaryView* militaryView = [[MilitaryView alloc] init];
        //添加背景图片
        [militaryView addBkg:self];
        //添加资源背景
        [militaryView addResourceBkg:self];
        
        //    //初始化建筑层
        //    [self removeChildByTag:333 cleanup:YES];
        //
        //    [self addChild:militaryBuildingLayer z:4 tag:333];
        
        
        
	}
	return self;
    
}


@end



