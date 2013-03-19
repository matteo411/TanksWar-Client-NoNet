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


@end
