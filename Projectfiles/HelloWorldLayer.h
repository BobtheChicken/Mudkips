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
#import "Powerup.h"
#import "Donkey.h"

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
    NSMutableArray *donkeys;
    NSMutableArray *powerups;
    NSMutableArray *flowerbullets;
    
    CCSprite* projectile;
    CCSprite* projectile2;
    int framespast;
    CGSize screenSize;
    CCSprite* pausebutton;
    CCLabelTTF* label;
    CCLabelTTF* tut;
    NSString* score;
    int intScore;
    CCSprite* donkey;
    
    CCLayerColor* colorLayer;
    
    int level;
    bool bosstime;
    
    bool isDying;
    
    bool isStuffMoving;
    
    int attacktype;
    int tempattacktype;
    
    bool isTimeWarped;
    
    bool deathanimation;
    
    
    bool ubershieldon;
    bool shieldon;
    
    int redtint;
    int bluetint;
    int greentint;
    
    CCSprite* border;
    
    CCSprite* countdown;
    
    CCLayerColor* gameOverLayer;
    
    CCMenu*  GameOverMenu;
    
    CCLabelTTF* gameOver;
    CCLabelTTF* gameOver1;
    CCLabelTTF* gameOver2;
    CCLabelTTF* gameOver3;
    
    CCLabelBMFont* coinLabel;
    
    int continueCost;

    
    
}

+(void)unpause;
+(void)resumegame;


@property (nonatomic, copy) NSString* helloWorldString;
@property (nonatomic, copy) NSString* helloWorldFontName;
@property (nonatomic) int helloWorldFontSize;

@end
