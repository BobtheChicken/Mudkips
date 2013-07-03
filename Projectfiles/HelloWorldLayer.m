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
int bossWidth = 190/2;
int bossHeight = 265/2;
int thetemporalint = 180;
int fromNumber;
int toNumber;
id movePlayer;

int gameSegment = 0;

int framespast;

int secondspast;

-(id) init
{
    if ((self = [super init]))
    {
        screenSize = [director winSize];
        bullets = [[NSMutableArray alloc] init];
        bulletSpeed = [[NSMutableArray alloc] init];
        fakebullets = [[NSMutableArray alloc] init];
        bulletDirection = [[NSMutableArray alloc] init];
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
        [self initBoss];
        [self schedule:@selector(update:)];
        
        [self pause];
        
        
        pausebutton = [CCSprite spriteWithFile:@"ship.png"];
        pausebutton.position = ccp(320,480);
        pausebutton.scale = 0.5;
        [self addChild:pausebutton];
        
        
        
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








-(void) bossAttack
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
    
    
    
    
    [self moveBullet];
    [self moveFakeBullet];
    
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
    int x = 150;
    int y = 400;
    boss = [CCSprite spriteWithFile:@"download.png"];
    boss.position = ccp(x,y);
    boss.scale = 0;
    [self addChild:boss z:0];
    
    id bossscale = [CCScaleTo actionWithDuration:1.0f scale:0.5f];
    [boss runAction:bossscale];
    
   [self shootBullet:1 angle:270];
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
        
        //player.rotation = touchangle;
        
        
        
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
            //NSLog(@"Collision detected!");
            
            gameSegment = 0;
            framespast = 0;
            secondspast = 0;
            
            [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5f scene:[Dead node]]];
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
                }
            }
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
    //NSLog([NSString stringWithFormat:@"%d", [bullets count]]);
    //NSLog([NSString stringWithFormat:@"%d", [fakebullets count]]);
    
    
    
}

-(void) shootBullet: (float) speed angle:(float) angleInput
{
    Bullet *newB = [Bullet bullet:speed :angleInput];
//    Bullet *b = [[Bullet alloc] initWithValues:speed :angleInput];
    newB.position = boss.position;
//    [b setPosition:player.position];
    
//    b.position = ccp(30, 30);
    [self addChild:newB z:9];
    [bullets addObject:newB];
    newB.scale = 0;
    id scale = [CCScaleTo actionWithDuration:1.0f scale:0.1f];
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
        
    
    }
    
}

-(void) gameSeg
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
    }
    
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
