//
//  ResourceScene.m
//  coco
//
//  Created by mq on 13-1-23.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "ResourceSence.h"
#import "CCUIViewWrapper.h"
#import "Building.h"
@implementation ResourceSence
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ResourceSence *layer = [ResourceSence node];
	
	// add layer as a child to scene
	
    
    MainLayer *mainLayer = [MainLayer node];
    [scene addChild: layer];
    [scene addChild: mainLayer];
	
	// return the scene
	return scene;
}
-(id) init
{
	if( (self=[super init])) {
        [Util playBkgSound];
        //触摸代理 kCCMenuTouchPriority 优先级最高
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:kCCMenuTouchPriority swallowsTouches:YES];
        
        buildings=[[NSMutableArray alloc] init];
        
        
        
        NSArray *nodes = [Util getNodelistByNodeName:@"resource_area"];
        NSLog(@"invoke10");
        for (NSMutableDictionary* node in nodes)//读取坐标点
        {
            NSLog(@"%@",node);
            Building *building=[[Building alloc]init];
            NSString* png = [node objectForKey:@"png"];
            NSLog(@"invoke10.4");
            building.BuildSprite=[CCSprite spriteWithFile:png rect:CGRectMake(0, 0, 47, 66) ];//mark!!!
            NSLog(@"invoke10.5");
            building.BuildSprite.position = ccp([[node objectForKey:@"x"]floatValue],[[node objectForKey:@"y"]floatValue]);
            building.key =[[node objectForKey:@"key"] intValue];
            building.level=[[node objectForKey:@"level"] intValue];
            building.png = [node objectForKey:@"png"];
            [buildings addObject:building];
            
            [self addChild:building.BuildSprite z:2];
        }
        NSLog(@"invoke11");
        
        //玩家资源
        playerResource=[[Resources alloc] init];
        [playerResource initialize];
        
        CCSprite *BackGround=[CCSprite spriteWithFile:@"ipad_military_bkg.png" rect:CGRectMake(0, 0, 1024, 768)];
        BackGround.anchorPoint=ccp(0, 0);
        [self addChild:BackGround z:1   tag:0  ];//添加背景图
        
        [self initAddNumOfResource];
        
        [self addLabel];
        //初始化资源
        
        //资源的计算
        
        
        
        
        CCSprite *topTable=[CCSprite spriteWithFile:@"ipad_helpup.png"];
        topTable.position=ccp(500,750);
        topTable.opacity=150;
        [self addChild:topTable z:2];
  
	}
	return self;
    
}

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
    [self schedule:@selector(updateLabel:)interval:10 ];
}
-(void)updateLabel:(ccTime)delta
{
    [playerResource setFood:addFood];   
    [playerResource setOil:addOil];
    [playerResource setSteel:addSteel];
    [playerResource setOre:addOre];
    [labelOfOil setString:[NSString stringWithFormat:@"%i",playerResource.oil]];
    [labelOfFood setString:[NSString stringWithFormat:@"%i",playerResource.food]];
    [labelOfSteel setString:[NSString stringWithFormat:@"%i",playerResource.steel]];
    [labelOfOre setString:[NSString stringWithFormat:@"%i",playerResource.ore]];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint point;
    point=[self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:point];
    NSLog(@"资源区触摸点坐标：%f,%f",point.x,point.y);
    return TRUE;//？？？ chenyl
    
}
-(void)selectSpriteForTouch:(CGPoint) point
{
    
    //NSLog(@"point:%f,%f",point.x,point.y);
    for (Building *building  in buildings) {
        if (CGRectContainsPoint(building.BuildSprite.boundingBox, point)) {
            [Util playClickSound];
            if([building.png isEqualToString:@"tags.png"])
            {
                [self ChoicePanel:building.key];
                return;
            }else
            {
                [self buildingHandle:building];
                return;
            }
            
        }
    }
    
}
-(void)buildingHandle:(Building *) building//建筑
{
    //self.isTouchEnabled=NO;
    [CCMenuItemFont setFontName:@"Marker Felt"];
    [CCMenuItemFont setFontSize:20];
    CCMenuItemImage *Delete=[CCMenuItemImage itemFromNormalImage:@"拆除btn.png" selectedImage:nil target:self selector:@selector(delete:)];
    CCMenuItemImage *upGrade=[CCMenuItemImage itemFromNormalImage:@"升级btn.png" selectedImage:nil target:self  selector:@selector(upgrade:)];
    Delete.tag= upGrade.tag = building.key;
    
    CCMenu *menu=[CCMenu menuWithItems:Delete,upGrade,nil];
    [menu setPosition:ccp(building.BuildSprite.position.x-20, building.BuildSprite.position.y+30)];
    [menu alignItemsHorizontally];
    [self addChild:menu z:3 tag:103];
}
-(void) ChoicePanel:(int)key//选择面板  building!!!!!!
{
    
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
    
    
    label.text=@"农田为城市提供粮食生产";   //设置label所显示的文本
    
    label.textColor = [UIColor whiteColor];    //设置文本的颜色
    
    label.transform=CGAffineTransformMakeRotation(M_PI*0.5);
    label.textAlignment = UITextAlignmentCenter;     //设置文本在label中显示的位置，这里为居中。
    
    //换行技巧：如下换行可实现多行显示，但要求label有足够的宽度。
    
    UIImage *menu1=[UIImage imageNamed:@"bl_3.png"];
    UIImageView *menuPic1=[[UIImageView alloc]initWithImage:menu1];
    menuPic1.frame=CGRectMake(20, 20, 40, 40);
    menuPic1.transform =CGAffineTransformMakeRotation(M_PI*0.5);
    menuPic1.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap1 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event1:)];
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
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(-50, 300, 200, 20)];   //声明UIlbel并指定其位置和长宽
    label2.backgroundColor = [UIColor clearColor];   //设置label的背景色，这里设置为透明色。
    label2.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];   //设置label的字体和字体大小。
    label2.text=@"石油基地为城市提供石油生产";   //设置label所显示的文本
    label2.textColor = [UIColor whiteColor];    //设置文本的颜色
    label2.transform=CGAffineTransformMakeRotation(M_PI*0.5);
    label2.textAlignment = UITextAlignmentCenter;     //设置文本在label中显示的位置，这里为居中。
    
    menuPic2.frame=CGRectMake(20, 20, 40, 40);
    menuPic2.transform =CGAffineTransformMakeRotation(M_PI*0.5);
    menuPic2.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap2 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event2:)];
    [menuPic2 addGestureRecognizer:singleTap2];
    singleTap2.view.tag = key;
    UIView *image2=[[UIView alloc] initWithFrame:CGRectMake(85, 0, 85, 595)];
    image2.backgroundColor=[UIColor colorWithRed:0 green:0.5 blue:0.7 alpha:0.0];
    image2.layer.borderColor=[[UIColor blackColor]CGColor];
    image2.layer.borderWidth=2;
    [image2 addSubview:label2];
    [image2 addSubview:menuPic2];
    [scroll addSubview:image2];
    
    
    UIImage *menu3=[UIImage imageNamed:@"bl_5.png"];
    UIImageView *menuPic3=[[UIImageView alloc]initWithImage:menu3];
    menuPic3.frame=CGRectMake(20, 20, 40, 40);
    menuPic3.transform =CGAffineTransformMakeRotation(M_PI*0.5);
    menuPic3.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap3 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event3:)];
    [menuPic3 addGestureRecognizer:singleTap3];
    singleTap3.view.tag = key;
    UIView *image3=[[UIView alloc] initWithFrame:CGRectMake(170, 0, 85, 595)];
    image3.backgroundColor=[UIColor colorWithRed:0 green:0.5 blue:0.7 alpha:0.0];
    image3.layer.borderColor=[[UIColor blackColor]CGColor];
    image3.layer.borderWidth=2;
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(-50, 300, 200, 20)];   //声明UIlbel并指定其位置和长宽
    label3.backgroundColor = [UIColor clearColor];   //设置label的背景色，这里设置为透明色。
    label3.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];   //设置label的字体和字体大小。
    label3.text=@"钢铁厂为城市提供钢铁生产";   //设置label所显示的文本
    label3.textColor = [UIColor whiteColor];    //设置文本的颜色
    label3.transform=CGAffineTransformMakeRotation(M_PI*0.5);
    label3.textAlignment = UITextAlignmentCenter;     //设置文本在label中显示的位置，这里为居中。
     [image3 addSubview:label3];
    [image3 addSubview:menuPic3];
    [scroll addSubview:image3];
    
    UIImage *menu4=[UIImage imageNamed:@"bl_6.png"];
    UIImageView *menuPic4=[[UIImageView alloc]initWithImage:menu4];
    menuPic4.frame=CGRectMake(20, 20, 40, 40);
    menuPic4.transform =CGAffineTransformMakeRotation(M_PI*0.5);
    menuPic4.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap4 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event4:)];
    [menuPic4 addGestureRecognizer:singleTap4];
    singleTap4.view.tag = key;
    UIView *image4=[[UIView alloc] initWithFrame:CGRectMake(255, 0, 85 , 595)];
    image4.layer.borderColor=[[UIColor blackColor]CGColor];
    image4.layer.borderWidth=2;
    image4.backgroundColor=[UIColor colorWithRed:0 green:0.5 blue:0.7 alpha:0.0];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(-50, 300, 200, 20)];   //声明UIlbel并指定其位置和长宽
    label4.backgroundColor = [UIColor clearColor];   //设置label的背景色，这里设置为透明色。
    label4.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];   //设置label的字体和字体大小。
    label4.text=@"稀矿场为城市提供稀有矿石生产";   //设置label所显示的文本
    label4.textColor = [UIColor whiteColor];    //设置文本的颜色
    label4.transform=CGAffineTransformMakeRotation(M_PI*0.5);
    label4.textAlignment = UITextAlignmentCenter;     //设置文本在label中显示的位置，这里为居中。
    [image4 addSubview:label4];
    
    [image4 addSubview:menuPic4];
    [scroll addSubview:image4];
    scroll.contentSize=CGSizeMake(nodeSize.x+2, nodeSize.y);
    CCUIViewWrapper *wrapper=[CCUIViewWrapper wrapperForUIView:scroll];
    wrapper.position=ccp(185,809);
    //wrapper.position=ccp(500,809);
    [self addChild:wrapper z:4 tag:20];
    NSLog(@"chenyl");
}

-(void)rotateWrench:(Building *) building//转动扳手
{
    NSLog(@"rotateWrench1");
    CCSprite *wrench=[CCSprite spriteWithFile:@"wrench.png"];
    wrench.position=ccp(building.BuildSprite.position.x-50,building.BuildSprite.position.y+10);
    [self addChild:wrench z:3];
    
    CCAction *rotate1=[CCRotateBy actionWithDuration:0.5 angle:60];
    CCAction *rotate2=[CCRotateBy actionWithDuration:0.5 angle:-60];
    NSLog(@"rotateWrench2");
    CCAction *repeat=[CCRepeat actionWithAction:[CCSequence actions:rotate1,rotate2 ,nil] times:5];//mark
    NSLog(@"rotateWrench3");
    CCAction *delete=[CCCallFuncN actionWithTarget:self selector:@selector(deleteWrench:)];
    NSLog(@"rotateWrench4");
    wrench.tag =building.key;
    [wrench runAction:[CCSequence actions:repeat,delete, nil]];
    
    //进度条
    CCProgressTimer *ct=[CCProgressTimer progressWithFile:@"进度条.png"];
    ct.position=ccp( building.BuildSprite.position.x-building.BuildSprite.boundingBox.size.height/4,building.BuildSprite.position.y+building.BuildSprite.boundingBox.size.width/4);
    ct.percentage = 0; //当前进度
    
    [self addChild:ct z:3 tag:building.key+500];
    
    //[self updateTimerdg:building];
    
    
    CCSequence *timerAction = [CCSequence actions:[CCProgressTo actionWithDuration:5 percent:100.f], nil];
    ct.type = kCCProgressTimerTypeHorizontalBarLR;
    
    
    
    [ct runAction:timerAction];
    
    
    [Util modifyPng:building.png  andLevel:[[NSNumber alloc] initWithInt:building.level]  ByKey:building.key]; //bug
    
    
    
    
}




-(void)deleteWrench:(id)sender //删除扳手
{
    
    
    NSLog(@"deleteWrench");
    CCSprite *delete = (CCSprite *)sender;
    int key = delete.tag;
    NSLog(@"key :%d",key);
    Building *tempBuilding;
    for (Building *building  in buildings)
    {
        if(building.key == key)
        {
            tempBuilding =building;
        }
    }
    
    
    
    CCParticleSystem *systerm=[CCParticleGalaxy node];
    systerm.position=tempBuilding.BuildSprite.position;
    systerm.contentSize=CGSizeMake(50,50);
    systerm.duration=0.5f;
    [self addChild: systerm z:2];
    CCSprite *levelOfbuilding=[CCSprite spriteWithFile:@"level1.png"];
    levelOfbuilding.position=ccp(tempBuilding.BuildSprite.position.x+20, tempBuilding.BuildSprite.position.y-30);
    [self addChild:levelOfbuilding z:2 tag:key];
    [self removeChild:sender cleanup:YES];
    
    
    [self removeChildByTag:key+500 cleanup:YES];
    
    
    
}
-(void)saveToServer:(CGPoint *)point withPng:(NSString *)png
{
    NSLog(@"invoke");
    
    NSNumber *myx = [NSNumber numberWithFloat:point->x];
    NSNumber *myy = [NSNumber numberWithFloat:point->y];
    
    
    
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            name, @"username",
                            channel, @"rid",
                            myx, @"pointx",
                            myy, @"pointy",
                            png,@"png",
                            @"military",@"category",
                            nil];
   /* [Pomelo requestWithRoute:@"connector.entryHandler.addArchitecture" andParams:params andCallback:^(NSDictionary *result)
    {
        NSArray *userList = [result objectForKey:@"users"];
        for (NSString *name2 in userList) {
            NSLog(@"%@",name2);
            
            
        }
        
    }];
    */
    
    
    
}

-(void)delete:(id)sender  //删除建筑
{
    [Util playClickSound];
    CCMenuItemFont *item =(CCMenuItemFont*) sender;
    int key = item.tag;
    [self removeChildByTag:103 cleanup:YES];
    
    for (Building *building  in buildings)
    {
        if(building.key == key)
        {
            CGPoint tempxy = building.BuildSprite.position;
            
            //删除
            // [buildings removeObject:building];
            [self removeChild:building.BuildSprite cleanup:YES];
            
            //配置
            building.png =@"tags.png";
            building.level = 0;
            building.BuildSprite =[CCSprite spriteWithFile:@"tags.png"];
            building.BuildSprite.position =tempxy;
            //添加
            // [buildings addObject:building];
            [self addChild:building.BuildSprite z:2];
            
            
            [self removeChildByTag:building.key cleanup:YES];
            
            //plist操作
            [Util modifyPng:building.png andLevel:[[NSNumber alloc] initWithInt:building.level]  ByKey:building.key];
            
        }
        
    }
}
-(void)upgrade:(id)sender  //升级建筑
{
    [Util playClickSound];
    //删除面板
    [self removeChildByTag:103 cleanup:YES];
    
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
    CCParticleSystem *systerm=[CCParticleGalaxy node];
    systerm.position=tempBuilding.BuildSprite.position;
    systerm.contentSize=CGSizeMake(50,50);
    systerm.duration=0.5f;
    [self addChild: systerm z:2];
    if (tempBuilding.level>=18) {
        tempBuilding.level=18;
    }
    
    [self removeChildByTag:tempBuilding.key cleanup:YES];
    
    CCSprite *levelOfbuilding=[CCSprite spriteWithFile:[NSString stringWithFormat:@"level%d.png",tempBuilding.level]];
    levelOfbuilding.tag=tempBuilding.key;
    levelOfbuilding.position=ccp(tempBuilding.BuildSprite.position.x+20, tempBuilding.BuildSprite.position.y-30);
    [self addChild:levelOfbuilding z:2];
    
    
}
-(void) event1:(UITapGestureRecognizer *)gesture
{
    [Util playClickSound];
    [self removeChildByTag:20 cleanup:YES];
    [self removeChildByTag:3 cleanup:YES];
    NSLog(@"invoke event1");
    
    for (Building *building  in buildings)
    {
        if(building.key == gesture.view.tag)
        {
            CGPoint tempxy = building.BuildSprite.position;
            
            //删除
            //[buildings removeObject:building];
            [self removeChild:building.BuildSprite cleanup:YES];
            NSLog(@"invoke event1 __if");
            //配置
            building.png =@"ipad_b9.png";
            building.level = 1;
            building.BuildSprite =[CCSprite spriteWithFile:@"ipad_b9.png"];
            NSLog(@"invoke event1 __if 1.1");
            building.BuildSprite.position =tempxy;
            NSLog(@"invoke event1 __if 1.2");
            NSLog(@"invoke event1 __if2");
            //添加
            //[buildings addObject:building];
            [self addChild:building.BuildSprite z:2];
            
            //plist操作
            [Util modifyPng:building.png andLevel:[[NSNumber alloc] initWithInt:building.level]  ByKey:building.key]; //bug
            
            
            NSLog(@"invoke  event1 __if3");
            
            
            
            [self rotateWrench:building];
        }
        
    }
    
    
}
-(void) event2:(UITapGestureRecognizer *)gesture
{
    [Util playClickSound];
    [self removeChildByTag:20 cleanup:YES];
    [self removeChildByTag:3 cleanup:YES];
    NSLog(@"invoke event1");
    
    for (Building *building  in buildings)
    {
        if(building.key == gesture.view.tag)
        {
            CGPoint tempxy = building.BuildSprite.position;
            
            //删除
            //[buildings removeObject:building];
            [self removeChild:building.BuildSprite cleanup:YES];
            NSLog(@"invoke event1 __if");
            //配置
            building.png =@"ipad_b15.png";
            building.level = 1;
            building.BuildSprite =[CCSprite spriteWithFile:@"ipad_b15.png"];
            NSLog(@"invoke event1 __if 1.1");
            building.BuildSprite.position =tempxy;
            NSLog(@"invoke event1 __if 1.2");
            NSLog(@"invoke event1 __if2");
            //添加
            //[buildings addObject:building];
            [self addChild:building.BuildSprite z:2];
            
            //plist操作
            [Util modifyPng:building.png andLevel:[[NSNumber alloc] initWithInt:building.level]  ByKey:building.key]; //bug
            
            
            NSLog(@"invoke  event1 __if3");
            
            
            
            [self rotateWrench:building];
        }
        
    }
    
}
-(void) event3:(UITapGestureRecognizer *)gesture
{
    [Util playClickSound];
    [self removeChildByTag:20 cleanup:YES];
    [self removeChildByTag:3 cleanup:YES];
    NSLog(@"invoke event1");
    
    for (Building *building  in buildings)
    {
        if(building.key == gesture.view.tag)
        {
            CGPoint tempxy = building.BuildSprite.position;
            
            //删除
            //[buildings removeObject:building];
            [self removeChild:building.BuildSprite cleanup:YES];
            NSLog(@"invoke event1 __if");
            //配置
            building.png =@"ipad_b12.png";
            building.level = 1;
            building.BuildSprite =[CCSprite spriteWithFile:@"ipad_b12.png"];
            NSLog(@"invoke event1 __if 1.1");
            building.BuildSprite.position =tempxy;
            NSLog(@"invoke event1 __if 1.2");
            NSLog(@"invoke event1 __if2");
            //添加
            //[buildings addObject:building];
            [self addChild:building.BuildSprite z:2];
            
            //plist操作
            [Util modifyPng:building.png andLevel:[[NSNumber alloc] initWithInt:building.level]  ByKey:building.key]; //bug
            
            
            NSLog(@"invoke  event1 __if3");
            
            
            
            [self rotateWrench:building];
        }
        
    }
    
}
-(void) event4:(UITapGestureRecognizer *)gesture
{
    [Util playClickSound];
    [self removeChildByTag:20 cleanup:YES];
    [self removeChildByTag:3 cleanup:YES];
    NSLog(@"invoke event1");
    
    for (Building *building  in buildings)
    {
        if(building.key == gesture.view.tag)
        {
            CGPoint tempxy = building.BuildSprite.position;
            
            //删除
            //[buildings removeObject:building];
            [self removeChild:building.BuildSprite cleanup:YES];
            
            //配置
            building.png =@"ipad_b18.png";
            building.level = 1;
            building.BuildSprite =[CCSprite spriteWithFile:@"ipad_b18.png"];
            NSLog(@"invoke event1 __if 1.1");
            building.BuildSprite.position =tempxy;
            
            //添加
            //[buildings addObject:building];
            [self addChild:building.BuildSprite z:2];
            
            //plist操作
            [Util modifyPng:building.png andLevel:[[NSNumber alloc] initWithInt:building.level]  ByKey:building.key]; //bug
            
            
            NSLog(@"invoke  event1 __if3");
            
            
            
            [self rotateWrench:building];
        }
        
    }
}
// on "dealloc" you need to release all your retained objects

-(void) initAddNumOfResource
{
    addFood=0;
    addOil=0;
    addOre=0;
    addSteel=0;
}


-(void) onExit
{
    
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super onExit];
    NSLog(@"invoke onExit4");
    
}
@end
