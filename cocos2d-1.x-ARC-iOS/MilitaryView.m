//
//  MilitaryView.m
//  coco
//
//  Created by 陈 奕龙 on 13-3-20.
//
//

#import "MilitaryView.h"

@implementation MilitaryView

//添加背景
-(void *)addBkg:(CCNode*) selfNode
{
    CCSprite *BackGround=[CCSprite spriteWithFile:@"ipad_reszonebkg.png" rect:CGRectMake(0, 0, 1024, 768)];
    BackGround.anchorPoint=ccp(0, 0);
    [selfNode addChild:BackGround z:1   tag:0  ];
}

//添加资源背景
-(void *)addResourceBkg:(CCNode*) selfNode
{
    CCSprite *topTable=[CCSprite spriteWithFile:@"ipad_helpup.png"];
    topTable.position=ccp(500,750);
    topTable.opacity=150;
    [selfNode addChild:topTable z:2];
}
@end
