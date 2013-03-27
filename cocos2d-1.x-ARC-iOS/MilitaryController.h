//
//  HelloWorldLayer.h
//  cocos2d-1.x-ARC-iOS
//
//  Created by Steffen Itterheim on 23.07.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import<Foundation/Foundation.h>
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Pomelo.h"
#import "AppDelegate.h"
#import "Resources.h"
#import "ResourceController.h"
#import "Util.h"

// HelloWorldLayer
@interface MilitaryController : CCLayer<PomeloDelegate>

{
//    NSMutableArray *buildingInformation; 
    CGPoint Tpoint;
    
    //标记玩家选中的精灵
    CCSprite *selSprite;
    
//    NSMutableArray *tagSprites;
    NSMutableArray *buildings;
    Resources *playerResource;
    
    //connection服务器的host
    NSString *host;
    //connection服务器的port
    NSInteger port;
    //当前用户的用户名
    NSString *name;
    //频道
    NSString *channel;
    NSArray *resources;
    CCLabelTTF *labelOfFood;
    CCLabelTTF *labelOfOil;
    CCLabelTTF *labelOfOre;
    CCLabelTTF *labelOfSteel;
    int addFood;
    int addOil;
    int addOre;
    int addSteel;
    CCLayer * armyLayer;
    int trainNum;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
@property (weak, nonatomic) Pomelo *pomelo;
@property(strong,nonatomic)NSString *name;
@property(strong,nonatomic)NSString *channel;
@end
