//
//  ResourceScene.h
//  coco
//
//  Created by mq on 13-1-23.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Resources.h"
#import "HelloWorldLayer.h"
@interface ResourceScene : CCLayer {
    CGPoint Tpoint;
    CCSprite *selSprite;
    NSMutableArray *tagSprites;
    NSMutableArray *buildingSprites;
    Resources *playerResource;
    NSString *host;//connection服务器的host
    NSInteger port;//connection服务器的port
    NSString *name;//当前用户的用户名
    NSString *channel;//频道
    NSArray *resources;
    CCLabelTTF *label;
    
}
+(CCScene *) scene;

@end
