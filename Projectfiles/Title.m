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
        CGSize screensize = [[CCDirector sharedDirector] screenSizeInPixels];
        
        glClearColor(0.91,0.92, 0.91, 1.0);
        [self unscheduleAllSelectors];
        
        // have everything stop
        CCNode* node;
        CCARRAY_FOREACH([self children], node)
        {
            [node pauseSchedulerAndActions];
        }
        
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        if (screenBounds.size.height == 568) {
            // code for iPhone 5
            NSLog(@"iphone 5, load bigger things.");
            [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"iphone5"];
        } else {
            // code for all other iOS devices
            NSLog(@"its not an iphone 5. smaller images.");
            [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"iphone5"];
        }
        
        
        CCSprite* bg = [CCSprite spriteWithFile:@"darkbluefill.png"];
        bg.position = [CCDirector sharedDirector].screenCenter;
        [self addChild:bg z:-100];
        bg.scale = 2;
        
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
        

        
//        CCLabelTTF *highscore = [CCMenuItemImage itemFromNormalImage:@"highscores.png" selectedImage:@"highscores.png" target:self selector:@selector(high)];
//        highscore.position = ccp(80, 60);
//        CCMenu *starMenu = [CCMenu menuWithItems:highscore, nil];
//        starMenu.position = CGPointZero;
//        [self addChild:starMenu];
//        highscore.scale = 0;
//        id menuscale = [CCScaleTo actionWithDuration:0.7f scale:1.0f];
//        [highscore runAction:menuscale];
        
        CCLabelTTF *mgwu = [CCMenuItemImage itemFromNormalImage:@"menu.png" selectedImage:@"menu.png" target:self selector:@selector(mgwu)];
        mgwu.position = ccp(25, 25);
        CCMenu *mgmenu = [CCMenu menuWithItems:mgwu, nil];
        mgmenu.position = CGPointZero;
        [self addChild:mgmenu];
        mgwu.scale = 0;
        id mmenuscale = [CCScaleTo actionWithDuration:0.7f scale:2.0f];
        [mgwu runAction:mmenuscale];
        
        
        
        CCSprite* title = [CCSprite spriteWithFile:@"glogo.png"];
        title.scale = 1.7;
        title.position = ccp(200,50);
        [self addChild:title];
        
        CCLabelTTF* titlelabel = [CCLabelTTF labelWithString:@"Blue" fontName:@"Helvetica" fontSize:50];
        //[self addChild:titlelabel z:100];
        titlelabel.position = ccp(240,100);
        
        //if([[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying] == false)
        //{
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"techno.mp3" loop:YES];
        //}
            
            
            
            
            
            bluemove = [CCSprite spriteWithFile:@"bubbles.png"];
            bluemove.scale = 1;
            bluemove.position = ccp(160,-100);
        [self addChild:bluemove z:-20];
        id move = [CCMoveTo actionWithDuration:4 position:ccp(160,800)];
        [bluemove runAction:move];
        
//            orangemove = [CCSprite spriteWithFile:@"orange.png"];
//            orangemove.scale = 0.05;
//            orangemove.position = ccp(245,365);
//            [self addChild:orangemove];
//            
//            
//            id moveAction = [CCMoveTo actionWithDuration:1 position:ccp(290,365)];
//            id moveActionBack = [CCMoveTo actionWithDuration:1 position:ccp(245,365)];
//            id delayTimeAction = [CCDelayTime actionWithDuration:1];
//            id delayTime2 = [CCDelayTime actionWithDuration:2];
//            CCSequence *act =[CCSequence actions:moveAction,delayTimeAction,moveActionBack,delayTimeAction,nil];
//            CCRepeatForever *repeat = [CCRepeatForever actionWithAction:act];
//            [orangemove runAction:repeat];
//            id makeblueball = [CCCallFunc actionWithTarget:self selector:@selector(makeblueball)];
//            id makeblueball2 = [CCCallFunc actionWithTarget:self selector:@selector(makeblueball2)];
//            
//            id moveBlueLeft = [CCMoveTo actionWithDuration:2 position:ccp(250,345)];
//            id removeMySprite = [CCCallFuncND actionWithTarget:bluemove selector:@selector(removeFromParentAndCleanup:) data:(void*)NO];
//            [bluemove runAction:[CCSequence actions:moveBlueLeft,removeMySprite,nil]];
//            
//            CCSequence *spawnBlue = [CCSequence actions:makeblueball,delayTime2,makeblueball2,delayTime2,nil];
//            CCRepeatForever *repblue = [CCRepeatForever actionWithAction:spawnBlue];
//            [self runAction:repblue];
        
            
            
            
        
        

    }
    return self;
}


//-(void) makeblueball
//{
// 
//    
//    bluemove = [CCSprite spriteWithFile:@"Glowing_Blue_Orb.png"];
//    bluemove.scale = 0.1;
//    bluemove.position = ccp(250,450);
//    [self addChild:bluemove];
//    
//    id fadein = [CCFadeIn actionWithDuration:0.5];
//    id delay = [CCDelayTime actionWithDuration:1];
//     id fadeout = [CCFadeOut actionWithDuration:0.5];
//    
//    id moveBlueLeft = [CCMoveTo actionWithDuration:2 position:ccp(250,345)];
//    id removeMySprite = [CCCallFuncND actionWithTarget:bluemove selector:@selector(removeFromParentAndCleanup:) data:(void*)NO];
//    [bluemove runAction:[CCSequence actions:moveBlueLeft,removeMySprite,nil]];
//    [bluemove runAction:[CCSequence actions:fadein,delay,fadeout, nil]];
//}
//
//-(void) makeblueball2
//{
//    
//    
//    bluemove = [CCSprite spriteWithFile:@"Glowing_Blue_Orb.png"];
//    bluemove.scale = 0.1;
//    bluemove.position = ccp(280,450);
//    [self addChild:bluemove];
//    
//    id fadein = [CCFadeIn actionWithDuration:0.5];
//    id delay = [CCDelayTime actionWithDuration:1];
//    id fadeout = [CCFadeOut actionWithDuration:0.5];
//    
//    id moveBlueLeft = [CCMoveTo actionWithDuration:2 position:ccp(280,345)];
//    id removeMySprite = [CCCallFuncND actionWithTarget:bluemove selector:@selector(removeFromParentAndCleanup:) data:(void*)NO];
//    [bluemove runAction:[CCSequence actions:moveBlueLeft,removeMySprite,nil]];
//    [bluemove runAction:[CCSequence actions:fadein,delay,fadeout, nil]];
//}

-(void) mgwu
{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"data"] == false)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:6 forKey:@"coins"];
        [MGWU showMessage:@"Achievement Get!      More Games" withImage:nil];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"data"];
    }
    //NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    //[[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [MGWU displayCrossPromo];
    [[SimpleAudioEngine sharedEngine] playEffect:@"zoom.mp3"];
}







-(void) high
{
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"high"] == false)
    {
        [MGWU showMessage:@"Achievement Get!      High Scores!" withImage:nil];
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
