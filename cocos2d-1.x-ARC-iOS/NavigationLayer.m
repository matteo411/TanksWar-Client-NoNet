//
//  NavigationLayer.m
//  coco
//
//  Created by 陈 奕龙 on 13-3-19.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "NavigationLayer.h"
#import "CCUIViewWrapper.h"
#import "SWScrollView.h"


@implementation NavigationLayer
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	NavigationLayer *layer = [NavigationLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    
	if( (self=[super init])) {
//        helloWorldLayer = [[HelloWorldLayer alloc]init];
//        resourceLabel = [[ResourceScene alloc]init];
        
        //添加右侧导航栏目
        CGSize size = [[UIScreen mainScreen] bounds].size;
        //控制右侧导航的参数，参数越小导航越大
        int rightSize = 8;
        //控制节点个数的参数，参数改变影响每个节点的大小
        int nodecount=10;
        
        NSLog(@"chenyl  %f,%f",size.width,size.height);//ipad模拟器因为是横的，所以 “|” 是宽 “——”是高
        
        // UIImageView *BGimage=[[UIImageView alloc]initWithImage:[UIImage  imageNamed:@"右侧导航条.png"]];
        
        UIScrollView *scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height/rightSize)];
        //Y,X,宽度（|）,高度（——）
        scroll.backgroundColor=[UIColor  colorWithRed:1  green:1 blue:1 alpha:0.5];
        //scroll.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"右侧导航条.png"]];
        //scroll.scrollEnabled = NO;
        scroll.directionalLockEnabled =NO;
       
        //设置背景
        
        UIImageView* bgview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"右侧导航条.png"]];
        bgview.frame = CGRectMake(0, 0, scroll.frame.size.width, scroll.frame.size.height);
        //bgview.transform = CGAffineTransformMakeRotation(135);
        [scroll addSubview:bgview];
               
        // size.width/nodecount*(nodecount-1)。。。。。chenyl
        UIView *image1=[[UIView alloc] initWithFrame:CGRectMake( scroll.frame.size.width/nodecount*(nodecount-1), 0, scroll.frame.size.width/nodecount, scroll.frame.size.height-1)];
        image1.backgroundColor=[UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        image1.layer.borderColor=[[UIColor whiteColor]CGColor];
        image1.layer.borderWidth=2;
        image1.userInteractionEnabled=YES;
        UITapGestureRecognizer *tapGestyre1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sceneTransition:)];
        [image1 addGestureRecognizer:tapGestyre1];
        [scroll addSubview:image1];
        
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        label1.text = @"军事区";
        [label1 setBackgroundColor:[UIColor clearColor]];
        [image1 addSubview:label1];
        
        
        
        
        UIView *image2=[[UIView alloc] initWithFrame:CGRectMake(scroll.frame.size.width/nodecount*(nodecount-2), 0, scroll.frame.size.width/nodecount, scroll.frame.size.height-1)];
        image2.backgroundColor=[UIColor colorWithRed:1 green:1 blue:0 alpha:1];
        image2.layer.borderColor=[[UIColor whiteColor]CGColor];
        image2.layer.borderWidth=2;
        image2.userInteractionEnabled=YES;
        UITapGestureRecognizer *tapGestyre2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sceneTransition2:)];
        [image2 addGestureRecognizer:tapGestyre2];
        [scroll addSubview:image2];
        
        UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        label2.text = @"资源区";
        [label2 setBackgroundColor:[UIColor clearColor]];
        [image2 addSubview:label2];
        
        
        
        
        //        CGPoint nodeSize=ccp(340,200);。。。。chenyl 不需要 （弹出代码）
        scroll.contentSize=CGSizeMake(scroll.frame.size.width+1, scroll.frame.size.height);//节点（内容）的大小
        CCUIViewWrapper *wrapper=[CCUIViewWrapper wrapperForUIView:scroll];
        
        
        
        
        
        wrapper.position=ccp(0,size.height/rightSize);
        
        [self addChild:wrapper z:4 tag:99];
        helloWorldLayer = [[HelloWorldLayer alloc]init];
        
        
        [self addChild:helloWorldLayer z:3 tag:97];
//        [self addChild:resourceLabel z:3 tag:98];
//        resourceLabel.isTouchEnabled=NO;
//        resourceLabel.visible=NO;
//        helloWorldLayer.visible=YES;
//        helloWorldLayer.isTouchEnabled=YES;
        
        
	}
	return self;
    
}

-(void)sceneTransition:(int)sender  //转换到军事区
{

    
    [self removeChildByTag:98 cleanup:NO];
    resourceLabel = [[ResourceScene alloc]init];
    [self addChild:resourceLabel z:3 tag:98];
  
//   
//     helloWorldLayer.isTouchEnabled=NO;
//    helloWorldLayer.visible=NO;
//    resourceLabel.isTouchEnabled=YES;
//    resourceLabel.visible=YES;
    

}

-(void)sceneTransition2:(int)sender
{

    [self removeChildByTag:97 cleanup:NO];
    helloWorldLayer = [[HelloWorldLayer alloc]init];
    [self addChild:helloWorldLayer z:3 tag:97];
    
//    resourceLabel.isTouchEnabled=NO;
//    resourceLabel.visible=NO;
//    
//    helloWorldLayer.isTouchEnabled=YES;
//    helloWorldLayer.visible=YES;

   
}

@end
