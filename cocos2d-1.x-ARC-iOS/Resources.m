//
//  Resources.m
//  coco
//
//  Created by mq on 13-1-23.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Resources.h"
#import "Util.h"

@implementation Resources

@synthesize food;
@synthesize oil;
@synthesize steel;
@synthesize ore;

@synthesize food_increase;
@synthesize steel_increase;
@synthesize oil_increase;
@synthesize ore_increase;
-(void) initialize
{
    NSDictionary* resource = [Util getNodeDictionaryByNodeName:@"resource"];
    //初始化资源
    food=[[resource objectForKey:@"food"] intValue];
    steel=[[resource objectForKey:@"steel"] intValue];
    oil=[[resource objectForKey:@"oil"] intValue];
    ore=[[resource objectForKey:@"ore"] intValue];
    
    //初始化资源增量
    food_increase = [[resource objectForKey:@"food_increase"] intValue];
    steel_increase = [[resource objectForKey:@"steel_increase"] intValue];
    oil_increase = [[resource objectForKey:@"oil_increase"] intValue];
    ore_increase = [[resource objectForKey:@"ore_increase"] intValue];
    
}




@end
