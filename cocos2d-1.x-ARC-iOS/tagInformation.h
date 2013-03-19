//
//  tagInformation.h
//  coco
//
//  Created by guest on 13-3-13.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface tagInformation :NSObject
{
  @public  CCSprite *buildingSprite;
  @public  enum
      {
        food,
        steel,
        oil,
        ore,
         tag
       } BuildingType;
  @public  int levelNum;
}
-(int)getLevelNum;
-(void)getBuildingType;


@end
