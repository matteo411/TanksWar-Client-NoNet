//
//  PlayArmy.m
//  coco
//
//  Created by apple  on 13-5-6.
//
//

#import "PlayerArmy.h"

@implementation PlayerArmy
@synthesize numOfArmyType1;
@synthesize numOfArmyType2;
@synthesize numOfArmyType3;
@synthesize numOfArmyType4;
static PlayerArmy *playerArmy=nil;

-(id)initWith
{
    self.numOfArmyType1=200;
    self.numOfArmyType2=100;
    self.numOfArmyType3=30;
    self.numOfArmyType4=0;
    return self;
}

+(PlayerArmy*)getPlayerArmy
{
    if (!playerArmy) {
        playerArmy=[[PlayerArmy alloc]initWith];
    }
    return playerArmy;
}


@end
