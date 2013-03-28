//
//  MilitaryBuildingView.h
//  coco
//
//  Created by 陈 奕龙 on 13-3-28.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Building.h"
#import "Util.h"
#import "CCUIViewWrapper.h"
#import "SWScrollView.h"
@interface MilitaryBuildingView : NSObject


-(NSMutableArray *)addBuildings:(CCNode*) selfNode;


//设置面板背景
-(void *)setPanelBkg:(CCNode*) selfNode;

//面板添加滚动视图
-(void *)addScrolltoPanel:(CCNode*) selfNode key:(int)key;

//even1,2,3,4通用事件
-(Building *)event:(CCNode*) selfNode tag: (int)tag png:(NSString *)png buildings:(NSMutableArray *)buildings;

//转动扳手
-(void *)rotateWrench:(CCNode*) selfNode building:(Building *) building;

//添加进度条
-(void *)addProgressTimer:(CCNode*) selfNode building:(Building *) building;
//添加倒计时
-(void *)addCountDown:(CCNode*) selfNode building:(Building *) building countDownLabel: (NSMutableArray *)countDownLabel;
//删除扳手
-(void *)deleteWrench:(CCNode*) selfNode building:(Building *) building sender:(id)sender;

//军工厂
-(void)armoryHandle:(CCNode*) selfNode building:(Building*) building;
//普通建筑
-(void)buildingHandle:(CCNode*) selfNode building:(Building*) building;

//删除建筑
-(void)deleteBuilding:(CCNode*) selfNode key:(int) key buildings:(NSMutableArray *)buildings;

//升级粒子系统
-(void)upgradeParticleSystem:(CCNode*) selfNode building:(Building*) tempBuilding;
//修改等级图表
-(void)modifyLevelOfBuilding:(CCNode*) selfNode building:(Building*) tempBuilding;
@end
