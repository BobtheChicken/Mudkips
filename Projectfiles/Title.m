//
//  Title.m
//  bullet hell-o
//
//  Created by Kevin Frans on 7/2/13.
//
//

#import "Title.h"
#import "HelloWorldLayer.h"
#import "LevelSelect.h"
#import "SimpleAudioEngine.h"

@implementation Title

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
        
        
        
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"zoom.mp3"];
        // add the labels shown during game over
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        CCLabelTTF* play = [CCMenuItemImage itemFromNormalImage:@"play.png" selectedImage:@"play.png" target:self selector:@selector(unPause)];
        play.position = ccp(160, 200);
        CCMenu *playmenu = [CCMenu menuWithItems:play, nil];
        playmenu.position = CGPointZero;
        [self addChild:playmenu];
        

        
        CCLabelTTF *highscore = [CCMenuItemImage itemFromNormalImage:@"highscores.png" selectedImage:@"highscores.png" target:self selector:@selector(high)];
        highscore.position = ccp(80, 60);
        CCMenu *starMenu = [CCMenu menuWithItems:highscore, nil];
        starMenu.position = CGPointZero;
        [self addChild:starMenu];
        
        CCLabelTTF *mgwu = [CCMenuItemImage itemFromNormalImage:@"mgwu.png" selectedImage:@"mgwu.png" target:self selector:@selector(mgwu)];
        mgwu.position = ccp(240, 60);
        CCMenu *mgmenu = [CCMenu menuWithItems:mgwu, nil];
        mgmenu.position = CGPointZero;
        [self addChild:mgmenu];
        
        CCSprite* title = [CCSprite spriteWithFile:@"blue.png"];
        title.position = ccp(160,400);
        [self addChild:title];
        

    }
    return self;
}

-(void) mgwu
{
    [MGWU displayCrossPromo];
    [[SimpleAudioEngine sharedEngine] playEffect:@"zoom.mp3"];
}

-(void) high
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:0.5f scene:[LevelSelect node]]];
    [[SimpleAudioEngine sharedEngine] playEffect:@"zoom.mp3"];
}

-(void) unPause
{
    //    [[CCDirector sharedDirector] popSceneWithTransition:
    //       [CCTransitionCrossFade transitionWithDuration:0.5f scene:[HelloWorldLayer node]]];
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionSlideInR transitionWithDuration:0.5f scene:[LevelSelect node]]];
    [[SimpleAudioEngine sharedEngine] playEffect:@"zoom.mp3"];
}



@end
