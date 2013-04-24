//
//  ArmyLayer.m
//  coco
//
//  Created by apple  on 13-4-1.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "ArmyLayer.h"


@implementation ArmyLayer

-(id) init
{
    if (self=[super init])
    {
        
        ArmyImage1=[CCSprite spriteWithFile:@"a_d1.png"];
        ArmyImage1.position=ccp(280,480);
        [self addChild:ArmyImage1];
        ArmyImage2=[CCSprite spriteWithFile:@"a_d2.png"];
        ArmyImage2.position=ccp(280, 420);
        [self addChild:ArmyImage2];
        ArmyImage3=[CCSprite spriteWithFile:@"a_d3.png"];
        ArmyImage3.position=ccp(280, 360);
        [self addChild:ArmyImage3];
        ArmyImage4=[CCSprite spriteWithFile:@"a_d4.png"];
        ArmyImage4.position=ccp(280, 300);
         [self addChild:ArmyImage4];
        
        ArmyNumTraining=[CCLabelTTF labelWithString:@"训练中的士兵数量：0" dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
        ArmyNumTraining.position=ccp(420, 490);
        [self addChild:ArmyNumTraining];
        
        ArmyNumNow=[CCLabelTTF labelWithString:@"现有的士兵数量：0" dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
        ArmyNumNow.position=ccp(420, 460);
        [self addChild:ArmyNumNow];
        
               
        
    }
    return self;
}
-(void) setTrainingLabel:(int)num  Value:(int) value TrainTime:(ccTime)time
{
    if (num==1) {
        //[ArmyNumTraining setString:[NSString stringWithFormat:@"训练中的士兵数量：%d"，value ] ];
        [ArmyNumTraining setString:[NSString stringWithFormat:@"训练中的士兵数量：%d",value]];
        countDownLabel=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"剩余的建造时间：%d",time]  dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
        countDownLabel.position=ccp(ArmyNumTraining.position.x+200,ArmyNumTraining.position.y );
        countDownLabel.tag=time+20000;
        [self schedule:@selector(countDown) interval:1];
        [self addChild:countDownLabel];
         ArmyNumTraining.tag=value+10000;
        [self scheduleOnce:@selector(trainingComplete) delay:time];
    }
}
-(void)trainingComplete
{
    NSLog(@"Hello TrainingComplete");
    [ArmyNumTraining setString:[NSString stringWithFormat:@"训练中的士兵数量：0" ] ];
    int tempValue=ArmyNumTraining.tag-10000;
    
    [ArmyNumNow setString:[NSString stringWithFormat:@"现有的士兵数量：%d",tempValue]];
}
-(void)countDown
{
    if(countDownLabel.tag==20000)
    {
        [self unschedule:@selector(countDown)];
        [self removeChild:countDownLabel cleanup:NO];
        
    }
    else
    {
        countDownLabel.tag--;
        [countDownLabel setString:[NSString stringWithFormat:@"剩余的建造时间：%d",countDownLabel.tag-20000]];
    }
    
}
@end
