/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"
#import "Player.h"

@interface HelloWorldLayer (PrivateMethods)
@end

@implementation HelloWorldLayer

CCSprite *player;
CGPoint posTouchScreen;
CGPoint screenCenter;
CCDirector *director;
CCSprite *obstacle;
int playerWidth = 41.6;
int playerHeight = 78.6;
int obstacleWidth = 26;
int obstacleHeight = 48;
int fromNumber;
int toNumber;
id movePlayer;

-(id) init
{
    if ((self = [super init]))
    {
        director = [CCDirector sharedDirector];
        screenCenter = director.screenCenter;
        glClearColor(255, 255, 255, 255);
        // initialize player sprite
        player = [CCSprite spriteWithFile:@"cloudmonster.png"];
        player.scale = 0.8;
        player.position = [director screenCenter];
        [self addChild:player];
        
        // initialize obstacles
        [self initObstacles];
        
        [self schedule:@selector(update:)];
    }
    
    return self;
}

-(void) initObstacles
{
    int x = 20;
    int y= 20;
    for (int i = 0; i < 5; i++)
    {
        obstacle = [CCSprite spriteWithFile:@"monster8.png"];
        obstacle.scale = 0.5;
        obstacle.position = ccp(x, y);
        [self addChild:obstacle z:10 tag:i];
        x = x + 40;
        y = y + 10;
    }
}

-(void) initBoss
{
    int x = 100;
    int y = 500;
    boss = [CCSprite spriteWithFile:@"download.jpeg"];
    boss.position = ccp(x,y);
}


-(void) grabTouchCoord
{
    // Methods that should run every frame here!
    KKInput *input = [KKInput sharedInput];
    //This will be true as long as there is at least one finger touching the screen
    if(input.touchesAvailable)
    {
        //This lets you see where you are touching
        //**COMMENT THIS OUT WHEN YOU START WORK ON YOUR OWN GAME
        [self stopAction:movePlayer];
        [self movePlayerToCoord];
        posTouchScreen = [input locationOfAnyTouchInPhase:KKTouchPhaseAny];
        //**
    }
}

-(void) movePlayerToCoord
{
    movePlayer = [CCMoveTo actionWithDuration:1 position:posTouchScreen];
    [player runAction:movePlayer];
}

-(void) detectCollisions
{
    if (CGRectIntersectsRect(CGRectMake(player.position.x, player.position.y, playerWidth, playerHeight), CGRectMake(obstacle.position.x, obstacle.position.y, obstacleWidth, obstacleHeight)) == true) {
        // NSLog(@"Collision detected!");
        [self removeChild:player cleanup:YES];
        
    }
}

-(void)update:(ccTime)dt
{
    [self grabTouchCoord];
    [self detectCollisions];
}


@end
