//
//  MilitaryBuildingLayer.h
//  coco
//
//  Created by 陈 奕龙 on 13-3-28.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Util.h"
#import "Building.h"
#import "CCUIViewWrapper.h"
#import "SWScrollView.h"
#import "Resources.h"
#import "MilitarySence.h"
#import "ArmyLayer.h"
#import "ResourceSence.h"
#import "MilitaryBuildingView.h"

#import "Util.h"

#import "PlayerArmy.h"
@interface MilitaryBuildingLayer : CCLayer {
    
    BOOL  isPanelExist;
    PlayerArmy *playerArmy;
    //建筑
    NSMutableArray *buildings;
    
    ArmyLayer * armyLayer;
    
    int trainNum;
    int trainArmyType;
    CCLabelTTF *labelOfFood;
    CCLabelTTF *labelOfOil;
    CCLabelTTF *labelOfOre;
    CCLabelTTF *labelOfSteel;
    
    Resources *playerResource;
    
    NSMutableArray *countDownLabel;
    CCLabelTTF *labelofFoodonMenu,*labelOfOilonMenu,*labelOfOreonMenu,*labelOfSteelonMenu;
    
    //自己的view
    MilitaryBuildingView *militaryBuildingView;
    
    
}
//+(CCScene *) scene;
-(void) onExit;

@end
