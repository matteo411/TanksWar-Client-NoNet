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

+(NSDictionary *) getNodeDictionaryByNodeName:(NSString *)  nodeName
{
    NSString *filename=@"DataList.plist";
    NSDictionary *dict=[NSDictionary dictionaryWithContentsOfFile:[Util getActuralPath:filename]];
    NSDictionary *nodes=[dict objectForKey:nodeName];
    
    return nodes;
}

+(BOOL) modifyPng:(NSString*) png andLevel:(NSNumber*) level ByKey:(int)key
{
    NSString *fileName = @"DataList.plist";
    BOOL result = false;
    NSString *filePath=[self getActuralPath:fileName]; 
    
    NSMutableDictionary *fileDic;
       

    
    if(![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSLog(@"文件不存在");
        fileDic = [NSMutableDictionary dictionaryWithContentsOfFile:[self getActuralPath:fileName]];
    }else
    {
        fileDic =[[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
        NSMutableArray *nodes = [fileDic objectForKey:@"military_area"];
        for (NSMutableDictionary *node in nodes) {
            NSLog(@"%d",[[node objectForKey:@"key"] intValue]);
            if ([[node objectForKey:@"key"] intValue] == key) {
                [node removeObjectForKey:@"png"];
                [node setObject:png forKey:@"png"];
                [node removeObjectForKey:@"level"];
                [node setObject:level forKey:@"level"];
                BOOL fileresult = [fileDic writeToFile:filePath atomically:YES];
                NSLog(@"fileresult:%d",fileresult);
                //[data writeToFile:path atomically:NO];
                NSLog(@"for1");
                NSLog(@"%@",node);
                result = true;
            }
        }
        
    }
    
    return result;
    
   
}

+(BOOL) writeResourceToPlist:(Resources*) playerResource
{
    NSString *fileName = @"DataList.plist";
    BOOL result = false;
    NSString *filePath=[self getActuralPath:fileName];
    
    NSMutableDictionary *fileDic;
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSLog(@"文件不存在");
        fileDic = [NSMutableDictionary dictionaryWithContentsOfFile:[self getActuralPath:fileName]];
    }else
    {
        fileDic =[[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
        NSMutableDictionary *resource = [fileDic objectForKey:@"resource"];
        
        [resource setObject:[NSNumber numberWithInt:playerResource.food] forKey:@"food"];
        [resource setObject:[NSNumber numberWithInt:playerResource.oil] forKey:@"oil"];
        [resource setObject:[NSNumber numberWithInt:playerResource.steel] forKey:@"steel"];
        [resource setObject:[NSNumber numberWithInt:playerResource.ore] forKey:@"ore"];
        [resource setObject:[NSNumber numberWithInt:playerResource.food_increase] forKey:@"food_increase"];
        [resource setObject:[NSNumber numberWithInt:playerResource.oil_increase] forKey:@"oil_increase"];
        [resource setObject:[NSNumber numberWithInt:playerResource.steel_increase] forKey:@"steel_increase"];
        [resource setObject:[NSNumber numberWithInt:playerResource.ore_increase] forKey:@"ore_increase"];
        
        BOOL fileresult = [fileDic writeToFile:filePath atomically:YES];
        result = fileresult;
        
    }
    return result;
}


+(BOOL) addIncreaseToResource
{
    NSString *fileName = @"DataList.plist";
    BOOL result = false;
    NSString *filePath=[self getActuralPath:fileName];
    
    NSMutableDictionary *fileDic;
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSLog(@"文件不存在");
        fileDic = [NSMutableDictionary dictionaryWithContentsOfFile:[self getActuralPath:fileName]];
    }else
    {
        fileDic =[[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
        NSMutableDictionary *resource = [fileDic objectForKey:@"resource"];
         
        [resource setObject:[NSNumber numberWithInt:[[resource objectForKey:@"food"] intValue] +[[resource objectForKey:@"food_increase"] intValue]] forKey:@"food"];
        [resource setObject:[NSNumber numberWithInt:[[resource objectForKey:@"oil"] intValue] +[[resource objectForKey:@"oil_increase"] intValue]] forKey:@"oil"];
        [resource setObject:[NSNumber numberWithInt:[[resource objectForKey:@"steel"] intValue] +[[resource objectForKey:@"steel_increase"] intValue]] forKey:@"steel"];
        [resource setObject:[NSNumber numberWithInt:[[resource objectForKey:@"ore"] intValue] +[[resource objectForKey:@"ore_increase"] intValue]] forKey:@"ore"];
        
        BOOL fileresult = [fileDic writeToFile:filePath atomically:YES];
        result = fileresult;
        
    }
    return result;

}


+(BOOL) consumeResource:(NSDictionary *)consumeResource
{
    NSString *fileName = @"DataList.plist";
    BOOL result = false;
    NSString *filePath=[self getActuralPath:fileName];
    
    NSMutableDictionary *fileDic;
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSLog(@"文件不存在");
        fileDic = [NSMutableDictionary dictionaryWithContentsOfFile:[self getActuralPath:fileName]];
    }else
    {
        fileDic =[[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
        NSMutableDictionary *resource = [fileDic objectForKey:@"resource"];

        int plist_food = [[resource objectForKey:@"food"] intValue];
        int plist_oil = [[resource objectForKey:@"oil"] intValue];
        int plist_steel = [[resource objectForKey:@"steel"] intValue];
        int plist_ore = [[resource objectForKey:@"ore"] intValue];
        
        int consume_food = [[consumeResource objectForKey:@"food"] intValue];
        int consume_oil = [[consumeResource objectForKey:@"oil"] intValue];
        int consume_steel = [[consumeResource objectForKey:@"steel"] intValue];
        int consume_ore = [[consumeResource objectForKey:@"ore"] intValue];
        
        if (plist_food >= consume_food && plist_oil >= consume_oil && plist_ore >= consume_ore && plist_steel >=consume_steel) {
            [resource setObject:[NSNumber numberWithInt:plist_food - consume_food] forKey:@"food"];
            [resource setObject:[NSNumber numberWithInt:plist_oil - consume_oil] forKey:@"oil"];
            [resource setObject:[NSNumber numberWithInt:plist_steel - consume_steel] forKey:@"steel"];
            [resource setObject:[NSNumber numberWithInt:plist_ore - consume_ore] forKey:@"ore"];
             BOOL fileresult = [fileDic writeToFile:filePath atomically:YES];
            result = true;
        }
       
        
       
        
        
    }
    return result;

}
@end
