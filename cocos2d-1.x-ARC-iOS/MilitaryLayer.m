//
//  HelloWorldLayer.m
//  War
//
//  Created by mq on 13-1-4.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//


// Import the interfaces
#import "SlidingMenuGrid.h"
#import "MilitaryLayer.h"
#import <math.h>
#import "CCUIViewWrapper.h"
#import "SWScrollView.h"

// HelloWorldLayer implementation
@implementation MilitaryLayer
@synthesize pomelo; 
@synthesize name;
@synthesize channel;
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MilitaryLayer *layer = [MilitaryLayer node];
    
	
	// add layer as a child to scene
	[scene addChild: layer];
	
//    MilitaryBuildingLayer* militaryBuildingLayer = [MilitaryBuildingLayer node];
//    [scene addChild:militaryBuildingLayer z:4];
    
    
	// return the scene
	return scene;
}


-(id) init
{   
	if( (self=[super init])) {
        
       [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
        //初始化视图
        MilitaryView* militaryView = [[MilitaryView alloc] init];
        //添加背景图片
        [militaryView addBkg:self];
        //添加资源背景
        [militaryView addResourceBkg:self];
        
        
        
        //初始化建筑层
        [self removeChildByTag:333 cleanup:YES];
        MilitaryBuildingLayer* militaryBuildingLayer = [MilitaryBuildingLayer node];
        [self addChild:militaryBuildingLayer z:4 tag:333];
        
        
               
	} 
	return self;
 
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event//触摸方法
{
    
    CGPoint point;
    point=[self convertTouchToNodeSpace:touch];
    NSLog(@" Military:%f,%f",point.x,point.y);
   
    return TRUE;//
}

@end
