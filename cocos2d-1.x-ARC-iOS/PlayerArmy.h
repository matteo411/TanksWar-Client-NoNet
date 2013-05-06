//
//  PlayArmy.h
//  coco
//
//  Created by apple  on 13-5-6.
//
//

#import <Foundation/Foundation.h>

@interface PlayerArmy : NSObject
{
    
}
+(PlayerArmy*)getPlayerArmy;
@property(nonatomic,assign)int numOfArmyType1;
@property(nonatomic,assign)int numOfArmyType2;
@property(nonatomic,assign)int numOfArmyType3;
@property(nonatomic,assign)int numOfArmyType4;
@end

