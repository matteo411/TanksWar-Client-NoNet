//
//  ArmyLayer.h
//  coco
//
//  Created by apple  on 13-4-1.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PlayerArmy.h"

@interface ArmyLayer : CCLayer
{
    int NUM;
    PlayerArmy *playArmy;
    CCLabelTTF *ArmyNumNow[4];
    CCLabelTTF *ArmyNumTraining[4];
    CCLabelTTF *countDownLabel[4];
    CCSprite  * ArmyImage[4];
}

-(id)init;
-(void) setTrainingLabel:(int)num  Value:(int) value TrainTime:(ccTime) time;
@end
