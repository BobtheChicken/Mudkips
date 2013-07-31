//
//  Pausue.m
//  bullet hell-o
//
//  Created by Kevin Frans on 7/2/13.
//
//

#import "Pausue.h"
#import "Title.h"
#import "Dead.h"
#import "StoreLayer.h"

@implementation Pausue

-(id) init
{
    if ((self = [super init]))
    {
       // glClearColor(255, 255, 255, 255);
        [self unscheduleAllSelectors];
        
        // have everything stop
        CCNode* node;
        CCARRAY_FOREACH([self children], node)
        {
            [node pauseSchedulerAndActions];
        }
        
        
        // add the labels shown during game over
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        CCSprite* background = [CCSprite spriteWithFile:@"pauseback.png"];
        background.position = ccp(160,240);
        [self addChild:background];
        
        
        CCLabelTTF* gameOver = [CCLabelTTF labelWithString:@"Paused" fontName:@"Arial" fontSize:40];
        [gameOver setColor:ccc3(0, 0, 0)];
        gameOver.position = CGPointMake(screenSize.width / 2, 440);
        //[self addChild:gameOver z:100 tag:100];
        
       /* // game over label runs 3 different actions at the same time to create the combined effect
        // 1) color tinting
        CCTintTo* tint1 = [CCTintTo actionWithDuration:2 red:255 green:0 blue:0];
        CCTintTo* tint2 = [CCTintTo actionWithDuration:2 red:255 green:255 blue:0];
        CCTintTo* tint3 = [CCTintTo actionWithDuration:2 red:0 green:255 blue:0];
        CCTintTo* tint4 = [CCTintTo actionWithDuration:2 red:0 green:255 blue:255];
        CCTintTo* tint5 = [CCTintTo actionWithDuration:2 red:0 green:0 blue:255];
        CCTintTo* tint6 = [CCTintTo actionWithDuration:2 red:255 green:0 blue:255];
        CCSequence* tintSequence = [CCSequence actions:tint1, tint2, tint3, tint4, tint5, tint6, nil];
        CCRepeatForever* repeatTint = [CCRepeatForever actionWithAction:tintSequence];
        [gameOver runAction:repeatTint];
        
        // 2) rotation with ease
        CCRotateTo* rotate1 = [CCRotateTo actionWithDuration:2 angle:3];
        CCEaseBounceInOut* bounce1 = [CCEaseBounceInOut actionWithAction:rotate1];
        CCRotateTo* rotate2 = [CCRotateTo actionWithDuration:2 angle:-3];
        CCEaseBounceInOut* bounce2 = [CCEaseBounceInOut actionWithAction:rotate2];
        CCSequence* rotateSequence = [CCSequence actions:bounce1, bounce2, nil];
        CCRepeatForever* repeatBounce = [CCRepeatForever actionWithAction:rotateSequence];
        [gameOver runAction:repeatBounce];
        
        // 3) jumping
        CCJumpBy* jump = [CCJumpBy actionWithDuration:3 position:CGPointZero height:screenSize.height / 3 jumps:1];
        CCRepeatForever* repeatJump = [CCRepeatForever actionWithAction:jump];
        [gameOver runAction:repeatJump];*/
        
        CCLabelTTF *highscore = [CCMenuItemImage itemFromNormalImage:@"orangecont.png" selectedImage:@"orangecont.png" target:self selector:@selector(unPause)];
        highscore.position = ccp(160, 290);
        highscore.scale = 1;
        CCMenu *starMenu = [CCMenu menuWithItems:highscore, nil];
        starMenu.position = CGPointZero;
        [self addChild:starMenu];
        
        CCLabelTTF *boss = [CCMenuItemImage itemFromNormalImage:@"giveup.png" selectedImage:@"giveup.png" target:self selector:@selector(restartGame)];
        boss.position = ccp(160, 210);
        CCMenu *moreMenu = [CCMenu menuWithItems:boss, nil];
        moreMenu.position = CGPointZero;
        [self addChild:moreMenu];
        
        CCLabelTTF *back = [CCMenuItemImage itemFromNormalImage:@"panic.png" selectedImage:@"panic.png" target:self selector:@selector(quitGame)];
        back.position = ccp(160, 130);
        CCMenu *backmenu = [CCMenu menuWithItems:back, nil];
        backmenu.position = CGPointZero;
        [self addChild:backmenu];
        

    }
    return self;
}

-(void) quitGame
{
    
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"panic"] == false)
    {
        [MGWU showMessage:@"Achievement Get!     Panic Shopping" withImage:nil];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"panic"];
    }
    
    
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionCrossFade transitionWithDuration:0.5f scene:[StoreLayer node]]];
    
}

-(void) restartGame
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5f scene:[Dead node]]];
}

-(void) unPause
{
     //   [[CCDirector sharedDirector] popSceneWithTransition:
       //    [CCTransitionCrossFade transitionWithDuration:0.5f scene:[HelloWorldLayer node]]];
    [[CCDirector sharedDirector] popScene];
}


@end
