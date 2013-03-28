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
        
       
        
        countDownLabel=[[NSMutableArray alloc]init];
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
            
            //初始化建筑等级
            if(building.level >0)
            {
            CCSprite *levelOfbuilding=[CCSprite spriteWithFile:[NSString stringWithFormat:@"level%d.png",building.level]];
            levelOfbuilding.tag=building.key;
            levelOfbuilding.position=ccp(building.BuildSprite.position.x+20, building.BuildSprite.position.y-30);
            [self addChild:levelOfbuilding z:2];
            }
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
      
        
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
      //self.isTouchEnabled=YES;第二种触摸方法（可以以后实现）-
        
        CCSprite *topTable=[CCSprite spriteWithFile:@"ipad_helpup.png"];
        topTable.position=ccp(500,750);
          topTable.opacity=150;
        [self addChild:topTable z:2];
        [self schedule:@selector(countDownLabelupDate) interval:1];
        
        
	} 
	return self;
 
}

-(void)addLabel//加上最上面的资源显示栏
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

-(void)updateLabel:(ccTime)delta//资源栏数值更新
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

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event//触摸方法
{
   
    CGPoint point;
    point=[self convertTouchToNodeSpace:touch];
    NSLog(@"%f,%f",point.x,point.y);
    [self selectSpriteForTouch:point];
    return TRUE;//
}

-(void)selectSpriteForTouch:(CGPoint) point//选择触摸点
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
    
}

-(void)armoryHandle:(Building*) building//军事管理菜单
{

    NSLog(@"armoryHandle");
    [CCMenuItemFont setFontName:@"Marker Felt"];
    [CCMenuItemFont setFontSize:20];
    CCMenuItemFont *Control=[CCMenuItemFont itemFromString:@"管理" target:self selector:@selector(control:)];
    CCMenuItemFont  *Delete=[CCMenuItemFont itemFromString:@"拆除" target:self selector:@selector(delete:)];
    CCMenuItemFont *upGrade=[CCMenuItemFont itemFromString:@"升级" target:self selector:@selector(upgrade:)];
    
    Delete.tag= upGrade.tag = building.key;
    
    CCMenu *menu=[CCMenu menuWithItems: Control,Delete,upGrade,nil];
    [menu setPosition:ccp(building.BuildSprite.position.x+50, building.BuildSprite.position.y-50)];
    [menu alignItemsHorizontally];
    [self addChild:menu z:3 tag:103];
}

-(void)control:(id)sender//军事区造兵面板
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
    NSLog(@"chenyl");
    CCLabelTTF *Back=[CCLabelTTF labelWithString:@"查看" dimensions:CGSizeMake(100, 50) alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:20];
    CCLabelTTF *Confirm=[CCLabelTTF labelWithString:@"返回" dimensions:CGSizeMake(100, 50) alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:20];
    CCMenuItemLabel *menu10=[CCMenuItemLabel itemWithLabel:Back target:self selector:@selector(GoToArmyPanel)];
    CCMenuItemLabel *menu11=[CCMenuItemLabel itemWithLabel:Confirm target:self selector:@selector(backToMilitoryZone)];
    CCMenu *menu=[CCMenu menuWithItems:menu10, menu11,nil];
    [menu alignItemsHorizontallyWithPadding:0];
    
    [menu setPosition:CGPointMake(400,550)];
    [self addChild:menu z:3 tag:202 ];

}
-(void)backToMilitoryZone//从军事区面板回到军事区
{
    [self removeChildByTag:3 cleanup:NO];
    [self removeChildByTag:20 cleanup:NO];
    [self removeChildByTag:202 cleanup:YES];
    
    
}

-(void)GoToArmyPanel//显示兵力菜单（未完成）
{
    CCNode *node=[self getChildByTag:20];
    node.visible=NO;
    
    CCNode *wrapper=[self getChildByTag:20];
    wrapper.visible=NO;
    armyLayer.visible=YES;
    
}
   
-(void)trainSoldier:(UITapGestureRecognizer *)gesture//训练士兵面板
{
    NSLog(@"trainsoldier1");
    //ccmenu  返回  和叉掉
    
    CCNode *wrapper=[self getChildByTag:20];
    wrapper.visible=NO;
    CCLayer *node=[[CCLayer alloc] init];
    node.tag=200;
    
    NSLog(@"trainsoldier1.3");

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
    
    
    CCLabelTTF *labelofFoodonMenu,*labelOfOilonMenu,*labelOfOreonMenu,*labelOfSteelonMenu;
    labelofFoodonMenu=[CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(80, 50) alignment:UIAlertViewStyleDefault fontName:@"Arial" fontSize:14];
    [labelofFoodonMenu setString:@":50"];
    labelofFoodonMenu.position=ccp(460, 335);
    [node addChild:labelofFoodonMenu    ];
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
    NSLog(@"trainsoldier2");
    
    UISlider *slider=[[UISlider alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    slider.minimumValue=0;
    slider.maximumValue=20;
    slider.value=0;
    slider.backgroundColor=[UIColor clearColor];
    [slider addTarget:self action:@selector(sliderChangeValue:) forControlEvents:UIControlEventValueChanged];
    
     CCUIViewWrapper *wrapper1=[CCUIViewWrapper wrapperForUIView:slider];
    
    [wrapper1 setRotation:90];
    wrapper1.position=ccp(330, 600);
    [node addChild:wrapper1];
   
    //[node addChild:wrapper2];
    [self addChild:node z:3];
    NSLog(@"trainsoldier3");

    
}

-(IBAction)sliderChangeValue:(id)sender//滑动改变兵力值
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
    
    textView.text=[NSString stringWithFormat:@"%d", (int)slider.value];
    trainNum=sliderValue;
    [self addChild:wrapper2 z:3 tag:205];

    
}

-(void)BacktTo:(id)sender//返回到造兵面板
{
    [self removeChildByTag:200 cleanup:NO];
    CCNode *wrapper=[self getChildByTag:20];
    [self removeChildByTag:205 cleanup:NO];
    wrapper.visible=YES;
    
}

-(void)Confirm:(id)sender//训练确认
{
    [self removeChildByTag:200 cleanup:NO];
    CCNode *wrapper=[self getChildByTag:20];
    [self removeChildByTag:205 cleanup:YES];
    
    wrapper.visible=YES;
    NSLog(@"train:%d",playerResource.Oil);
    [playerResource setFood:-50*trainNum];
    [playerResource setOil:-50*trainNum];
    [playerResource  setSteel:-50*trainNum ];
    [playerResource setOre:-50*trainNum];
    NSLog(@"train:%d",playerResource.Oil);
    [self deleteResource];
    
}

-(void)buildingHandle:(Building *) building//普通建筑管理
{
   
    
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
    

    UIImage *menu1=[UIImage imageNamed:@"armory_item.png"];

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

-(void)rotateWrench:(Building *) building//转动扳手  加入进度条  加入倒计时器
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
    
    int buildtime=5;
    
    [ct runAction:timerAction];
    
    NSNumber* buildingLevel = [[NSNumber alloc] initWithInt:building.level];
    [Util modifyPng:building.png andLevel:buildingLevel  ByKey:building.key]; //bug
    
    CCLabelTTF *countDown=[CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(80, 40) alignment:UITextAlignmentLeft fontName:@"Arial" fontSize:24];
    [countDown setString:[NSString stringWithFormat: @"%.2d:%.2d",buildtime/60,buildtime%60]];
    [countDownLabel addObject:countDown];
    countDown.color=ccRED;
    countDown.position=ccp(850, 650-countDownLabel.count*40);
    [self addChild:countDown z:2 tag:buildtime+5000];
    
    
    
}
-(void)countDownLabelupDate
{
    
    NSLog(@"hello label1");
    
    for (int num=countDownLabel.count; num>=1; num--)
    {
        NSLog(@"hello label2  %d",num);
        CCLabelTTF *countDown=[countDownLabel objectAtIndex:num-1];
        NSLog(@"hello label3");
        countDown.tag--;
        NSLog(@"hello label4");
        [countDown setString:[NSString stringWithFormat:@"%.2d:%.2d",(countDown.tag-5000)/60,(countDown.tag-5000)%60]];
         NSLog(@"hello label5");
        if (countDown.tag==5000) {
            [countDownLabel removeObjectAtIndex:num-1];
            [self removeChild:countDown cleanup:YES];
        }
    }
}

-(void)updateTimer:(id) sender{
    NSLog(@"invoke updateTimer");

    CCNode *temp=(CCNode *) sender;
    int tempKey=temp.tag;
    Building *tempBuilding;
    for (Building *building  in buildings)
    {
        if(building.key == tempKey)
        {
            tempBuilding =building;
        }
    }

    NSLog(@"key:%d",tempKey );
    NSLog(@"invoke updateTimer");
    CCProgressTimer* ct=(CCProgressTimer*)[self getChildByTag:tempBuilding.key+500];
    ct.percentage= ct.percentage+20;
    if (ct.percentage >=100) {
        [self unschedule:@selector(updateTimer:)];
        [self removeChild:ct cleanup:YES];
       
    }
    
    
    
   
}//进度条控制

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
            NSNumber* buildingLevel = [[NSNumber alloc] initWithInt:building.level];
            [Util modifyPng:building.png andLevel: buildingLevel ByKey:building.key];
            
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
            building.png =@"armory.png";
            building.level = 1;
            building.BuildSprite =[CCSprite spriteWithFile:@"armory.png"];
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


-(void) initAddNumOfResource//资源增加变量
{
    addFood=100;
    addOil=100;
    addOre=100;
    addSteel=100;
}

-(void)deleteResource
{
    [labelOfOil setString:[NSString stringWithFormat:@"%i",playerResource.Oil]];
    [labelOfFood setString:[NSString stringWithFormat:@"%i",playerResource.Food]];
    [labelOfSteel setString:[NSString stringWithFormat:@"%i",playerResource.Steel]];
    [labelOfOre setString:[NSString stringWithFormat:@"%i",playerResource.Ore]];
}




@end
