//
//  Building.h
//  coco
//
//  Created by 陈 奕龙 on 13-3-20.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface Building : NSObject{
    //建筑
    CCSprite *Build;
    
    //扳手
    CCSprite *Wrench;
    //等级
    
}

@property (nonatomic, retain) CCSprite* Build;
@property (nonatomic, retain) CCSprite* Wrench;
@end
