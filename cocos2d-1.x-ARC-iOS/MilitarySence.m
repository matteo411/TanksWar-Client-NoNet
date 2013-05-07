//
//  HelloWorldLayer.m
//  War
//
//  Created by mq on 13-1-4.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//


// Import the interfaces
#import "SlidingMenuGrid.h"
#import "MilitarySence.h"
#import <math.h>
#import "MilitaryBkgLayer.h"
#import "MilitaryBuildingLayer.h"
#import "Util.h"
// HelloWorldLayer implementation
@implementation MilitarySence

static MilitarySence* militarySenceInstance;

+(MilitarySence*) sharedLayer
{
	NSAssert(militarySenceInstance != nil, @"MilitarySence not available!");
	return militarySenceInstance;
}

-(MilitaryBkgLayer*) militaryBkgLayer
{
	CCNode* layer = [self getChildByTag:LayerTagMilitaryBkgLayer];
	NSAssert([layer isKindOfClass:[MilitaryBkgLayer class]], @"%@: not a GameLayer!", NSStringFromSelector(_cmd));
	return (MilitaryBkgLayer*)layer;
}

-(MilitaryBuildingLayer*) militaryBuildingLayer
{
	CCNode* layer = [self getChildByTag:LayerTagMilitaryBuildingLayer];
	NSAssert([layer isKindOfClass:[MilitaryBuildingLayer class]], @"%@: not a GameLayer!", NSStringFromSelector(_cmd));
	return (MilitaryBuildingLayer*)layer;
}


+(id) scene
{
	CCScene* scene = [CCScene node];
	MilitarySence* layer = [MilitarySence node];
	[scene addChild:layer];
	return scene;
}



-(id) init
{
	if ((self = [super init]))
	{
        [Util playBkgSound];
        
		militarySenceInstance = self;
		MilitaryBkgLayer* militaryBkgLayer = [MilitaryBkgLayer node];
		[self addChild:militaryBkgLayer z:1 tag:LayerTagMilitaryBkgLayer];
		
		// The UserInterfaceLayer remains static and relative to the screen area.
		MilitaryBuildingLayer* militaryBuildingLayer = [MilitaryBuildingLayer node];
		[self addChild:militaryBuildingLayer z:2 tag:LayerTagMilitaryBuildingLayer];
        
         MainLayer *mainLayer = [MainLayer node];
        [self addChild: mainLayer];

	}
	
	return self;
}


-(void) onExit
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	 [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	// The Layer will be gone now, to avoid crashes on further access it needs to be nil.
	militarySenceInstance = nil;
    [super onExit];
	
}


+(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

+(CGPoint) locationFromTouches:(NSSet*)touches
{
	return [self locationFromTouch:[touches anyObject]];
}

@end
