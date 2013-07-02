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
int bossWidth = 190/2;
int bossHeight = 265/2;
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
        
        bullets = [[NSMutableArray alloc] init];
        bulletDirection = [[NSMutableArray alloc] init];
        director = [CCDirector sharedDirector];
        screenCenter = director.screenCenter;
        glClearColor(255, 255, 255, 255);
        // initialize player sprite
        player = [CCSprite spriteWithFile:@"cloudmonster.png"];
        player.scale = 0.2;
        player.position = [director screenCenter];
        [self addChild:player z:9001];
        
        // initialize obstacles
        //[self initObstacles];
        [self initBoss];

        
        [self schedule:@selector(update:)];
    }
    
    return self;
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
    boss = [CCSprite spriteWithFile:@"download.jpeg"];
    boss.position = ccp(x,y);
    boss.scale = 0.5;
    [self addChild:boss z:0];
    
    [self shootBullet];
    int tempInt = (arc4random() % 90)+245;
    NSNumber *temp = [NSNumber numberWithInt:tempInt];
    [bulletDirection addObject:temp];
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
        
        NSLog(NSStringFromCGPoint(direction));
        
        player.position = ccpAdd(player.position, direction);
        
        //player.rotation = touchangle;

        
        
    }
}



-(void) detectCollisions
{
    
    if (CGRectIntersectsRect(CGRectMake(player.position.x, player.position.y, playerWidth, playerHeight), CGRectMake(boss.position.x, boss.position.y, bossWidth, bossHeight)) == true) {
        // NSLog(@"Collision detected!");
        
        [self removeChild:player cleanup:YES];
        
    }
    for(int i = 0; i < [bullets count]; i++)
    {
        NSInteger j = i;
        CCSprite* tempSprite = [bullets objectAtIndex:j];
        //if ([self isCollidingSphere:tempSprite WithSphere:player] == true) {
            // NSLog(@"Collision detected!");
            
            //[self removeChild:[bullets objectAtIndex:j] cleanup:YES];
        //}
    }
}

-(void) bossAttack
{
    if(gameSegment ==0)
    {
        if((framespast % 25) == 0)
        {
            [self shootBullet];
            int tempInt = (arc4random() % 90)+245;
            NSNumber *temp = [NSNumber numberWithInt:tempInt];
            [bulletDirection addObject:temp];
        }
    }
    
    if(gameSegment ==1)
    {
        [self shootBullet];
        int tempInt = 270;
        NSNumber *temp = [NSNumber numberWithInt:tempInt];
        [bulletDirection addObject:temp];
        
        [self shootBullet];
        tempInt = 260;
        temp = [NSNumber numberWithInt:tempInt];
        [bulletDirection addObject:temp];
        
        [self shootBullet];
        tempInt = 280;
        temp = [NSNumber numberWithInt:tempInt];
        [bulletDirection addObject:temp];

    }
    
    
    
    //move the bullets
    for(int i = 0; i < [bullets count]; i++)
    {
        NSInteger j = i;
        projectile = [bullets objectAtIndex:j];
        float angle = [[bulletDirection objectAtIndex:j] floatValue];
        float speed = 1; // Move 50 pixels in 60 frames (1 second)
        
        float vx = cos(angle * M_PI / 180) * speed;
        float vy = sin(angle * M_PI / 180) * speed;
        
        CGPoint direction = ccp(vx,vy);
        
        projectile.position = ccpAdd(projectile.position, direction);
        
    }
        
}



-(void) shootBullet
{
bullet = [CCSprite spriteWithFile:@"monster5.png"];
bullet.position = boss.position;
[self addChild:bullet z:9];
[bullets addObject:bullet];
bullet.scale = 0.2;
}


-(void)update:(ccTime)dt
{
    [self grabTouchCoord];
    [self detectCollisions];
    
    framespast++;
    
    secondspast = framespast/60;
    
    [self bossAttack];
    //[self moveBullet];
    
}



//obj2 is the player
-(BOOL) isCollidingSphere:(CCSprite *) obj1 WithSphere:(CCSprite *) obj2
{
    float minDistance = 15 + 15;
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
