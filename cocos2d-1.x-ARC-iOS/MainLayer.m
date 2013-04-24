//
//  NavigationLayer.m
//  coco
//
//  Created by 陈 奕龙 on 13-3-19.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "MainLayer.h"
#import "CCUIViewWrapper.h"
#import "SWScrollView.h"
#import "MainView.h"


@implementation MainLayer
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainLayer *layer = [MainLayer node];
	
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
      
        
     
       
        
       ;
    }
	return self;
    
}


-(void)sceneTransition:(int)sender
{
    
       
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[MilitarySence scene] ]];
    
    
}


-(void)sceneTransition2:(int)sender  
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[ResourceSence scene] ]];

}

-(void)sceneTransition3:(int)sender
{
   
  [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[WorldSence scene] ]];

    
    

}

@end
