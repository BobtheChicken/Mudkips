/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "cocos2d.h"
#import "Player.h"
#import "Pausue.h"
#import "Bullet.h"

@interface HelloWorldLayer : CCLayer
{
	NSString* helloWorldString;
	NSString* helloWorldFontName;
	int helloWorldFontSize;
    CGPoint posTouchScreen;
    id movePlayer;
    CCSprite* boss;
    CGPoint playerpos;
    float touchangle;
    float fakebulletangle;
    CCSprite* bullet;
    CCSprite* fakebullet;
    NSMutableArray *bullets;
    NSMutableArray *bulletDirection;
    NSMutableArray *bulletSpeed;
    NSMutableArray *fakebullets;
    CCSprite* projectile;
    CCSprite* projectile2;
    int framespast;
    CGSize screenSize;
    CCSprite* pausebutton;
    
}

@property (nonatomic, copy) NSString* helloWorldString;
@property (nonatomic, copy) NSString* helloWorldFontName;
@property (nonatomic) int helloWorldFontSize;

@end
