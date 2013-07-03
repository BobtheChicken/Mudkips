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
    [MGWU preFacebook]; //Temporarily disables Facebook until you integrate it later
}

-(id) alternateView
{
	return nil;
}

@end
