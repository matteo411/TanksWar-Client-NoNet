//
//  ResourceScene.m
//  coco
//
//  Created by mq on 13-1-23.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "ResourceScene.h"


@implementation ResourceScene
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ResourceScene *layer = [ResourceScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
-(id) init
{
	if( (self=[super init])) {
        
        playerResource=[[Resources alloc] init];
        [playerResource initialazation];
        CGSize size = [[CCDirector sharedDirector] winSize];
        tagSprites=[[NSMutableArray alloc] init];
        buildingSprites=[[NSMutableArray alloc] init];
        
		// create and initialize a Label
		//CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];
        CCSprite *BackGround=[CCSprite spriteWithFile:@"background.png" rect:CGRectMake(0, 0, 1024, 768)];
        BackGround.anchorPoint=ccp(0, 0);
        [self addChild:BackGround z:1   tag:0];
        
        CCSpriteBatchNode *tags=[CCSpriteBatchNode batchNodeWithFile:@"tags.png" capacity:24];
        
        [self addChild:tags z:2 tag:100];
        for (int y=0; y<4; y++)
            for (int x=0; x<6; x++)
            {
                CCSprite *s=[CCSprite spriteWithBatchNode:tags rect:CGRectMake(0, 0, 64, 64)];
                s.tag=y*6+x+1;
                [s setOpacity:255];
                [tags addChild:s ];
                [s setPosition:ccp(size.width*(2+x)/12, size.height*(3+y)/10)];
                [tagSprites addObject:s ];
                
            }

        label=[CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(100, 100) alignment: UIViewAnimationCurveEaseIn fontName:@"Arial" fontSize:16];
        [label setString:[NSString stringWithFormat:@"石油：%i\n粮食：%i\n钢铁：%i\n锡矿：%i",playerResource.Fuel,playerResource.Crop,playerResource.Steel,playerResource.Xi]];
        label.position=ccp(120, 670);
        [self addChild:label z:2 tag:101];
        
        [CCMenuItemFont setFontName:@"Marker Felt"];
        [CCMenuItemFont setFontSize:40  ];
        CCMenuItemFont *militaryArea=[CCMenuItemFont itemFromString:@"军事区" target:self selector:@selector(sceneTransition:) ];
        
        CCMenu *changeScene=[CCMenu menuWithItems:militaryArea, nil];
        [changeScene alignItemsHorizontally];
        [changeScene setPosition:ccp(800, 670)];
        [self addChild:changeScene z:2 tag:102];
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
        
        
        
        
	}
	return self;
    
}
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    
    
    CGPoint point;
    point=[self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:point];
    
    return TRUE;
    
}
-(void)selectSpriteForTouch:(CGPoint) point
{
    for (CCSprite *sprite in buildingSprites) {
        if (CGRectContainsPoint(sprite.boundingBox, point)) {
            selSprite=sprite;
            [self updateBuilding];
            return;
        }
    }
    for (CCSprite *sprite in tagSprites)
    {
        if (CGRectContainsPoint(sprite.boundingBox, point))
        {
            selSprite=sprite;
            [self ChoicePanel];
            return;
        }
    }
}
-(void)updateBuilding
{
    //self.isTouchEnabled=NO;
    [CCMenuItemFont setFontName:@"Marker Felt"];
    [CCMenuItemFont setFontSize:30];
    CCMenuItemFont  *Delete=[CCMenuItemFont itemFromString:@"拆除" target:self selector:@selector(delete:)];
    CCMenuItemFont *upGrade=[CCMenuItemFont itemFromString:@"升级" target:self selector:@selector(upgrade:)];
    CCMenu *menu=[CCMenu menuWithItems:Delete,upGrade,nil];
    [menu setPosition:ccp(selSprite.position.x+50, selSprite.position.y-50)];
    [menu alignItemsHorizontally];
    [self addChild:menu z:3 tag:103];
}
-(void) ChoicePanel
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *Panel=[CCSprite spriteWithFile:@"panel.png"];
    Panel.position=ccp(size.width/2, size.height/2);
    [self addChild:Panel z:3 tag:3];
    CCSprite *Menu1=[CCSprite spriteWithFile:@"menu1.png"];
    CCSprite *Menu2=[CCSprite spriteWithFile:@"menu2.png"];
    CCMenuItemSprite *menu1=[CCMenuItemSprite itemFromNormalSprite:Menu1 selectedSprite:nil target:self selector:@selector(Choicemenu1:) ];
    CCMenuItemSprite *menu2=[CCMenuItemSprite itemFromNormalSprite:Menu2 selectedSprite:nil target:self selector:@selector(Choicemenu2:)];
    //CCMenuItemSprite *menu3=[CCMenuItemSprite i]
    CCMenu *menu=[CCMenu menuWithItems:menu1,menu2, nil];
    [menu alignItemsVerticallyWithPadding:0];
    [menu setPosition:ccp(size.width/2, size.height/2)];
    [self addChild:menu z:4 tag:4];
}
-(void)Choicemenu1:sender
{
    [self removeChildByTag:4 cleanup:YES];
    [self removeChildByTag:3 cleanup:YES];
    self.isTouchEnabled=YES;
    CCSprite *Build=[CCSprite spriteWithFile:@"building1.png"];
    [buildingSprites addObject:Build];
    Build.position=selSprite.position;
    [self addChild:Build z:3];
    
   // CGPoint myp = Build.position;
    //[self saveToServer:&myp withPng:@"building1.png"];
    
    
}
-(void)Choicemenu2:sender
{
    [self removeChildByTag:4 cleanup:YES];
    [self removeChildByTag:3 cleanup:YES];
    self.isTouchEnabled=YES;
    CCSprite *Build=[CCSprite spriteWithFile:@"building2.png"];
    [buildingSprites addObject:Build];
    Build.position=selSprite.position;
    [self addChild:Build z:3];
    
   // CGPoint myp = Build.position;
   // [self saveToServer:&myp withPng:@"building2.png"];
    
}
-(void) labelOfNum
{
    
    [label setString:[NSString stringWithFormat:@"石油：%i\n粮食：%i\n钢铁：%i\n锡矿：%i",playerResource.Fuel,playerResource.Crop,playerResource.Steel,playerResource.Xi]];
}
-(void)delete:(id)sender
{
    [self removeChildByTag:103 cleanup:YES];
    [self removeChild:selSprite  cleanup:YES];
    [buildingSprites removeObject:selSprite ];
    
}
-(void)upgrade:(id)sender
{
    [self removeChildByTag:103 cleanup:YES];
    //[self removeChild:selSprite cleanup:YES];
}
-(void)sceneTransition:(id)sender
{
    CCTransitionFade *tran=[CCTransitionFade transitionWithDuration:2 scene:[HelloWorldLayer scene] withColor:ccWHITE];
    [[CCDirector sharedDirector] replaceScene:tran];
}


@end
