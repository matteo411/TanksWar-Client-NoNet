//
//  WorldLayer.h
//  coco
//
//  Created by guest on 13-4-24.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MainLayer.h"
#import "RobotArmy.h"
#import "FightSence.h"
#import "PlayerArmy.h"
@interface WorldSence : CCLayer {
    CCSprite *robot;
    CCSprite *player;
    RobotArmy *robotArmy;
    PlayerArmy *playerArmy;
    
}

+(CCScene *) scene;

@end
