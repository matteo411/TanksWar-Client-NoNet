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
    CCSprite *BuildSprite;
    
    //key
    int key;
    
    //png
    NSString* png;
    
    //等级
    int level;
    
}
@property (nonatomic) int level;
@property (nonatomic) int key;
@property (nonatomic,strong) NSString* png;
@property (nonatomic, strong) CCSprite* BuildSprite;
@end
