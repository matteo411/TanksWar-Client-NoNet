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
    
    //key
    int key;
    //等级
    
    int level;
    
}
@property (nonatomic) int level;
@property (nonatomic) int key;
@property (nonatomic, strong) CCSprite* Build;
@end
