//
//  AppDelegate.h
//  cocos2d-1.x-ARC-iOS
//
//  Created by Steffen Itterheim on 23.07.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pomelo.h"


@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate,PomeloDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic) UIWindow *window;
@property (strong, nonatomic) Pomelo *pomelo;

@end
