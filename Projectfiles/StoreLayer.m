//
//  StoreLayer.m
//  bullet hell-o
//
//  Created by Kevin Frans on 7/10/13.
//
//

#import "StoreLayer.h"
#import "HelloWorldLayer.h"

@implementation StoreLayer

int numPowerUp1;
int numPowerUp2;

int coins;
NSString *CoinString;
CCLabelBMFont *coinsLabel;

-(id) init
{
	if ((self = [super init]))
	{
        CCSprite* background = [CCSprite spriteWithFile:@"blank.png"];
        background.position = ccp(160,240);
        [self addChild:background];
        
        //glClearColor(255, 255, 255, 255);
        screenSize = [[CCDirector sharedDirector] winSize];
        CGPoint screenCenter = [[CCDirector sharedDirector] screenCenter];
        CCLabelBMFont *gameTitle = [CCLabelTTF labelWithString:@"STORE" fontName:@"Bend2SquaresBRK" fontSize:75];
        gameTitle.color = ccc3(0,0,0);
        gameTitle.position = ccp(screenCenter.x, screenCenter.y + 210);
        [self addChild:gameTitle];
        
        int CoinNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"coins"];
        //        NSNumber *endingHighScoreNumber = [MGWU objectForKey:@"sharedHighScore"];
        coins = CoinNumber;
        CoinString = [[NSString alloc] initWithFormat:@"Coins: %i", coins];
        coinsLabel = [CCLabelTTF labelWithString:CoinString fontName:@"Bend2SquaresBRK" fontSize:60];
        coinsLabel.position = ccp(screenSize.width/2, screenSize.height -100);
        coinsLabel.color = ccc3(0, 0, 0);
        [self addChild:coinsLabel];
        
        
        /*CCMenuItemFont *goBackToHome = [CCMenuItemFont itemFromString: @"Back to Menu" target:self selector:@selector(goHome)];
        [goBackToHome setFontName:@"Bend2SquaresBRK"];
        [goBackToHome setFontSize:25];
        goBackToHome.color = ccc3(0, 0, 0);
        
        CCMenu *goHomeMenu = [CCMenu menuWithItems:goBackToHome, nil];
        [goHomeMenu alignItemsVertically];
        goHomeMenu.position = ccp(screenSize.width/2, 40);
        [self addChild:goHomeMenu];*/
        
        
        CCLabelTTF *highscore = [CCMenuItemImage itemFromNormalImage:@"coinsmall.png" selectedImage:@"coinsmall.png" target:self selector:@selector(buyCash1)];
        highscore.position = ccp(80, 300);
        CCMenu *starMenu = [CCMenu menuWithItems:highscore, nil];
        starMenu.position = CGPointZero;
        [self addChild:starMenu];
        
        CCLabelTTF *boss = [CCMenuItemImage itemFromNormalImage:@"coinmedium.png" selectedImage:@"coinmedium.png" target:self selector:@selector(buyCash2)];
        boss.position = ccp(240, 300);
        CCMenu *moreMenu = [CCMenu menuWithItems:boss, nil];
        moreMenu.position = CGPointZero;
        [self addChild:moreMenu];
        
        CCLabelTTF *back = [CCMenuItemImage itemFromNormalImage:@"coinbig.png" selectedImage:@"coinbig.png" target:self selector:@selector(buyCash3)];
        back.position = ccp(160, 180);
        //back.scale = 0.5;
        CCMenu *backmenu = [CCMenu menuWithItems:back, nil];
        backmenu.position = CGPointZero;
        [self addChild:backmenu];
        
        CCLabelTTF *back2 = [CCMenuItemImage itemFromNormalImage:@"back.png" selectedImage:@"back.png" target:self selector:@selector(goHome)];
        back2.position = ccp(160, 70);
        back2.scale = 0.8;
        CCMenu *backmenu2 = [CCMenu menuWithItems:back2, nil];
        backmenu2.position = CGPointZero;
        [self addChild:backmenu2];
        
        [self scheduleUpdate];
        
    }
    return self;
}

-(void) buyCash1
{
    [MGWU testBuyProduct:@"com.kev.blu.10" withCallback:@selector(boughtProduct:) onTarget:self];
}

-(void) buyCash2
{
    [MGWU testBuyProduct:@"com.kev.blu.50" withCallback:@selector(boughtProduct:) onTarget:self];
}

-(void) buyCash3
{
    [MGWU testBuyProduct:@"com.kev.blu.300" withCallback:@selector(boughtProduct:) onTarget:self];
}


-(void) boughtProduct:(NSString*) powerupToBuy
{
    NSLog(@"Something was Bought!");
    [MGWU showMessage:@"Purchase Successful" withImage:nil];
    if ([powerupToBuy isEqualToString:@"com.kev.blu.10"] == true)
    {
        NSLog(@"1000 Coins added!");
        coins += 10;
        //NSNumber *boughtCoinVal = [NSNumber numberWithInt:coins];
        [[NSUserDefaults standardUserDefaults] setInteger:coins forKey:@"coins"];
    }
    
    if ([powerupToBuy isEqualToString:@"com.kev.blu.50"] == true)
    {
        NSLog(@"3000 Coins added!");
        coins += 50;
        //NSNumber *boughtCoinVal = [NSNumber numberWithInt:coins];
        [[NSUserDefaults standardUserDefaults] setInteger:coins forKey:@"coins"];
        
    }
    
    if ([powerupToBuy isEqualToString:@"com.kev.blu.300"] == true)
    {
        NSLog(@"10000 Coins added!");
        coins += 300;
        //NSNumber *boughtCoinVal = [NSNumber numberWithInt:coins];
        [[NSUserDefaults standardUserDefaults] setInteger:coins forKey:@"coins"];
    }
    
}


-(void) goHome
{
    //glClearColor(0, 0, 0, 255);
    [[CCDirector sharedDirector] popScene];
}


-(void) update:(ccTime)delta
{
    CoinString = [[NSString alloc] initWithFormat:@"Coins: %i", coins];
    [coinsLabel setString:CoinString];
}

@end
