//
//  MilitaryBuildingView.m
//  coco
//
//  Created by 陈 奕龙 on 13-3-28.
//
//

#import "MilitaryBuildingView.h"

@implementation MilitaryBuildingView

-(NSMutableArray *)addBuildings:(CCNode*) selfNode
{
    
    NSMutableArray * buildings = [[NSMutableArray alloc] init];
    NSArray *nodes = [Util getNodelistByNodeName:@"nodes"];
    for (NSMutableDictionary* node in nodes)//读取坐标点
    {
        Building *building=[[Building alloc]init];
        NSString* png = [node objectForKey:@"png"];
        building.BuildSprite=[CCSprite spriteWithFile:png ];//mark!!!
        building.BuildSprite.position = ccp([[node objectForKey:@"x"]floatValue],[[node objectForKey:@"y"]floatValue]);
        building.key =[[node objectForKey:@"key"] intValue];
        building.level=[[node objectForKey:@"level"] intValue];
        building.png =png;
        [buildings addObject:building];
        [selfNode addChild:building.BuildSprite z:2];
        
        //初始化建筑等级
        if(building.level >0)
        {
            CCSprite *levelOfbuilding=[CCSprite spriteWithFile:[NSString stringWithFormat:@"level%d.png",building.level]];
            levelOfbuilding.tag=building.key;
            levelOfbuilding.position=ccp(building.BuildSprite.position.x+20, building.BuildSprite.position.y-30);
            [selfNode addChild:levelOfbuilding z:2];
        }
    }
    return buildings;
    
}

//设置面板背景
-(void *)setPanelBkg:(CCNode*) selfNode
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *Panel=[CCSprite spriteWithFile:@"panel.png"];
    Panel.position=ccp(size.width/2, size.height/2);
    [selfNode addChild:Panel z:3 tag:3];
}

//面板添加滚动视图
-(void *)addScrolltoPanel:(CCNode*) selfNode key:(int)key
{
    UIScrollView *scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 340, 595)];
    scroll.backgroundColor=[UIColor  colorWithRed:1  green:1 blue:1 alpha:0];
    CGPoint nodeSize=ccp(340,595);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-50, 300, 200, 20)];   //声明UIlbel并指定其位置和长宽
    
    label.backgroundColor = [UIColor clearColor];   //设置label的背景色，这里设置为透明色。
    
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];   //设置label的字体和字体大小。
    
    
    label.text=@"介绍dhaskdjaslkdjlfhkdashfkjasdhfkjhaiuefhlkajfilehfaehfleifhkadfhaskfdb";   //设置label所显示的文本
    
    label.textColor = [UIColor whiteColor];    //设置文本的颜色
    
    label.transform=CGAffineTransformMakeRotation(M_PI*0.5);
    label.textAlignment = UITextAlignmentCenter;     //设置文本在label中显示的位置，这里为居中。
    
    //换行技巧：如下换行可实现多行显示，但要求label有足够的宽度。
    
    
    UIImage *menu1=[UIImage imageNamed:@"armory_item.png"];
    
    UIImageView *menuPic1=[[UIImageView alloc]initWithImage:menu1];
    menuPic1.frame=CGRectMake(20, 20, 40, 40);
    menuPic1.transform =CGAffineTransformMakeRotation(M_PI*0.5);
    menuPic1.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap1 =[[UITapGestureRecognizer alloc] initWithTarget:selfNode action:@selector(event1:)];
    [menuPic1 addGestureRecognizer:singleTap1];
    singleTap1.view.tag = key;
    UIView *image1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 85, 595)];
    image1.backgroundColor=[UIColor colorWithRed:0 green:0.5 blue:0.7 alpha:0.0];
    image1.layer.borderColor=[[UIColor blackColor]CGColor];
    image1.layer.borderWidth=2;
    [image1 addSubview:label];
    [image1 addSubview:menuPic1];
    [scroll addSubview:image1];
    
    
    UIImage *menu2=[UIImage imageNamed:@"bl_4.png"];
    UIImageView *menuPic2=[[UIImageView alloc]initWithImage:menu2];
    menuPic2.frame=CGRectMake(20, 20, 40, 40);
    menuPic2.transform =CGAffineTransformMakeRotation(M_PI*0.5);
    menuPic2.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap2 =[[UITapGestureRecognizer alloc] initWithTarget:selfNode action:@selector(event2:)];
    [menuPic2 addGestureRecognizer:singleTap2];
    singleTap2.view.tag = key;
    UIView *image2=[[UIView alloc] initWithFrame:CGRectMake(85, 0, 85, 595)];
    image2.backgroundColor=[UIColor colorWithRed:0 green:0.5 blue:0.7 alpha:0.0];
    image2.layer.borderColor=[[UIColor blackColor]CGColor];
    image2.layer.borderWidth=2;
    [image2 addSubview:menuPic2];
    [scroll addSubview:image2];
    
    
    UIImage *menu3=[UIImage imageNamed:@"bl_5.png"];
    UIImageView *menuPic3=[[UIImageView alloc]initWithImage:menu3];
    menuPic3.frame=CGRectMake(20, 20, 40, 40);
    menuPic3.transform =CGAffineTransformMakeRotation(M_PI*0.5);
    menuPic3.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap3 =[[UITapGestureRecognizer alloc] initWithTarget:selfNode action:@selector(event3:)];
    [menuPic3 addGestureRecognizer:singleTap3];
    singleTap3.view.tag = key;
    UIView *image3=[[UIView alloc] initWithFrame:CGRectMake(170, 0, 85, 595)];
    image3.backgroundColor=[UIColor colorWithRed:0 green:0.5 blue:0.7 alpha:0.0];
    image3.layer.borderColor=[[UIColor blackColor]CGColor];
    image3.layer.borderWidth=2;
    [image3 addSubview:menuPic3];
    [scroll addSubview:image3];
    
    UIImage *menu4=[UIImage imageNamed:@"bl_6.png"];
    UIImageView *menuPic4=[[UIImageView alloc]initWithImage:menu4];
    menuPic4.frame=CGRectMake(20, 20, 40, 40);
    menuPic4.transform =CGAffineTransformMakeRotation(M_PI*0.5);
    menuPic4.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap4 =[[UITapGestureRecognizer alloc] initWithTarget:selfNode action:@selector(event4:)];
    [menuPic4 addGestureRecognizer:singleTap4];
    singleTap4.view.tag = key;
    UIView *image4=[[UIView alloc] initWithFrame:CGRectMake(255, 0, 85 , 595)];
    image4.layer.borderColor=[[UIColor blackColor]CGColor];
    image4.layer.borderWidth=2;
    image4.backgroundColor=[UIColor colorWithRed:0 green:0.5 blue:0.7 alpha:0.0];
    
    [image4 addSubview:menuPic4];
    [scroll addSubview:image4];
    scroll.contentSize=CGSizeMake(nodeSize.x+2, nodeSize.y);
    CCUIViewWrapper *wrapper=[CCUIViewWrapper wrapperForUIView:scroll];
    wrapper.position=ccp(185,809);
    //wrapper.position=ccp(500,809);
    [selfNode addChild:wrapper z:4 tag:20];

}



-(Building  *)event:(CCNode*) selfNode tag: (int)tag png:(NSString *)png buildings:(NSMutableArray *)buildings;
{
    
    [selfNode removeChildByTag:20 cleanup:YES];
    [selfNode removeChildByTag:3 cleanup:YES];
    
    for (Building *building  in buildings)
    {
        if(building.key == tag)
        {
            CGPoint tempxy = building.BuildSprite.position;
            
            //删除
            //[buildings removeObject:building];
            [selfNode removeChild:building.BuildSprite cleanup:YES];
            
            //配置
            building.png =png;
            building.level = 1;
            building.BuildSprite =[CCSprite spriteWithFile:png];
            building.BuildSprite.position =tempxy;
            
            //添加
            //[buildings addObject:building];
            [selfNode addChild:building.BuildSprite z:2];
            
            return building;
        }
        
    }
    return NULL;
}

-(void *)rotateWrench:(CCNode*) selfNode building:(Building *) building
{

    CCSprite *wrench=[CCSprite spriteWithFile:@"wrench.png"];
    wrench.position=ccp(building.BuildSprite.position.x-50,building.BuildSprite.position.y+10);
    [selfNode addChild:wrench z:3];
    
    CCAction *rotate1=[CCRotateBy actionWithDuration:0.5 angle:60];
    CCAction *rotate2=[CCRotateBy actionWithDuration:0.5 angle:-60];
    CCAction *repeat=[CCRepeat actionWithAction:[CCSequence actions:rotate1,rotate2 ,nil] times:5];//mark
    CCAction *delete=[CCCallFuncN actionWithTarget:selfNode selector:@selector(deleteWrench:)];
    wrench.tag =building.key;
    [wrench runAction:[CCSequence actions:repeat,delete, nil]];
}

-(void *)addProgressTimer:(CCNode*) selfNode building:(Building *) building
{
    CCProgressTimer *ct=[CCProgressTimer progressWithFile:@"进度条.png"];
    ct.position=ccp( building.BuildSprite.position.x-building.BuildSprite.boundingBox.size.height/4,building.BuildSprite.position.y+building.BuildSprite.boundingBox.size.width/4);
    ct.percentage = 0; //当前进度
    [selfNode addChild:ct z:3 tag:building.key+500];
    
    CCSequence *timerAction = [CCSequence actions:[CCProgressTo actionWithDuration:5 percent:100.f], nil];
    ct.type = kCCProgressTimerTypeHorizontalBarLR;
    
    
    
    [ct runAction:timerAction];
}

-(void *)addCountDown:(CCNode*) selfNode building:(Building *) building countDownLabel:(NSMutableArray *)countDownLabel
{
    int buildtime=5;
    NSNumber* buildingLevel = [[NSNumber alloc] initWithInt:building.level];
    [Util modifyPng:building.png andLevel:buildingLevel  ByKey:building.key]; //bug
    
    CCLabelTTF *countDown=[CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(80, 40) alignment:UITextAlignmentLeft fontName:@"Arial" fontSize:24];
    [countDown setString:[NSString stringWithFormat: @"%.2d:%.2d",buildtime/60,buildtime%60]];
    [countDownLabel addObject:countDown];
    countDown.color=ccRED;
    countDown.position=ccp(850, 650-countDownLabel.count*40);
    [selfNode addChild:countDown z:2 tag:buildtime+5000];

}

-(void *)deleteWrench:(CCNode*) selfNode building:(Building *) tempBuilding sender:(id)sender
{
    CCParticleSystem *systerm=[CCParticleGalaxy node];
    systerm.position=tempBuilding.BuildSprite.position;
    systerm.contentSize=CGSizeMake(50,50);
    systerm.duration=0.5f;
    [selfNode addChild: systerm z:2];
    CCSprite *levelOfbuilding=[CCSprite spriteWithFile:@"level1.png"];
    levelOfbuilding.position=ccp(tempBuilding.BuildSprite.position.x+20, tempBuilding.BuildSprite.position.y-30);
    [selfNode addChild:levelOfbuilding z:2 tag:tempBuilding.key];
    [selfNode removeChild:sender cleanup:YES];
    
    
    [selfNode removeChildByTag:tempBuilding.key+500 cleanup:YES];
}

-(void)armoryHandle:(CCNode*) selfNode building:(Building*) building
{
    [CCMenuItemFont setFontName:@"Marker Felt"];
    [CCMenuItemFont setFontSize:20];
    CCMenuItemFont *Control=[CCMenuItemFont itemFromString:@"管理" target:selfNode selector:@selector(control:)];
    CCMenuItemFont  *Delete=[CCMenuItemFont itemFromString:@"拆除" target:selfNode selector:@selector(delete:)];
    CCMenuItemFont *upGrade=[CCMenuItemFont itemFromString:@"升级" target:selfNode selector:@selector(upgrade:)];
    
    Delete.tag= upGrade.tag = building.key;
    
    CCMenu *menu=[CCMenu menuWithItems: Control,Delete,upGrade,nil];
    [menu setPosition:ccp(building.BuildSprite.position.x+50, building.BuildSprite.position.y-50)];
    [menu alignItemsHorizontally];
    [selfNode addChild:menu z:3 tag:103];
}

-(void)buildingHandle:(CCNode*) selfNode building:(Building*) building
{
    [CCMenuItemFont setFontName:@"Marker Felt"];
    [CCMenuItemFont setFontSize:20];
    CCMenuItemFont  *Delete=[CCMenuItemFont itemFromString:@"拆除" target:selfNode selector:@selector(delete:)];
    CCMenuItemFont *upGrade=[CCMenuItemFont itemFromString:@"升级" target:selfNode selector:@selector(upgrade:)];
    Delete.tag= upGrade.tag = building.key;
    
    CCMenu *menu=[CCMenu menuWithItems:Delete,upGrade,nil];
    [menu setPosition:ccp(building.BuildSprite.position.x+50, building.BuildSprite.position.y-50)];
    [menu alignItemsHorizontally];
    [selfNode addChild:menu z:3 tag:103];
}

-(void)deleteBuilding:(CCNode*) selfNode key:(int) key buildings:(NSMutableArray *)buildings
{
    for (Building *building  in buildings)
    {
        if(building.key == key)
        {
            CGPoint tempxy = building.BuildSprite.position;
            
            //删除
            // [buildings removeObject:building];
            [selfNode removeChild:building.BuildSprite cleanup:YES];
            
            //配置
            building.png =@"tags.png";
            building.level = 0;
            building.BuildSprite =[CCSprite spriteWithFile:@"tags.png"];
            building.BuildSprite.position =tempxy;
            //添加
            // [buildings addObject:building];
            [selfNode addChild:building.BuildSprite z:2];
            
            
            [selfNode removeChildByTag:building.key cleanup:YES];
            
            
            //plist操作
            NSNumber* buildingLevel = [[NSNumber alloc] initWithInt:building.level];
            [Util modifyPng:building.png andLevel: buildingLevel ByKey:building.key];
            
        }
        
    }
}
-(void)upgradeParticleSystem:(CCNode*) selfNode building:(Building*) tempBuilding
{
    CCParticleSystem *systerm=[CCParticleGalaxy node];
    systerm.position=tempBuilding.BuildSprite.position;
    systerm.contentSize=CGSizeMake(50,50);
    systerm.duration=0.5f;
    [selfNode addChild: systerm z:2];
}

-(void)modifyLevelOfBuilding:(CCNode*) selfNode building:(Building*) tempBuilding
{
    if (tempBuilding.level>=18) {
        tempBuilding.level=18;
    }
    
    [selfNode removeChildByTag:tempBuilding.key cleanup:YES];
    
    CCSprite *levelOfbuilding=[CCSprite spriteWithFile:[NSString stringWithFormat:@"level%d.png",tempBuilding.level]];
    levelOfbuilding.tag=tempBuilding.key;
    levelOfbuilding.position=ccp(tempBuilding.BuildSprite.position.x+20, tempBuilding.BuildSprite.position.y-30);
    [selfNode addChild:levelOfbuilding z:2];
}
@end
