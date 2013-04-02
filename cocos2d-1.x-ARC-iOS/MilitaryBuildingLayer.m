//
//  MilitaryBuildingLayer.m
//  coco
//
//  Created by 陈 奕龙 on 13-3-28.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "MilitaryBuildingLayer.h"


@implementation MilitaryBuildingLayer


//+(CCScene *) scene
//{
//	// 'scene' is an autorelease object.
//	CCScene *scene = [CCScene node];
//	
//	// 'layer' is an autorelease object.
//	MilitaryBuildingLayer *layer = [MilitaryBuildingLayer node];
//	
//	// add layer as a child to scene
//	[scene addChild: layer];
//	
//	// return the scene
//	return scene;
//}

-(id) init
{
    if( (self=[super init])) {
        
        //触摸优先
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:kCCMenuTouchPriority swallowsTouches:YES];
        
        
        countDownLabel=[[NSMutableArray alloc]init];
        
        //玩家资源
        playerResource=[[Resources alloc] init];
        [playerResource initialize];
        buildings=[[NSMutableArray alloc] init];
        
        isPanelExist=NO;//判断当前是否存在控制面板
        
        militaryBuildingView = [[MilitaryBuildingView alloc] init];
        buildings =[militaryBuildingView addBuildings:self];
                
        armyLayer=[[ArmyLayer alloc]init];
       // armyLayer.zOrder=4;
        [self addChild:armyLayer z:4 tag:334];
        armyLayer.visible=NO;
        
        [self addLabel];
        
         [self schedule:@selector(countDownLabelupDate) interval:1];
        
        

    }
    
    return self;
}





//加上最上面的资源显示栏
-(void)addLabel
{
    CCSprite *foodImage=[CCSprite spriteWithFile:@"bl_3s.png"];
    foodImage.position=ccp(90, 740);
    [self addChild:foodImage z:3];
    CCSprite *OilImage=[CCSprite spriteWithFile:@"bl_4s.png"];
    OilImage.position=ccp(290, 740);
    [self addChild:OilImage z:3];
    CCSprite *SteelImage=[CCSprite spriteWithFile:@"bl_5s.png"];
    SteelImage.position=ccp(490, 740);
    [self addChild:SteelImage z:3];
    CCSprite *OreImage=[CCSprite spriteWithFile:@"bl_6s.png"];
    OreImage.position=ccp(690, 740);
    [self addChild:OreImage z:3];
    
    labelOfFood=[CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(150, 100) alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:20];
    [labelOfFood setString:[NSString stringWithFormat:@"%i",playerResource.food]];
    labelOfFood.position=ccp(200, 700);
    [self addChild:labelOfFood z:3 tag:101];
    [labelOfFood setColor:ccRED];
    
    labelOfOil=[CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(150, 100)  alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:20];
    [labelOfOil setString:[NSString stringWithFormat:@"%i",playerResource.oil]];
    labelOfOil.position=ccp(400, 700);
    [labelOfOil setColor:ccRED];
    [self addChild:labelOfOil z:3 tag:101];
    
    labelOfSteel=[CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(150, 100) alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:20];
    [labelOfSteel setString:[NSString stringWithFormat:@"%i",playerResource.steel]];
    labelOfSteel.position=ccp(600, 700);
    [labelOfSteel setColor:ccRED];
    [self addChild:labelOfSteel z:3 tag:101];
    
    labelOfOre=[CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(150, 100) alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:20];
    [labelOfOre setString:[NSString stringWithFormat:@"%i",playerResource.ore]];
    labelOfOre.position=ccp(800, 700);
    [labelOfOre setColor:ccRED];
    [self addChild:labelOfOre z:3 tag:101];
    
    [self schedule:@selector(updateLabel:)interval:1 ];
}

-(void)updateLabel:(ccTime)delta//资源栏数值更新
{
 
    [Util addIncreaseToResource];
    [playerResource initialize];
    [labelOfOil setString:[NSString stringWithFormat:@"%i",playerResource.oil]];
    [labelOfFood setString:[NSString stringWithFormat:@"%i",playerResource.food]];
    [labelOfSteel setString:[NSString stringWithFormat:@"%i",playerResource.steel]];
    [labelOfOre setString:[NSString stringWithFormat:@"%i",playerResource.ore]];
}
-(void)countDownLabelupDate
{
    
    for (int num=countDownLabel.count; num>=1; num--)
    {
        
        CCLabelTTF *countDown=[countDownLabel objectAtIndex:num-1];
        
        countDown.tag--;
        
        [countDown setString:[NSString stringWithFormat:@"%.2d:%.2d",(countDown.tag-5000)/60,(countDown.tag-5000)%60]];
        
        if (countDown.tag==5000) {
            [countDownLabel removeObjectAtIndex:num-1];
            [self removeChild:countDown cleanup:YES];
            for (int num=countDownLabel.count; num>=1; num--)
            {
                countDown.position=ccp(850, 650-countDownLabel.count*40);
            }
        }
    }
}

//触摸方法
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    CGPoint point;
    point=[self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:point];
    return TRUE;//
}

-(void)selectSpriteForTouch:(CGPoint) point//选择触摸点
{
    for (Building *building  in buildings)
    {
        if (CGRectContainsPoint(building.BuildSprite.boundingBox, point)&&isPanelExist==NO)
        {
            isPanelExist=YES;
            if([building.png isEqualToString:@"tags.png"])
            {
                [self ChoicePanel:building.key];
                //isTouchTheBuilding=YES;
                return;
            }
            else
            {
                if ([building.png isEqualToString:@"armory.png"])
                {
                    [self armoryHandle:building];
                }
                else
                    [self buildingHandle:building];
                
                return;
            }
            
        }
    }
    if (isPanelExist==YES)
    {
        CCSprite *PanelBg = [self getChildByTag:3];
        if (!CGRectContainsPoint(PanelBg.boundingBox, point)) {
        [self removeChildByTag:3 cleanup:NO];
        [self removeChildByTag:20 cleanup:NO];
        [self removeChildByTag:202 cleanup:YES];
            isPanelExist=NO;
            armyLayer.visible=NO;
        }
        
        //CCSprite *PanelBg=[s]
    }
    
}


//军事管理菜单
-(void)armoryHandle:(Building*) building
{
    [militaryBuildingView armoryHandle:self building:building];
}


//普通建筑管理
-(void)buildingHandle:(Building *) building
{
    [militaryBuildingView buildingHandle:self building:building];
}


//军事区造兵面板
-(void)control:(id)sender
{
    [self removeChildByTag:103 cleanup:YES];
    
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *Panel=[CCSprite spriteWithFile:@"panel.png"];
    Panel.position=ccp(size.width/2, size.height/2);
    [self addChild:Panel z:3 tag:3];
    UIScrollView *scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 340, 595)];
    scroll.backgroundColor=[UIColor  colorWithRed:1  green:1 blue:1 alpha:0];
    CGPoint nodeSize=ccp(340,595);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-50, 300, 200, 20)];   //声明UIlbel并指定其位置和长宽
    
    label.backgroundColor = [UIColor clearColor];   //设置label的背景色，这里设置为透明色。
    
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];   //设置label的字体和字体大小。
    
    
    label.text=@"介绍";   //设置label所显示的文本
    
    label.textColor = [UIColor whiteColor];    //设置文本的颜色
    
    label.transform=CGAffineTransformMakeRotation(M_PI*0.5);
    label.textAlignment = UITextAlignmentCenter;     //设置文本在label中显示的位置，这里为居中。
    
    //换行技巧：如下换行可实现多行显示，但要求label有足够的宽度。
    
    UIImage *menu1=[UIImage imageNamed:@"a_d1.png"];
    UIImageView *menuPic1=[[UIImageView alloc]initWithImage:menu1];
    menuPic1.frame=CGRectMake(20, 20, 40, 40);
    menuPic1.transform =CGAffineTransformMakeRotation(M_PI*0.5);
    menuPic1.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap1 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(trainSoldier:)];
    [menuPic1 addGestureRecognizer:singleTap1];
    //singleTap1.view.tag = key;
    UIView *image1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 85, 595)];
    image1.backgroundColor=[UIColor colorWithRed:0 green:0.5 blue:0.7 alpha:0.0];
    image1.layer.borderColor=[[UIColor blackColor]CGColor];
    image1.layer.borderWidth=2;
    [image1 addSubview:label];
    [image1 addSubview:menuPic1];
    [scroll addSubview:image1];
    
    
    UIImage *menu2=[UIImage imageNamed:@"a_d2.png"];
    UIImageView *menuPic2=[[UIImageView alloc]initWithImage:menu2];
    menuPic2.frame=CGRectMake(20, 20, 40, 40);
    menuPic2.transform =CGAffineTransformMakeRotation(M_PI*0.5);
    menuPic2.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap2 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event2:)];
    [menuPic2 addGestureRecognizer:singleTap2];
    //singleTap2.view.tag = key;
    UIView *image2=[[UIView alloc] initWithFrame:CGRectMake(85, 0, 85, 595)];
    image2.backgroundColor=[UIColor colorWithRed:0 green:0.5 blue:0.7 alpha:0.0];
    image2.layer.borderColor=[[UIColor blackColor]CGColor];
    image2.layer.borderWidth=2;
    [image2 addSubview:menuPic2];
    [scroll addSubview:image2];
    
    
    UIImage *menu3=[UIImage imageNamed:@"a_d3.png"];
    UIImageView *menuPic3=[[UIImageView alloc]initWithImage:menu3];
    menuPic3.frame=CGRectMake(20, 20, 40, 40);
    menuPic3.transform =CGAffineTransformMakeRotation(M_PI*0.5);
    menuPic3.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap3 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event3:)];
    [menuPic3 addGestureRecognizer:singleTap3];
    //singleTap3.view.tag = key;
    UIView *image3=[[UIView alloc] initWithFrame:CGRectMake(170, 0, 85, 595)];
    image3.backgroundColor=[UIColor colorWithRed:0 green:0.5 blue:0.7 alpha:0.0];
    image3.layer.borderColor=[[UIColor blackColor]CGColor];
    image3.layer.borderWidth=2;
    [image3 addSubview:menuPic3];
    [scroll addSubview:image3];
    
    UIImage *menu4=[UIImage imageNamed:@"a_d4.png"];
    UIImageView *menuPic4=[[UIImageView alloc]initWithImage:menu4];
    menuPic4.frame=CGRectMake(20, 20, 40, 40);
    menuPic4.transform =CGAffineTransformMakeRotation(M_PI*0.5);
    menuPic4.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap4 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event4:)];
    [menuPic4 addGestureRecognizer:singleTap4];
    //singleTap4.view.tag = key;
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
    [self addChild:wrapper z:3 tag:20  ];
    CCLabelTTF *Back=[CCLabelTTF labelWithString:@"查看" dimensions:CGSizeMake(100, 50) alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:20];
    CCLabelTTF *Confirm=[CCLabelTTF labelWithString:@"返回" dimensions:CGSizeMake(100, 50) alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:20];
    CCMenuItemLabel *menu10=[CCMenuItemLabel itemWithLabel:Back target:self selector:@selector(GoToArmyPanel)];
    CCMenuItemLabel *menu11=[CCMenuItemLabel itemWithLabel:Confirm target:self selector:@selector(backToMilitoryZone)];
    CCMenu *menu=[CCMenu menuWithItems:menu10, menu11,nil];
    [menu alignItemsHorizontallyWithPadding:0];
    
    [menu setPosition:CGPointMake(400,550)];
    [self addChild:menu z:3 tag:202 ];
    
}

//从军事区面板回到军事区
-(void)backToMilitoryZone
{
    [self removeChildByTag:3 cleanup:NO];
    [self removeChildByTag:20 cleanup:NO];
    [self removeChildByTag:202 cleanup:YES];
    
    isPanelExist=NO;
    armyLayer.visible=NO;
    
}


//显示兵力菜单（未完成）
-(void)GoToArmyPanel
{
    CCNode *node=[self getChildByTag:20];
    node.visible=NO;
    
    CCNode *wrapper=[self getChildByTag:20];
    wrapper.visible=NO;
    armyLayer.visible=YES;
    
}


//训练士兵面板
-(void)trainSoldier:(UITapGestureRecognizer *)gesture
{
    //ccmenu  返回  和叉掉
    
    CCNode *wrapper=[self getChildByTag:20];
    wrapper.visible=NO;
    CCLayer *node=[[CCLayer alloc] init];
    node.tag=200;
    CCSprite *image=[CCSprite spriteWithFile:@"a_d1.png"];
    image.position=ccp(280,480);
    [node addChild:image];
    //[self addChild:image z:5 tag:201];
    CCSprite *foodImage=[CCSprite spriteWithFile:@"bl_3s.png"];
    foodImage.position=ccp(400, 350);
    [node addChild:foodImage];
    //[self addChild:foodImage z:3];
    CCSprite *OilImage=[CCSprite spriteWithFile:@"bl_4s.png"];
    OilImage.position=ccp(400, 320);
    [node addChild:OilImage];
    //[self addChild:OilImage z:3];
    CCSprite *SteelImage=[CCSprite spriteWithFile:@"bl_5s.png"];
    SteelImage.position=ccp(400, 290);
    [node addChild:SteelImage];
    //[self addChild:SteelImage z:3];
    CCSprite *OreImage=[CCSprite spriteWithFile:@"bl_6s.png"];
    [node addChild:OreImage];
    OreImage.position=ccp(400, 260);
    //[self addChild:OreImage z:3];
    
    
    
    labelofFoodonMenu=[CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(80, 50) alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:14];
    [labelofFoodonMenu setString:@":50"];
    labelofFoodonMenu.position=ccp(460, 335);
    [node addChild:labelofFoodonMenu  ];
    //[self addChild:labelofFoodonMenu z:3 tag:202];
    
    labelOfOilonMenu=[CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(80, 50)  alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:14];
    [labelOfOilonMenu setString:@":50"];
    [node addChild:labelOfOilonMenu];
    labelOfOilonMenu.position=ccp(460, 305);
    
    //[self addChild:labelOfOilonMenu z:3 tag:203];
    
    labelOfSteelonMenu=[CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(80, 50) alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:14];
    [labelOfSteelonMenu setString:@":50"];
    [node addChild:labelOfSteelonMenu];
    labelOfSteelonMenu.position=ccp(460, 275);
    
    //[self addChild:labelOfSteelonMenu z:3 tag:204];
    
    labelOfOreonMenu=[CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(80, 50) alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:14];
    [labelOfOreonMenu setString:@":50"];
    labelOfOreonMenu.position=ccp(460, 245);
    [node addChild:labelOfOreonMenu];
    //[self addChild:labelOfOreonMenu z:3 tag:205];
    
    CCLabelTTF *Back=[CCLabelTTF labelWithString:@"返回" dimensions:CGSizeMake(100, 50) alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:20];
    CCLabelTTF *Confirm=[CCLabelTTF labelWithString:@"确定" dimensions:CGSizeMake(100, 50) alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:20];
    CCMenuItemLabel *menu1=[CCMenuItemLabel itemWithLabel:Back target:self selector:@selector(BacktTo:)];
    CCMenuItemLabel *menu2=[CCMenuItemLabel itemWithLabel:Confirm target:self selector:@selector(Confirm:)];
    CCMenu *menu=[CCMenu menuWithItems:menu2, menu1,nil];
    [menu alignItemsHorizontallyWithPadding:0];
    [node addChild:menu];
    [menu setPosition:CGPointMake(750, 200)];
    //[self addChild:menu z:3];
   
    
    UISlider *slider=[[UISlider alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    slider.minimumValue=0;
    slider.maximumValue=20;
    slider.value=0;
    slider.backgroundColor=[UIColor clearColor];
    [slider addTarget:self action:@selector(sliderChangeValue:) forControlEvents:UIControlEventValueChanged];
    
    CCUIViewWrapper *wrapper1=[CCUIViewWrapper wrapperForUIView:slider];
    
    [wrapper1 setRotation:90];
    wrapper1.position=ccp(330, 600);
    [node addChild:wrapper1 ];
    
    //[node addChild:wrapper2];
    [self addChild:node z:3];

    
    
}

//滑动改变兵力值
-(IBAction)sliderChangeValue:(id)sender
{
    [self removeChildByTag:205 cleanup:YES];
    UITextField *textView=[[UITextField alloc] initWithFrame:CGRectMake(0, 0,50, 30)];
    [textView adjustsFontSizeToFitWidth];
    textView.keyboardType=UIKeyboardAppearanceAlert;
    [textView setBorderStyle:UITextBorderStyleRoundedRect];
    
    CCUIViewWrapper *wrapper2=[CCUIViewWrapper wrapperForUIView:textView];
    wrapper2.rotation=90;
    wrapper2.position=ccp(400, 400);
    UISlider *slider=(UISlider*)sender;
    int sliderValue=(int)(slider.value+0.5);
    slider.value=sliderValue;
    [labelofFoodonMenu setString:[NSString stringWithFormat:@":%d",50*sliderValue]];
    [labelOfOilonMenu setString:[NSString stringWithFormat:@":%d",50*sliderValue]];
    [labelOfOreonMenu setString:[NSString stringWithFormat:@":%d",50*sliderValue]];
    [labelOfSteelonMenu setString:[NSString stringWithFormat:@":%d",50*sliderValue]];
    textView.text=[NSString stringWithFormat:@"%d", (int)slider.value];
    trainNum=sliderValue;
    [self addChild:wrapper2 z:3 tag:205];
    
    
}

//返回到造兵面板
-(void)BacktTo:(id)sender
{
    [self removeChildByTag:200 cleanup:NO];
    CCNode *wrapper=[self getChildByTag:20];
    [self removeChildByTag:205 cleanup:NO];
    wrapper.visible=YES;
    
}

//训练确认
-(void)Confirm:(id)sender
{
    NSLog(@"invoke Confirm");
    [self removeChildByTag:200 cleanup:NO];
    CCNode *wrapper=[self getChildByTag:20];
    [self removeChildByTag:205 cleanup:YES];
    
    wrapper.visible=YES;
   
    NSMutableDictionary* consumeResource = [[NSMutableDictionary alloc] init];
    [consumeResource setObject:[NSNumber numberWithInt:50*trainNum] forKey:@"food"];
    [consumeResource setObject:[NSNumber numberWithInt:50*trainNum] forKey:@"oil"];
    [consumeResource setObject:[NSNumber numberWithInt:50*trainNum] forKey:@"steel"];
    [consumeResource setObject:[NSNumber numberWithInt:50*trainNum] forKey:@"ore"];
    BOOL result = [Util consumeResource:consumeResource];
    if (result) {
        NSLog(@"训练成功");
        [armyLayer setTrainingLabel:1 Value:trainNum TrainTime:10];
    }else
    {
        NSLog(@"资源不够，训练失败");
    }
    
    
   
}





//删除扳手
-(void)deleteWrench:(id)sender
{
    CCSprite *delete = (CCSprite *)sender;
    int key = delete.tag;
    Building *tempBuilding;
    for (Building *building  in buildings)
    {
        if(building.key == key)
        {
            tempBuilding =building;
        }
    }
    
    [militaryBuildingView deleteWrench:self building:tempBuilding sender:sender];
}

//删除建筑
-(void)delete:(id)sender  
{
    
    CCMenuItemFont *item =(CCMenuItemFont*) sender;
    int key = item.tag;
    
    [self removeChildByTag:103 cleanup:YES];
    
    [militaryBuildingView deleteBuilding:self key:key buildings:buildings];
}

//升级建筑
-(void)upgrade:(id)sender  
{
    //删除面板
    [self removeChildByTag:103 cleanup:YES];
    //得到当前建筑
    CCMenuItemFont *item =(CCMenuItemFont*) sender;
    int key = item.tag;
    Building * tempBuilding;
    for (Building *building  in buildings)
    {
        if(building.key == key)
        {
            building.level++;
            tempBuilding = building;
        }
    }
    //粒子系统
    [militaryBuildingView upgradeParticleSystem:self building:tempBuilding];   
    //修改等级图标
    [militaryBuildingView modifyLevelOfBuilding:self building:tempBuilding];
}

//选择面板  
-(void) ChoicePanel:(int)key
{
    //设置面板背景
    [militaryBuildingView setPanelBkg:self];
   
    //添加面板滚动视图
    [militaryBuildingView addScrolltoPanel:self key:key];
 
}

-(void) event1:(UITapGestureRecognizer *)gesture
{
    int gestureviewtag = gesture.view.tag;
    Building* building =[militaryBuildingView event:self tag:gestureviewtag png:@"armory.png" buildings:buildings];
    [self rotateWrench:building];
}
-(void) event2:(UITapGestureRecognizer *)gesture
{
    int gestureviewtag = gesture.view.tag;
    Building* building =[militaryBuildingView event:self tag:gestureviewtag png:@"ipad_b15.png" buildings:buildings];
    [self rotateWrench:building];
}
-(void) event3:(UITapGestureRecognizer *)gesture
{
    int gestureviewtag = gesture.view.tag;
    Building* building =[militaryBuildingView event:self tag:gestureviewtag png:@"ipad_b12.png" buildings:buildings];
    [self rotateWrench:building];
}
-(void) event4:(UITapGestureRecognizer *)gesture
{
    int gestureviewtag = gesture.view.tag;
    Building* building =[militaryBuildingView event:self tag:gestureviewtag png:@"ipad_b18.png" buildings:buildings];
    [self rotateWrench:building];
    
}
-(void)rotateWrench:(Building *) building//转动扳手  加入进度条  加入倒计时器
{
       isPanelExist=NO;
    //转动扳手
    [militaryBuildingView rotateWrench:self building:building];
    
    //添加进度条
    [militaryBuildingView addProgressTimer:self building:building];
    
    //加入倒计时
    [militaryBuildingView addCountDown:self building:building countDownLabel:countDownLabel];
    
}

@end
