/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "AppDelegate.h"

@implementation AppDelegate

-(void) initializationComplete
{
#ifdef KK_ARC_ENABLED
	CCLOG(@"ARC is enabled");
#else
	CCLOG(@"ARC is either not available or not enabled");
#endif
    
    [MGWU loadMGWU:@"iliketoeatpieandbananasandlotsandlotsofcake"];
    [MGWU dark];
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    // attempt to extract a token from the url
    return [MGWU handleURL:url];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [director stopAnimation];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [director startAnimation];
}

-(void) applicationWillResignActive:(UIApplication *)application
{
    [director pause];
}

-(void) applicationDidBecomeActive:(UIApplication *)application
{
    [director resume];
}

-(id) alternateView
{
	return nil;
}

@end
