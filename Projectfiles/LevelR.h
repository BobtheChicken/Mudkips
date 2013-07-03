//
//  LevelR.h
//  bullet hell-o
//
//  Created by Kevin Frans on 7/3/13.
//
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "Player.h"
#import "Pausue.h"
#import "Bullet.h"

@interface LevelR : CCLayer
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
    CCLabelTTF* label;
    NSString* score;
    int intScore;
}

@end
