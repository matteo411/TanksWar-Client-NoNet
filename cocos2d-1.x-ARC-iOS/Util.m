//
//  Util.m
//  coco
//
//  Created by 陈 奕龙 on 13-3-16.
//
//

#import "Util.h"

@implementation Util


+(NSString*) getActuralPath:(NSString *) file//读取plist文件  确定tag坐标点
{
    NSArray *path=[file componentsSeparatedByString:@"."    ];
    NSString *acturalPath=[[NSBundle mainBundle] pathForResource:[path objectAtIndex:0] ofType:[path objectAtIndex:1]];
    return acturalPath;
}

+(NSArray *) getNodelistByNodeName:(NSString *)  nodeName
{
    NSString *filename=@"DataList.plist";
    NSDictionary *dict=[NSDictionary dictionaryWithContentsOfFile:[Util getActuralPath:filename]];
    NSArray *nodes=[dict objectForKey:nodeName];
    
    return nodes;
}

+(BOOL) modifyPng:(NSString*) png ByKey:(int)key
{
    NSLog(@"invoke");
    NSLog(@"png:%@,key:%d",png,key);
    BOOL result = false;
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"DataList.plist"];//[self getActuralPath:@"DataList.plist"];
    NSLog(@"filePath:%@",filePath);
    NSMutableDictionary *fileDic;
        NSString *fileName = @"DataList.plist";
//    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSLog(@"文件不存在");
        fileDic = [NSMutableDictionary dictionaryWithContentsOfFile:[self getActuralPath:fileName]];
    }else
    {
        fileDic =[[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
        NSMutableArray *nodes = [fileDic objectForKey:@"nodes"];
        for (NSMutableDictionary *node in nodes) {
            NSLog(@"%d",[[node objectForKey:@"key"] intValue]);
            if ([[node objectForKey:@"key"] intValue] == key) {
                [node removeObjectForKey:@"png"];
                [node setObject:png forKey:@"png"];
                BOOL fileresult = [fileDic writeToFile:filePath atomically:YES];
                NSLog(@"fileresult:%d",fileresult);
                //[data writeToFile:path atomically:NO];
                NSLog(@"for1");
                NSLog(@"%@",node);
                result = true;
            }
        }
        
    }
  
    
    
    
    
    NSString *path2 = [self getActuralPath:@"DataList.plist"];//[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"DataList.plist"];
    //根据路径获取test.plist的全部内容
    NSMutableDictionary *data2= [[[NSMutableDictionary alloc]initWithContentsOfFile:path2]mutableCopy];
    //获取初一班的信息
    NSMutableArray *nodes2 = [data2 objectForKey:@"nodes"];
    for (NSMutableDictionary *node in nodes2) {
        if ([[node objectForKey:@"key"] intValue] == key) {
             NSLog(@"for2");
            NSLog(@"%@",node);
        }
    }
    
    return result;
    
   
}
@end
