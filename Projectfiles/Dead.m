//
//  Dead.m
//  bullet hell-o
//
//  Created by Kevin Frans on 7/2/13.
//
//

#import "Dead.h"
#import "HelloWorldLayer.h"
#import "Title.h"
#import "LevelSelect.h"

@implementation Dead

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
        
        
        // add the labels shown during game over
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        NSString *score = [NSString stringWithFormat:@"%d", [[NSUserDefaults standardUserDefaults] integerForKey:@"score"]];
        
        CCLabelTTF* gameOver = [CCLabelTTF labelWithString:score fontName:@"Arial" fontSize:40];
        gameOver.position = CGPointMake(screenSize.width / 2, 400);
        [self addChild:gameOver z:100 tag:100];
        
        CCTintTo* tint = [CCTintTo actionWithDuration:2 red:0 green:0 blue:255];
        [gameOver runAction:tint];
        /*// game over label runs 3 different actions at the same time to create the combined effect
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
        
       /* CCMenuItemFont *playAgain = [CCMenuItemFont itemFromString: @"Retry" target:self selector:@selector(retry)];
        CCMenuItemFont *restart = [CCMenuItemFont itemFromString: @"Level Select" target:self selector:@selector(sel)];
        CCMenuItemFont *quit = [CCMenuItemFont itemFromString: @"Quit" target:self selector:@selector(quitGame)];
        [playAgain setFontName:@"Arial"];
        [restart setFontName:@"Arial"];
        [quit setFontName:@"Arial"];
        CCMenu *gameOverMenu = [CCMenu menuWithItems:playAgain, restart, quit, nil];
        [gameOverMenu alignItemsVertically];
        gameOverMenu.position = ccp(screenSize.width/2, screenSize.height/2 - 80);
        gameOverMenu.color = ccc3(0, 0, 0);
        [self addChild:gameOverMenu];
        
        */
        CCLabelTTF *highscore = [CCMenuItemImage itemFromNormalImage:@"retry.png" selectedImage:@"retry.png" target:self selector:@selector(retry)];
        highscore.position = ccp(160, 290);
        highscore.scale = 2;
        CCMenu *starMenu = [CCMenu menuWithItems:highscore, nil];
        starMenu.position = CGPointZero;
        [self addChild:starMenu];
        
        CCLabelTTF *boss = [CCMenuItemImage itemFromNormalImage:@"highscores.png" selectedImage:@"highscores.png" target:self selector:@selector(sel)];
        boss.position = ccp(100, 80);
        CCMenu *moreMenu = [CCMenu menuWithItems:boss, nil];
        moreMenu.position = CGPointZero;
        [self addChild:moreMenu];
        
        CCLabelTTF *back = [CCMenuItemImage itemFromNormalImage:@"back.png" selectedImage:@"back.png" target:self selector:@selector(quitGame)];
        back.position = ccp(240, 80);
        back.scale = 0.5;
        CCMenu *backmenu = [CCMenu menuWithItems:back, nil];
        backmenu.position = CGPointZero;
        [self addChild:backmenu];
        
    }
    return self;
}

-(void) quitGame
{
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionSlideInL transitionWithDuration:0.5f scene:[Title node]]];
}

-(void) sel
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:0.5f scene:[LevelSelect node]]];
}

-(void) retry
{
    //    [[CCDirector sharedDirector] popSceneWithTransition:
    //       [CCTransitionCrossFade transitionWithDuration:0.5f scene:[HelloWorldLayer node]]];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:0.5f scene:[HelloWorldLayer node]]];
}


@end

