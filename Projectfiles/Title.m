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
        
        CCLabelTTF* gameOver = [CCLabelTTF labelWithString:@"A game about \n not touching \n the color blue" fontName:@"Arial" fontSize:40];
        gameOver.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
        [self addChild:gameOver z:100 tag:100];
        
        // game over label runs 3 different actions at the same time to create the combined effect
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
        [gameOver runAction:repeatJump];
        
        CCMenuItemFont *playAgain = [CCMenuItemFont itemFromString: @"Start" target:self selector:@selector(unPause)];
        CCMenuItemFont *restart = [CCMenuItemFont itemFromString: @"High Squirrel" target:self selector:@selector(restartGame)];
        CCMenuItemFont *quit = [CCMenuItemFont itemFromString: @"Moar Gaemrms" target:self selector:@selector(quitGame)];
        [playAgain setFontName:@"Arial"];
        [restart setFontName:@"Arial"];
        //[quit setFontName:@"Arial"];
        CCMenu *gameOverMenu = [CCMenu menuWithItems:playAgain, restart, quit, nil];
        [gameOverMenu alignItemsVertically];
        gameOverMenu.position = ccp(screenSize.width/2, screenSize.height/2 - 80);
        gameOverMenu.color = ccc3(0, 0, 0);
        [self addChild:gameOverMenu];
    }
    return self;
}

-(void) quitGame
{
    [MGWU displayCrossPromo];
    [[SimpleAudioEngine sharedEngine] playEffect:@"zoom.mp3"];
}

-(void) restartGame
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5f scene:[LevelSelect node]]];
    [[SimpleAudioEngine sharedEngine] playEffect:@"zoom.mp3"];
}

-(void) unPause
{
    //    [[CCDirector sharedDirector] popSceneWithTransition:
    //       [CCTransitionCrossFade transitionWithDuration:0.5f scene:[HelloWorldLayer node]]];
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionCrossFade transitionWithDuration:0.5f scene:[LevelSelect node]]];
    [[SimpleAudioEngine sharedEngine] playEffect:@"zoom.mp3"];
}



@end
