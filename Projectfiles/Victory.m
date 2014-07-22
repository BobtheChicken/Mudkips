//
//  Victory.m
//  bullet hell-o
//
//  Created by Kevin Frans on 7/8/14.
//
//

#import "Victory.h"
#import "Title.h"

@implementation Victory

-(id) init
{
    if ((self = [super init]))
    {
        glClearColor(255, 255, 255, 255);
        [self unscheduleAllSelectors];
        
        // have everything stop
        CCNode* node;
        CCARRAY_FOREACH([self children], node)
        {
            [node pauseSchedulerAndActions];
        }
        
        
        CCSprite* bg = [CCSprite spriteWithFile:@"darkbluefill.png"];
        bg.position = [[CCDirector sharedDirector] screenCenter];
        [self addChild:bg];
        
        CCSprite* victory = [CCSprite spriteWithFile:@"victory.png"];
        victory.position = [[CCDirector sharedDirector] screenCenter];
        [self addChild:victory];
        
        [self scheduleUpdate];
    }
    return self;
    
}


-(void) update:(ccTime)delta
{
    
    if ([KKInput sharedInput].anyTouchBeganThisFrame)
    {
        [[CCDirector sharedDirector] pushScene:
         [CCTransitionCrossFade transitionWithDuration:0.5f scene:[Title node]]];
    }
    
}

@end
