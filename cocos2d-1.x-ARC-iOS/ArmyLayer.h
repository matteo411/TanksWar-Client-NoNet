//
//  ArmyLayer.h
//  coco
//
//  Created by apple  on 13-4-1.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ArmyLayer : CCLayer
{
    CCLabelTTF *ArmyNumNow;
    CCLabelTTF *ArmyNumTraining;
    CCLabelTTF *countDownLabel;
    CCSprite  * ArmyImage1, *ArmyImage2,*ArmyImage3 ,*ArmyImage4;
}

-(id)init;
-(void) setTrainingLabel:(int)num  Value:(int) value TrainTime:(ccTime) time;
@end
