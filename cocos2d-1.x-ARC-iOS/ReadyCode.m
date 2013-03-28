//
//  ReadyCode.m
//  coco
//
//  Created by 陈 奕龙 on 13-3-20.
//
//

#import "ReadyCode.h"

@implementation ReadyCode

//                  不要删除，等前后端整合时候有用
//-(BOOL) initPomelo
//{
//    //初始化pomelo
//    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
//    pomelo = myDelegate.pomelo;
//    if (pomelo != nil) {
//        return TRUE;
//    }else{
//        return  FALSE;
//    }
//}
//-(void)connectToPomelo
//{
//    //连接gate服务器得到分配的connect服务器
//
//    [pomelo connectToHost:@"127.0.0.1" onPort:3014 withCallback:^(Pomelo *p){
//        NSDictionary *params = [NSDictionary dictionaryWithObject:@"chenyl107" forKey:@"uid"];
//        [pomelo requestWithRoute:@"gate.gateHandler.queryEntry" andParams:params andCallback:^(NSDictionary *result){
//
//            [pomelo disconnectWithCallback:^(Pomelo *p){
//                host = [result objectForKey:@"host"];
//                port = [[result objectForKey:@"port"] intValue];
//
//                //连接得到的connection服务器
//                [pomelo connectToHost:host onPort:port withCallback:^(Pomelo *p){
//
//
//                    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                                            name, @"username",
//                                            channel, @"rid",
//                                            nil];
//                    [p requestWithRoute:@"connector.entryHandler.enter" andParams:params andCallback:^(NSDictionary *result){
//                        NSArray *userList = [result objectForKey:@"users"];
//                        for (NSString *name1 in userList) {
//                            NSLog(@"%@",name1);
//                            //只是为了看一下该频道里有多少人，没啥用 可与去掉
//
//
//                            NSDictionary *params2 = [NSDictionary dictionaryWithObjectsAndKeys:
//                                                     @"military", @"category",
//                                                     nil];
//                            [p requestWithRoute:@"connector.entryHandler.getArchitecture" andParams:params2 andCallback:^(NSDictionary* responseData){
//
//
//                                resources = [responseData objectForKey:@"Resources"];
//
//                                int count = [resources count];
//
//                                for (int i=0; i<count; i++) {
//
//                                    NSLog(@"chenyl1");
//                                    NSDictionary *resource =[resources objectAtIndex:i];
//                                    NSNumber *xx = [resource objectForKey:@"pointx"];
//                                    NSNumber *yy = [resource objectForKey:@"pointy"];
//                                    NSString *pngg = [resource objectForKey:@"png"];
//                                    CGPoint thep = CGPointMake( [xx floatValue],  [yy floatValue]);
//
//                                    for (CCSprite *sprite in tagSprites)
//                                    {
//                                        if(fabs([sprite position].x - thep.x)<1.0)
//                                        {
//
//
//
//                                            self.isTouchEnabled=YES;
//
//                                            CCSprite *Build=[CCSprite spriteWithFile:pngg];
//
//                                            [buildingSprites addObject:Build];
//
//                                            Build.position=thep;
//
//                                            [self addChild:Build z:3];
//
//                                        }
//                                    }
//
//
//                                }
//
//
//
//
//                            }];
//
//
//                        }
//
//                    }];
//
//
//                }];
//            }];
//        }];
//    }];
//
//
//
//}



//        name = @"chenyl107";
//        channel = @"junshi";


//        if ([self initPomelo]) {
//            [self connectToPomelo];
//        }else{
//            NSLog(@"pomelo初始化失败");
//        }


//static int TAG_TAG=100;
//static int TAG_BACKGROUND=0;
//static int TAG__LABAl=101;
//static int TAG__CHANGSCENE=102;
//static int  TAG__UPDATEBUILD=103;
//static int TAG__PANEL=3;
//static int TAG__CHOICEMENU=4;


////connection服务器的host
//NSString *host;
////connection服务器的port
//NSInteger port;
////当前用户的用户名
//NSString *name;
////频道
//NSString *channel;

//-(void)saveToServer:(CGPoint *)point withPng:(NSString *)png
//{
//    NSLog(@"invoke");
//    
//    NSNumber *myx = [NSNumber numberWithFloat:point->x];
//    NSNumber *myy = [NSNumber numberWithFloat:point->y];
//    
//    
//    
//    
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
//                            name, @"username",
//                            channel, @"rid",
//                            myx, @"pointx",
//                            myy, @"pointy",
//                            png,@"png",
//                            @"military",@"category",
//                            nil];
//    [pomelo requestWithRoute:@"connector.entryHandler.addArchitecture" andParams:params andCallback:^(NSDictionary *result){
//        NSArray *userList = [result objectForKey:@"users"];
//        for (NSString *name2 in userList) {
//            NSLog(@"%@",name2);
//            
//            
//        }
//        
//    }];
//    
//    
//    
//    
//}

@end
