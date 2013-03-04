//
//  Resources.m
//  coco
//
//  Created by mq on 13-1-23.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Resources.h"


@implementation Resources
-(int)Crop
{
    return  crop;
}
-(int)Steel
{
    return  steel;
}
-(int)Fuel
{
    return fuel;
}
-(int)Xi
{
    return xi;
}
-(void)setCrop:(int)numChanged
{
    crop+=numChanged;
}
-(void)setFuel:(int)numChanged
{
    fuel+=numChanged;
}
-(void)setXi:(int)numChanged
{
    xi+=numChanged;
}
-(void)setSteel:(int)numChanged
{
    steel+=numChanged;
}
-(void) initialazation
{
    crop=1000;
    steel=1000;
    fuel=1000;
    xi=1000;
}
@end
