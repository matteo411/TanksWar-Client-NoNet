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
    BOOL result = false;
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"DataList.plist"];
    //根据路径获取test.plist的全部内容
    NSMutableDictionary *data= [[[NSMutableDictionary alloc]initWithContentsOfFile:path]mutableCopy];
    //获取初一班的信息
    NSMutableArray *nodes = [data objectForKey:@"nodes"];
    
    for (NSMutableDictionary *node in nodes) {
        if ([[node objectForKey:@"key"] intValue] == key) {
            [node setValue:png forKey:@"png"];
            [data writeToFile:path atomically:YES];
            result = true;
        }
    }
    return result;
  
}
@end
