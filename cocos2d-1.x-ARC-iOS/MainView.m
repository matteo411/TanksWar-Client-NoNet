//
//  NavigationView.m
//  coco
//
//  Created by 陈 奕龙 on 13-3-20.
//
//

#import "MainView.h"
#import "MainScene.h"
@implementation MainView

-(void *)Navigation:(CCNode*) self1
{
    //添加右侧导航栏目
    NSLog(@"3");
    CGSize size = [[UIScreen mainScreen] bounds].size;
    //控制右侧导航的参数，参数越小导航越大
    int rightSize = 8;
    //控制节点个数的参数，参数改变影响每个节点的大小
    int nodecount=10;
    
    UIScrollView *scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(-10, 35,786,95)];
    //Y,X,宽度（|）,高度（——）
    scroll.backgroundColor=[UIColor  colorWithRed:1  green:1 blue:1 alpha:0];
    scroll.scrollEnabled = NO;
    scroll.directionalLockEnabled =NO;
    
    //设置背景
    
    UIImageView* bgview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"右侧导航条.png"]];
    bgview.frame = CGRectMake(600,0, scroll.frame.size.height, scroll.frame.size.width);
    bgview.transform = CGAffineTransformMakeRotation(M_PI*0.5);
    bgview.center=ccp(384,45);
    [scroll addSubview:bgview];
    
    // size.width/nodecount*(nodecount-1)。。。。。chenyl
    UIView *image1=[[UIView alloc] initWithFrame:CGRectMake( bgview.frame.size.width/nodecount*(nodecount-1), 9, bgview.frame.size.width/nodecount, bgview.frame.size.height-10)];
    image1.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    image1.layer.borderColor=[[UIColor colorWithRed:0 green:0 blue:0 alpha:0] CGColor];//[[UIColor whiteColor]CGColor];
    image1.layer.borderWidth=2;
    image1.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGestyre1=[[UITapGestureRecognizer alloc] initWithTarget:self1 action:@selector(sceneTransition:)];
    [image1 addGestureRecognizer:tapGestyre1];
    [scroll addSubview:image1];
    
//    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
//    label1.text = @"军事区";
//    [label1 setBackgroundColor:[UIColor clearColor]];
    
    
    UIImageView* label1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"军事区nav.png"]];
    label1.frame = CGRectMake(0, 0, 76, 83);
    
//    bgview.center=ccp(384,45);
    
    
    
    [image1 addSubview:label1];
    
    
    
    
    UIView *image2=[[UIView alloc] initWithFrame:CGRectMake(bgview.frame.size.width/nodecount*(nodecount-2), 9, bgview.frame.size.width/nodecount, bgview.frame.size.height-10)];
    image2.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    image2.layer.borderColor=[[UIColor colorWithRed:0 green:0 blue:0 alpha:0] CGColor];//[[UIColor whiteColor]CGColor];
    image2.layer.borderWidth=2;
    image2.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGestyre2=[[UITapGestureRecognizer alloc] initWithTarget:self1 action:@selector(sceneTransition2:)];
    [image2 addGestureRecognizer:tapGestyre2];
    [scroll addSubview:image2];
    
//    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
//    label2.text = @"资源区";
//    [label2 setBackgroundColor:[UIColor clearColor]];
    UIImageView* label2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"资源区nav.png"]];
    label2.frame = CGRectMake(0, 0, 76, 83);
    [image2 addSubview:label2];
    
    scroll.contentSize=CGSizeMake(scroll.frame.size.width+1, scroll.frame.size.height);//节点（内容）的大小
    CCUIViewWrapper *wrapper=[CCUIViewWrapper wrapperForUIView:scroll];
    wrapper.position=ccp(0,size.height/rightSize);
    [self1 addChild:wrapper z:4 tag:99];
    
}


@end
