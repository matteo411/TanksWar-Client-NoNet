//
//  RobotArmy.h
//  coco
//
//  Created by apple  on 13-5-5.
//
//

#import <Foundation/Foundation.h>

@interface RobotArmy : NSObject
{
}
+(RobotArmy*)getRobotArmy;
@property(nonatomic,assign)int numOfArmyType1;
@property(nonatomic,assign)int numOfArmyType2;
@property(nonatomic,assign)int numOfArmyType3;
@property(nonatomic,assign)int numOfArmyType4;
@end
