//
//  Resources.h
//  coco
//
//  Created by mq on 13-1-23.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Resources : NSObject
{
    int food;
    int steel;
    int oil;
    int ore;
}
-(int)Food;
-(int)Steel;
-(int)Oil;
-(int)Ore;
-(void)setFood:(int) numChanged;
-(void)setSteel:(int)numChanged;
-(void)setOil:(int)numChanged;
-(void)setOre:(int) numChanged;
-(void) initialazation;
@end
