//
//  Util.h
//  coco
//
//  Created by 陈 奕龙 on 13-3-16.
//
//

#import <Foundation/Foundation.h>

@interface Util : NSObject


+(NSString*) getActuralPath:(NSString *) file;
+(NSArray *) getNodelistByNodeName:(NSString *) nodeName;
//+(NSDictionary *) getSingleNodeByKEY
+(BOOL) modifyPng:(NSString*) png ByKey:(int)key;
@end
