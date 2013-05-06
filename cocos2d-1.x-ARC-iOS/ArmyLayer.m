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
        playArmy=[PlayerArmy getPlayerArmy  ];
        
        ArmyImage[0]=[CCSprite spriteWithFile:@"a_d1.png"];
        ArmyImage[0].position=ccp(280,480);
        [self addChild:ArmyImage[0]];
        ArmyImage[1]=[CCSprite spriteWithFile:@"a_d2.png"];
        ArmyImage[1].position=ccp(280, 420);
        [self addChild:ArmyImage[1]];
        ArmyImage[2]=[CCSprite spriteWithFile:@"a_d3.png"];
        ArmyImage[2].position=ccp(280, 360);
        [self addChild:ArmyImage[2]];
        ArmyImage[3]=[CCSprite spriteWithFile:@"a_d4.png"];
        ArmyImage[3].position=ccp(280, 300);
         [self addChild:ArmyImage[3]];
        
        ArmyNumTraining[0]=[CCLabelTTF labelWithString:@"训练中的部队数量：0" dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
        ArmyNumTraining[0].position=ccp(420, 490);
        [self addChild:ArmyNumTraining[0]];
        
        ArmyNumNow[0]=[CCLabelTTF labelWithString:@"现有的部队数量：0" dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
        ArmyNumNow[0].position=ccp(420, 460);
        [self addChild:ArmyNumNow[0]];
        
        ArmyNumTraining[1]=[CCLabelTTF labelWithString:@"训练中的部队数量：0" dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
        ArmyNumTraining[1].position=ccp(420, 430);
        [self addChild:ArmyNumTraining[1]];
        
        ArmyNumNow[1]=[CCLabelTTF labelWithString:@"现有的部队数量：0" dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
        ArmyNumNow[1].position=ccp(420, 400);
        [self addChild:ArmyNumNow[1]];
        
        ArmyNumTraining[2]=[CCLabelTTF labelWithString:@"训练中的部队数量：0" dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
        ArmyNumTraining[2].position=ccp(420, 370);
        [self addChild:ArmyNumTraining[2]];
        
        ArmyNumNow[2]=[CCLabelTTF labelWithString:@"现有的部队数量：0" dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
        ArmyNumNow[2].position=ccp(420, 340);
        [self addChild:ArmyNumNow[2]];
        
        ArmyNumTraining[3]=[CCLabelTTF labelWithString:@"训练中的部队数量：0" dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
        ArmyNumTraining[3].position=ccp(420, 310);
        [self addChild:ArmyNumTraining[3]];
        
        ArmyNumNow[3]=[CCLabelTTF labelWithString:@"现有的部队数量：0" dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
        ArmyNumNow[3].position=ccp(420, 280);
        [self addChild:ArmyNumNow[3]];
        [ArmyNumNow[0] setString:[NSString stringWithFormat:@"现有的部队数量：%d",[playArmy numOfArmyType1]]];
        [ArmyNumNow[1] setString:[NSString stringWithFormat:@"现有的部队数量：%d",[playArmy numOfArmyType2]]];
        [ArmyNumNow[2] setString:[NSString stringWithFormat:@"现有的部队数量：%d",[playArmy numOfArmyType3]]];
        [ArmyNumNow[3] setString:[NSString stringWithFormat:@"现有的部队数量：%d",[playArmy numOfArmyType4]]];
        
    }
    return self;
}
-(void) setTrainingLabel:(int)num  Value:(int) value TrainTime:(ccTime)time
{
         NUM=num;
        //[ArmyNumTraining setString:[NSString stringWithFormat:@"训练中的士兵数量：%d"，value ] ];
        [ArmyNumTraining[num-1] setString:[NSString stringWithFormat:@"训练中的部队数量：%d",value]];
        countDownLabel[num-1]=[CCLabelTTF labelWithString:[NSString stringWithFormat:@"剩余的建造时间：%d",time]  dimensions:CGSizeMake(200,30) alignment:UITextAlignmentLeft fontName:@"Helvetica-Bold" fontSize:18];
        countDownLabel[num-1].position=ccp(ArmyNumTraining[num-1].position.x+200,ArmyNumTraining[num-1].position.y );
        countDownLabel[num-1].tag=time+20000;
        [self schedule:@selector(countDown) interval:1];
        [self addChild:countDownLabel[num-1]];
         ArmyNumTraining[num-1].tag=value+10000;
        [self scheduleOnce:@selector(trainingComplete) delay:time];
      
}
-(void)trainingComplete
{
    
    
    NSLog(@"Hello TrainingComplete");
    [ArmyNumTraining[NUM-1] setString:[NSString stringWithFormat:@"训练中的士兵数量：0" ] ];
    int tempValue=ArmyNumTraining[NUM-1].tag-10000;
    
    [ArmyNumNow[NUM-1] setString:[NSString stringWithFormat:@"现有的士兵数量：%d",[playArmy numOfArmyType1]+tempValue]];
    if (NUM==1) {
        [playArmy setNumOfArmyType1:[playArmy numOfArmyType1]+tempValue];
    }
    else if (NUM==2)
    {
        [playArmy setNumOfArmyType2:[playArmy numOfArmyType1]+tempValue];
    }
    else if(NUM==3)
    {
        [playArmy setNumOfArmyType3:[playArmy numOfArmyType1]+tempValue];
    }
    else 
    {
    [playArmy setNumOfArmyType4:[playArmy numOfArmyType1]+tempValue];
     }
      
}
-(void)countDown
{
    NSLog(@"hello countdown");
    if(countDownLabel[NUM-1].tag==20000)
    {
        [self unschedule:@selector(countDown)];
        [self removeChild:countDownLabel[NUM-1] cleanup:YES];
        
    }
    else
    {
        countDownLabel[NUM-1] .tag--;
        [countDownLabel[NUM-1] setString:[NSString stringWithFormat:@"剩余的建造时间：%d",countDownLabel[NUM-1].tag-20000]];
    }
   
}
    
@end
