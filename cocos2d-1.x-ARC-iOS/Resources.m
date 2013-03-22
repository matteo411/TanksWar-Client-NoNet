//
//  Resources.m
//  coco
//
//  Created by mq on 13-1-23.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Resources.h"


@implementation Resources
-(int)Food
{
    return  food;
}
-(int)Steel
{
    return  steel;
}
-(int)Oil
{
    return oil;
}
-(int)Ore
{
    return ore;
}
-(void)setFood:(int)numChanged
{
    food+=numChanged;
}
-(void)setOil:(int)numChanged
{
    oil+=numChanged;
}
-(void)setOre:(int)numChanged
{
    ore+=numChanged;
}
-(void)setSteel:(int)numChanged
{
    steel+=numChanged;
}
-(void) initialize
{
    food=1000;
    steel=1000;
    oil=1000;
    ore=1000;
}
@end
