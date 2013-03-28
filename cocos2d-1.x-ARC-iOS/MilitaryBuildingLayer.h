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
#import "MilitaryLayer.h"

#import "ResourceLayer.h"
#import "MilitaryBuildingView.h"
@interface MilitaryBuildingLayer : CCLayer {
    
    
    //建筑
    NSMutableArray *buildings;
    
    CCLayer * armyLayer;
    
    int trainNum;
    
    CCLabelTTF *labelOfFood;
    CCLabelTTF *labelOfOil;
    CCLabelTTF *labelOfOre;
    CCLabelTTF *labelOfSteel;
    
    Resources *playerResource;
    
    int addFood;
    int addOil;
    int addOre;
    int addSteel;
    
    
    
     NSMutableArray *countDownLabel;
    
    
    //自己的view
    MilitaryBuildingView *militaryBuildingView;
    
    
}
//+(CCScene *) scene;

@end
