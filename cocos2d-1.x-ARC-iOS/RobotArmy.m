//
//  RobotArmy.m
//  coco
//
//  Created by apple  on 13-5-5.
//
//

#import "RobotArmy.h"

@implementation RobotArmy

@synthesize numOfArmyType1;
@synthesize numOfArmyType2;
@synthesize numOfArmyType3;
@synthesize numOfArmyType4;
static RobotArmy *robotArmy=nil;

-(id)initWith
{
    self.numOfArmyType1=200;
    self.numOfArmyType2=100;
    self.numOfArmyType3=50;
    self.numOfArmyType4=20;
    return self;
}

+(RobotArmy*)getRobotArmy
{
    if (!robotArmy) {
        robotArmy=[[RobotArmy alloc]initWith];
    }
    return robotArmy;
}

@end
