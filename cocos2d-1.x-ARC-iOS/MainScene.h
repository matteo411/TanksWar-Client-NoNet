//
//  NavigationLayer.h
//  coco
//
//  Created by 陈 奕龙 on 13-3-19.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ResourceLayer.h"
#import "MilitaryLayer.h"

@interface MainScene : CCLayer {
    ResourceLayer *resourceLayer;
    MilitaryLayer *militaryLayer;
}
+(CCScene *) scene;
@end
