//
//  HelloWorldLayer.m
//  War
//
//  Created by mq on 13-1-4.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//


// Import the interfaces
#import "SlidingMenuGrid.h"
#import "MilitaryController.h"
#import <math.h>
#import "CCUIViewWrapper.h"
#import "SWScrollView.h"
#import "Building.h"
// HelloWorldLayer implementation
@implementation MilitaryController
@synthesize pomelo; 
@synthesize name;
@synthesize channel;
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MilitaryController *layer = [MilitaryController node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{   
	if( (self=[super init])) {
        
        buildings=[[NSMutableArray alloc] init];
       
        //初始化tags
//        CCSpriteBatchNode *tags=[CCSpriteBatchNode batchNodeWithFile:@"tags.png" capacity:24];
        
        
        //从文件中读取数据并添加到tags和tagSprites

//        NSString *filename=@"DataList.plist";
//        NSDictionary *dict=[NSDictionary dictionaryWithContentsOfFile:[Util getActuralPath:filename]];
//        NSArray *nodes=[dict objectForKey:@"nodes"];
        
        NSArray *nodes = [Util getNodelistByNodeName:@"nodes"];
        NSLog(@"invoke10");
        for (NSMutableDictionary* node in nodes)//读取坐标点
        {
//            NSLog(@"%@",node);
            Building *building=[[Building alloc]init];
            NSString* png = [node objectForKey:@"png"];
            NSLog(@"png=%@",png);
             NSLog(@"invoke10.4");
            building.BuildSprite=[CCSprite spriteWithFile:png ];//mark!!!
            NSLog(@"invoke10.5");
            building.BuildSprite.position = ccp([[node objectForKey:@"x"]floatValue],[[node objectForKey:@"y"]floatValue]);
            building.key =[[node objectForKey:@"key"] intValue];
            building.level=[[node objectForKey:@"level"] intValue];
            building.png =png;
            [buildings addObject:building];
            
            [self addChild:building.BuildSprite z:2];
        }
        NSLog(@"invoke11");
        
        //玩家资源
        playerResource=[[Resources alloc] init];
        [playerResource initialize];

        CCSprite *BackGround=[CCSprite spriteWithFile:@"ipad_reszonebkg.png" rect:CGRectMake(0, 0, 1024, 768)];
        BackGround.anchorPoint=ccp(0, 0);
        [self addChild:BackGround z:1   tag:0  ];//添加背景图
        
        [self initAddNumOfResource];

        [self addLabel];
        //初始化资源
       
//资源的计算
      
        
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];//触摸代理 

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
    [labelOfFood setString:[NSString stringWithFormat:@"%i",playerResource.Food]];
    labelOfFood.position=ccp(200, 700);
    [self addChild:labelOfFood z:3 tag:101];
    [labelOfFood setColor:ccRED];
    
    labelOfOil=[CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(150, 100)  alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:20];
    [labelOfOil setString:[NSString stringWithFormat:@"%i",playerResource.Oil]];
    labelOfOil.position=ccp(400, 700);
    [labelOfOil setColor:ccRED];
    [self addChild:labelOfOil z:3 tag:101];
    
    labelOfSteel=[CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(150, 100) alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:20];
    [labelOfSteel setString:[NSString stringWithFormat:@"%i",playerResource.Steel]];
    labelOfSteel.position=ccp(600, 700);
    [labelOfSteel setColor:ccRED];
    [self addChild:labelOfSteel z:3 tag:101];
    
    labelOfOre=[CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(150, 100) alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:20];
    [labelOfOre setString:[NSString stringWithFormat:@"%i",playerResource.Ore]];
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
    [labelOfOil setString:[NSString stringWithFormat:@"%i",playerResource.Oil]];
    [labelOfFood setString:[NSString stringWithFormat:@"%i",playerResource.Food]];
    [labelOfSteel setString:[NSString stringWithFormat:@"%i",playerResource.Steel]];
    [labelOfOre setString:[NSString stringWithFormat:@"%i",playerResource.Ore]];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint point;
    point=[self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:point];
    return TRUE;//
}
-(void)selectSpriteForTouch:(CGPoint) point
{
    
     //NSLog(@"point:%f,%f",point.x,point.y);
    for (Building *building  in buildings) {
        if (CGRectContainsPoint(building.BuildSprite.boundingBox, point))
        {
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
    CCMenuItemFont  *Delete=[CCMenuItemFont itemFromString:@"拆除" target:self selector:@selector(delete:)];
    CCMenuItemFont *upGrade=[CCMenuItemFont itemFromString:@"升级" target:self selector:@selector(upgrade:)];
    Delete.tag= upGrade.tag = building.key;
    
    CCMenu *menu=[CCMenu menuWithItems:Delete,upGrade,nil];
    [menu setPosition:ccp(building.BuildSprite.position.x+50, building.BuildSprite.position.y-50)];
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

    
    label.text=@"介绍dhaskdjaslkdjlfhkdashfkjasdhfkjhaiuefhlkajfilehfaehfleifhkadfhaskfdb";   //设置label所显示的文本
    
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
    
    //plist操作
    NSLog(@"before modifyPng" );
    [Util modifyPng:building.png ByKey:building.key]; //bug
    
    
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
        [pomelo requestWithRoute:@"connector.entryHandler.addArchitecture" andParams:params andCallback:^(NSDictionary *result){
            NSArray *userList = [result objectForKey:@"users"];
            for (NSString *name2 in userList) {
                NSLog(@"%@",name2);
                
                
            }
            
        }];


    
    
}

-(void)delete:(id)sender  //删除建筑
{
    
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
            [Util modifyPng:building.png ByKey:building.key];
            
        }
        
    }       
}
-(void)upgrade:(id)sender  //升级建筑
{
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
            
            
            
            
            NSLog(@"invoke  event1 __if3");
           
            
            
            [self rotateWrench:building];
        }
    
    }
    
  
}
-(void) event2:(UITapGestureRecognizer *)gesture
{
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
            
            
            
            
            NSLog(@"invoke  event1 __if3");
            
            
            
            [self rotateWrench:building];
        }
        
    }

}
-(void) event3:(UITapGestureRecognizer *)gesture
{
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
            
           
            
            
            NSLog(@"invoke  event1 __if3");
            
            
            
            [self rotateWrench:building];
        }
        
    }
    
}
-(void) event4:(UITapGestureRecognizer *)gesture
{
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





@end
