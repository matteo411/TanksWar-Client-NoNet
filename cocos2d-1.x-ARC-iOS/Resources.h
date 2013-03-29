//
//  Resources.h
//  coco
//
//  Created by mq on 13-1-23.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Util.h"
@interface Resources : NSObject
{
    //资源
    int food;
    int steel;
    int oil;
    int ore;
    
    //资源增量
    int food_increase;
    int steel_increase;
    int oil_increase;
    int ore_increase;
}
@property (nonatomic) int food;
@property (nonatomic) int steel;
@property (nonatomic) int oil;
@property (nonatomic) int ore;

@property (nonatomic) int food_increase;
@property (nonatomic) int steel_increase;
@property (nonatomic) int oil_increase;
@property (nonatomic) int ore_increase;

-(void) initialize;


@end
