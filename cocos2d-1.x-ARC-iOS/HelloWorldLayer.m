//
//  HelloWorldLayer.m
//  War
//
//  Created by mq on 13-1-4.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//


// Import the interfaces
#import "SlidingMenuGrid.h"
#import "HelloWorldLayer.h"
#import<math.h>
#import "CCUIViewWrapper.h"
#import "SWScrollView.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer
@synthesize pomelo; 
@synthesize name;
@synthesize channel;
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
// on "init" you need to initialize your instance
-(id) init
{   // always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        //MyUIview *view=[[MyUIview alloc] initWithNibName:@"MyUIview" bundle:nil];
        //[[[CCDirector sharedDirector] openGLView] addSubview:view.view];
        tagSprites=[[NSMutableArray alloc] init];
        buildingSprites=[[NSMutableArray alloc] init];
        
        //  从文件中读取数据
        CCSpriteBatchNode *tags=[CCSpriteBatchNode batchNodeWithFile:@"tags.png" capacity:24];
        [self addChild:tags z:2 tag:TAG_TAG];
        NSString *filename=@"DataList.plist";
        NSDictionary *dict=[NSDictionary dictionaryWithContentsOfFile:[Util getActuralPath:filename]];
        NSArray *nodes=[dict objectForKey:@"nodes"];
        
        for (id node in nodes)//读取坐标点
        {
            int x=[[node objectForKey:@"x"]floatValue];
            int y=[[node objectForKey:@"y"]floatValue];
            CCSprite *s=[CCSprite spriteWithBatchNode:tags  rect:CGRectMake(0, 0, 64, 64)];
            [tags addChild:s ];
            [s setPosition:ccp(x,y)];
            
            [tagSprites addObject:s];
        }
   
        
        playerResource=[[Resources alloc] init];
        [playerResource initialazation];
        //CGSize size = [[CCDirector sharedDirector] winSize];
		// create and initialize a Label
		//CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];
        CCSprite *BackGround=[CCSprite spriteWithFile:@"map.png" rect:CGRectMake(0, 0, 1024, 768)];
        BackGround.anchorPoint=ccp(0, 0);
        [self addChild:BackGround z:1   tag:TAG_BACKGROUND  ];
        name = @"chenyl107";
        channel = @"junshi";
        
        
        if ([self initPomelo]) {
            [self connectToPomelo];
        }else{
            NSLog(@"pomelo初始化失败");
        }
        
        
        label=[CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(100, 100) alignment: UIViewAnimationCurveEaseIn fontName:@"Arial" fontSize:16];
        [label setString:[NSString stringWithFormat:@"石油：%i\n粮食：%i\n钢铁：%i\n锡矿：%i",playerResource.Fuel,playerResource.Crop,playerResource.Steel,playerResource.Xi]];
        label.position=ccp(120, 670);
        [self addChild:label z:2 tag:TAG__LABAl];
        [self schedule:@selector(update:)interval:2 ];
                [CCMenuItemFont setFontName:@"Marker Felt"];
        [CCMenuItemFont setFontSize:40  ];
        CCMenuItemFont *militaryArea=[CCMenuItemFont itemFromString:@"资源区" target:self selector:@selector(sceneTransition:) ];
    
        CCMenu *changeScene=[CCMenu menuWithItems:militaryArea, nil];
        [changeScene alignItemsHorizontally];
        [changeScene setPosition:ccp(930, 730)];
        [self addChild:changeScene z:2 tag:TAG__CHANGSCENE];
         [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        

	}
	return self;
 
}

//-(NSString*) getActuralPath:(NSString *) file//读取plist文件  确定tag坐标点
//{
//    NSArray *path=[file componentsSeparatedByString:@"."    ];
//    NSString *acturalPath=[[NSBundle mainBundle] pathForResource:[path objectAtIndex:0] ofType:[path objectAtIndex:1]];
//    return acturalPath;
//}
-(BOOL) initPomelo
{
    //初始化pomelo
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    pomelo = myDelegate.pomelo;
    if (pomelo != nil) {
        return TRUE;
    }else{
        return  FALSE;
    }
}
-(void)connectToPomelo
{
    //连接gate服务器得到分配的connect服务器
    
    [pomelo connectToHost:@"127.0.0.1" onPort:3014 withCallback:^(Pomelo *p){
        NSDictionary *params = [NSDictionary dictionaryWithObject:@"chenyl107" forKey:@"uid"];
        [pomelo requestWithRoute:@"gate.gateHandler.queryEntry" andParams:params andCallback:^(NSDictionary *result){
            
            [pomelo disconnectWithCallback:^(Pomelo *p){
                host = [result objectForKey:@"host"];
                port = [[result objectForKey:@"port"] intValue];
                
                //连接得到的connection服务器
                [pomelo connectToHost:host onPort:port withCallback:^(Pomelo *p){
                    
                    
                    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                            name, @"username",
                                            channel, @"rid",
                                            nil];
                    [p requestWithRoute:@"connector.entryHandler.enter" andParams:params andCallback:^(NSDictionary *result){
                        NSArray *userList = [result objectForKey:@"users"];
                        for (NSString *name1 in userList) {
                            NSLog(@"%@",name1);
                            //只是为了看一下该频道里有多少人，没啥用 可与去掉
                            
                            
                            NSDictionary *params2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                                     @"military", @"category",
                                                     nil];
                            [p requestWithRoute:@"connector.entryHandler.getArchitecture" andParams:params2 andCallback:^(NSDictionary* responseData){
                               
                                
                                resources = [responseData objectForKey:@"Resources"];
                                
                                int count = [resources count];
                                
                                for (int i=0; i<count; i++) {
                                    
                                    NSLog(@"chenyl1");
                                    NSDictionary *resource =[resources objectAtIndex:i];
                                    NSNumber *xx = [resource objectForKey:@"pointx"];
                                    NSNumber *yy = [resource objectForKey:@"pointy"];
                                    NSString *pngg = [resource objectForKey:@"png"];
                                    CGPoint thep = CGPointMake( [xx floatValue],  [yy floatValue]);
                                    
                                    for (CCSprite *sprite in tagSprites)
                                    {
                                        if(fabs([sprite position].x - thep.x)<1.0)
                                        {
                                            
                                            
                                            
                                            self.isTouchEnabled=YES;
                                            
                                            CCSprite *Build=[CCSprite spriteWithFile:pngg];
                                            
                                            [buildingSprites addObject:Build];
                                            
                                            Build.position=thep;
                                            
                                            [self addChild:Build z:3];
                                            
                                        }
                                    }
                                    
                                    
                                }
                                
                                
                                
                                
                            }];
                            
                            
                        }
                        
                    }];
                    
                    
                }];
            }];
        }];
    }];
    
    

}
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    
    
    CGPoint point;
    point=[self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:point];
    NSLog(@"%f",point.x);
    NSLog(@"%f",point.y);
    return TRUE;

}
-(void)selectSpriteForTouch:(CGPoint) point
{
    for (CCSprite *sprite in buildingSprites) {
        if (CGRectContainsPoint(sprite.boundingBox, point)) {
            selSprite=sprite;
            [self updateBuilding];
            return;
        }
    }
    for (CCSprite *sprite in tagSprites)
    {
        if (CGRectContainsPoint(sprite.boundingBox, point))
        {
            selSprite=sprite;
            [self ChoicePanel];
            return;
        }
    }
}
-(void)updateBuilding//升级建筑
{
    //self.isTouchEnabled=NO;
    [CCMenuItemFont setFontName:@"Marker Felt"];
    [CCMenuItemFont setFontSize:30];
    CCMenuItemFont  *Delete=[CCMenuItemFont itemFromString:@"拆除" target:self selector:@selector(delete:)];
    CCMenuItemFont *upGrade=[CCMenuItemFont itemFromString:@"升级" target:self selector:@selector(upgrade:)];
    CCMenu *menu=[CCMenu menuWithItems:Delete,upGrade,nil];
    [menu setPosition:ccp(selSprite.position.x+50, selSprite.position.y-50)];
    [menu alignItemsHorizontally];
    [self addChild:menu z:3 tag:TAG__UPDATEBUILD];
}
-(void) ChoicePanel//选择面板
{ 
    
   /* CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *Panel=[CCSprite spriteWithFile:@"panel.png"];
    Panel.position=ccp(size.width/2, size.height/2);
    [self addChild:Panel z:3 tag:TAG__PANEL];*/
    /*
    NSMutableArray *allItems=[[NSMutableArray alloc] init];
    CCSprite *firstmenu=[CCSprite spriteWithFile:@"农田menu.png"];
    CCSprite *firstSelmenu=[CCSprite spriteWithFile:@"农田.png"];
    CCSprite *secondmenu=[CCSprite spriteWithFile:@"石油厂menu.png"];
    CCSprite *secondSelmenu=[CCSprite spriteWithFile:@"石油厂.png"];
    CCSprite *thirdmenu=[CCSprite spriteWithFile:@"钢铁厂menu.png"];
    CCSprite *thirdSelmenu=[CCSprite spriteWithFile:@"钢铁厂.png"];
    CCSprite *forthmenu=[CCSprite spriteWithFile:@"稀矿场menu.png"];
    CCSprite *forthSelmenu=[CCSprite spriteWithFile:@"稀矿场.png"];
    CCMenuItemSprite    *menu1=[CCMenuItemSprite itemFromNormalSprite:firstmenu selectedSprite:firstSelmenu target:self selector:@selector(Choicemenu1:)];
    CCMenuItemSprite    *menu2=[CCMenuItemSprite itemFromNormalSprite:secondmenu selectedSprite:secondSelmenu target:self selector: @selector(Choicemenu2:)];
    CCMenuItemSprite     *menu3=[CCMenuItemSprite itemFromNormalSprite:thirdmenu selectedSprite:thirdSelmenu target:self selector:@selector(Choicemenu3:)   ];
    CCMenuItemSprite    *menu4=[CCMenuItemSprite itemFromNormalSprite:forthmenu selectedSprite:forthSelmenu target:self selector:@selector(Choicemenu4:)];
    menu1.tag=1001;
    menu2.tag=1002;
    menu3.tag=1003;
    menu4.tag=1004;
    [allItems addObject:menu1];
    [allItems addObject:menu2];
    [allItems addObject:menu3];
    [allItems addObject:menu4];
    SlidingMenuGrid *menugrid=[SlidingMenuGrid menuWithArray:allItems cols:1 rows:4 position:ccp(size.width/2,size.height/2) padding:CGPointMake(100, 100) verticalPaging:YES];
    menugrid.contentSize=CGSizeMake(100, 100);

    [self addChild:menugrid z:2 tag:1005];
     */
    
    UIScrollView *scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 340, 595)];
    scroll.backgroundColor=[UIColor  colorWithRed:1  green:1 blue:1 alpha:0];
    CGPoint nodeSize=ccp(340,595);
    int nodecount=4;
    //UIImage *image=[UIImage imageNamed:@"农田menu.png"];
    UIView *image1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 170, 595)];
    image1.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    image1.layer.borderColor=[[UIColor whiteColor]CGColor];
    image1.layer.borderWidth=2;
    image1.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGestyre1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event1: )];
    [image1 addGestureRecognizer:tapGestyre1];
    [scroll addSubview:image1];
    UIView *image2=[[UIView alloc] initWithFrame:CGRectMake(170, 0, 170, 595)];
    image2.backgroundColor=[UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    image2.layer.borderColor=[[UIColor whiteColor]CGColor];
    image2.layer.borderWidth=2;
    UITapGestureRecognizer *tapGestyre2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event2: )];
    [image2 addGestureRecognizer:tapGestyre2];
    [scroll addSubview:image2];
    UIView *image3=[[UIView alloc] initWithFrame:CGRectMake(340, 0, 170, 595)];
    image3.backgroundColor=[UIColor colorWithRed:0 green:1 blue:0 alpha:1];
    image3.layer.borderColor=[[UIColor whiteColor]CGColor];
    image3.layer.borderWidth=2;
    UITapGestureRecognizer *tapGestyre3=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event3: )];
    [image3 addGestureRecognizer:tapGestyre3];
    [scroll addSubview:image3];
    UIView *image4=[[UIView alloc] initWithFrame:CGRectMake(510, 0, 170   , 595)];
    image4.layer.borderColor=[[UIColor whiteColor]CGColor];
    image4.layer.borderWidth=2;
    image4.backgroundColor=[UIColor colorWithRed:0 green:0 blue:1 alpha:1];
    UITapGestureRecognizer *tapGestyre4=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event4: )];
    [image4 addGestureRecognizer:tapGestyre4];
    [scroll addSubview:image4];
    scroll.contentSize=CGSizeMake(nodeSize.x*2, nodeSize.y);
    CCUIViewWrapper *wrapper=[CCUIViewWrapper wrapperForUIView:scroll];
    wrapper.position=ccp(185,809);
    [self addChild:wrapper z:4 tag:20];
 /*  CCUIViewWrapper *menu1=[CCUIViewWrapper wrapperForUIView:image1];
    CCUIViewWrapper *menu2=[CCUIViewWrapper wrapperForUIView:image2];
    CCUIViewWrapper *menu3=[CCUIViewWrapper wrapperForUIView:image3];
    CCUIViewWrapper *menu4=[CCUIViewWrapper wrapperForUIView:image4];
    CCMenuItemSprite *Menu1=[CCMenuItemSprite itemFromNormalSprite:menu1 selectedSprite:nil target:self selector:@selector(Choicemenu1:)];
     CCMenuItemSprite *Menu2=[CCMenuItemSprite itemFromNormalSprite:menu2 selectedSprite:nil target:self selector:@selector(Choicemenu2:)];
     CCMenuItemSprite *Menu3=[CCMenuItemSprite itemFromNormalSprite:menu3 selectedSprite:nil target:self selector:@selector(Choicemenu3:)];
     CCMenuItemSprite *Menu4=[CCMenuItemSprite itemFromNormalSprite:menu4 selectedSprite:nil target:self selector:@selector(Choicemenu4:)];
    */
    /*
    CCSprite *Menu1=[CCSprite spriteWithFile:@"农田menu.png"];
    CCSprite *Menu2=[CCSprite spriteWithFile:@"石油厂menu.png"];
    CCSprite *Menu3=[CCSprite spriteWithFile:@"钢铁厂menu.png"];
    CCSprite *Menu4=[CCSprite spriteWithFile:@"稀矿场menu.png"];
    CCMenuItemSprite *menu1=[CCMenuItemSprite itemFromNormalSprite:Menu1 selectedSprite:nil target:self selector:@selector(Choicemenu1:)];
    CCMenuItemSprite *menu2=[CCMenuItemSprite itemFromNormalSprite:Menu2 selectedSprite:nil target:self selector:@selector(Choicemenu2:)];
    CCMenuItemSprite *menu3=[CCMenuItemSprite itemFromNormalSprite:Menu3 selectedSprite:nil target:self selector:@selector(Choicemenu3:)];
    CCMenuItemSprite *menu4=[CCMenuItemSprite itemFromNormalSprite:Menu4 selectedSprite:nil target:self selector:@selector(Choicemenu4:)];
   
    CCMenu *menu=[CCMenu menuWithItems:menu1,menu2,menu3,menu4,nil];
    [menu alignItemsVerticallyWithPadding:-20];
    [menu setPosition:ccp(7*size.width/24, 9*size.height/20)];
    [self addChild:menu z:4 tag:TAG__CHOICEMENU];
     */
}
-(void)Choicemenu1:sender
{
    [self removeChildByTag:4 cleanup:YES];
    [self removeChildByTag:3 cleanup:YES];
    self.isTouchEnabled=YES;
    CCSprite *Build=[CCSprite spriteWithFile:@"农田.png"];
    [buildingSprites addObject:Build];
    Build.position=selSprite.position;
    [self addChild:Build z:2];
   [self rotateWrench];
    
    CGPoint myp = Build.position;
    [self saveToServer:&myp withPng:@"农田.png"];
    
    
}
-(void)Choicemenu2:sender
{
    [self removeChildByTag:4 cleanup:YES];
    [self removeChildByTag:3 cleanup:YES];
    self.isTouchEnabled=YES;
    CCSprite *Build=[CCSprite spriteWithFile:@"石油厂.png"];
    [buildingSprites addObject:Build];
    Build.position=selSprite.position;
    [self addChild:Build z:2];
    [self rotateWrench];
    
    CGPoint myp = Build.position;
    [self saveToServer:&myp withPng:@"石油厂.png"];
    
}
-(void)Choicemenu3:sender
{
    [self removeChildByTag:4 cleanup:YES];
    [self removeChildByTag:3 cleanup:YES];
    self.isTouchEnabled=YES;
    CCSprite *Build=[CCSprite spriteWithFile:@"钢铁厂.png"];
    [buildingSprites addObject:Build];
    Build.position=selSprite.position;
    [self addChild:Build z:2];
    [self rotateWrench];
    
    CGPoint myp = Build.position;
    [self saveToServer:&myp withPng:@"钢铁厂.png"];
    
    
}
-(void)Choicemenu4:sender
{
    [self removeChildByTag:4 cleanup:YES];
    [self removeChildByTag:3 cleanup:YES];
    self.isTouchEnabled=YES;
    CCSprite *Build=[CCSprite spriteWithFile:@"稀矿场.png"];
    [buildingSprites addObject:Build];
    Build.position=selSprite.position;
    [self addChild:Build z:2];
    [self rotateWrench];
    
    CGPoint myp = Build.position;
    [self saveToServer:&myp withPng:@"稀矿场.png"];
    
    
}
-(void)rotateWrench//转动扳手
{
    CCSprite *wrench=[CCSprite spriteWithFile:@"wrench.png"];
    wrench.position=ccp(selSprite.position.x-40, selSprite.position.y+40);
    [self addChild:wrench z:2 tag:19 ];
    
    CCAction *rotate1=[CCRotateBy actionWithDuration:0.5 angle:60];
    CCAction *rotate2=[CCRotateBy actionWithDuration:0.5 angle:-60];
    CCAction *repeat=[CCRepeat actionWithAction:[CCSequence actions:rotate1,rotate2 ,nil] times:10];
    CCAction *delete=[CCCallFuncN actionWithTarget:self selector:@selector(deleteWrench:)];
    [wrench runAction:[CCSequence actions:repeat,delete, nil]];
    
}
-(void)deleteWrench:(id)sender //删除扳手
{
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
    [self removeChildByTag:103 cleanup:YES];
    [self removeChild:selSprite  cleanup:YES];
    [buildingSprites removeObject:selSprite ];
    
}
-(void)upgrade:(id)sender  //升级建筑
{
    [self removeChildByTag:103 cleanup:YES];
    //[self removeChild:selSprite cleanup:YES];
}
-(void)sceneTransition:(id)sender  //转换到军事区
{
     UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Do you sure you want to leave?" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes" ,@"No", nil];
    [alert show];
                                                                                           
   
}
-(void)alertView:(UIAlertView*)actionsheet //uikit 的应用 （试验）  弹出提示按钮
   clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
    }
    else if (buttonIndex==1) {
        CCTransitionFade *tran=[CCTransitionFade transitionWithDuration:2 scene:[ResourceScene scene] withColor:ccWHITE];
        [[CCDirector sharedDirector] replaceScene:tran];
    }
    else{
        
    }
}

-(void)update:(ccTime)delta
{
    [playerResource setCrop:50];
    [playerResource setFuel:50];
   [playerResource setSteel:50];
    [playerResource setXi:50];
    [label setString:[NSString stringWithFormat:@"石油：%i\n粮食：%i\n钢铁：%i\n锡矿：%i",playerResource.Fuel,playerResource.Crop,playerResource.Steel,playerResource.Xi]];

}
-(void) event1:(UITapGestureRecognizer *)gesture
{
    [self removeChildByTag:20 cleanup:YES];
    //[self removeChildByTag:3 cleanup:YES];
    self.isTouchEnabled=YES;
    CCSprite *Build=[CCSprite spriteWithFile:@"农田.png"];
    [buildingSprites addObject:Build];
    Build.position=selSprite.position;
    [self addChild:Build z:2];
    [self rotateWrench];
    
    CGPoint myp = Build.position;
    [self saveToServer:&myp withPng:@"农田.png"];
}
-(void) event2:(UITapGestureRecognizer *)gesture
{
    [self removeChildByTag:20 cleanup:YES];
    [self removeChildByTag:3 cleanup:YES];
    self.isTouchEnabled=YES;
    CCSprite *Build=[CCSprite spriteWithFile:@"石油厂.png"];
    [buildingSprites addObject:Build];
    Build.position=selSprite.position;
    [self addChild:Build z:2];
    [self rotateWrench];
    
    CGPoint myp = Build.position;
    [self saveToServer:&myp withPng:@"石油厂.png"];
}
-(void) event3:(UITapGestureRecognizer *)gesture
{
    [self removeChildByTag:20 cleanup:YES];
    [self removeChildByTag:3 cleanup:YES];
    self.isTouchEnabled=YES;
    CCSprite *Build=[CCSprite spriteWithFile:@"钢铁厂.png"];
    [buildingSprites addObject:Build];
    Build.position=selSprite.position;
    [self addChild:Build z:2];
    [self rotateWrench];
    
    CGPoint myp = Build.position;
    [self saveToServer:&myp withPng:@"钢铁厂.png"];
    
}
-(void) event4:(UITapGestureRecognizer *)gesture
{
    [self removeChildByTag:20 cleanup:YES];
    [self removeChildByTag:3 cleanup:YES];
    self.isTouchEnabled=YES;
    CCSprite *Build=[CCSprite spriteWithFile:@"稀矿场.png"];
    [buildingSprites addObject:Build];
    Build.position=selSprite.position;
    [self addChild:Build z:2];
    [self rotateWrench];
    
    CGPoint myp = Build.position;
    [self saveToServer:&myp withPng:@"稀矿场.png"];
}
// on "dealloc" you need to release all your retained objects







@end
