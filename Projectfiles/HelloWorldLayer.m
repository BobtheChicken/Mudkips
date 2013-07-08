/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim.
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"
#import "Player.h"
#import "Dead.h"
#import "LevelSelect.h"

@interface HelloWorldLayer (PrivateMethods)
@end

@implementation HelloWorldLayer

CCSprite *player;
CCSprite *shield;
CGPoint posTouchScreen;
CGPoint screenCenter;
CCDirector *director;
CCSprite *obstacle;
int playerWidth = 41.6;
int playerHeight = 78.6;
int bossWidth = 190/2;
int bossHeight = 265/2;
int thetemporalint = 180;
int fromNumber;
int toNumber;
id movePlayer;
int omganothertemportalint;

bool bwooo = false;

int gameSegment = 0;

int framespast;

int secondspast;

int stagespast;

int wowanothertemportalint;

-(id) init
{
    if ((self = [super init]))
    {
        wowanothertemportalint = 180;
        
        NSNumber *leveldata = [[NSUserDefaults standardUserDefaults] objectForKey:@"leveldata"];
        level = [leveldata intValue];
        NSLog([NSString stringWithFormat:@"%i", level]);
        
        
        
        shieldon = false;
        
        stagespast = 0;
        framespast = 0;
        secondspast = 0;
        gameSegment = 0;
        bosstime = false;
        
        thetemporalint = 180;
        
        omganothertemportalint = 180;
        
        intScore = 0;
        screenSize = [director winSize];
        bullets = [[NSMutableArray alloc] init];
        //donkeys = [[NSMutableArray alloc] init];
        //bulletSpeed = [[NSMutableArray alloc] init];
        fakebullets = [[NSMutableArray alloc] init];
        powerups = [[NSMutableArray alloc] init];
        //bulletDirection = [[NSMutableArray alloc] init];
        director = [CCDirector sharedDirector];
        screenCenter = director.screenCenter;
        glClearColor(255, 255, 255, 255);
        // initialize player sprite
        player = [CCSprite spriteWithFile:@"orange.png"];
        player.scale = 0.2;
        player.position = [director screenCenter];
        [self addChild:player z:9001];
        
        // initialize obstacles
        //[self initObstacles];
        // [self initBoss];
        [self schedule:@selector(update:)];
        
        [self pause];
        
        
        pausebutton = [CCSprite spriteWithFile:@"pause.png"];
        pausebutton.position = ccp(305,465);
        pausebutton.scale = 1;
        [self addChild:pausebutton];
        
        [self initScore];
        
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"bwooo.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"zoom.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"swip.mp3"];
        
        
        if([[NSUserDefaults standardUserDefaults] boolForKey:@"endless"] == false)
        {
            if(level == 1)
            {
                bosstime = true;
                stagespast = 5;
            }
            if(level == 2)
            {
                bosstime = true;
                stagespast = 10;
            }
            if(level == 3)
            {
                bosstime = true;
                stagespast = 15;
            }
        }
        
        [self initBoss];
        
        
    }
    return self;
}





-(void)update:(ccTime)dt
{
    [self grabTouchCoord];
    
    
    framespast++;
    
    secondspast = framespast/60;
    
    [self bossAttack];
    //[self moveBullet];
    
    [self gameSeg];
    [self detectCollisions];
    
    
    
    
    KKInput* input = [KKInput sharedInput];
    
    if ([input isAnyTouchOnNode:pausebutton touchPhase:KKTouchPhaseAny]) {
        
        [self pause];
        
    }
    
    
}





-(void) initScore
{
    
    label = [CCLabelTTF labelWithString:@"0" fontName:@"Bend2SquaresBRK" fontSize:24];
    
    label.position = ccp(50,465);
    
    label.color = ccc3(0, 0, 0);
    
    [self addChild: label];
}



-(void) bossAttack
{
    if(bosstime == true)
    {
        if(level == 1)
        {
            if(gameSegment ==0)
            {
                if((framespast % 25) == 0)
                {
                    
                    int tempInt = (arc4random() % 90) + 240;
                    
                    
                    [self shootBullet:1 angle:tempInt];
                }
            }
            
            if(gameSegment ==1)
            {
                if((framespast % 25) ==0)
                {
                    
                    [self shootBullet:3 angle:240];
                    [self shootBullet:3 angle:270];
                    [self shootBullet:3 angle:300];
                }
                
            }
            if(gameSegment == 2)
            {
                if((framespast % 25) ==0)
                {
                    [self shootBullet:5 angle:300];
                    
                    [self shootBullet:5 angle:240];
                }
                
                for(int i = 0; i < [bullets count]; i++)
                {
                    NSInteger j = i;
                    projectile = [bullets objectAtIndex:j];
                    
                    if(projectile.position.x > 300)
                    {
                        
                        [[bullets objectAtIndex:j] changeAngle:240.0];
                    }
                    if(projectile.position.x < 10)
                    {
                        [[bullets objectAtIndex:j] changeAngle:300.0];
                    }
                    if(projectile.position.y < 0)
                    {
                        if( [[bullets objectAtIndex:j] getAngle] == 240)
                        {
                            [[bullets objectAtIndex:j] changeAngle:160.0];
                        }
                        if([[bullets objectAtIndex:j] getAngle] == 300)
                        {
                            [[bullets objectAtIndex:j] changeAngle:390.0];
                        }
                    }
                    
                }
            }
            
            if(gameSegment == 3)
            {
                if((framespast % 25) ==0)
                {
                    [self shootBullet:3 angle:180];
                    
                    for(int i = 0; i < [bullets count]; i++)
                    {
                        NSInteger j = i;
                        int tempDir = [[bullets objectAtIndex:j] getAngle] + 30;
                        
                        [[bullets objectAtIndex:j] changeAngle:tempDir];
                    }
                }
            }
            if(gameSegment == 4)
            {
                if((framespast % 25) ==0)
                {
                    [self shootBullet:3 angle:270];
                    
                    [self shootBullet:3 angle:270];
                    
                    for(int i = 0; i < [bullets count]; i++)
                    {
                        NSInteger j = i;
                        int tempDir = [[bullets objectAtIndex:j] getAngle] + (arc4random() % 90)-45;
                        [[bullets objectAtIndex:j] changeAngle:tempDir];
                    }
                }
            }
            if(gameSegment == 5)
            {
                if((framespast % 45) ==0)
                {
                    
                    [self shootBullet:3 angle:thetemporalint];
                    thetemporalint = thetemporalint + 15;
                    
                    
                    [self shootBullet:3 angle:thetemporalint];
                    
                    for(int i = 0; i < [bullets count]; i++)
                    {
                        NSInteger j = i;
                        [[bullets objectAtIndex:j] changeAngle:[[bullets objectAtIndex:j] getAngle] + 5];
                    }
                }
            }
            
            if(gameSegment == 6)
            {
                if((framespast % 45) ==0)
                {
                    
                    
                    [self shootBullet:3 angle:180];
                    [self shootBullet:3 angle:200];
                    [self shootBullet:3 angle:220];
                    [self shootBullet:3 angle:240];
                    [self shootBullet:3 angle:260];
                    [self shootBullet:3 angle:280];
                    [self shootBullet:3 angle:300];
                    [self shootBullet:3 angle:320];
                    [self shootBullet:3 angle:340];
                    [self shootBullet:3 angle:360];
                    
                    
                }
            }
            
        }
        
        if(level == 2)
        {
            if(gameSegment ==0)
            {
                if((framespast % 100) == 0)
                {
                    int tempInt = (arc4random() % 300) -245;
                    
                    [self makeDownvote:tempInt];
                    
                    
                    
                }
            }
            if(gameSegment ==1)
            {
                if((framespast % 25) == 0)
                {
                    [self shootBulletwithPos:3 angle:270 xpos:0 ypos:0];
                    
                    [self shootBulletwithPos:3 angle:240 xpos:-50 ypos:0];
                    
                    [self shootBulletwithPos:3 angle:300 xpos:50 ypos:0];
                    
                    
                    
                }
            }
            if(gameSegment ==2)
            {
                if((framespast % 25) == 0)
                {
                    [self shootBulletwithPos:3 angle:270 xpos:0 ypos:0];
                    
                    [self shootBulletwithPos:3 angle:240 xpos:100 ypos:0];
                    
                    [self shootBulletwithPos:3 angle:300 xpos:-100 ypos:0];
                    
                    
                    
                }
            }
            if(gameSegment ==3)
            {
                if((framespast % 250) == 0)
                {
                    [self makeDownvote:-200];
                    
                    [self makeDownvote:-100];
                    
                    [self makeDownvote:0];
                    
                    [self makeDownvote:100];
                    
                    [self makeDownvote:200];
                    
                    
                    
                }
            }
            if(gameSegment ==4)
            {
                if((framespast % 25) == 0)
                {
                    [self shootBulletwithPos:3 angle:270 xpos:100 ypos:0];
                    [self shootBulletwithPos:3 angle:271 xpos:-100 ypos:0];
                    
                    for(int i = 0; i < [bullets count];i++)
                    {
                        if([[bullets objectAtIndex:i] getAngle] > 270)
                        {
                            [[bullets objectAtIndex:i] changeAngle:[[bullets objectAtIndex:i] getAngle] + 15];
                        }
                        else{
                            [[bullets objectAtIndex:i] changeAngle:[[bullets objectAtIndex:i] getAngle] - 15];
                        }
                    }
                    
                    
                    
                }
            }
            if(gameSegment ==5)
            {
                if((framespast % 25) == 0)
                {
                    [self shootBulletwithPos:3 angle:300 xpos:-100 ypos:0];
                    [self shootBulletwithPos:3 angle:240 xpos:100 ypos:0];
                    
                    for(int i = 0; i < [bullets count];i++)
                    {
                        
                        //[[bullets objectAtIndex:i] changeAngle:[[bullets objectAtIndex:i] getAngle] + 50];
                        
                    }
                    
                    
                    
                }
                if((framespast % 100) == 0)
                {
                    [self makeDownvote:-30];
                    
                    
                    
                    
                    
                }
            }
        }
        
        if(level == 3)
        {
            if(gameSegment ==0)
            {
                if(framespast == 160)
                {
                    
                    
                    [self yeswecan];
                    
                    
                }
            }
            if(gameSegment ==1)
            {
                if((framespast % 50) == 0)
                {
                    
                    
                    [self shootBulletwithPosDonkey:3 angle:270 xpos:0 ypos:0];
                    
                    
                }
            }
            if(gameSegment ==2)
            {
                if((framespast % 25) == 0)
                {
                    
                    
                    [self shootBulletwithPos:3 angle:omganothertemportalint xpos:0 ypos:0];
                    
                    omganothertemportalint = omganothertemportalint + 15;
                    
                    [self shootBulletwithPos:3 angle:omganothertemportalint xpos:0 ypos:0];
                    
                    omganothertemportalint = omganothertemportalint + 15;
                }
            }
            if(gameSegment ==3)
            {
                if((framespast % 10) == 0)
                {
                    
                    
                    [self shootBulletwithPos:7 angle:270 xpos:0 ypos:0];
                    
                    [self shootBulletwithPos:7 angle:250 xpos:0 ypos:0];
                    
                    [self shootBulletwithPos:7 angle:290 xpos:0 ypos:0];
                    
                }
            }
            if(gameSegment ==4)
            {
                if(framespast == 1500)
                {
                    [self yeswecan];
                }
                if((framespast % 50) == 0)
                {
                    
                    
                    [self shootBulletwithPosDonkey:3 angle:270 xpos:100 ypos:0];
                    
                    [self shootBulletwithPosDonkey:3 angle:270 xpos:0 ypos:0];
                    
                    [self shootBulletwithPosDonkey:3 angle:270 xpos:-100 ypos:0];
                    
                }
            }
        }
        if(level == 4)
        {
            if(gameSegment ==0)
            {
                if(framespast == 160)
                {
                    
                    
                    
                    
                    
                }
            }
            if(gameSegment ==1)
            {
                if((framespast % 50) == 0)
                {
                    
                    
                    [self shootBulletwithPosDonkey:3 angle:270 xpos:0 ypos:0];
                    
                    
                }
            }
            if(gameSegment ==2)
            {
                if((framespast % 25) == 0)
                {
                    
                    
                    [self shootBulletwithPos:3 angle:omganothertemportalint xpos:0 ypos:0];
                    
                    omganothertemportalint = omganothertemportalint + 15;
                    
                    [self shootBulletwithPos:3 angle:omganothertemportalint xpos:0 ypos:0];
                    
                    omganothertemportalint = omganothertemportalint + 15;
                }
            }
            if(gameSegment ==3)
            {
                if((framespast % 10) == 0)
                {
                    
                    
                    [self shootBulletwithPos:7 angle:270 xpos:0 ypos:0];
                    
                    [self shootBulletwithPos:7 angle:250 xpos:0 ypos:0];
                    
                    [self shootBulletwithPos:7 angle:290 xpos:0 ypos:0];
                    
                }
            }
            if(gameSegment ==4)
            {
                if(framespast == 1500)
                {
                    [self yeswecan];
                }
                if((framespast % 50) == 0)
                {
                    
                    
                    [self shootBulletwithPosDonkey:3 angle:270 xpos:100 ypos:0];
                    
                    [self shootBulletwithPosDonkey:3 angle:270 xpos:0 ypos:0];
                    
                    [self shootBulletwithPosDonkey:3 angle:270 xpos:-100 ypos:0];
                    
                }
            }
        }
        
    }
    
    
    
    
    
    else if(bosstime == false)
    {
        if(stagespast < 5)
        {
            if(attacktype == 0)
            {
                attacktype = 1;
            }
            
            if(attacktype == 1)
            {
                if(framespast == 10)
                {
                    tut = [CCLabelTTF labelWithString:@"Tap to move" fontName:@"Bend2SquaresBRK" fontSize:60];
                    
                    tut.position = ccp(160,320);
                    
                    tut.color = ccc3(0, 0, 0);
                    
                    [self addChild: tut];
                }
                
            }
            else if(attacktype == 2)
            {
                if(framespast ==10)
                {
                    [self shootBulletwithPos:1 angle:260 xpos:0 ypos:0];
                    
                    [self removeChild:tut];
                    
                    tut = [CCLabelTTF labelWithString:@"Don't touch blue" fontName:@"Bend2SquaresBRK" fontSize:60];
                    
                    tut.position = ccp(160,320);
                    
                    tut.color = ccc3(0, 0, 0);
                    [self addChild:tut];
                }
            }
            else if(attacktype == 3)
            {
                
                if(framespast ==10)
                {
                    [self shootBulletwithPosPowerup:1 angle:260 xpos:0 ypos:0];
                    
                    [self removeChild:tut];
                    
                    tut = [CCLabelTTF labelWithString:@"Grab powerups for\nspecial abilities" fontName:@"Bend2SquaresBRK" fontSize:60];
                    
                    tut.position = ccp(160,320);
                    
                    tut.color = ccc3(0, 0, 0);
                    [self addChild:tut];
                }
            }
            else if(attacktype == 4)
            {
                if(framespast == 10)
                {
                    [self removeChild:tut];
                }
                if((framespast % 50) == 0)
                {
                    [self shootBulletwithPos:1 angle:360 xpos:-200 ypos:-80];
                    [self shootBulletwithPos:1 angle:360 xpos:-200 ypos:-200];
                    [self shootBulletwithPos:1 angle:360 xpos:-200 ypos:-320];
                    [self shootBulletwithPos:1 angle:360 xpos:-200 ypos:-440];
                }
            }
            else if(attacktype == 5)
            {
                if((framespast % 25) == 0)
                {
                    wowanothertemportalint = wowanothertemportalint + 15;
                    [self shootBulletwithPos:3 angle:wowanothertemportalint xpos:0 ypos:0];
                    for(int i = 0; i < [bullets count]; i++)
                    {
                        //[[bullets objectAtIndex:i] changeAngle:[[bullets objectAtIndex:i] getAngle] + 15];
                    }
                }
            
        }
        
        
        if(stagespast > 4 && stagespast < 10)
        {
            if(attacktype == 0)
            {
                tempattacktype = (arc4random() % 5)+1;
                while(attacktype == tempattacktype)
                {
                    tempattacktype = (arc4random() % 5)+1;
                }
                
                attacktype = tempattacktype;
                
                NSLog([NSString stringWithFormat:@"%d",attacktype]);
                wowanothertemportalint = 180;
            }
            
            if(attacktype == 1)
            {
                if((framespast % 25) == 0)
                {
                    [self shootBulletwithPos:3 angle:270 xpos:(arc4random() % 320)-160 ypos:0];
                }
            }
            else if(attacktype == 2)
            {
                if((framespast % 10) == 0)
                {
                    [self shootBulletwithPos:2 angle:(arc4random() % 360) xpos:0 ypos:-240];
                }
            }
            else if(attacktype == 3)
            {
                if((framespast % 25) == 0)
                {
                    [self shootBulletwithPos:3 angle:300 xpos:-100 ypos:0];
                    [self shootBulletwithPos:3 angle:270 xpos:0 ypos:0];
                    [self shootBulletwithPos:3 angle:240 xpos:100 ypos:0];
                }
            }
            else if(attacktype == 4)
            {
                if((framespast % 25) == 0)
                {
                    [self shootBulletwithPos:2 angle:360 xpos:-200 ypos:-80];
                    [self shootBulletwithPos:2 angle:360 xpos:-200 ypos:-200];
                    [self shootBulletwithPos:2 angle:360 xpos:-200 ypos:-320];
                    [self shootBulletwithPos:2 angle:360 xpos:-200 ypos:-440];
                }
            }
            else if(attacktype == 5)
            {
                if((framespast % 25) == 0)
                {
                    wowanothertemportalint = wowanothertemportalint + 15;
                    [self shootBulletwithPos:3 angle:wowanothertemportalint xpos:0 ypos:0];
                    for(int i = 0; i < [bullets count]; i++)
                    {
                        //[[bullets objectAtIndex:i] changeAngle:[[bullets objectAtIndex:i] getAngle] + 15];
                    }
                }
                if((framespast % 50) == 0)
                {
                    //wowanothertemportalint = wowanothertemportalint + 15;
                    //[self shootBulletwithPos:3 angle:wowanothertemportalint xpos:0 ypos:0];
                    for(int i = 0; i < [bullets count]; i++)
                    {
                        [[bullets objectAtIndex:i] changeAngle:[[bullets objectAtIndex:i] getAngle] + 15];
                    }
                }
            }
        }
        
        if(stagespast > 9 && stagespast < 15)
        {
            if(attacktype == 0)
            {
                tempattacktype = (arc4random() % 5)+1;
                while(attacktype == tempattacktype)
                {
                    tempattacktype = (arc4random() % 5)+1;
                }
                
                attacktype = tempattacktype;
                
                NSLog([NSString stringWithFormat:@"%d",attacktype]);
                wowanothertemportalint = 180;
            }
            
            if(attacktype == 1)
            {
                if((framespast % 75) == 0)
                {
                    int tempInt = (arc4random() % 300) -245;
                    
                    [self makeDownvote:tempInt];
                }
            }
            else if(attacktype == 2)
            {
                if((framespast % 50) == 0)
                {
                    [self shootBulletwithPos:2 angle:180 xpos:0 ypos:-240];
                    
                    [self shootBulletwithPos:2 angle:90 xpos:0 ypos:-240];
                    
                    [self shootBulletwithPos:2 angle:270 xpos:0 ypos:-240];
                    
                    [self shootBulletwithPos:2 angle:360 xpos:0 ypos:-240];
                    
                    [self shootBulletwithPos:2 angle:45 xpos:0 ypos:-240];
                    
                    [self shootBulletwithPos:2 angle:135 xpos:0 ypos:-240];
                    
                    [self shootBulletwithPos:2 angle:225 xpos:0 ypos:-240];
                    
                    [self shootBulletwithPos:2 angle:315 xpos:0 ypos:-240];
                }
            }
            else if(attacktype == 3)
            {
                if((framespast % 75) == 0)
                {
                    [self makeDownvoteSpeed:-100 speed:3];
                    [self makeDownvoteSpeed:100 speed:3];
                }
            }
            else if(attacktype == 4)
            {
                if((framespast % 75) == 0)
                {
                    [self shootBulletwithPos:2 angle:340 xpos:-200 ypos:-80];
                    [self shootBulletwithPos:2 angle:350 xpos:-200 ypos:-200];
                    [self shootBulletwithPos:2 angle:10 xpos:-200 ypos:-320];
                    [self shootBulletwithPos:2 angle:20 xpos:-200 ypos:-440];
                }
            }
            else if(attacktype == 5)
            {
                if((framespast % 25) == 0)
                {
                    wowanothertemportalint = wowanothertemportalint + 15;
                    [self shootBulletwithPos:3 angle:wowanothertemportalint xpos:0 ypos:0];
                    for(int i = 0; i < [bullets count]; i++)
                    {
                        //[[bullets objectAtIndex:i] changeAngle:[[bullets objectAtIndex:i] getAngle] + 15];
                    }
                }
                if((framespast % 50) == 0)
                {
                    //wowanothertemportalint = wowanothertemportalint + 15;
                    //[self shootBulletwithPos:3 angle:wowanothertemportalint xpos:0 ypos:0];
                    for(int i = 0; i < [bullets count]; i++)
                    {
                        [[bullets objectAtIndex:i] changeAngle:[[bullets objectAtIndex:i] getAngle] - 15];
                    }
                }
            }
        }
        
        if(stagespast > 14)
        {
            if(attacktype == 0)
            {
                //attacktype = 2;
                tempattacktype = (arc4random() % 5)+1;
                while(attacktype == tempattacktype)
                {
                    tempattacktype = (arc4random() % 5)+1;
                }
                
                attacktype = tempattacktype;
                
                NSLog([NSString stringWithFormat:@"%d",attacktype]);
                wowanothertemportalint = 180;
                
            }
            
            if(attacktype == 1)
            {
                if((framespast % 75) == 0)
                {
                    int tempInt = (arc4random() % 300) -245;
                    
                    [self shootBulletwithPosDonkey:2 angle:170 xpos:tempInt ypos:0];
                }
            }
            else if(attacktype == 2)
            {
                if((framespast % 50) == 0)
                {
                    [self shootBulletwithPos:2 angle:180 xpos:0 ypos:-240];
                    
                    [self shootBulletwithPos:2 angle:90 xpos:0 ypos:-240];
                    
                    [self shootBulletwithPos:2 angle:270 xpos:0 ypos:-240];
                    
                    [self shootBulletwithPos:2 angle:360 xpos:0 ypos:-240];
                    
                    [self shootBulletwithPos:2 angle:45 xpos:0 ypos:-240];
                    
                    [self shootBulletwithPos:2 angle:135 xpos:0 ypos:-240];
                    
                    [self shootBulletwithPos:2 angle:225 xpos:0 ypos:-240];
                    
                    [self shootBulletwithPos:2 angle:315 xpos:0 ypos:-240];
                }
            }
            else if(attacktype == 3)
            {
                if((framespast % 75) == 0)
                {
                    [self makeDownvoteSpeed:-100 speed:3];
                    [self makeDownvoteSpeed:100 speed:3];
                }
            }
            else if(attacktype == 4)
            {
                if((framespast % 75) == 0)
                {
                    [self shootBulletwithPos:2 angle:340 xpos:-200 ypos:-80];
                    [self shootBulletwithPos:2 angle:350 xpos:-200 ypos:-200];
                    [self shootBulletwithPos:2 angle:10 xpos:-200 ypos:-320];
                    [self shootBulletwithPos:2 angle:20 xpos:-200 ypos:-440];
                }
            }
            else if(attacktype == 5)
            {
                if((framespast % 25) == 0)
                {
                    wowanothertemportalint = wowanothertemportalint + 15;
                    [self shootBulletwithPos:3 angle:wowanothertemportalint xpos:0 ypos:0];
                    for(int i = 0; i < [bullets count]; i++)
                    {
                        //[[bullets objectAtIndex:i] changeAngle:[[bullets objectAtIndex:i] getAngle] + 15];
                    }
                }
                if((framespast % 50) == 0)
                {
                    //wowanothertemportalint = wowanothertemportalint + 15;
                    //[self shootBulletwithPos:3 angle:wowanothertemportalint xpos:0 ypos:0];
                    for(int i = 0; i < [bullets count]; i++)
                    {
                        [[bullets objectAtIndex:i] changeAngle:[[bullets objectAtIndex:i] getAngle] - 15];
                    }
                }
            }
        }
        
    }
    
    [self moveBullet];
    [self moveFakeBullet];
    
    
}
}


-(void) yeswecan
{
    [self shootBulletwithPosSmall:1 angle:270 xpos:-140 ypos:0];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-60 ypos:0];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-20 ypos:0];
    [self shootBulletwithPosSmall:1 angle:270 xpos:0 ypos:0];
    [self shootBulletwithPosSmall:1 angle:270 xpos:20 ypos:0];
    [self shootBulletwithPosSmall:1 angle:270 xpos:60 ypos:0];
    [self shootBulletwithPosSmall:1 angle:270 xpos:80 ypos:0];
    [self shootBulletwithPosSmall:1 angle:270 xpos:100 ypos:0];
    
    [self shootBulletwithPosSmall:1 angle:270 xpos:-120 ypos:-20];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-80 ypos:-20];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-20 ypos:-20];
    [self shootBulletwithPosSmall:1 angle:270 xpos:60 ypos:-20];
    
    [self shootBulletwithPosSmall:1 angle:270 xpos:-100 ypos:-40];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-20 ypos:-40];
    [self shootBulletwithPosSmall:1 angle:270 xpos:0 ypos:-40];
    [self shootBulletwithPosSmall:1 angle:270 xpos:20 ypos:-40];
    [self shootBulletwithPosSmall:1 angle:270 xpos:60 ypos:-40];
    [self shootBulletwithPosSmall:1 angle:270 xpos:80 ypos:-40];
    [self shootBulletwithPosSmall:1 angle:270 xpos:100 ypos:-40];
    
    [self shootBulletwithPosSmall:1 angle:270 xpos:-100 ypos:-60];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-20 ypos:-60];
    [self shootBulletwithPosSmall:1 angle:270 xpos:100 ypos:-60];
    
    
    [self shootBulletwithPosSmall:1 angle:270 xpos:-100 ypos:-80];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-20 ypos:-80];
    [self shootBulletwithPosSmall:1 angle:270 xpos:0 ypos:-80];
    [self shootBulletwithPosSmall:1 angle:270 xpos:20 ypos:-80];
    [self shootBulletwithPosSmall:1 angle:270 xpos:60 ypos:-80];
    [self shootBulletwithPosSmall:1 angle:270 xpos:80 ypos:-80];
    [self shootBulletwithPosSmall:1 angle:270 xpos:100 ypos:-80];
    
    [self shootBulletwithPosSmall:1 angle:270 xpos:0 ypos:-120];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-120 ypos:-120];
    [self shootBulletwithPosSmall:1 angle:270 xpos:40 ypos:-120];
    [self shootBulletwithPosSmall:1 angle:270 xpos:60 ypos:-120];
    [self shootBulletwithPosSmall:1 angle:270 xpos:80 ypos:-120];
    
    [self shootBulletwithPosSmall:1 angle:270 xpos:0 ypos:-140];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-120 ypos:-140];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-60 ypos:-140];
    [self shootBulletwithPosSmall:1 angle:270 xpos:40 ypos:-140];
    
    [self shootBulletwithPosSmall:1 angle:270 xpos:-120 ypos:-160];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-60 ypos:-160];
    [self shootBulletwithPosSmall:1 angle:270 xpos:0 ypos:-160];
    [self shootBulletwithPosSmall:1 angle:270 xpos:40 ypos:-160];
    [self shootBulletwithPosSmall:1 angle:270 xpos:60 ypos:-160];
    [self shootBulletwithPosSmall:1 angle:270 xpos:80 ypos:-160];
    
    [self shootBulletwithPosSmall:1 angle:270 xpos:-100 ypos:-180];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-80 ypos:-180];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-40 ypos:-180];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-20 ypos:-180];
    [self shootBulletwithPosSmall:1 angle:270 xpos:40 ypos:-180];
    
    [self shootBulletwithPosSmall:1 angle:270 xpos:40 ypos:-200];
    [self shootBulletwithPosSmall:1 angle:270 xpos:60 ypos:-200];
    [self shootBulletwithPosSmall:1 angle:270 xpos:80 ypos:-200];
    
    //can
    
    [self shootBulletwithPosSmall:1 angle:270 xpos:-120 ypos:-240];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-100 ypos:-240];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-80 ypos:-240];
    [self shootBulletwithPosSmall:1 angle:270 xpos:0 ypos:-240];
    [self shootBulletwithPosSmall:1 angle:270 xpos:80 ypos:-240];
    [self shootBulletwithPosSmall:1 angle:270 xpos:160 ypos:-240];
    
    [self shootBulletwithPosSmall:1 angle:270 xpos:-120 ypos:-260];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-20 ypos:-260];
    [self shootBulletwithPosSmall:1 angle:270 xpos:20 ypos:-260];
    [self shootBulletwithPosSmall:1 angle:270 xpos:80 ypos:-260];
    [self shootBulletwithPosSmall:1 angle:270 xpos:100 ypos:-260];
    [self shootBulletwithPosSmall:1 angle:270 xpos:160 ypos:-260];
    
    [self shootBulletwithPosSmall:1 angle:270 xpos:-120 ypos:-280];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-40 ypos:-280];
    [self shootBulletwithPosSmall:1 angle:270 xpos:40 ypos:-280];
    [self shootBulletwithPosSmall:1 angle:270 xpos:80 ypos:-280];
    [self shootBulletwithPosSmall:1 angle:270 xpos:120 ypos:-280];
    [self shootBulletwithPosSmall:1 angle:270 xpos:160 ypos:-280];
    
    [self shootBulletwithPosSmall:1 angle:270 xpos:-120 ypos:-300];
    [self shootBulletwithPosSmall:1 angle:270 xpos:140 ypos:-300];
    [self shootBulletwithPosSmall:1 angle:270 xpos:160 ypos:-300];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-40 ypos:-300];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-20 ypos:-300];
    [self shootBulletwithPosSmall:1 angle:270 xpos:0 ypos:-300];
    [self shootBulletwithPosSmall:1 angle:270 xpos:20 ypos:-300];
    [self shootBulletwithPosSmall:1 angle:270 xpos:40 ypos:-300];
    [self shootBulletwithPosSmall:1 angle:270 xpos:80 ypos:-300];
    
    [self shootBulletwithPosSmall:1 angle:270 xpos:-120 ypos:-320];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-100 ypos:-320];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-80 ypos:-320];
    [self shootBulletwithPosSmall:1 angle:270 xpos:-40 ypos:-320];
    [self shootBulletwithPosSmall:1 angle:270 xpos:40 ypos:-320];
    [self shootBulletwithPosSmall:1 angle:270 xpos:80 ypos:-320];
    [self shootBulletwithPosSmall:1 angle:270 xpos:160 ypos:-320];
}
-(void) makeDownvote:(float) xOffset
{
    [self shootBulletwithPos:1 angle:270 xpos:50+xOffset ypos:0];
    //    [self shootBulletwithPos:1 angle:270 xpos:60 ypos:0];
    [self shootBulletwithPos:1 angle:270 xpos:70+xOffset ypos:0];
    //    [self shootBulletwithPos:1 angle:270 xpos:80 ypos:0];
    [self shootBulletwithPos:1 angle:270 xpos:90+xOffset ypos:0];
    //    [self shootBulletwithPos:1 angle:270 xpos:100 ypos:0];
    
    [self shootBulletwithPos:1 angle:270 xpos:50+xOffset ypos:10];
    //    [self shootBulletwithPos:1 angle:270 xpos:60 ypos:10];
    [self shootBulletwithPos:1 angle:270 xpos:70+xOffset ypos:10];
    //    [self shootBulletwithPos:1 angle:270 xpos:80 ypos:10];
    [self shootBulletwithPos:1 angle:270 xpos:90+xOffset ypos:10];
    //    [self shootBulletwithPos:1 angle:270 xpos:100 ypos:10];
    
    [self shootBulletwithPos:1 angle:270 xpos:50+xOffset ypos:20];
    //    [self shootBulletwithPos:1 angle:270 xpos:60 ypos:20];
    [self shootBulletwithPos:1 angle:270 xpos:70+xOffset ypos:20];
    //    [self shootBulletwithPos:1 angle:270 xpos:80 ypos:20];
    [self shootBulletwithPos:1 angle:270 xpos:90+xOffset ypos:20];
    //    [self shootBulletwithPos:1 angle:270 xpos:100 ypos:20];
    
    [self shootBulletwithPos:1 angle:270 xpos:50+xOffset ypos:30];
    //    [self shootBulletwithPos:1 angle:270 xpos:60 ypos:30];
    [self shootBulletwithPos:1 angle:270 xpos:70+xOffset ypos:30];
    //    [self shootBulletwithPos:1 angle:270 xpos:80 ypos:30];
    [self shootBulletwithPos:1 angle:270 xpos:90+xOffset ypos:30];
    //    [self shootBulletwithPos:1 angle:270 xpos:100 ypos:30];
    
    [self shootBulletwithPos:1 angle:270 xpos:50+xOffset ypos:40];
    //    [self shootBulletwithPos:1 angle:270 xpos:60 ypos:40];
    [self shootBulletwithPos:1 angle:270 xpos:70+xOffset ypos:40];
    //    [self shootBulletwithPos:1 angle:270 xpos:80 ypos:40];
    [self shootBulletwithPos:1 angle:270 xpos:90+xOffset ypos:40];
    //    [self shootBulletwithPos:1 angle:270 xpos:100 ypos:40];
    
    [self shootBulletwithPos:1 angle:270 xpos:50+xOffset ypos:50];
    //    [self shootBulletwithPos:1 angle:270 xpos:60 ypos:50];
    [self shootBulletwithPos:1 angle:270 xpos:70+xOffset ypos:50];
    //    [self shootBulletwithPos:1 angle:270 xpos:80 ypos:50];
    [self shootBulletwithPos:1 angle:270 xpos:90+xOffset ypos:50];
    //    [self shootBulletwithPos:1 angle:270 xpos:100 ypos:50];
    
    [self shootBulletwithPos:1 angle:270 xpos:30+xOffset ypos:-10];
    //    [self shootBulletwithPos:1 angle:270 xpos:40 ypos:-10];
    [self shootBulletwithPos:1 angle:270 xpos:50+xOffset ypos:-10];
    //    [self shootBulletwithPos:1 angle:270 xpos:60 ypos:-10];
    [self shootBulletwithPos:1 angle:270 xpos:70+xOffset ypos:-10];
    //    [self shootBulletwithPos:1 angle:270 xpos:80 ypos:-10];
    [self shootBulletwithPos:1 angle:270 xpos:90+xOffset ypos:-10];
    //    [self shootBulletwithPos:1 angle:270 xpos:100 ypos:-10];
    [self shootBulletwithPos:1 angle:270 xpos:110+xOffset ypos:-10];
    //    [self shootBulletwithPos:1 angle:270 xpos:120 ypos:-10];
    
    [self shootBulletwithPos:1 angle:270 xpos:40+xOffset ypos:-20];
    //    [self shootBulletwithPos:1 angle:270 xpos:50 ypos:-20];
    [self shootBulletwithPos:1 angle:270 xpos:60+xOffset ypos:-20];
    //    [self shootBulletwithPos:1 angle:270 xpos:70 ypos:-20];
    [self shootBulletwithPos:1 angle:270 xpos:80+xOffset ypos:-20];
    //    [self shootBulletwithPos:1 angle:270 xpos:90 ypos:-20];
    [self shootBulletwithPos:1 angle:270 xpos:100+xOffset ypos:-20];
    //    [self shootBulletwithPos:1 angle:270 xpos:110 ypos:-20];
    
    [self shootBulletwithPos:1 angle:270 xpos:50+xOffset ypos:-30];
    //    [self shootBulletwithPos:1 angle:270 xpos:60 ypos:-30];
    [self shootBulletwithPos:1 angle:270 xpos:70+xOffset ypos:-30];
    //    [self shootBulletwithPos:1 angle:270 xpos:80 ypos:-30];
    [self shootBulletwithPos:1 angle:270 xpos:90+xOffset ypos:-30];
    //    [self shootBulletwithPos:1 angle:270 xpos:100 ypos:-30];
    
    [self shootBulletwithPos:1 angle:270 xpos:60+xOffset ypos:-40];
    //    [self shootBulletwithPos:1 angle:270 xpos:70 ypos:-40];
    [self shootBulletwithPos:1 angle:270 xpos:80+xOffset ypos:-40];
    //    [self shootBulletwithPos:1 angle:270 xpos:90 ypos:-40];
    
    [self shootBulletwithPos:1 angle:270 xpos:70+xOffset ypos:-50];
    //    [self shootBulletwithPos:1 angle:270 xpos:80 ypos:-50];
    
    
    
    
    //                [self shootBulletwithPos:1 angle:270 xpos:50 ypos:0];
    //                [self shootBulletwithPos:1 angle:270 xpos:60 ypos:0];
    //                [self shootBulletwithPos:1 angle:270 xpos:70 ypos:0];
    //                [self shootBulletwithPos:1 angle:270 xpos:80 ypos:0];
    //                [self shootBulletwithPos:1 angle:270 xpos:90 ypos:0];
    //                [self shootBulletwithPos:1 angle:270 xpos:100 ypos:0];
    //
    //                [self shootBulletwithPos:1 angle:270 xpos:50 ypos:10];
    //                [self shootBulletwithPos:1 angle:270 xpos:60 ypos:10];
    //                [self shootBulletwithPos:1 angle:270 xpos:70 ypos:10];
    //                [self shootBulletwithPos:1 angle:270 xpos:80 ypos:10];
    //                [self shootBulletwithPos:1 angle:270 xpos:90 ypos:10];
    //                [self shootBulletwithPos:1 angle:270 xpos:100 ypos:10];
    //
    //                [self shootBulletwithPos:1 angle:270 xpos:50 ypos:20];
    //                [self shootBulletwithPos:1 angle:270 xpos:60 ypos:20];
    //                [self shootBulletwithPos:1 angle:270 xpos:70 ypos:20];
    //                [self shootBulletwithPos:1 angle:270 xpos:80 ypos:20];
    //                [self shootBulletwithPos:1 angle:270 xpos:90 ypos:20];
    //                [self shootBulletwithPos:1 angle:270 xpos:100 ypos:20];
    //
    //                [self shootBulletwithPos:1 angle:270 xpos:50 ypos:30];
    //                [self shootBulletwithPos:1 angle:270 xpos:60 ypos:30];
    //                [self shootBulletwithPos:1 angle:270 xpos:70 ypos:30];
    //                [self shootBulletwithPos:1 angle:270 xpos:80 ypos:30];
    //                [self shootBulletwithPos:1 angle:270 xpos:90 ypos:30];
    //                [self shootBulletwithPos:1 angle:270 xpos:100 ypos:30];
    //
    //                [self shootBulletwithPos:1 angle:270 xpos:50 ypos:40];
    //                [self shootBulletwithPos:1 angle:270 xpos:60 ypos:40];
    //                [self shootBulletwithPos:1 angle:270 xpos:70 ypos:40];
    //                [self shootBulletwithPos:1 angle:270 xpos:80 ypos:40];
    //                [self shootBulletwithPos:1 angle:270 xpos:90 ypos:40];
    //                [self shootBulletwithPos:1 angle:270 xpos:100 ypos:40];
    //
    //                [self shootBulletwithPos:1 angle:270 xpos:50 ypos:50];
    //                [self shootBulletwithPos:1 angle:270 xpos:60 ypos:50];
    //                [self shootBulletwithPos:1 angle:270 xpos:70 ypos:50];
    //                [self shootBulletwithPos:1 angle:270 xpos:80 ypos:50];
    //                [self shootBulletwithPos:1 angle:270 xpos:90 ypos:50];
    //                [self shootBulletwithPos:1 angle:270 xpos:100 ypos:50];
    //
    //                [self shootBulletwithPos:1 angle:270 xpos:30 ypos:-10];
    //                [self shootBulletwithPos:1 angle:270 xpos:40 ypos:-10];
    //                [self shootBulletwithPos:1 angle:270 xpos:50 ypos:-10];
    //                [self shootBulletwithPos:1 angle:270 xpos:60 ypos:-10];
    //                [self shootBulletwithPos:1 angle:270 xpos:70 ypos:-10];
    //                [self shootBulletwithPos:1 angle:270 xpos:80 ypos:-10];
    //                [self shootBulletwithPos:1 angle:270 xpos:90 ypos:-10];
    //                [self shootBulletwithPos:1 angle:270 xpos:100 ypos:-10];
    //                [self shootBulletwithPos:1 angle:270 xpos:110 ypos:-10];
    //                [self shootBulletwithPos:1 angle:270 xpos:120 ypos:-10];
    //
    //                [self shootBulletwithPos:1 angle:270 xpos:40 ypos:-20];
    //                [self shootBulletwithPos:1 angle:270 xpos:50 ypos:-20];
    //                [self shootBulletwithPos:1 angle:270 xpos:60 ypos:-20];
    //                [self shootBulletwithPos:1 angle:270 xpos:70 ypos:-20];
    //                [self shootBulletwithPos:1 angle:270 xpos:80 ypos:-20];
    //                [self shootBulletwithPos:1 angle:270 xpos:90 ypos:-20];
    //                [self shootBulletwithPos:1 angle:270 xpos:100 ypos:-20];
    //                [self shootBulletwithPos:1 angle:270 xpos:110 ypos:-20];
    //
    //                [self shootBulletwithPos:1 angle:270 xpos:50 ypos:-30];
    //                [self shootBulletwithPos:1 angle:270 xpos:60 ypos:-30];
    //                [self shootBulletwithPos:1 angle:270 xpos:70 ypos:-30];
    //                [self shootBulletwithPos:1 angle:270 xpos:80 ypos:-30];
    //                [self shootBulletwithPos:1 angle:270 xpos:90 ypos:-30];
    //                [self shootBulletwithPos:1 angle:270 xpos:100 ypos:-30];
    //
    //                [self shootBulletwithPos:1 angle:270 xpos:60 ypos:-40];
    //                [self shootBulletwithPos:1 angle:270 xpos:70 ypos:-40];
    //                [self shootBulletwithPos:1 angle:270 xpos:80 ypos:-40];
    //                [self shootBulletwithPos:1 angle:270 xpos:90 ypos:-40];
    //
    //                [self shootBulletwithPos:1 angle:270 xpos:70 ypos:-50];
    //                [self shootBulletwithPos:1 angle:270 xpos:80 ypos:-50];
    
    //[self shootBulletwithPos:1 angle:270 xpos:80 ypos:-60];
}


-(void) makeDownvoteSpeed:(float) xOffset speed:(float) speedInput
{
    [self shootBulletwithPos:speedInput angle:270 xpos:50+xOffset ypos:0];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:60 ypos:0];
    [self shootBulletwithPos:speedInput angle:270 xpos:70+xOffset ypos:0];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:80 ypos:0];
    [self shootBulletwithPos:speedInput angle:270 xpos:90+xOffset ypos:0];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:100 ypos:0];
    
    [self shootBulletwithPos:speedInput angle:270 xpos:50+xOffset ypos:10];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:60 ypos:10];
    [self shootBulletwithPos:speedInput angle:270 xpos:70+xOffset ypos:10];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:80 ypos:10];
    [self shootBulletwithPos:speedInput angle:270 xpos:90+xOffset ypos:10];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:100 ypos:10];
    
    [self shootBulletwithPos:speedInput angle:270 xpos:50+xOffset ypos:20];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:60 ypos:20];
    [self shootBulletwithPos:speedInput angle:270 xpos:70+xOffset ypos:20];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:80 ypos:20];
    [self shootBulletwithPos:speedInput angle:270 xpos:90+xOffset ypos:20];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:100 ypos:20];
    
    [self shootBulletwithPos:speedInput angle:270 xpos:50+xOffset ypos:30];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:60 ypos:30];
    [self shootBulletwithPos:speedInput angle:270 xpos:70+xOffset ypos:30];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:80 ypos:30];
    [self shootBulletwithPos:speedInput angle:270 xpos:90+xOffset ypos:30];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:100 ypos:30];
    
    [self shootBulletwithPos:speedInput angle:270 xpos:50+xOffset ypos:40];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:60 ypos:40];
    [self shootBulletwithPos:speedInput angle:270 xpos:70+xOffset ypos:40];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:80 ypos:40];
    [self shootBulletwithPos:speedInput angle:270 xpos:90+xOffset ypos:40];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:100 ypos:40];
    
    [self shootBulletwithPos:speedInput angle:270 xpos:50+xOffset ypos:50];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:60 ypos:50];
    [self shootBulletwithPos:speedInput angle:270 xpos:70+xOffset ypos:50];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:80 ypos:50];
    [self shootBulletwithPos:speedInput angle:270 xpos:90+xOffset ypos:50];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:100 ypos:50];
    
    [self shootBulletwithPos:speedInput angle:270 xpos:30+xOffset ypos:-10];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:40 ypos:-10];
    [self shootBulletwithPos:speedInput angle:270 xpos:50+xOffset ypos:-10];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:60 ypos:-10];
    [self shootBulletwithPos:speedInput angle:270 xpos:70+xOffset ypos:-10];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:80 ypos:-10];
    [self shootBulletwithPos:speedInput angle:270 xpos:90+xOffset ypos:-10];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:100 ypos:-10];
    [self shootBulletwithPos:speedInput angle:270 xpos:110+xOffset ypos:-10];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:120 ypos:-10];
    
    [self shootBulletwithPos:speedInput angle:270 xpos:40+xOffset ypos:-20];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:50 ypos:-20];
    [self shootBulletwithPos:speedInput angle:270 xpos:60+xOffset ypos:-20];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:70 ypos:-20];
    [self shootBulletwithPos:speedInput angle:270 xpos:80+xOffset ypos:-20];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:90 ypos:-20];
    [self shootBulletwithPos:speedInput angle:270 xpos:100+xOffset ypos:-20];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:110 ypos:-20];
    
    [self shootBulletwithPos:speedInput angle:270 xpos:50+xOffset ypos:-30];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:60 ypos:-30];
    [self shootBulletwithPos:speedInput angle:270 xpos:70+xOffset ypos:-30];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:80 ypos:-30];
    [self shootBulletwithPos:speedInput angle:270 xpos:90+xOffset ypos:-30];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:100 ypos:-30];
    
    [self shootBulletwithPos:speedInput angle:270 xpos:60+xOffset ypos:-40];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:70 ypos:-40];
    [self shootBulletwithPos:speedInput angle:270 xpos:80+xOffset ypos:-40];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:90 ypos:-40];
    
    [self shootBulletwithPos:speedInput angle:270 xpos:70+xOffset ypos:-50];
    //    [self shootBulletwithPos:speedInput angle:270 xpos:80 ypos:-50];
    
    
    
    
    //                [self shootBulletwithPos:1 angle:270 xpos:50 ypos:0];
    //                [self shootBulletwithPos:1 angle:270 xpos:60 ypos:0];
    //                [self shootBulletwithPos:1 angle:270 xpos:70 ypos:0];
    //                [self shootBulletwithPos:1 angle:270 xpos:80 ypos:0];
    //                [self shootBulletwithPos:1 angle:270 xpos:90 ypos:0];
    //                [self shootBulletwithPos:1 angle:270 xpos:100 ypos:0];
    //
    //                [self shootBulletwithPos:1 angle:270 xpos:50 ypos:10];
    //                [self shootBulletwithPos:1 angle:270 xpos:60 ypos:10];
    //                [self shootBulletwithPos:1 angle:270 xpos:70 ypos:10];
    //                [self shootBulletwithPos:1 angle:270 xpos:80 ypos:10];
    //                [self shootBulletwithPos:1 angle:270 xpos:90 ypos:10];
    //                [self shootBulletwithPos:1 angle:270 xpos:100 ypos:10];
    //
    //                [self shootBulletwithPos:1 angle:270 xpos:50 ypos:20];
    //                [self shootBulletwithPos:1 angle:270 xpos:60 ypos:20];
    //                [self shootBulletwithPos:1 angle:270 xpos:70 ypos:20];
    //                [self shootBulletwithPos:1 angle:270 xpos:80 ypos:20];
    //                [self shootBulletwithPos:1 angle:270 xpos:90 ypos:20];
    //                [self shootBulletwithPos:1 angle:270 xpos:100 ypos:20];
    //
    //                [self shootBulletwithPos:1 angle:270 xpos:50 ypos:30];
    //                [self shootBulletwithPos:1 angle:270 xpos:60 ypos:30];
    //                [self shootBulletwithPos:1 angle:270 xpos:70 ypos:30];
    //                [self shootBulletwithPos:1 angle:270 xpos:80 ypos:30];
    //                [self shootBulletwithPos:1 angle:270 xpos:90 ypos:30];
    //                [self shootBulletwithPos:1 angle:270 xpos:100 ypos:30];
    //
    //                [self shootBulletwithPos:1 angle:270 xpos:50 ypos:40];
    //                [self shootBulletwithPos:1 angle:270 xpos:60 ypos:40];
    //                [self shootBulletwithPos:1 angle:270 xpos:70 ypos:40];
    //                [self shootBulletwithPos:1 angle:270 xpos:80 ypos:40];
    //                [self shootBulletwithPos:1 angle:270 xpos:90 ypos:40];
    //                [self shootBulletwithPos:1 angle:270 xpos:100 ypos:40];
    //
    //                [self shootBulletwithPos:1 angle:270 xpos:50 ypos:50];
    //                [self shootBulletwithPos:1 angle:270 xpos:60 ypos:50];
    //                [self shootBulletwithPos:1 angle:270 xpos:70 ypos:50];
    //                [self shootBulletwithPos:1 angle:270 xpos:80 ypos:50];
    //                [self shootBulletwithPos:1 angle:270 xpos:90 ypos:50];
    //                [self shootBulletwithPos:1 angle:270 xpos:100 ypos:50];
    //
    //                [self shootBulletwithPos:1 angle:270 xpos:30 ypos:-10];
    //                [self shootBulletwithPos:1 angle:270 xpos:40 ypos:-10];
    //                [self shootBulletwithPos:1 angle:270 xpos:50 ypos:-10];
    //                [self shootBulletwithPos:1 angle:270 xpos:60 ypos:-10];
    //                [self shootBulletwithPos:1 angle:270 xpos:70 ypos:-10];
    //                [self shootBulletwithPos:1 angle:270 xpos:80 ypos:-10];
    //                [self shootBulletwithPos:1 angle:270 xpos:90 ypos:-10];
    //                [self shootBulletwithPos:1 angle:270 xpos:100 ypos:-10];
    //                [self shootBulletwithPos:1 angle:270 xpos:110 ypos:-10];
    //                [self shootBulletwithPos:1 angle:270 xpos:120 ypos:-10];
    //
    //                [self shootBulletwithPos:1 angle:270 xpos:40 ypos:-20];
    //                [self shootBulletwithPos:1 angle:270 xpos:50 ypos:-20];
    //                [self shootBulletwithPos:1 angle:270 xpos:60 ypos:-20];
    //                [self shootBulletwithPos:1 angle:270 xpos:70 ypos:-20];
    //                [self shootBulletwithPos:1 angle:270 xpos:80 ypos:-20];
    //                [self shootBulletwithPos:1 angle:270 xpos:90 ypos:-20];
    //                [self shootBulletwithPos:1 angle:270 xpos:100 ypos:-20];
    //                [self shootBulletwithPos:1 angle:270 xpos:110 ypos:-20];
    //
    //                [self shootBulletwithPos:1 angle:270 xpos:50 ypos:-30];
    //                [self shootBulletwithPos:1 angle:270 xpos:60 ypos:-30];
    //                [self shootBulletwithPos:1 angle:270 xpos:70 ypos:-30];
    //                [self shootBulletwithPos:1 angle:270 xpos:80 ypos:-30];
    //                [self shootBulletwithPos:1 angle:270 xpos:90 ypos:-30];
    //                [self shootBulletwithPos:1 angle:270 xpos:100 ypos:-30];
    //
    //                [self shootBulletwithPos:1 angle:270 xpos:60 ypos:-40];
    //                [self shootBulletwithPos:1 angle:270 xpos:70 ypos:-40];
    //                [self shootBulletwithPos:1 angle:270 xpos:80 ypos:-40];
    //                [self shootBulletwithPos:1 angle:270 xpos:90 ypos:-40];
    //
    //                [self shootBulletwithPos:1 angle:270 xpos:70 ypos:-50];
    //                [self shootBulletwithPos:1 angle:270 xpos:80 ypos:-50];
    
    //[self shootBulletwithPos:1 angle:270 xpos:80 ypos:-60];
}



-(void) initObstacles
{
    int x = 20;
    int y= 20;
    for (int i = 0; i < 1; i++)
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
    if(bosstime == true)
    {
        if(level == 1)
        {
            tut = [CCLabelTTF labelWithString:@"New Boss!" fontName:@"Bend2SquaresBRK" fontSize:60];
            
            tut.position = ccp(160,320);
            
            tut.color = ccc3(0, 0, 0);
            [self addChild:tut];
            
            id newboss = [CCScaleTo actionWithDuration:0.5f scale:1.0f];
            [tut runAction:newboss];
            [self schedule:@selector(newBoss) interval:3.0];
            
            int x = 150;
            int y = 400;
            boss = [CCSprite spriteWithFile:@"Glowing_Blue_Orb.png"];
            boss.position = ccp(x,y);
            boss.scale = 0;
            [self addChild:boss z:0];
            
            id bossscale = [CCScaleTo actionWithDuration:1.0f scale:0.5f];
            [boss runAction:bossscale];
            
            [self shootBullet:1 angle:270];
        }
        else if(level == 2)
        {
            int x = 150;
            int y = 400;
            boss = [CCSprite spriteWithFile:@"download.png"];
            boss.position = ccp(x,y);
            boss.scale = 0;
            [self addChild:boss z:0];
            
            id bossscale = [CCScaleTo actionWithDuration:1.0f scale:0.5f];
            [boss runAction:bossscale];
            
            [self shootBullet:1 angle:90];
        }
        else if(level == 3)
        {
            int x = 150;
            int y = 400;
            boss = [CCSprite spriteWithFile:@"w_obama.png"];
            boss.position = ccp(x,y);
            boss.scale = 0;
            [self addChild:boss z:0];
            
            id bossscale = [CCScaleTo actionWithDuration:1.0f scale:0.5f];
            [boss runAction:bossscale];
            
            [self shootBullet:1 angle:90];
        }
        else if(level == 4)
        {
            int x = 150;
            int y = 400;
            boss = [CCSprite spriteWithFile:@"flower.png"];
            boss.position = ccp(x,y);
            boss.scale = 0;
            [self addChild:boss z:0];
            
            id bossscale = [CCScaleTo actionWithDuration:1.0f scale:0.5f];
            [boss runAction:bossscale];
            
            [self shootBullet:1 angle:90];
        }
    }
    else if(bosstime == false)
    {
        int x = 150;
        int y = 500;
        boss = [CCSprite spriteWithFile:@"Glowing_Blue_Orb.png"];
        boss.position = ccp(x,y);
        boss.scale = 0;
        [self addChild:boss z:0];
        
        id bossscale = [CCScaleTo actionWithDuration:1.0f scale:0.1f];
        [boss runAction:bossscale];
        
        [self shootBullet:1 angle:90];
    }
}













- (void)newBoss {
    
    [self unschedule:@selector(mySelector)];
    
    
    [self removeChild:tut];
    
}


-(void) grabTouchCoord
{
    // Methods that should run every frame here!
    KKInput *input = [KKInput sharedInput];
    //This will be true as long as there is at least one finger touching the screen
    
    
    
    
    
    if(input.touchesAvailable)
    {
        //[self stopAction:movePlayer];
        //[self movePlayerToCoord];
        playerpos = player.position;
        
        posTouchScreen = [input locationOfAnyTouchInPhase:KKTouchPhaseAny];
        //        [self calculateAngleWith:playerpos andWith:posTouchScreen andSetVariable:touchangle];
        
        CGPoint rot_pos2 = [player position];
        CGPoint rot_pos1 = posTouchScreen;
        
        if(rot_pos2.x - rot_pos1.x > 1 || rot_pos1.x - rot_pos2.x > 1)
        {
            if(rot_pos2.y - rot_pos1.y > 1 || rot_pos1.y - rot_pos2.y > 1)
            {
                
                
                float rotation_theta = atan((rot_pos1.y-rot_pos2.y)/(rot_pos1.x-rot_pos2.x)) * 180 / M_PI;
                
                //        float rotation;
                
                if(rot_pos1.y - rot_pos2.y > 0)
                {
                    if(rot_pos1.x - rot_pos2.x < 0)
                    {
                        touchangle = (-90-rotation_theta);
                    }
                    else if(rot_pos1.x - rot_pos2.x > 0)
                    {
                        touchangle = (90-rotation_theta);
                    }
                }
                else if(rot_pos1.y - rot_pos2.y < 0)
                {
                    if(rot_pos1.x - rot_pos2.x < 0)
                    {
                        touchangle = (270-rotation_theta);
                    }
                    else if(rot_pos1.x - rot_pos2.x > 0)
                    {
                        touchangle = (90-rotation_theta);
                    }
                }
                
                if (touchangle < 0)
                {
                    touchangle+=360;
                }
                
                
                
                
                //        NSLog(@"%f", touchangle);
                
                float speed = 10; // Move 50 pixels in 60 frames (1 second)
                
                float vx = cos(touchangle * M_PI / 180) * speed;
                float vy = sin(touchangle * M_PI / 180) * speed;
                
                CGPoint direction = ccp(vy,vx);
                
                // NSLog(NSStringFromCGPoint(direction));
                
                player.position = ccpAdd(player.position, direction);
                
                shield.position = player.position;
                
                //player.rotation = touchangle;
                
            }
            
        }
        
    }
}



-(void) detectCollisions
{
    
    if (CGRectIntersectsRect(CGRectMake(player.position.x, player.position.y, playerWidth, playerHeight), CGRectMake(boss.position.x, boss.position.y, bossWidth, bossHeight)) == true)
    {
        // NSLog(@"Collision detected!");
        
        [self removeChild:player cleanup:YES];
        
    }
    for(int i = 0; i < [bullets count]; i++)
    {
        
        NSInteger j = i;
        CCSprite* tempSprite = [bullets objectAtIndex:j];
        if ([self isCollidingSphere:tempSprite WithSphere:player] == true) {
            if(shieldon == true)
            {
                [self removeChild:tempSprite];
                [bullets removeObjectAtIndex:i];
                [self removeChild:shield];
                shieldon = false;
            }
            else{
                //NSLog(@"Collision detected!");
                
                gameSegment = 0;
                framespast = 0;
                secondspast = 0;
                
                [[SimpleAudioEngine sharedEngine] playEffect:@"zoom.mp3"];
                
                [[NSUserDefaults standardUserDefaults] setInteger:intScore forKey:@"score"];
                
                [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5f scene:[Dead node]]];
            }
        }
    }
    
        for(int i = 0; i < [fakebullets count]; i++)
        {
            NSInteger j = i;
            if([fakebullets count] > 0)
            {
                
                CCSprite* tempFakeSprite = [fakebullets objectAtIndex:j];
                if ([self isCollidingSphere:[fakebullets objectAtIndex:j] WithSphere:player] == true)
                {
                    // NSLog(@"Collision detected!");
                    
                    [self removeChild:tempFakeSprite cleanup:YES];
                    [fakebullets removeObjectAtIndex:j];
                    intScore = intScore + 100;
                    // NSLog([NSString stringWithFormat:@"%d", intScore]);
                    NSString *str = [NSString stringWithFormat:@"%d",intScore];
                    [label setString:str];
                    [label draw];
                    
                    if(bwooo == false)
                    {
                        //[[SimpleAudioEngine sharedEngine] playEffect:@"bwooo.mp3"];
                        bwooo = true;
                    }
                }
            }
        }
    
    
    for(int i = 0; i < [powerups count];i++)
    {
        NSInteger j = i;
        CCSprite* tempSprite = [powerups objectAtIndex:j];
        if ([self isCollidingSphere:tempSprite WithSphere:player] == true) {
            //NSLog(@"Collision detected!");
            
            [self removeChild:tempSprite];
            [powerups removeAllObjects];
            
            [self returnBullet];
            for(int i = 0; i < [bullets count]; i++)
            {
                Bullet *temp = [bullets objectAtIndex:i];
                
                [self removeChild:temp];
                
                
                
                
                //  [bullets removeObjectAtIndex:j];
                //[bulletDirection removeObjectAtIndex:j];
                //[bulletSpeed removeObjectAtIndex:j];
                
                
            }
            
            [bullets removeAllObjects];
            
            shield = [CCSprite spriteWithFile:@"shield.png"];
            shield.scale = 0.2;
            shield.position = player.position;
            [self addChild:shield z:-10];
            shieldon = true;
            
        }
    }
}

-(void) pause
{
    [[CCDirector sharedDirector] pushScene:
     [CCTransitionCrossFade transitionWithDuration:0.5f scene:[Pausue node]]];
}


-(void) moveBullet
{
    //move the bullets
    for(int i = 0; i < [bullets count]; i++)
    {
        NSInteger j = i;
        projectile = [bullets objectAtIndex:j];
        float angle = [[bullets objectAtIndex:j] getAngle];
        float speed = [[bullets objectAtIndex:j] getSpeed]; // Move 50 pixels in 60 frames (1 second)
        
        float vx = cos(angle * M_PI / 180) * speed;
        float vy = sin(angle * M_PI / 180) * speed;
        
        CGPoint direction = ccp(vx,vy);
        
        projectile.position = ccpAdd(projectile.position, direction);
        
    }
    for(int i = 0; i < [donkeys count]; i++)
    {
        NSInteger j = i;
        projectile = [donkeys objectAtIndex:j];
        float angle = 270;
        float speed = 3;
        
        float vx = cos(angle * M_PI / 180) * speed;
        float vy = sin(angle * M_PI / 180) * speed;
        
        CGPoint direction = ccp(vx,vy);
        
        projectile.position = ccpAdd(projectile.position, direction);
        
    }
    for(int i = 0; i < [powerups count]; i++)
    {
        NSInteger j = i;
        projectile = [powerups objectAtIndex:j];
        float angle = [[powerups objectAtIndex:j] getAngle];
        float speed = [[powerups objectAtIndex:j] getSpeed]; // Move 50 pixels in 60 frames (1 second)
        
        float vx = cos(angle * M_PI / 180) * speed;
        float vy = sin(angle * M_PI / 180) * speed;
        
        CGPoint direction = ccp(vx,vy);
        
        projectile.position = ccpAdd(projectile.position, direction);
        
    }
    
    
    
    
    //NSLog([NSString stringWithFormat:@"%d", [bullets count]]);
    //NSLog([NSString stringWithFormat:@"%d", [fakebullets count]]);
    
    
    
}

-(void) shootBullet: (float) speed angle:(float) angleInput
{
    Bullet *newB = [Bullet bullet:speed :angleInput];
    //    Bullet *b = [[Bullet alloc] initWithValues:speed :angleInput];
    newB.position = boss.position;
    //  newB.position.x = newB.position.x + xInput;
    //    [b setPosition:player.position];
    
    //    b.position = ccp(30, 30);
    [self addChild:newB z:9];
    [bullets addObject:newB];
    newB.scale = 0;
    id scale = [CCScaleTo actionWithDuration:1.0f scale:0.1f];
    [newB runAction:scale];
    //   [[SimpleAudioEngine sharedEngine] playEffect:@"swip.mp3"];
}


-(void) shootBulletwithPos: (float) speed angle:(float) angleInput xpos:(float) xInput ypos:(float) yInput
{
    Bullet *newB = [Bullet bullet:speed :angleInput];
    //    Bullet *b = [[Bullet alloc] initWithValues:speed :angleInput];
    newB.position = boss.position;
    newB.position = ccp(newB.position.x + xInput, newB.position.y + yInput);
    //    [b setPosition:player.position];
    
    //    b.position = ccp(30, 30);
    [self addChild:newB z:9];
    [bullets addObject:newB];
    newB.scale = 0;
    id scale = [CCScaleTo actionWithDuration:1.0f scale:0.1f];
    [newB runAction:scale];
}

-(void) shootBulletwithPosPowerup: (float) speed angle:(float) angleInput xpos:(float) xInput ypos:(float) yInput
{
    if(shieldon == false)
    {
        Powerup *newB = [Powerup powerup:speed :angleInput];
        //    Bullet *b = [[Bullet alloc] initWithValues:speed :angleInput];
        newB.position = boss.position;
        newB.position = ccp(newB.position.x + xInput, newB.position.y + yInput);
        //    [b setPosition:player.position];
        
        //    b.position = ccp(30, 30);
        [self addChild:newB z:9];
        [powerups addObject:newB];
        newB.scale = 0.2f;
    }
    
}

-(void) shootBulletwithPosDonkey: (float) speed angle:(float) angleInput xpos:(float) xInput ypos:(float) yInput
{
    Bullet *newB = [Bullet bullet:speed :angleInput];
    //    Bullet *b = [[Bullet alloc] initWithValues:speed :angleInput];
    newB.position = boss.position;
    newB.position = ccp(newB.position.x + xInput, newB.position.y + yInput);
    //    [b setPosition:player.position];
    
    //    b.position = ccp(30, 30);
    [self addChild:newB z:9];
    [bullets addObject:newB];
    newB.scale = 0;
    id scale = [CCScaleTo actionWithDuration:1.0f scale:0.1f];
    [newB runAction:scale];
    
    donkey = [CCSprite spriteWithFile:@"Democrat_Donkey.png"];
    donkey.position = newB.position;
    donkey.scale = 0;
    [self addChild:donkey z:0];
    
    id bossscale = [CCScaleTo actionWithDuration:1.0f scale:0.5f];
    [donkey runAction:bossscale];
    
    [donkeys addObject:donkey];
}

-(void) shootBulletwithPosSmall: (float) speed angle:(float) angleInput xpos:(float) xInput ypos:(float) yInput
{
    Bullet *newB = [Bullet bullet:speed :angleInput];
    //    Bullet *b = [[Bullet alloc] initWithValues:speed :angleInput];
    newB.position = boss.position;
    newB.position = ccp(newB.position.x + xInput, newB.position.y + yInput +200);
    //    [b setPosition:player.position];
    
    //    b.position = ccp(30, 30);
    [self addChild:newB z:9];
    [bullets addObject:newB];
    newB.scale = 0;
    id scale = [CCScaleTo actionWithDuration:1.0f scale:0.05f];
    [newB runAction:scale];
}

-(void) returnBullet
{
    for(int i = 0; i < [bullets count]; i++)
    {
        NSInteger j = i;
        projectile = [bullets objectAtIndex:j];
        fakebullet = [CCSprite spriteWithFile:@"orange.png"];
        fakebullet.position = projectile.position;
        [self addChild:fakebullet];
        [fakebullets addObject:fakebullet];
        fakebullet.scale = 0.1;
        
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"bwooo.mp3"];
        bwooo = false;
        
    }
    
}

-(void) gameSeg
{
    if(bosstime == true)
    {
        if(level == 1)
        {
            if(framespast == 440)
            {
                gameSegment = 1;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    Bullet *temp = [bullets objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                
                [bullets removeAllObjects];
            }
            if(framespast == 740)
            {
                gameSegment = 2;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    Bullet *temp = [bullets objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                }
                [bullets removeAllObjects];
            }
            if(framespast == 940)
            {
                gameSegment = 3;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    NSInteger j = i;
                    
                    [self removeChild:[bullets objectAtIndex:j]];
                    
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                [bullets removeAllObjects];
            }
            if(framespast == 1140)
            {
                gameSegment = 4;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    NSInteger j = i;
                    
                    [self removeChild:[bullets objectAtIndex:j]];
                    
                    /// [bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                [bullets removeAllObjects];
            }
            if(framespast == 1300)
            {
                gameSegment = 5;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    //            NSInteger j = i;
                    CCSprite *tempB = [bullets objectAtIndex:i];
                    
                    [self removeChild:tempB];
                    
                    //[bulletDirection removeObjectAtIndex:i];
                    // [bulletSpeed removeObjectAtIndex:i];
                    
                    
                    
                }
                [bullets removeAllObjects];
            }
            if(framespast == 1700)
            {
                gameSegment = 6;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    NSInteger j = i;
                    
                    [self removeChild:[bullets objectAtIndex:j]];
                    
                    // [bulletDirection removeObjectAtIndex:j];
                    // [bulletSpeed removeObjectAtIndex:j];
                    
                    
                    
                }
                [bullets removeAllObjects];
            }
            if(framespast == 1900)
            {
                gameSegment = 7;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    NSInteger j = i;
                    
                    [self removeChild:[bullets objectAtIndex:j]];
                    
                    // [bulletDirection removeObjectAtIndex:j];
                    // [bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                [bullets removeAllObjects];
                
                [self gameEnd];
            }
        }
        
        if(level == 2)
        {
            if(framespast == 540)
            {
                gameSegment = 1;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    Bullet *temp = [bullets objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                
                [bullets removeAllObjects];
            }
            if(framespast == 640)
            {
                gameSegment = 2;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    Bullet *temp = [bullets objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                
                [bullets removeAllObjects];
            }
            if(framespast == 840)
            {
                gameSegment = 3;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    Bullet *temp = [bullets objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                
                [bullets removeAllObjects];
            }
            if(framespast == 1260)
            {
                gameSegment = 4;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    Bullet *temp = [bullets objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                
                [bullets removeAllObjects];
            }
            if(framespast == 1460)
            {
                gameSegment = 5;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    Bullet *temp = [bullets objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                
                [bullets removeAllObjects];
            }
            if(framespast == 2000)
            {
                gameSegment = 6;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    Bullet *temp = [bullets objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                
                [bullets removeAllObjects];
                
                [self gameEnd];
            }
            
            
        }
        
        if(level == 3)
        {
            if(framespast == 350)
            {
                gameSegment = 1;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    Bullet *temp = [bullets objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                [bullets removeAllObjects];
                
            }
            if(framespast == 650)
            {
                gameSegment = 2;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    Bullet *temp = [bullets objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                for(int i = 0; i < [donkeys count]; i++)
                {
                    CCSprite *temp = [donkeys objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                
                [donkeys removeAllObjects];
                [bullets removeAllObjects];
            }
            if(framespast == 1050)
            {
                gameSegment = 3;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    Bullet *temp = [bullets objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                [bullets removeAllObjects];
            }
            if(framespast == 1450)
            {
                gameSegment = 4;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    Bullet *temp = [bullets objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                [bullets removeAllObjects];
            }
            if(framespast == 1750)
            {
                gameSegment = 5;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    Bullet *temp = [bullets objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                [bullets removeAllObjects];
            }
            if(framespast == 2000)
            {
                gameSegment = 6;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    Bullet *temp = [bullets objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                [bullets removeAllObjects];
                
                [self gameEnd];
            }
            
            
            
            
            
        }
        
        if(level == 4)
        {
            if(framespast == 350)
            {
                gameSegment = 1;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    Bullet *temp = [bullets objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                [bullets removeAllObjects];
                
            }
            if(framespast == 650)
            {
                gameSegment = 2;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    Bullet *temp = [bullets objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                for(int i = 0; i < [donkeys count]; i++)
                {
                    CCSprite *temp = [donkeys objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                
                [donkeys removeAllObjects];
                [bullets removeAllObjects];
            }
            if(framespast == 1050)
            {
                gameSegment = 3;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    Bullet *temp = [bullets objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                [bullets removeAllObjects];
            }
            if(framespast == 1450)
            {
                gameSegment = 4;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    Bullet *temp = [bullets objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                [bullets removeAllObjects];
            }
            if(framespast == 1750)
            {
                gameSegment = 5;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    Bullet *temp = [bullets objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                [bullets removeAllObjects];
            }
            if(framespast == 2000)
            {
                gameSegment = 6;
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    Bullet *temp = [bullets objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                [bullets removeAllObjects];
                
                [self gameEnd];
            }
            
            
            
            
            
        }
    }
    
    
    
    
    if(bosstime == false)
    {
        if(framespast == 300)
        {
            if(stagespast > 5)
            {
                
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    Bullet *temp = [bullets objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    int randomtemp = arc4random() % 10;
                    
                    if(randomtemp == 5)
                    {
                        [self shootBulletwithPosPowerup:1 angle:260 xpos:0 ypos:0];
                    }
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                
                [bullets removeAllObjects];
                attacktype = 0;
                framespast = 0;
                stagespast++;
            }
            if(stagespast < 6)
            {
                
                [self returnBullet];
                for(int i = 0; i < [bullets count]; i++)
                {
                    Bullet *temp = [bullets objectAtIndex:i];
                    
                    [self removeChild:temp];
                    
                    
                    
                    
                    //  [bullets removeObjectAtIndex:j];
                    //[bulletDirection removeObjectAtIndex:j];
                    //[bulletSpeed removeObjectAtIndex:j];
                    
                    
                }
                
                [bullets removeAllObjects];
                attacktype++;
                framespast = 0;
                stagespast++;
            }
        }
        
        if(stagespast == 5)
        {
            bosstime = true;
            level = 1;
            [self initBoss];
        }
        else if(stagespast == 10)
        {
            bosstime = true;
            level = 2;
            [self initBoss];
        }
        else if(stagespast == 15)
        {
            bosstime = true;
            level = 3;
            [self initBoss];
        }
        else if(stagespast == 20)
        {
            bosstime = true;
            level = 4;
            [self initBoss];
        }
    }
}


-(void) gameEnd
{
    [self shootBulletwithPosPowerup:3 angle:260 xpos:0 ypos:0];
    
    id bossscale = [CCScaleTo actionWithDuration:1.0f scale:2.0f];
    [boss runAction:bossscale];
    
    id bossturn = [CCRotateTo actionWithDuration:3.0 angle:200];
    [boss runAction:bossturn];
    
    id bossscale2 = [CCScaleTo actionWithDuration:3.0f scale:0.0f];
    [boss runAction:bossscale2];
    
    [self schedule:@selector(mySelector) interval:3.0];
    
    
    
    
}

- (void)mySelector {
    
    [self unschedule:@selector(mySelector)];
    
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"endless"] == false)
    {
        [[CCDirector sharedDirector] pushScene:
         [CCTransitionCrossFade transitionWithDuration:0.5f scene:[LevelSelect node]]];
    }
    
    // [[CCDirector sharedDirector] pushScene:
    //[CCTransitionCrossFade transitionWithDuration:0.5f scene:[LevelSelect node]]];
    stagespast = stagespast + 1;
    bosstime = false;
    [self initBoss];
    gameSegment = 0;
    framespast = 0;
    
}


-(void) moveFakeBullet
{
    for(int i = 0; i < [fakebullets count]; i++)
    {
        //NSLog(@"d");
        NSInteger j = i;
        
        projectile2 = [fakebullets objectAtIndex:j];
        
        
        CGPoint rot_pos2 = [projectile2 position];
        CGPoint rot_pos1 = [player position];
        
        float rotation_theta = atan((rot_pos1.y-rot_pos2.y)/(rot_pos1.x-rot_pos2.x)) * 180 / M_PI;
        
        //        float rotation;
        
        if(rot_pos1.y - rot_pos2.y > 0)
        {
            if(rot_pos1.x - rot_pos2.x < 0)
            {
                fakebulletangle = (-90-rotation_theta);
            }
            else if(rot_pos1.x - rot_pos2.x > 0)
            {
                fakebulletangle = (90-rotation_theta);
            }
        }
        else if(rot_pos1.y - rot_pos2.y < 0)
        {
            if(rot_pos1.x - rot_pos2.x < 0)
            {
                fakebulletangle = (270-rotation_theta);
            }
            else if(rot_pos1.x - rot_pos2.x > 0)
            {
                fakebulletangle = (90-rotation_theta);
            }
        }
        
        if (fakebulletangle < 0)
        {
            fakebulletangle+=360;
        }
        
        
        
        
        //        NSLog(@"%f", touchangle);
        
        float speed = 10; // Move 50 pixels in 60 frames (1 second)
        
        float vx = cos(fakebulletangle * M_PI / 180) * speed;
        float vy = sin(fakebulletangle * M_PI / 180) * speed;
        
        CGPoint direction = ccp(vy,vx);
        
        // NSLog(NSStringFromCGPoint(direction));
        
        projectile2.position = ccpAdd(projectile2.position, direction);
        
        //player.rotation = touchangle;
        
        
        
    }
}

//obj2 is the player
-(BOOL) isCollidingSphere:(CCSprite *) obj1 WithSphere:(CCSprite *) obj2
{
    float minDistance = 15 + 30;
    float dx = obj2.position.x - obj1.position.x;
    float dy = obj2.position.y - obj1.position.y;
    if (! (dx > minDistance || dy > minDistance) )
    {
        float actualDistance = sqrt( dx * dx + dy * dy );
        return (actualDistance <= minDistance);
    }
    return NO;
}

@end
