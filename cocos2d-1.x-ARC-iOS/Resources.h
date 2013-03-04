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
    int crop;
    int steel;
    int fuel;
    int xi;
}
-(int)Crop;
-(int)Steel;
-(int)Fuel;
-(int)Xi;
-(void)setCrop:(int) numChanged;
-(void)setSteel:(int)numChanged;
-(void)setFuel:(int)numChanged;
-(void)setXi:(int) numChanged;
-(void) initialazation;
@end
