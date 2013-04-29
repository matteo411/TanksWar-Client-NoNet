//
//  Created by Steffen Itterheim on 23.07.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import<Foundation/Foundation.h>
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Pomelo.h"
#import "AppDelegate.h"
#import "MilitarySence.h"
#import "MilitaryBuildingLayer.h"
#import "MilitaryView.h"
#import "ArmyLayer.h"
#import "MainLayer.h"

//<PomeloDelegate>
@interface MilitaryBkgLayer : CCLayer
{
    
    
    CGPoint Tpoint;
    
    NSArray *resources;
    
    
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

//+(Resources *)getPlayerResource;

-(void) onExit;

@property (weak, nonatomic) Pomelo *pomelo;
@property(strong,nonatomic)NSString *name;
@property(strong,nonatomic)NSString *channel;
@end
