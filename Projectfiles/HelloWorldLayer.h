/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "cocos2d.h"
#import "Player.h";

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
    CCSprite* bullet;
    NSMutableArray *bullets;
    NSMutableArray *bulletDirection;
    CCSprite* projectile;
    int framespast;
    
}

@property (nonatomic, copy) NSString* helloWorldString;
@property (nonatomic, copy) NSString* helloWorldFontName;
@property (nonatomic) int helloWorldFontSize;

@end
