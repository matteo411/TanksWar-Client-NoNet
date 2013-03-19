//
//  NavigationLayer.h
//  coco
//
//  Created by 陈 奕龙 on 13-3-19.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ResourceScene.h"
#import "HelloWorldLayer.h"

@interface NavigationLayer : CCLayer {
    ResourceScene *resourceLabel;
    HelloWorldLayer *helloWorldLayer;
}
+(CCScene *) scene;
@end
