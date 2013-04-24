//
//  Util.h
//  coco
//
//  Created by 陈 奕龙 on 13-3-16.
//
//

#import <Foundation/Foundation.h>
#import "Resources.h"
@interface Util : NSObject


+(NSString*) getActuralPath:(NSString *) file;

+(NSArray *) getNodelistByNodeName:(NSString *) nodeName;

+(NSDictionary *) getNodeDictionaryByNodeName:(NSString *)  nodeName;

+(BOOL) modifyPng:(NSString*) png andLevel:(NSNumber*) level ByKey:(int)key;

+(BOOL) addIncreaseToResource;

+(BOOL) writeResourceToPlist:(NSDictionary *) playerResource;

+(BOOL) consumeResource:(NSDictionary *)consumeResource;
@end
