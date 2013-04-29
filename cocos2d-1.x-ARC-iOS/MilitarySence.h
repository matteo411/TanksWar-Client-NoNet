//
//  HelloWorldLayer.h
//  cocos2d-1.x-ARC-iOS
//
//  Created by Steffen Itterheim on 23.07.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import<Foundation/Foundation.h>
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Pomelo.h"
#import "AppDelegate.h"

typedef enum
{
	LayerTagMilitaryBkgLayer,
	LayerTagMilitaryBuildingLayer,
} MilitarySenceTags;

@class MilitaryBkgLayer;
@class MilitaryBuildingLayer;
//<PomeloDelegate>
@interface MilitarySence : CCLayer
{

   
}


+(MilitarySence*) sharedLayer;

@property (readonly) MilitaryBkgLayer* militaryBkgLayer;
@property (readonly) MilitaryBuildingLayer* militaryBuildingLayer;

-(void) onExit;
+(CCScene *) scene;
+(CGPoint) locationFromTouch:(UITouch*)touch;
+(CGPoint) locationFromTouches:(NSSet *)touches;
//+(Resources *)getPlayerResource;

@end
