//
//  FightSence.h
//  coco
//
//  Created by apple  on 13-5-5.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MainLayer.h"
#import "RobotArmy.h"
#import "PlayerArmy.h"
@interface FightSence : CCLayer {
    RobotArmy *robotArmy;
    int playerArmyArray[4];
    int robotArmyArray[4];
    PlayerArmy *playerArmy;
    CCLabelTTF * playerArmyLabel[4];
    CCLabelTTF * robotArmyLabel[4];
    CCSprite *robotArmyImage[4];
    CCSprite *playerArmyImage[4];
}
+(CCScene *) scene;
@end
