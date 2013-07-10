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
#import "High.h"
#import "StatLayer.h"

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
        play.scale = 0;
        id bossscale = [CCScaleTo actionWithDuration:0.5f scale:1.0f];
        [play runAction:bossscale];
        

        
        CCLabelTTF *highscore = [CCMenuItemImage itemFromNormalImage:@"highscores.png" selectedImage:@"highscores.png" target:self selector:@selector(high)];
        highscore.position = ccp(80, 60);
        CCMenu *starMenu = [CCMenu menuWithItems:highscore, nil];
        starMenu.position = CGPointZero;
        [self addChild:starMenu];
        highscore.scale = 0;
        id menuscale = [CCScaleTo actionWithDuration:0.7f scale:1.0f];
        [highscore runAction:menuscale];
        
        CCLabelTTF *mgwu = [CCMenuItemImage itemFromNormalImage:@"mgwu.png" selectedImage:@"mgwu.png" target:self selector:@selector(mgwu)];
        mgwu.position = ccp(240, 60);
        CCMenu *mgmenu = [CCMenu menuWithItems:mgwu, nil];
        mgmenu.position = CGPointZero;
        [self addChild:mgmenu];
        mgwu.scale = 0;
        id mmenuscale = [CCScaleTo actionWithDuration:0.7f scale:1.0f];
        [mgwu runAction:mmenuscale];
        
        
        
        CCSprite* title = [CCSprite spriteWithFile:@"blue.png"];
        title.position = ccp(160,400);
        [self addChild:title];
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"techno.mp3" loop:YES];
        

    }
    return self;
}

-(void) mgwu
{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"data"] == false)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:6 forKey:@"coins"];
        [MGWU showMessage:@"Achievement Get!      Clearing the data" withImage:nil];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"data"];
    }
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [MGWU displayCrossPromo];
    [[SimpleAudioEngine sharedEngine] playEffect:@"zoom.mp3"];
}

-(void) high
{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"high"] == false)
    {
        [MGWU showMessage:@"Achievement Get!      You found a bug!" withImage:nil];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"high"];
    }
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:0.5f scene:[StatLayer node]]];
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
