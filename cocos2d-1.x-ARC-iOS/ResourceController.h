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
#import "MilitaryController.h"
#import "Util.h"
@interface ResourceController: CCLayer {
    CGPoint Tpoint;
    
    //标记玩家选中的精灵
    CCSprite *selSprite;
    
    //    NSMutableArray *tagSprites;
    NSMutableArray *buildings;
    Resources *playerResource;
    
    //connection服务器的host
    NSString *host;
    //connection服务器的port
    NSInteger port;
    //当前用户的用户名
    NSString *name;
    //频道
    NSString *channel;
    NSArray *resources;
    CCLabelTTF *labelOfFood;
    CCLabelTTF *labelOfOil;
    CCLabelTTF *labelOfOre;
    CCLabelTTF *labelOfSteel;
    int addFood;
    int addOil;
    int addOre;
    int addSteel;
}
+(CCScene *) scene;

@end
